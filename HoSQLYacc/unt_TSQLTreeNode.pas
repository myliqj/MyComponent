unit unt_TSQLTreeNode;

interface

uses
  unt_ISQLTreeNode, DGL_SQLTreeList,

  Classes, Contnrs;

type
  TSQLTreeNode = class(TSQLTreeNodeAbst)
  protected
    F_Text: string;
    F_Type: ESQLNodeType;
    F_Keyword: ESQLNodeKeyword;
    F_AliasName: string;
    F_IsCurrent: Boolean; //是否当前光标所在的Token
    F_Path: string; 

    F_Parent: TSQLTreeNodeAbst;
//    F_ChildNodes: TObjectList;
    F_ChildNodes: ISQLTreeNodeList;

    function L_GetNode(I_Index: Integer): ISQLTreeNode; override;
    function L_GetParentNode: ISQLTreeNode; override;
    function L_GetCount: integer; override;

    function L_GetParent: TSQLTreeNodeAbst; override;
    procedure L_SetParent(I_Parent: TSQLTreeNodeAbst); override;

    function L_GetText: string; override;
    procedure L_SetText(I_Text: string); override;

    function L_GetType: ESQLNodeType; override;
    procedure L_SetType(I_Type: ESQLNodeType); override;

    function L_GetKeyword: ESQLNodeKeyword; override;
    procedure L_SetKeyword(I_Keyword: ESQLNodeKeyword); override;

    function L_GetAliasName: string; override;
    procedure L_SetAliasName(I_AliasName: string); override;

    function L_GetIsCurrent: Boolean; override;
    procedure L_SetIsCurrent(I_IsCurrent: Boolean); override;

    function L_GetPath: string; override;
    procedure L_SetPath(I_Path: string); override;
  public
    constructor Create(I_Owner: TComponent); override;
    destructor Destroy; override;

    function P_GetNodeByIndex(I_Index: integer): TSQLTreeNodeAbst; override;
    procedure P_InsertChild(I_Mode: EAddChildMode; I_Node: TSQLTreeNodeAbst); override;
    procedure P_RemoveChild(I_Node: TSQLTreeNodeAbst); override;

    //显示树形结构
    function P_GetSubTreeText(I_CurLevel: Integer): string; override; //顶层 I_CurLevel = 0
    //查找当前节点
    function P_FindCurrentNode(I_StartNode: ISQLTreeNode): ISQLTreeNode; override;

//    property R_Nodes[I_Index: Integer]: ISQLTreeNode read L_GetNode;
//    property R_Count: integer read L_GetCount;
//    property R_Parent: TSQLTreeNode read L_GetParent write L_SetParent;
//    property R_Text: string read L_GetText write L_SetText;
//    property R_Type: ESQLNodeType read L_GetType write L_SetType;
//    property R_Keyword: ESQLNodeKeyword read L_GetKeyword write L_SetKeyword;
//    property R_AliasName: string read L_GetAliasName write L_SetAliasName;
//    property R_IsCurrent: Boolean read L_GetIsCurrent write L_SetIsCurrent;
  end;

  TSQLTreeNodeManager = class(TSQLTreeNode)
  private
  public
    function P_NewNode: TSQLTreeNode;
    //把I_Node移到I_ParentNode之下
    procedure P_MoveNode(I_Node: TSQLTreeNodeAbst;
      I_ParentNode: TSQLTreeNodeAbst; I_Mode: EAddChildMode);
    //把I_Node的所有子节点移到I_ParentNode之下
    procedure P_MoveChildNodes(I_Node: TSQLTreeNode;
      I_ParentNode: TSQLTreeNode; I_Mode: EAddChildMode);
    //回收节点
    procedure P_Takeback(I_Node: TSQLTreeNode);
  end;

implementation

uses
  TypInfo, SysUtils;

{ TSQLTreeNode }

constructor TSQLTreeNode.Create(I_Owner: TComponent);
begin
  inherited;
//  F_ChildNodes := TObjectList.Create;
  F_ChildNodes := TSQLTreeNodeList.Create;
//  F_ChildNodes.OwnsObjects := false;
end;

destructor TSQLTreeNode.Destroy;
begin
//  if Assigned(F_ChildNodes) then
//    F_ChildNodes.Free;
  F_ChildNodes := nil;
  inherited;
end;

function TSQLTreeNode.L_GetAliasName: string;
begin
  result := F_AliasName;
end;

function TSQLTreeNode.L_GetCount: integer;
begin
//  result := F_ChildNodes.Count;
  result := F_ChildNodes.Size;
end;

function TSQLTreeNode.L_GetIsCurrent: Boolean;
begin
  result := F_IsCurrent
end;

function TSQLTreeNode.L_GetKeyword: ESQLNodeKeyword;
begin
  result := F_Keyword;
end;

function TSQLTreeNode.L_GetNode(I_Index: Integer): ISQLTreeNode;
begin
  result := P_GetNodeByIndex(I_Index);
end;

function TSQLTreeNode.L_GetParent: TSQLTreeNodeAbst;
begin
  result := F_Parent;
end;

function TSQLTreeNode.L_GetText: string;
begin
  result := F_Text;
end;

function TSQLTreeNode.L_GetType: ESQLNodeType;
begin
  result := F_Type;
end;

procedure TSQLTreeNode.L_SetAliasName(I_AliasName: string);
begin
  F_AliasName := I_AliasName;
end;

procedure TSQLTreeNode.L_SetIsCurrent(I_IsCurrent: Boolean);
begin
  F_IsCurrent := I_IsCurrent;
end;

procedure TSQLTreeNode.L_SetKeyword(I_Keyword: ESQLNodeKeyword);
begin
  F_Keyword := I_Keyword;
end;

procedure TSQLTreeNode.L_SetParent(I_Parent: TSQLTreeNodeAbst);
begin
  F_Parent := I_Parent;
end;

procedure TSQLTreeNode.L_SetText(I_Text: string);
begin
  F_Text := I_Text;
end;

procedure TSQLTreeNode.L_SetType(I_Type: ESQLNodeType);
begin
  F_Type := I_Type;
end;

function TSQLTreeNode.P_GetNodeByIndex(I_Index: Integer): TSQLTreeNodeAbst;
var
  _i: integer;
  _it: ISQLTreeNodeIterator;
begin
//  result := TSQLTreeNode(F_ChildNodes.Items[I_Index]);
  _it := F_ChildNodes.ItBegin;
  _i := 0;
  result := nil;
  while not _it.IsEqual(F_ChildNodes.ItEnd) do begin
    if _i = I_Index then begin
      result := _it.Value;
      Exit;
    end;
    Inc(_i);
    _it.Next;
  end;
end;

function TSQLTreeNode.P_GetSubTreeText(I_CurLevel: Integer): string;
var
  _i: Integer;
  _node: ISQLTreeNode;
  _text: string;
begin
  result := '';
  for _i := 0 to I_CurLevel - 1 do
    result := result + '  ';
  result := Result + '+Text:' + R_Text
    + ' Type:' + GetEnumName(TypeInfo(ESQLNodeType), Ord(R_Type))
    + ' Keyword:' + GetEnumName(TypeInfo(ESQLNodeKeyword), Ord(R_Keyword));
  if Trim(R_Path) <> '' then
     result := Result + ' PATH:' + R_Path;
  if Trim(R_AliasName) <> '' then
    result := Result + ' Alias Name:' + R_AliasName;
  if R_IsCurrent then
    result := Result + ' Current:True';
  for _i := 0 to R_Count - 1 do begin
    _node := R_Nodes[_i];
    if _node = nil then
      _text := 'Node is nil'
    else
      _text := _node.P_GetSubTreeText(I_CurLevel + 1);
    result := result + #13#10 + _text;
  end;
end;

procedure TSQLTreeNode.P_InsertChild(I_Mode: EAddChildMode;
  I_Node: TSQLTreeNodeAbst);
begin
  if I_Node.R_Parent <> nil then begin
    I_Node.R_Parent.P_RemoveChild(I_Node);
  end;

  case I_Mode of
    acmFirst:
//      F_ChildNodes.Insert(0, I_Node);
      F_ChildNodes.Insert(F_ChildNodes.ItBegin, I_Node);
    acmLast:
//      F_ChildNodes.Insert(F_ChildNodes.Count, I_Node);
      F_ChildNodes.Insert(F_ChildNodes.ItEnd, I_Node);
  else
//    F_ChildNodes.Add(I_Node);
    F_ChildNodes.Insert(I_Node);
  end;
  I_Node.R_Parent := self;
end;

procedure TSQLTreeNode.P_RemoveChild(I_Node: TSQLTreeNodeAbst);
begin
  if I_Node.R_Parent <> self then
    Exit;
//  F_ChildNodes.Delete(F_ChildNodes.IndexOf(I_Node));
  F_ChildNodes.EraseValue(I_Node);
  I_Node.R_Parent := nil;
end;

function TSQLTreeNode.P_FindCurrentNode(I_StartNode: ISQLTreeNode): ISQLTreeNode;
var
  _i: integer;
begin
  result := nil;
  if I_StartNode.R_IsCurrent then begin
    result := I_StartNode;
    Exit;
  end;
  for _i := 0 to I_StartNode.R_Count - 1 do begin
    result := P_FindCurrentNode(I_StartNode.R_Nodes[_i]);
    if Result <> nil then
      Exit;
  end;
end;

function TSQLTreeNode.L_GetParentNode: ISQLTreeNode;
begin
  result := L_GetParent;
end;

function TSQLTreeNode.L_GetPath: string;
begin
  result := F_Path;
end;

procedure TSQLTreeNode.L_SetPath(I_Path: string);
begin
  F_Path := I_Path;
end;

{ TSQLTreeNodeManager }

procedure TSQLTreeNodeManager.P_MoveChildNodes(I_Node,
  I_ParentNode: TSQLTreeNode; I_Mode: EAddChildMode);
var
  _i: integer;
begin
  for _i := 0 to I_Node.R_Count - 1 do begin
    P_MoveNode(I_Node.P_GetNodeByIndex(_i), I_ParentNode, I_Mode);
  end;
end;

procedure TSQLTreeNodeManager.P_MoveNode(I_Node, I_ParentNode: TSQLTreeNodeAbst;
  I_Mode: EAddChildMode);
begin
  if I_Node.R_Parent <> nil then begin
    I_Node.R_Parent.P_RemoveChild(I_Node);
  end;

  I_ParentNode.P_InsertChild(I_Mode, I_Node);
end;

function TSQLTreeNodeManager.P_NewNode: TSQLTreeNode;
begin
  result := TSQLTreeNode.Create(self);
  P_InsertChild(acmLast, result);
end;

procedure TSQLTreeNodeManager.P_Takeback(I_Node: TSQLTreeNode);
begin
  if I_Node.R_Parent <> nil then begin
    I_Node.R_Parent.P_RemoveChild(I_Node);
  end;

  FreeAndNil(I_Node);
end;

end.

