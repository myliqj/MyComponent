unit frm_tyMain;

interface

uses
  unt_ISQLTreeNode,
//
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SynEdit, unt_HoSynEdit, SynEditHighlighter,
  SynHighlighterSQL, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    SynSQLSyn1: TSynSQLSyn;
    Panel1: TPanel;
    btnPrnTree: TButton;
    Button2: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    edSQL: THoSynEdit;
    Splitter2: TSplitter;
    mmRst: TRichEdit;
    lbSQLs: TListBox;
    Button3: TButton;
    btnRefreshList: TButton;
    btnSave: TButton;
    btnNew: TButton;
    btnDel: TButton;
    procedure btnPrnTreeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbSQLsDblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnRefreshListClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    { Private declarations }
    F_FieldNames: TStringList;
    F_TableNames: TStringList;

    procedure L_FindFields(I_Root: ISQLTreeNode; I_TableName: string);
    function L_GetTablesNode(I_QueryNode: ISQLTreeNode): ISQLTreeNode;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function getSyntexTree(I_SQL: string): ISQLTreeNode; external '..\HoSqlYacc.dll';

implementation

uses
  unt_SQLTreeAnalyzer, DGL_String;

{$R *.dfm}

procedure TForm1.btnPrnTreeClick(Sender: TObject);
var
  _tree: ISQLTreeNode;
begin
  mmRst.Lines.Clear;
  try
    _tree := getSyntexTree(edSQL.Lines.Text);
    mmRst.Lines.Text := _tree.P_GetSubTreeText(0);
  except
    on E: Exception do
      mmRst.Lines.Add(E.Message);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  _tree: ISQLTreeNode;
  _curNode: ISQLTreeNode;
  _parentNode: ISQLTreeNode;
  _i, _j: integer;
  _tableRoot: ISQLTreeNode;
  _tableName: string;
begin
  mmRst.Lines.Clear;
  F_FieldNames.Clear;
  F_TableNames.Clear;
  try
    _tree := getSyntexTree(edSQL.Lines.Text);
    _curNode := _tree.P_FindCurrentNode(_tree);
    if _curNode <> nil then begin
      _parentNode := _curNode.R_ParentNode;
      while _parentNode <> nil do begin
        if _parentNode.R_Type = sntKey then begin
          Break;
        end;
        _parentNode := _parentNode.R_ParentNode;
      end;
      if _parentNode <> nil then begin
        if _parentNode.R_Keyword = snkFields then begin
          _parentNode := _parentNode.R_ParentNode;
          if _parentNode = nil then
            Exit;

          _tableName := '';
          if _curNode.R_ParentNode <> nil then begin
            if _curNode.R_ParentNode.R_Keyword = snkAliasAndField then begin
              _tableName := Copy(_curNode.R_ParentNode.R_Text, 1
                , Pos('.', _curNode.R_ParentNode.R_Text) - 1);
            end;
          end;

          for _i := 0 to _parentNode.R_Count - 1 do begin
            if _parentNode.R_Nodes[_i].R_Keyword = snkTables then begin
              _TableRoot := _parentNode.R_Nodes[_i];
              L_FindFields(_TableRoot, _tableName);
            end else if _parentNode.R_Nodes[_i].R_Keyword = snkJoinClause then begin
              for _j := 0 to _parentNode.R_Nodes[_i].R_Count - 1 do begin
                if _parentNode.R_Nodes[_i].R_Nodes[_j].R_Keyword = snkTables then
                  _TableRoot := _parentNode.R_Nodes[_i].R_Nodes[_j];
                L_FindFields(_TableRoot, _tableName);
              end;
            end;
          end;
        end else if _parentNode.R_Text = C_TABLES then begin
        end;
      end;
    end;

    for _i := 0 to F_tableNames.Count - 1 do begin
      mmRst.Lines.Add('table: ' + F_TableNames.Strings[_i]);
    end;
    for _i := 0 to F_fieldNames.Count - 1 do begin
      mmRst.Lines.Add('field: ' + F_FieldNames.Strings[_i]);
    end;
  except
    on E: Exception do
      mmRst.Lines.Add(E.Message);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  F_FieldNames := TStringList.Create;
  F_FieldNames.Sorted := true;
  F_FieldNames.Duplicates := dupIgnore;

  F_TableNames := TStringList.Create;
  F_TableNames.Sorted := true;
  F_TableNames.Duplicates := dupIgnore;

  btnRefreshList.Click;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//  lbSQLs.Items.SaveToFile('testCase.txt');
  F_TableNames.Free;
  F_FieldNames.Free;
end;

procedure TForm1.L_FindFields(I_Root: ISQLTreeNode; I_TableName: string);
var
  _tableName: string;
  _tmpStr1: string;
  _tmpStr2: string;
  _pos: integer;
  _i: integer;
  _j: integer;
  _k: integer;
  _qryNode: ISQLTreeNode;
  _fieldsRootNode: ISQLTreeNode;
begin
  //起点从 From 开始

  _tableName := Trim(I_TableName);
  for _i := 0 to I_Root.R_Count - 1 do begin
    if I_Root.R_Nodes[_i].R_Type = sntNode then begin
      if (_tableName = I_Root.R_Nodes[_i].R_Text)
        or (_tableName = I_Root.R_Nodes[_i].R_AliasName)
        or (_tableName = '')
        then begin
        //普通表
        F_TableNames.Add(I_Root.R_Nodes[_i].R_Text);
      end;
    end else if (I_Root.R_Nodes[_i].R_Keyword = snkQuery)
      and ((I_Root.R_Nodes[_i].R_AliasName = _tableName)
      or (_tableName = ''))
      then begin
      //表是一个查询
      _qryNode := I_Root.R_Nodes[_i];
      for _j := 0 to _qryNode.R_Count - 1 do begin
        if _qryNode.R_Nodes[_j].R_Keyword = snkFields then begin
          _fieldsRootNode := _qryNode.R_Nodes[_j];
          for _k := 0 to _fieldsRootNode.R_Count - 1 do begin
            if Trim(_fieldsRootNode.R_Nodes[_k].R_AliasName) <> '' then begin
              F_FieldNames.Add(Trim(_fieldsRootNode.R_Nodes[_k].R_AliasName));
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
                F_FieldNames.Add(Trim(_tmpStr2));
              end;
            end else if Trim(_fieldsRootNode.R_Nodes[_k].R_Text) = '*' then begin
              L_FindFields(L_GetTablesNode(_qryNode), '');
            end else begin
              F_FieldNames.Add(Trim(_fieldsRootNode.R_Nodes[_k].R_Text));
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm1.lbSQLsDblClick(Sender: TObject);
begin
  edSQL.Lines.Text := StringReplace(lbSQLs.Items[lbSQLs.ItemIndex],
    '\r', #13#10, [rfIgnoreCase ,rfReplaceAll]);
  btnPrnTree.Click;
end;

function TForm1.L_GetTablesNode(I_QueryNode: ISQLTreeNode): ISQLTreeNode;
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

procedure TForm1.Button3Click(Sender: TObject);
var
  _analyzer: TSQLTreeAnalyzer;
  _tree: ISQLTreeNode;
  _tableNames: TStrSet;
  _fieldNames: TStrSet;
  _itStr: IStrIterator;
begin
  mmRst.Lines.Clear;
  _tree := getSyntexTree(edSQL.Lines.Text);
  _analyzer := TSQLTreeAnalyzer.Create;
  try
    _analyzer.P_GetTableAndFields(_tree, _tableNames, _fieldNames);
    _itStr := _tableNames.ItBegin;
    while not _itStr.IsEqual(_tableNames.ItEnd) do begin
      mmRst.Lines.Add('table: ' + _itStr.Value);
      _itStr.Next;
    end;
    _itStr := _fieldNames.ItBegin;
    while not _itStr.IsEqual(_fieldNames.ItEnd) do begin
      mmRst.Lines.Add('field: ' + _itStr.Value);
      _itStr.Next;
    end;
  finally
    _analyzer.Free;
  end;
end;

procedure TForm1.btnRefreshListClick(Sender: TObject);
begin
  lbSQLs.Items.LoadFromFile('testCase.txt');
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  lbSQLs.Items[lbSQLs.ItemIndex] := StringReplace(edSQL.Lines.Text,
    #13#10, '\r', [rfIgnoreCase ,rfReplaceAll]);
  lbSQLs.Items.SaveToFile('testCase.txt');
end;

procedure TForm1.btnNewClick(Sender: TObject);
begin
  lbSQLs.Items.Add(StringReplace(edSQL.Lines.Text,
    #13#10, '\r', [rfIgnoreCase ,rfReplaceAll]));
  lbSQLs.Items.SaveToFile('testCase.txt');
end;

procedure TForm1.btnDelClick(Sender: TObject);
begin
  lbSQLs.Items.Delete(lbSQLs.ItemIndex);
  lbSQLs.Items.SaveToFile('testCase.txt');
end;

end.

