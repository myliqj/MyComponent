unit unt_ISQLTreeNode;

interface

const
  C_QUERY = '<QUERY>';
  C_FIELDS = '<FIELDS>';
  C_TABLES = '<TABLES>';
  C_UPDATE = '<UPDATE>';
  C_SET = '<SET>';
  C_CONDITIONS = '<CONDITIONS>';
  C_JOINS = '<JOINS>';
  C_INNER_JOIN = '<INNER JOIN>';
  C_LEFT_JOIN = '<LEFT JOIN>';
  C_RIGHT_JOIN = '<RIGHT JOIN>';
  C_JOIN_CONDITIONS = '<JOIN CONDITIONS>';
  C_JOIN_TABLES = '<JOIN TABLES>';
  C_GROUP = '<GROUP BY>';
  C_HAVING_CONDITIONS = '<HAVING CONDITIONS>';
  C_ORDER = '<ORDER BY>';

type
  EAddChildMode = (acmFirst, acmAdd, acmLast);
  ESQLNodeType = (sntNode, sntKey, sntSentence);
  ESQLNodeKeyword = (
    snkNone, snkQuery, snkFields, snkTables, snkJoins, snkJoinClause,
    snkWhereClause,
    snkGroupClause, snkHavingClause, snkOrderClause, snkConditionClause,
    snkUpdate, snkSet, snkInsert, snkValuesClause, snkUnionClause,

    snkAliasAndField, // 标识形如 a.b("表.字段") 或 2.a("引用.字段") 的表达式
    snkSchemaAndTable, // 标识形如 a.b("模式名.表名") 的表达式

    snkNumber, snkFloat, snkString, snkIdentifier, snkKeyword, snkOperator,
    snkExpression, snkLinkParam, snkAggLinkParam, snkParam);

  ISQLTreeNode = interface
    function L_GetNode(I_Index: Integer): ISQLTreeNode;
    function L_GetParentNode: ISQLTreeNode;
    function L_GetCount: integer;

    function L_GetText: string;
    procedure L_SetText(I_Text: string);

    function L_GetType: ESQLNodeType;
    procedure L_SetType(I_Type: ESQLNodeType);

    function L_GetKeyword: ESQLNodeKeyword;
    procedure L_SetKeyword(I_Keyword: ESQLNodeKeyword);

    function L_GetAliasName: string;
    procedure L_SetAliasName(I_AliasName: string);

    function L_GetIsCurrent: Boolean;
    procedure L_SetIsCurrent(I_IsCurrent: Boolean);

    //以文本形式显示树形结构
    function P_GetSubTreeText(I_CurLevel: Integer): string; //顶层 I_CurLevel = 0
    function P_FindCurrentNode(I_StartNode: ISQLTreeNode): ISQLTreeNode;

    function L_GetPath: string;
    procedure L_SetPath(I_Path: string);

    property R_Nodes[I_Index: Integer]: ISQLTreeNode read L_GetNode;
    property R_ParentNode: ISQLTreeNode read L_GetParentNode;
    property R_Count: integer read L_GetCount;
    property R_Text: string read L_GetText write L_SetText;
    property R_Type: ESQLNodeType read L_GetType write L_SetType;
    property R_Keyword: ESQLNodeKeyword read L_GetKeyword write L_SetKeyword;
    property R_AliasName: string read L_GetAliasName write L_SetAliasName;
    property R_IsCurrent: Boolean read L_GetIsCurrent write L_SetIsCurrent;
    property R_Path: string read L_GetPath write L_SetPath;
  end;

implementation

end.

