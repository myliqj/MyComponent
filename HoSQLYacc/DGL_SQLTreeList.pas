unit DGL_SQLTreeList;

interface

uses
  unt_ISQLTreeNode,

  SysUtils, Classes;

{$I DGLCfg.inc_h}

type
  TSQLTreeNodeAbst = class(TComponent, ISQLTreeNode)
  protected
    function L_GetNode(I_Index: Integer): ISQLTreeNode; virtual; abstract;
    function L_GetParentNode: ISQLTreeNode; virtual; abstract;
    function L_GetCount: integer; virtual; abstract;

    function L_GetParent: TSQLTreeNodeAbst; virtual; abstract;
    procedure L_SetParent(I_Parent: TSQLTreeNodeAbst); virtual; abstract;

    function L_GetText: string; virtual; abstract;
    procedure L_SetText(I_Text: string); virtual; abstract;

    function L_GetType: ESQLNodeType; virtual; abstract;
    procedure L_SetType(I_Type: ESQLNodeType); virtual; abstract;

    function L_GetKeyword: ESQLNodeKeyword; virtual; abstract;
    procedure L_SetKeyword(I_Keyword: ESQLNodeKeyword); virtual; abstract;

    function L_GetAliasName: string; virtual; abstract;
    procedure L_SetAliasName(I_AliasName: string); virtual; abstract;

    function L_GetIsCurrent: Boolean; virtual; abstract;
    procedure L_SetIsCurrent(I_IsCurrent: Boolean); virtual; abstract;

    function L_GetPath: string; virtual; abstract;
    procedure L_SetPath(I_Path: string);  virtual; abstract;

  public
    function P_GetNodeByIndex(I_Index: integer): TSQLTreeNodeAbst; virtual; abstract;
    procedure P_InsertChild(I_Mode: EAddChildMode; I_Node: TSQLTreeNodeAbst); virtual; abstract;
    procedure P_RemoveChild(I_Node: TSQLTreeNodeAbst); virtual; abstract;

    //****实现ISQLTreeNode接口****//

    //以文本形式显示树形结构
    function P_GetSubTreeText(I_CurLevel: Integer): string; virtual; abstract; //顶层 I_CurLevel = 0
    function P_FindCurrentNode(I_StartNode: ISQLTreeNode): ISQLTreeNode; virtual; abstract;

    property R_Nodes[I_Index: Integer]: ISQLTreeNode read L_GetNode;
    property R_Count: integer read L_GetCount;
    property R_Parent: TSQLTreeNodeAbst read L_GetParent write L_SetParent;
    property R_Text: string read L_GetText write L_SetText;
    property R_Type: ESQLNodeType read L_GetType write L_SetType;
    property R_Keyword: ESQLNodeKeyword read L_GetKeyword write L_SetKeyword;
    property R_AliasName: string read L_GetAliasName write L_SetAliasName;
    property R_IsCurrent: Boolean read L_GetIsCurrent write L_SetIsCurrent;
    property R_Path: string read L_GetPath write L_SetPath;
  end;

  _ValueType = TSQLTreeNodeAbst;
const
  _NULL_Value: _ValueType = nil;
{$DEFINE _DGL_NotHashFunction}

{$DEFINE  _DGL_Compare}
function _IsEqual(const a, b: _ValueType): boolean; //{$ifdef _DGL_Inline} inline; {$endif} //result:=(a=b);
function _IsLess(const a, b: _ValueType): boolean; {$IFDEF _DGL_Inline}inline; {$ENDIF} //result:=(a<b); 默认排序准则

{$I DGL.inc_h}

type
  TSQLTreeNodeAlgorithms = _TAlgorithms;

  ISQLTreeNodeIterator = _IIterator;
  ISQLTreeNodeContainer = _IContainer;
  ISQLTreeNodeSerialContainer = _ISerialContainer;
  ISQLTreeNodeVector = _IVector;
  ISQLTreeNodeList = _IList;
  ISQLTreeNodeDeque = _IDeque;
  ISQLTreeNodeStack = _IStack;
  ISQLTreeNodeQueue = _IQueue;
  ISQLTreeNodePriorityQueue = _IPriorityQueue;
  ISQLTreeNodeSet = _ISet;
  ISQLTreeNodeMultiSet = _IMultiSet;

  TSQLTreeNodeVector = _TVector;
  TSQLTreeNodeDeque = _TDeque;
  TSQLTreeNodeList = _TList;
  ISQLTreeNodeVectorIterator = _IVectorIterator; //速度比_IIterator稍快一点:)
  ISQLTreeNodeDequeIterator = _IDequeIterator; //速度比_IIterator稍快一点:)
  ISQLTreeNodeListIterator = _IListIterator; //速度比_IIterator稍快一点:)
  TSQLTreeNodeStack = _TStack;
  TSQLTreeNodeQueue = _TQueue;
  TSQLTreeNodePriorityQueue = _TPriorityQueue;

  ISQLTreeNodeMapIterator = _IMapIterator;
  ISQLTreeNodeMap = _IMap;
  ISQLTreeNodeMultiMap = _IMultiMap;

  TSQLTreeNodeSet = _TSet;
  TSQLTreeNodeMultiSet = _TMultiSet;
  TSQLTreeNodeMap = _TMap;
  TSQLTreeNodeMultiMap = _TMultiMap;
  TSQLTreeNodeHashSet = _THashSet;
  TSQLTreeNodeHashMultiSet = _THashMultiSet;
  TSQLTreeNodeHashMap = _THashMap;
  TSQLTreeNodeHashMultiMap = _THashMultiMap;

implementation
uses
  HashFunctions;

function _IsEqual(const a, b: _ValueType): boolean;
begin
  result := (a = b);
end;

function _IsLess(const a, b: _ValueType): boolean;
begin
  result := (Cardinal(a) < Cardinal(b));
end;


{$I DGL.inc_pas}

end.

