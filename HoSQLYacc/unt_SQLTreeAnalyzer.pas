unit unt_SQLTreeAnalyzer;

interface

uses
  unt_ISQLTreeNode, _DGL_SQLElement,

  DGL_String;

type
  EResultType = (ertNone, ertFields, ertTables);

  TSQLTreeAnalyzer = class
  private
    F_TableNames: ISQLElementDGLSet;
    F_FieldNames: ISQLElementDGLSet;
    function L_GetTablesNode(I_QueryNode: ISQLTreeNode): ISQLTreeNode;
    procedure L_FindFields(I_Root: ISQLTreeNode; I_TableAlias: string);
    function L_GetParentKeyNode(I_CurrentNode: ISQLTreeNode): ISQLTreeNode;
  public
    function P_DetectRefType(I_CurrentNode: ISQLTreeNode): EResultType;
    procedure P_GetRefTablesAndFields(I_TableAlias: string; I_CurrentNode: ISQLTreeNode;
      I_Level: integer; var O_TableNames: ISQLElementDGLSet;
      var O_FieldNames: ISQLElementDGLSet);
    /// <summary>
    /// 从指定节点开始，搜索可以引用的表和字段，存入O_TableNames和O_FieldNames
    /// </summary>
    /// <param name="I_CurrentNode">从此节点开始搜索可以引用哪些表和字段</param>
    /// <param name="I_Level">对于嵌套查询的，可以访问上一级的表，此参数标记从最开始向上了多少级</param>
    /// <param name="O_TableNames"></param>
    /// <param name="O_FieldNames"></param>
    /// <returns></returns>
//    function P_GetTableAndFields(I_TableAlias: string; I_CurrentNode: ISQLTreeNode;
//      I_Level: integer; var O_TableNames: TStrSet; var O_FieldNames: TStrSet): EResultType;
  end;

implementation

uses
  SysUtils;

{ TSQLTreeAnalyzer }

procedure TSQLTreeAnalyzer.L_FindFields(I_Root: ISQLTreeNode;
  I_TableAlias: string);
var
  _tableAlias: string;
  _tmpStr1: string;
  _tmpStr2: string;
  _pos: integer;
  _i: integer;
  _j: integer;
  _k: integer;
  _qryNode: ISQLTreeNode;
  _fieldsRootNode: ISQLTreeNode;

  _elementName: string;
  _elementRealName: string;
  _elementLeader: string;
  _elementAlias: string;
begin
  //起点从 From 开始

  _tableAlias := Trim(I_TableAlias);
  for _i := 0 to I_Root.R_Count - 1 do begin
    if I_Root.R_Nodes[_i].R_Type = sntNode then begin
      if (_tableAlias = I_Root.R_Nodes[_i].R_Text)
        or (_tableAlias = I_Root.R_Nodes[_i].R_AliasName)
        or (_tableAlias = '')
        then begin
        //普通表
        _elementName := I_Root.R_Nodes[_i].R_Text;
        _elementRealName := I_Root.R_Nodes[_i].R_Text;
        _elementLeader := '';
        _elementAlias := I_Root.R_Nodes[_i].R_AliasName;
        F_TableNames.Insert(Pair_SQLElementDGL(_elementName, _elementRealName
          , _elementLeader, _elementAlias, eetTable));
      end;
    end else if (I_Root.R_Nodes[_i].R_Keyword = snkQuery)
      and ((I_Root.R_Nodes[_i].R_AliasName = _tableAlias)
      or (_tableAlias = ''))
      then begin
      //表是一个查询
      _qryNode := I_Root.R_Nodes[_i];
      for _j := 0 to _qryNode.R_Count - 1 do begin
        if _qryNode.R_Nodes[_j].R_Keyword = snkFields then begin
          _fieldsRootNode := _qryNode.R_Nodes[_j];
          for _k := 0 to _fieldsRootNode.R_Count - 1 do begin
            if Trim(_fieldsRootNode.R_Nodes[_k].R_AliasName) <> '' then begin
              _elementName := Trim(_fieldsRootNode.R_Nodes[_k].R_AliasName);
              _elementRealName := Trim(_fieldsRootNode.R_Nodes[_k].R_Text);
              _elementLeader := I_Root.R_Nodes[_i].R_AliasName;
              _elementAlias := _fieldsRootNode.R_Nodes[_i].R_AliasName;
              F_FieldNames.Insert(
                Pair_SQLElementDGL(_elementName, _elementRealName, _elementLeader,
                _elementAlias, eetField));
            end else if _fieldsRootNode.R_Nodes[_k].R_Keyword = snkAliasAndField then begin
              _tmpStr1 := _fieldsRootNode.R_Nodes[_k].R_Text;
              _pos := pos('.', _tmpStr1);
              _tmpStr2 := Copy(_tmpStr1, _pos + 1, Length(_tmpStr1) - _pos);
              if Trim(_tmpStr2) = '*' then begin
                _tmpStr2 := Copy(_tmpStr1, 1, _pos - 1);
                if Trim(_tmpStr2) <> '' then begin
                  L_FindFields(L_GetTablesNode(_qryNode), Trim(_tmpStr2));
                end;
              end else if Trim(_tmpStr2) <> '' then begin
                _elementName := Trim(_tmpStr2);
                _elementRealName := Trim(_tmpStr2);
                _elementLeader := Copy(_tmpStr1, 1, _pos - 1);
                _elementAlias := I_Root.R_Nodes[_i].R_AliasName;
                F_FieldNames.Insert(
                  Pair_SQLElementDGL(_elementName, _elementRealName, _elementLeader,
                  _elementAlias, eetField));
              end;
            end else if Trim(_fieldsRootNode.R_Nodes[_k].R_Text) = '*' then begin
              L_FindFields(L_GetTablesNode(_qryNode), '');
            end else begin
              _elementName := Trim(_fieldsRootNode.R_Nodes[_k].R_Text);
              _elementRealName := Trim(_fieldsRootNode.R_Nodes[_k].R_Text);
              _elementLeader := I_Root.R_Nodes[_i].R_AliasName;
              _elementAlias := Trim(_fieldsRootNode.R_Nodes[_k].R_AliasName);
              F_FieldNames.Insert(
                Pair_SQLElementDGL(_elementName, _elementRealName, _elementLeader,
                _elementAlias, eetField));
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TSQLTreeAnalyzer.L_GetParentKeyNode(
  I_CurrentNode: ISQLTreeNode): ISQLTreeNode;
//返回最近一个为Key类型的上级，若无则返回顶级父节点（SQL有误时)
var
  _parentNode: ISQLTreeNode;
begin
  result := nil;
  if I_CurrentNode = nil then Exit;

  //找到类型为KeyWord的第一个上级
  _parentNode := I_CurrentNode.R_ParentNode;
  while _parentNode <> nil do begin
    if _parentNode.R_Type = sntKey then begin
      Break;
    end;
    if _parentNode.R_ParentNode = nil then
      Break;
    _parentNode := _parentNode.R_ParentNode;
  end;

  result := _parentNode;
end;

function TSQLTreeAnalyzer.L_GetTablesNode(
  I_QueryNode: ISQLTreeNode): ISQLTreeNode;
var
  _i: integer;
begin
  result := nil;
  for _i := 0 to I_QueryNode.R_Count - 1 do begin
    if (I_QueryNode.R_Nodes[_i].R_Keyword = snkTables)
      and (I_QueryNode.R_Nodes[_i].R_Type = sntKey) then
    begin
      result := I_QueryNode.R_Nodes[_i];
    end;
  end;
end;

function TSQLTreeAnalyzer.P_DetectRefType(
  I_CurrentNode: ISQLTreeNode): EResultType;
//检测当前节点引用的是表还是字段。
//  若当前节点是字段项或查询条件项，那么引用的是字段
//  若当前节点是表项目，那么引用的是表
var
  _parentNode: ISQLTreeNode;
begin
  result := ertNone;
  _parentNode := L_GetParentKeyNode(I_CurrentNode);
  if _parentNode = nil then
    Exit;
  if _parentNode.R_Keyword in [snkFields, snkWhereClause, snkOrderClause
    , snkGroupClause, snkSet, snkNone] then begin
    result := ertFields
  end else if _parentNode.R_Keyword in [snkTables] then begin
    result := ertTables;
  end;
end;

procedure TSQLTreeAnalyzer.P_GetRefTablesAndFields(I_TableAlias: string;
  I_CurrentNode: ISQLTreeNode; I_Level: integer; var O_TableNames,
  O_FieldNames: ISQLElementDGLSet);
var
  _tableAlias: string;
  _joinNode: ISQLTreeNode;
  _parentNode: ISQLTreeNode;
  _i, _j, _k: integer;
  _tableRoot: ISQLTreeNode;
begin
  Assert(O_TableNames <> nil, 'TableNames list has not been created yet!');
  Assert(O_FieldNames <> nil, 'FieldNames list has not been created yet!');
  F_TableNames := O_TableNames;
  F_FieldNames := O_FieldNames;

  if I_TableAlias = '' then begin
    _tableAlias := '';
    //取型如table.field的表名table
    if I_CurrentNode.R_ParentNode <> nil then begin
      if I_CurrentNode.R_ParentNode.R_Keyword = snkAliasAndField then begin
        _tableAlias := Copy(I_CurrentNode.R_ParentNode.R_Text, 1
          , Pos('.', I_CurrentNode.R_ParentNode.R_Text) - 1);
      end else if I_CurrentNode.R_ParentNode.R_Keyword = snkLinkParam then begin
        exit;
      end;
    end;
  end else
    _tableAlias := I_TableAlias;

  //找<Tables>或<Joins>的上级
  _parentNode := L_GetParentKeyNode(I_CurrentNode);
  if _parentNode.R_Keyword <> snkNone then
    _parentNode := _parentNode.R_ParentNode;

  if _parentNode = nil then Exit;

  if _parentNode.R_Keyword = snkJoinClause then begin
    _parentNode := _parentNode.R_ParentNode; // snkJoins 节点
    if _parentNode = nil then Exit;
    _parentNode := _parentNode.R_ParentNode; // snkQuery 节点
    if _parentNode = nil then Exit;
  end;

  for _i := 0 to _parentNode.R_Count - 1 do begin
    if _parentNode.R_Nodes[_i].R_Keyword = snkTables then begin
      _TableRoot := _parentNode.R_Nodes[_i];
      L_FindFields(_TableRoot, _tableAlias);
    end else if _parentNode.R_Nodes[_i].R_Keyword = snkJoins then begin
      for _j := 0 to _parentNode.R_Nodes[_i].R_Count - 1 do begin
        _joinNode := _parentNode.R_Nodes[_i].R_Nodes[_j];
        for _k := 0 to _joinNode.R_Count - 1 do begin
          if _joinNode.R_Nodes[_k].R_Keyword = snkTables then
            _TableRoot := _joinNode.R_Nodes[_k];
          L_FindFields(_TableRoot, _tableAlias);
        end;
      end;
    end;
  end;

  if _parentNode.R_ParentNode <> nil then begin
    //嵌套SQL的处理
    if I_Level < 2 then begin
      if P_DetectRefType(_parentNode.R_ParentNode) = ertFields then begin
        P_GetRefTablesAndFields(_tableAlias, _parentNode.R_ParentNode, I_Level + 1,
          O_TableNames, O_FieldNames);
      end;
    end;
  end;
end;
{
function TSQLTreeAnalyzer.P_GetTableAndFields(I_TableAlias: string;
  I_CurrentNode: ISQLTreeNode; I_Level: integer;
  var O_TableNames: TStrSet; var O_FieldNames: TStrSet): EResultType;
var
  _joinNode: ISQLTreeNode;
  _parentNode: ISQLTreeNode;
  _i, _j, _k: integer;
  _tableRoot: ISQLTreeNode;
  _tableAlias: string;
begin
  result := ertFields;

  if I_Level = 1 then begin
    F_TableNames := TStrSet.Create;
    F_FieldNames := TStrSet.Create;

    O_TableNames := F_TableNames;
    O_FieldNames := F_FieldNames;
  end;

//  I_CurrentNode := I_SQLTree.P_FindCurrentNode(I_SQLTree);
  if I_CurrentNode <> nil then begin

    if I_TableAlias = '' then begin
      _tableAlias := '';
    //取型如table.field的表名table
      if I_CurrentNode.R_ParentNode <> nil then begin
        if I_CurrentNode.R_ParentNode.R_Keyword = snkAliasAndField then begin
          _tableAlias := Copy(I_CurrentNode.R_ParentNode.R_Text, 1
            , Pos('.', I_CurrentNode.R_ParentNode.R_Text) - 1);
        end else if I_CurrentNode.R_ParentNode.R_Keyword = snkLinkParam then begin
          exit;
        end;
      end;
    end else
      _tableAlias := I_TableAlias;

    //找到类型为KeyWord的第一个上级
    _parentNode := I_CurrentNode.R_ParentNode;
    while _parentNode <> nil do begin
      if _parentNode.R_Type = sntKey then begin
        Break;
      end;
      if _parentNode.R_ParentNode = nil then
        Break;
      _parentNode := _parentNode.R_ParentNode;
    end;

    if _parentNode <> nil then begin
      if _parentNode.R_Keyword in [snkFields, snkWhereClause, snkOrderClause
        , snkGroupClause, snkNone] then begin

        //找<Tables>或<Joins>的上级

        if _parentNode.R_Keyword <> snkNone then
          _parentNode := _parentNode.R_ParentNode;

        if _parentNode = nil then Exit;

        if _parentNode.R_Keyword = snkJoinClause then begin
          _parentNode := _parentNode.R_ParentNode; // snkJoins 节点
          if _parentNode = nil then Exit;
          _parentNode := _parentNode.R_ParentNode; // snkQuery 节点
          if _parentNode = nil then Exit;
        end;

        for _i := 0 to _parentNode.R_Count - 1 do begin
          if _parentNode.R_Nodes[_i].R_Keyword = snkTables then begin
            _TableRoot := _parentNode.R_Nodes[_i];
            L_FindFields(_TableRoot, _tableAlias);
          end else if _parentNode.R_Nodes[_i].R_Keyword = snkJoins then begin
            for _j := 0 to _parentNode.R_Nodes[_i].R_Count - 1 do begin
              _joinNode := _parentNode.R_Nodes[_i].R_Nodes[_j];
              for _k := 0 to _joinNode.R_Count - 1 do begin
                if _joinNode.R_Nodes[_k].R_Keyword = snkTables then
                  _TableRoot := _joinNode.R_Nodes[_k];
                L_FindFields(_TableRoot, _tableAlias);
              end;
            end;
          end;
        end;

        if _parentNode.R_ParentNode <> nil then begin
          if I_Level < 2 then begin
            if _parentNode.R_ParentNode.R_Keyword <> snkNone then begin
              P_GetTableAndFields(_tableAlias, _parentNode.R_ParentNode
                , I_Level + 1, O_TableNames, O_FieldNames);
            end;
          end;
        end;
      end else if _parentNode.R_Keyword = snkTables then begin
        result := ertTables;
        if I_Level = 1 then begin

        end;
      end;
    end;
  end;
end;
}
end.

