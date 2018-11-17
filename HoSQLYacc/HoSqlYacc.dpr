
library sqlYacc;

uses
  sharemem,
  classes,
	SysUtils,
	ComCtrls,
	TypInfo,
	Dialogs,
	
	dlib,
	yacclib,
	lexlib,
	unt_ISQLTreeNode in 'unt_ISQLTreeNode.pas',
	unt_TSQLTreeNode in 'unt_TSQLTreeNode.pas',
  DGL_SQLTreeList in 'DGL_SQLTreeList.pas'
  ;

var
  g_tree: TSQLTreeNodeManager;
  _tmpNode: TSQLTreeNode;
  _step: integer;

procedure G_Init;
begin
  if assigned(g_tree) then begin
    g_tree.free;
  end;
  g_tree:= TSQLTreeNodeManager.Create(nil); 
end;
  
const TK_IDENTIFIER = 257;
const TK_STRING = 258;
const TK_INT = 259;
const TK_NUM = 260;
const TK_SELECT = 261;
const TK_FROM = 262;
const TK_QUANTIFIER = 263;
const TK_WHERE = 264;
const TK_AND = 265;
const TK_OR = 266;
const TK_NOT = 267;
const TK_EXISTS = 268;
const TK_IS = 269;
const TK_LIKE = 270;
const TK_INNER = 271;
const TK_LEFT = 272;
const TK_RIGHT = 273;
const TK_OUTER = 274;
const TK_JOIN = 275;
const TK_ON = 276;
const TK_ORDER = 277;
const TK_ASC = 278;
const TK_DESC = 279;
const TK_GROUP = 280;
const TK_HAVING = 281;
const TK_BY = 282;
const TK_AS = 283;
const TK_NULL = 284;
const TK_IN = 285;
const TK_UNION = 286;
const TK_ALL = 287;
const TK_WITH = 288;
const TK_UR = 289;
const TK_FETCH = 290;
const TK_FIRST = 291;
const TK_ROWS = 292;
const TK_ONLY = 293;
const TK_UPDATE = 294;
const TK_SET = 295;
const TK_ASTERISK = 296;
const TK_COMMA = 297;
const TK_LEFT_PARENT = 298;
const TK_RIGHT_PARENT = 299;
const TK_PLUS = 300;
const TK_SLASH = 301;
const TK_COLON = 302;
const TK_QUESTION = 303;
const TK_WELL = 304;
const TK_SPOT = 305;
const TK_OPERATOR = 306;
const TK_END = 307;

// If you have defined your own YYSType then put an empty  %union { } in
// your .y file. Or you can put your type definition within the curly braces.
type YYSType = record
                 yyString : String;
                 yyTSQLTreeNode : TSQLTreeNode;
               end(*YYSType*);
// source: E:\Tools\Develop\Others\dyacclex-1.4\src\yacc\yyparse.cod line# 2

var yylval : YYSType;

type
  TLexer = class(TLexerParserBase)
  public
    function parse() : integer; override;
  end;

  TParser = class(TLexerParserBase)
  public
    lexer : TLexer;

    function parse() : integer; override;
  end;


function TParser.parse() : integer;

var 
  yystate, yysp, yyn : Integer;
  yys : array [1..yymaxdepth] of Integer;
  yyv : array [1..yymaxdepth] of YYSType;
  yyval : YYSType;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)

  var 
    //_node: TSQLTreeNode;
    _i: integer;
// source: E:\Tools\Develop\Others\dyacclex-1.4\src\yacc\yyparse.cod line# 30
begin
  (* actions: *)
  case yyruleno of
1 : begin
       end;
2 : begin
         // source: sqlYacc.txt line#84
         
         yyaccept; 
         
       end;
3 : begin
         // source: sqlYacc.txt line#88
         
         
       end;
4 : begin
         // source: sqlYacc.txt line#91
         
         
       end;
5 : begin
         // source: sqlYacc.txt line#94
         
         //出错时，指针移向TK_END(分号;)继续
         //writeln(g_tree.P_GetSubTreeText(0));
         //G_Init;
         yyerrok; 
         
       end;
6 : begin
         // source: sqlYacc.txt line#104
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //  inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Query1';
         yyval.yyTSQLTreeNode.R_Keyword := snkQuery;
         yyval.yyTSQLTreeNode.R_Type := sntSentence;
         yyval.yyTSQLTreeNode.R_Text := C_QUERY;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-6].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-5].yyTSQLTreeNode);
         if yyv[yysp-4].yyTSQLTreeNode <> nil then
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-4].yyTSQLTreeNode);
         if yyv[yysp-3].yyTSQLTreeNode <> nil then
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-3].yyTSQLTreeNode);
         if yyv[yysp-2].yyTSQLTreeNode <> nil then
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         if yyv[yysp-1].yyTSQLTreeNode <> nil then
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         
       end;
7 : begin
         // source: sqlYacc.txt line#128
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //  inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Query2';
         yyval.yyTSQLTreeNode.R_Text := '<' + UpperCase(yyval.yyTSQLTreeNode.R_Text) + '>';
         yyval.yyTSQLTreeNode.R_Keyword := snkUnionClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
8 : begin
         // source: sqlYacc.txt line#144
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //  inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Query3';
         yyval.yyTSQLTreeNode.R_Text := '<' + UpperCase(yyval.yyTSQLTreeNode.R_Text) + ' ALL>';
         yyval.yyTSQLTreeNode.R_Keyword := snkUnionClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-3].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
9 : begin
       end;
10 : begin
         // source: sqlYacc.txt line#164
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;	
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Expression1';
         yyval.yyTSQLTreeNode.R_Keyword := snkExpression;
         
       end;
11 : begin
         // source: sqlYacc.txt line#173
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Expression2';
         yyval.yyTSQLTreeNode.R_Keyword := snkExpression;
         
       end;
12 : begin
         // source: sqlYacc.txt line#182
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Expression3';
         yyval.yyTSQLTreeNode.R_Keyword := snkAliasAndField;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-2].yyTSQLTreeNode.R_Text + '.' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
13 : begin
         // source: sqlYacc.txt line#195
         
         //参数引用。如：:?1.fieldName
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Expression4';
         yyval.yyTSQLTreeNode.R_Keyword := snkAliasAndField;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-2].yyTSQLTreeNode.R_Text + '.' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
14 : begin
         // source: sqlYacc.txt line#209
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Expression5';
         yyval.yyTSQLTreeNode.R_Keyword := snkExpression;
         
       end;
15 : begin
         // source: sqlYacc.txt line#221
         
         //ShowMessage('TK_SELECT tySelectList');
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectClause1';
         if yyv[yysp-1].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
16 : begin
         // source: sqlYacc.txt line#233
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectClause2';
         if yyv[yysp-2].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-2].yyTSQLTreeNode);
         
       end;
17 : begin
         // source: sqlYacc.txt line#245
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectClause3';
         if yyv[yysp-2].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-2].yyTSQLTreeNode);
         
       end;
18 : begin
         // source: sqlYacc.txt line#260
         
         //ShowMessage('tySelectItem' + yyv[yysp-0].yyTSQLTreeNode.R_Text);
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectList1';
         yyval.yyTSQLTreeNode.R_Keyword := snkFields;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_FIELDS;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
19 : begin
         // source: sqlYacc.txt line#273
         
         //ShowMessage('tySelectList 1: + ' + yyv[yysp-2].yyTSQLTreeNode.R_Text + ' , tySelectList 2: ' + yyv[yysp-0].yyTSQLTreeNode.R_Text);
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectList2';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         //g_tree.P_MoveChildNodes(yyv[yysp-0].yyTSQLTreeNode, yyval.yyTSQLTreeNode, acmLast); (* 字段列表节点重复，只要其中一个 *)
         //g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
20 : begin
         // source: sqlYacc.txt line#288
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectItem1';
         
       end;
21 : begin
         // source: sqlYacc.txt line#296
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectItem2';
         
       end;
22 : begin
         // source: sqlYacc.txt line#304
         
         //字段别名 
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectItem3';
         yyval.yyTSQLTreeNode.R_Nodes[_i].R_AliasName := yyv[yysp-0].yyTSQLTreeNode.R_Text;
         if yyv[yysp-0].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
23 : begin
         // source: sqlYacc.txt line#318
         
         //字段别名 
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')SelectItem4';
         yyval.yyTSQLTreeNode.R_AliasName := yyv[yysp-0].yyTSQLTreeNode.R_Text;
         if yyv[yysp-0].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
24 : begin
         // source: sqlYacc.txt line#333
         
         (* 字段为空 *)
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr1';
         yyval.yyTSQLTreeNode.R_Keyword := snkIdentifier;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := '';
         
       end;
25 : begin
         // source: sqlYacc.txt line#345
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr2';
         
       end;
26 : begin
         // source: sqlYacc.txt line#353
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr3';
         yyval.yyTSQLTreeNode.R_Keyword := snkAliasAndField;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-2].yyTSQLTreeNode.R_Text + '.' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
27 : begin
         // source: sqlYacc.txt line#366
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr4';
         
       end;
28 : begin
         // source: sqlYacc.txt line#374
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr5';
         
       end;
29 : begin
         // source: sqlYacc.txt line#382
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr6';
         
       end;
30 : begin
         // source: sqlYacc.txt line#390
         
         yyval.yyTSQLTreeNode:=yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr7';
         
       end;
31 : begin
         // source: sqlYacc.txt line#398
         
         (* 函数 *)
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-4].yyTSQLTreeNode.R_Text + '(' + yyv[yysp-1].yyTSQLTreeNode.R_Text + ')';
         g_tree.P_TakeBack(yyv[yysp-4].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-2].yyTSQLTreeNode);
         
       end;
32 : begin
         // source: sqlYacc.txt line#408
         
         (* 函数 *)
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr8';
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-3].yyTSQLTreeNode.R_Text + '(' + yyv[yysp-1].yyTSQLTreeNode.R_Text + ')';
         g_tree.P_TakeBack(yyv[yysp-3].yyTSQLTreeNode);
         //ShowMessage('tyFieldExpr');
         
       end;
33 : begin
         // source: sqlYacc.txt line#421
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FieldExpr9';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
34 : begin
         // source: sqlYacc.txt line#431
         
         // 格式：':?参数'
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement2';
         yyval.yyTSQLTreeNode.R_Keyword := snkLinkParam;
         
       end;
35 : begin
         // source: sqlYacc.txt line#441
         
         // 格式：':参数'
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement3';
         yyval.yyTSQLTreeNode.R_Keyword := snkParam;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-0].yyTSQLTreeNode.R_Text;
         
       end;
36 : begin
         // source: sqlYacc.txt line#452
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement4';
         //ShowMessage('tyConditionElement');
         
       end;
37 : begin
         // source: sqlYacc.txt line#464
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')FromClause1';
         if yyv[yysp-1].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
38 : begin
         // source: sqlYacc.txt line#477
         
         (* 表为空 *)
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableList1';
         yyval.yyTSQLTreeNode.R_Keyword := snkTables;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_TABLES;
         
       end;
39 : begin
         // source: sqlYacc.txt line#489
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableList2';
         yyval.yyTSQLTreeNode.R_Keyword := snkTables;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_TABLES;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
40 : begin
         // source: sqlYacc.txt line#501
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableList3';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         //g_tree.P_MoveChildNodes(yyv[yysp-0].yyTSQLTreeNode, yyv[yysp-2].yyTSQLTreeNode, acmLast); (* 字段列表节点重复，只要其中一个 *)
         //g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
41 : begin
         // source: sqlYacc.txt line#515
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableItem1';
         //ShowMessage('tyTableItem');
         
       end;
42 : begin
         // source: sqlYacc.txt line#524
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableItem2';
         
       end;
43 : begin
         // source: sqlYacc.txt line#532
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableItem3';
         yyval.yyTSQLTreeNode.R_AliasName := yyv[yysp-0].yyTSQLTreeNode.R_Text;
         if yyv[yysp-0].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
44 : begin
         // source: sqlYacc.txt line#545
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableItem4';
         yyval.yyTSQLTreeNode.R_AliasName := yyv[yysp-0].yyTSQLTreeNode.R_Text;
         if yyv[yysp-0].yyTSQLTreeNode.R_IsCurrent then
         yyval.yyTSQLTreeNode.R_IsCurrent := true;
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
45 : begin
         // source: sqlYacc.txt line#560
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode; 
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableExpr1';
         
       end;
46 : begin
         // source: sqlYacc.txt line#568
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableExpr2';
         yyval.yyTSQLTreeNode.R_Keyword := snkSchemaAndTable;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-2].yyTSQLTreeNode.R_Text + '.' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
47 : begin
         // source: sqlYacc.txt line#581
         
         yyval.yyTSQLTreeNode:=yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')TableExpr3';
         //ShowMessage('tyTableItem');
         
       end;
48 : begin
         // source: sqlYacc.txt line#592
         
         yyval.yyTSQLTreeNode := nil;
         
       end;
49 : begin
         // source: sqlYacc.txt line#596
         
         if yyv[yysp-1].yyTSQLTreeNode=nil then begin
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         yyval.yyTSQLTreeNode.R_Keyword := snkJoins;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_JOINS;
         end else begin
         yyval.yyTSQLTreeNode:=yyv[yysp-1].yyTSQLTreeNode;
         end;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinClause2';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
50 : begin
         // source: sqlYacc.txt line#615
         
         yyval.yyTSQLTreeNode := yyv[yysp-3].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         
         _tmpNode := g_tree.P_NewNode;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, _tmpNode);
         _tmpNode.R_Text := C_TABLES;
         _tmpNode.R_Keyword := snkTables;
         _tmpNode.R_Type := sntKey;
         _tmpNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         
         yyv[yysp-1].yyTSQLTreeNode.R_Keyword := snkWhereClause;
         yyv[yysp-1].yyTSQLTreeNode.R_Type := sntKey;
         yyv[yysp-1].yyTSQLTreeNode.R_Text := C_JOIN_CONDITIONS;
         yyv[yysp-1].yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
51 : begin
         // source: sqlYacc.txt line#640
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkJoinClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_INNER_JOIN;
         
       end;
52 : begin
         // source: sqlYacc.txt line#651
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkJoinClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_INNER_JOIN;
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
53 : begin
         // source: sqlYacc.txt line#663
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkJoinClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_LEFT_JOIN;
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
54 : begin
         // source: sqlYacc.txt line#675
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkJoinClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_LEFT_JOIN;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
55 : begin
         // source: sqlYacc.txt line#688
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkJoinClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_RIGHT_JOIN;
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
56 : begin
         // source: sqlYacc.txt line#700
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')JoinItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkJoinClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_RIGHT_JOIN;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
57 : begin
         // source: sqlYacc.txt line#714
         (* 可以为空 *) 
       end;
58 : begin
         // source: sqlYacc.txt line#716
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereClause1';
         yyval.yyTSQLTreeNode.R_Keyword := snkWhereClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_CONDITIONS;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
59 : begin
         // source: sqlYacc.txt line#729
         (* 正常不可以为空 *) 
       end;
60 : begin
         // source: sqlYacc.txt line#731
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereList1';
         //ShowMessage('tyWhereList -> tyWhereItem = '
         //  + yyv[yysp-0].yyTSQLTreeNode.R_Text);
         
       end;
61 : begin
         // source: sqlYacc.txt line#741
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereList2';
         yyval.yyTSQLTreeNode.R_Keyword := snkConditionClause;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode); 
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         //ShowMessage('tyWhereList -> tyWhereList tyOrAnd tyWhereList = '
         //  + yyv[yysp-2].yyTSQLTreeNode.R_Text + ' ' + yyval.yyTSQLTreeNode.R_Text + ' ' + yyv[yysp-0].yyTSQLTreeNode.R_Text);
         
       end;
62 : begin
         // source: sqlYacc.txt line#755
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereList3';
         yyval.yyTSQLTreeNode.R_Keyword := snkConditionClause;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode); 
         
       end;
63 : begin
         // source: sqlYacc.txt line#766
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereList4';
         //ShowMessage('tyWhereList -> TK_LEFT_PARENT tyWhereList TK_RIGHT_PARENT = '+ yyval.yyTSQLTreeNode.R_Text + ')');
         
       end;
64 : begin
         // source: sqlYacc.txt line#778
         
         yyval.yyTSQLTreeNode := yyv[yysp-3].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereItem1';
         yyval.yyTSQLTreeNode.R_Keyword := snkConditionClause;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         //ShowMessage('tyWhereItem');
         
       end;
65 : begin
         // source: sqlYacc.txt line#790
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereItem2';
         //ShowMessage('tyWhereItem - tyConditionElement : ' + yyval.yyTSQLTreeNode.R_Text);
         
       end;
66 : begin
         // source: sqlYacc.txt line#801
         
         (* 字段为空 *)
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement1';
         yyval.yyTSQLTreeNode.R_Keyword := snkNone;
         yyval.yyTSQLTreeNode.R_Text := '';
         
       end;
67 : begin
         // source: sqlYacc.txt line#812
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement5';
         
       end;
68 : begin
         // source: sqlYacc.txt line#820
         
         (* 表达式 *)
         yyval.yyTSQLTreeNode := yyv[yysp-3].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement8';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-4].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         //ShowMessage('tyConditionElement');
         
       end;
69 : begin
         // source: sqlYacc.txt line#832
         
         (* 表达式 *)
         yyval.yyTSQLTreeNode := yyv[yysp-3].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement9';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-4].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         //ShowMessage('tyConditionElement');
         
       end;
70 : begin
         // source: sqlYacc.txt line#844
         
         (* 表达式 *)
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement10';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
71 : begin
         // source: sqlYacc.txt line#855
         
         (* 表达式 *)
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')ConditionElement11';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
72 : begin
         // source: sqlYacc.txt line#869
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrAnd1';
         yyval.yyTSQLTreeNode.R_Keyword := snkConditionClause;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         
       end;
73 : begin
         // source: sqlYacc.txt line#879
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrAnd2';
         yyval.yyTSQLTreeNode.R_Keyword := snkConditionClause;
         yyval.yyTSQLTreeNode.R_Type := sntNode;
         
       end;
74 : begin
       end;
75 : begin
         // source: sqlYacc.txt line#892
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrderClause1';
         g_tree.P_Takeback(yyv[yysp-2].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
76 : begin
       end;
77 : begin
         // source: sqlYacc.txt line#905
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrderList1';
         yyval.yyTSQLTreeNode.R_Keyword := snkOrderClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_ORDER;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
78 : begin
         // source: sqlYacc.txt line#917
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrderList2';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
79 : begin
       end;
80 : begin
         // source: sqlYacc.txt line#929
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrderItem1';
         
       end;
81 : begin
         // source: sqlYacc.txt line#937
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrderItem2';
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
82 : begin
         // source: sqlYacc.txt line#946
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')OrderItem3';
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
83 : begin
       end;
84 : begin
         // source: sqlYacc.txt line#958
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')GroupClause1';
         g_tree.P_Takeback(yyv[yysp-3].yyTSQLTreeNode);
         g_tree.P_Takeback(yyv[yysp-2].yyTSQLTreeNode);
         if yyv[yysp-0].yyTSQLTreeNode <> nil then begin
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         end;
         
       end;
85 : begin
       end;
86 : begin
         // source: sqlYacc.txt line#974
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')GroupList1';
         yyval.yyTSQLTreeNode.R_Keyword := snkGroupClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_GROUP;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
87 : begin
         // source: sqlYacc.txt line#986
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')GroupList1';
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
88 : begin
       end;
89 : begin
         // source: sqlYacc.txt line#998
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')GroupItem1';
         
       end;
90 : begin
       end;
91 : begin
         // source: sqlYacc.txt line#1009
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')HavingClause1';
         yyval.yyTSQLTreeNode.R_Keyword := snkWhereClause;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_HAVING_CONDITIONS;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
92 : begin
       end;
93 : begin
         // source: sqlYacc.txt line#1024
         
         g_tree.P_TakeBack(yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
94 : begin
         // source: sqlYacc.txt line#1029
         
         g_tree.P_TakeBack(yyv[yysp-4].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-3].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-2].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-1].yyTSQLTreeNode);
         g_tree.P_TakeBack(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
95 : begin
         // source: sqlYacc.txt line#1040
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')In1';
         
       end;
96 : begin
         // source: sqlYacc.txt line#1048
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')In2';
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-1].yyTSQLTreeNode.R_Text + ' ' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
97 : begin
         // source: sqlYacc.txt line#1061
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Like1';
         
       end;
98 : begin
         // source: sqlYacc.txt line#1069
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Like2';
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-1].yyTSQLTreeNode.R_Text + ' ' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
99 : begin
         // source: sqlYacc.txt line#1082
         
         yyval.yyTSQLTreeNode:=yyv[yysp-0].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Is1';
         
       end;
100 : begin
         // source: sqlYacc.txt line#1090
         
         yyval.yyTSQLTreeNode:=yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         //if yyval.yyTSQLTreeNode.R_Path<>'' then
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         //yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')Is2';
         yyval.yyTSQLTreeNode.R_Text := yyv[yysp-1].yyTSQLTreeNode.R_Text + ' ' + yyv[yysp-0].yyTSQLTreeNode.R_Text;
         g_tree.P_Takeback(yyv[yysp-0].yyTSQLTreeNode);
         
       end;
101 : begin
         // source: sqlYacc.txt line#1103
         
         yyval.yyTSQLTreeNode := g_tree.P_newNode;
         yyval.yyTSQLTreeNode.R_Keyword := snkUpdate;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_UPDATE;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         if yyv[yysp-1].yyTSQLTreeNode <> nil then
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         if yyv[yysp-0].yyTSQLTreeNode <> nil then
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
102 : begin
       end;
103 : begin
         // source: sqlYacc.txt line#1118
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         inc(_step);
         if yyval.yyTSQLTreeNode.R_Path<>'' then
         yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '->';
         yyval.yyTSQLTreeNode.R_Path := yyval.yyTSQLTreeNode.R_Path + '(' + IntToStr(_step) + ')WhereClause1';
         yyval.yyTSQLTreeNode.R_Keyword := snkTables;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_TABLES;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
104 : begin
       end;
105 : begin
         // source: sqlYacc.txt line#1133
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
106 : begin
         // source: sqlYacc.txt line#1138
         
         yyval.yyTSQLTreeNode := yyv[yysp-0].yyTSQLTreeNode;
         g_tree.P_Takeback(yyv[yysp-1].yyTSQLTreeNode);
         
       end;
107 : begin
       end;
108 : begin
         // source: sqlYacc.txt line#1146
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         yyval.yyTSQLTreeNode.R_Keyword := snkSet;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_SET;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-5].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-3].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         
       end;
109 : begin
         // source: sqlYacc.txt line#1156
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         yyval.yyTSQLTreeNode.R_Keyword := snkSet;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_SET;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-3].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-1].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
110 : begin
       end;
111 : begin
         // source: sqlYacc.txt line#1169
         
         yyval.yyTSQLTreeNode := g_tree.P_NewNode;
         yyval.yyTSQLTreeNode.R_Keyword := snkSet;
         yyval.yyTSQLTreeNode.R_Type := sntKey;
         yyval.yyTSQLTreeNode.R_Text := C_SET;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
112 : begin
         // source: sqlYacc.txt line#1177
         
         yyval.yyTSQLTreeNode := yyv[yysp-2].yyTSQLTreeNode;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
113 : begin
       end;
114 : begin
         // source: sqlYacc.txt line#1185
         
         yyval.yyTSQLTreeNode := yyv[yysp-1].yyTSQLTreeNode;
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-2].yyTSQLTreeNode);
         yyval.yyTSQLTreeNode.P_InsertChild(acmLast, yyv[yysp-0].yyTSQLTreeNode);
         
       end;
// source: E:\Tools\Develop\Others\dyacclex-1.4\src\yacc\yyparse.cod line# 34
  end;
end(*yyaction*);

(* parse table: *)

type YYARec = record
                sym, act : Integer;
              end;
     YYRRec = record
                len, sym : Integer;
              end;

const

yynacts   = 1039;
yyngotos  = 153;
yynstates = 185;
yynrules  = 114;
yymaxtoken = 307;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 256; act: 2 ),
  ( sym: 0; act: -1 ),
  ( sym: 261; act: -1 ),
  ( sym: 264; act: -1 ),
  ( sym: 294; act: -1 ),
  ( sym: 295; act: -1 ),
  ( sym: 307; act: -1 ),
{ 1: }
  ( sym: 0; act: 0 ),
  ( sym: 261; act: 7 ),
  ( sym: 294; act: 8 ),
  ( sym: 307; act: 9 ),
  ( sym: 264; act: -102 ),
  ( sym: 295; act: -102 ),
{ 2: }
  ( sym: 307; act: 10 ),
{ 3: }
  ( sym: 295; act: 12 ),
  ( sym: 264; act: -104 ),
  ( sym: 307; act: -104 ),
{ 4: }
  ( sym: 307; act: 13 ),
{ 5: }
  ( sym: 262; act: 15 ),
{ 6: }
  ( sym: 286; act: 16 ),
  ( sym: 307; act: 17 ),
{ 7: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 263; act: 26 ),
  ( sym: 287; act: 27 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 262; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 306; act: -9 ),
{ 8: }
  ( sym: 257; act: 33 ),
  ( sym: 298; act: 34 ),
{ 9: }
{ 10: }
{ 11: }
  ( sym: 264; act: 36 ),
  ( sym: 307; act: -57 ),
{ 12: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 41 ),
  ( sym: 302; act: 30 ),
  ( sym: 306; act: -9 ),
  ( sym: 264; act: -107 ),
  ( sym: 307; act: -107 ),
  ( sym: 297; act: -110 ),
{ 13: }
{ 14: }
{ 15: }
  ( sym: 257; act: 33 ),
  ( sym: 298; act: 34 ),
  ( sym: 264; act: -38 ),
  ( sym: 271; act: -38 ),
  ( sym: 272; act: -38 ),
  ( sym: 273; act: -38 ),
  ( sym: 275; act: -38 ),
  ( sym: 277; act: -38 ),
  ( sym: 280; act: -38 ),
  ( sym: 286; act: -38 ),
  ( sym: 288; act: -38 ),
  ( sym: 290; act: -38 ),
  ( sym: 297; act: -38 ),
  ( sym: 299; act: -38 ),
  ( sym: 307; act: -38 ),
{ 16: }
  ( sym: 261; act: 7 ),
  ( sym: 287; act: 46 ),
{ 17: }
{ 18: }
{ 19: }
  ( sym: 306; act: 47 ),
  ( sym: 257; act: -21 ),
  ( sym: 262; act: -21 ),
  ( sym: 283; act: -21 ),
  ( sym: 297; act: -21 ),
  ( sym: 299; act: -21 ),
{ 20: }
  ( sym: 257; act: 48 ),
  ( sym: 283; act: 49 ),
  ( sym: 262; act: -18 ),
  ( sym: 297; act: -18 ),
  ( sym: 299; act: -18 ),
{ 21: }
  ( sym: 297; act: 50 ),
  ( sym: 262; act: -15 ),
{ 22: }
  ( sym: 298; act: 51 ),
  ( sym: 305; act: 52 ),
  ( sym: 257; act: -10 ),
  ( sym: 262; act: -10 ),
  ( sym: 264; act: -10 ),
  ( sym: 265; act: -10 ),
  ( sym: 266; act: -10 ),
  ( sym: 267; act: -10 ),
  ( sym: 269; act: -10 ),
  ( sym: 270; act: -10 ),
  ( sym: 271; act: -10 ),
  ( sym: 272; act: -10 ),
  ( sym: 273; act: -10 ),
  ( sym: 275; act: -10 ),
  ( sym: 277; act: -10 ),
  ( sym: 278; act: -10 ),
  ( sym: 279; act: -10 ),
  ( sym: 280; act: -10 ),
  ( sym: 281; act: -10 ),
  ( sym: 283; act: -10 ),
  ( sym: 285; act: -10 ),
  ( sym: 286; act: -10 ),
  ( sym: 288; act: -10 ),
  ( sym: 290; act: -10 ),
  ( sym: 297; act: -10 ),
  ( sym: 299; act: -10 ),
  ( sym: 306; act: -10 ),
  ( sym: 307; act: -10 ),
{ 23: }
{ 24: }
  ( sym: 305; act: 53 ),
  ( sym: 257; act: -11 ),
  ( sym: 262; act: -11 ),
  ( sym: 264; act: -11 ),
  ( sym: 265; act: -11 ),
  ( sym: 266; act: -11 ),
  ( sym: 267; act: -11 ),
  ( sym: 269; act: -11 ),
  ( sym: 270; act: -11 ),
  ( sym: 271; act: -11 ),
  ( sym: 272; act: -11 ),
  ( sym: 273; act: -11 ),
  ( sym: 275; act: -11 ),
  ( sym: 277; act: -11 ),
  ( sym: 278; act: -11 ),
  ( sym: 279; act: -11 ),
  ( sym: 280; act: -11 ),
  ( sym: 281; act: -11 ),
  ( sym: 283; act: -11 ),
  ( sym: 285; act: -11 ),
  ( sym: 286; act: -11 ),
  ( sym: 288; act: -11 ),
  ( sym: 290; act: -11 ),
  ( sym: 297; act: -11 ),
  ( sym: 299; act: -11 ),
  ( sym: 306; act: -11 ),
  ( sym: 307; act: -11 ),
{ 25: }
{ 26: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 262; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 306; act: -9 ),
{ 27: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 262; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 306; act: -9 ),
{ 28: }
{ 29: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 261; act: 7 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 30: }
  ( sym: 257; act: 60 ),
  ( sym: 259; act: 24 ),
  ( sym: 303; act: 61 ),
  ( sym: 262; act: -9 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 267; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 271; act: -9 ),
  ( sym: 272; act: -9 ),
  ( sym: 273; act: -9 ),
  ( sym: 275; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 278; act: -9 ),
  ( sym: 279; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 281; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 31: }
{ 32: }
  ( sym: 257; act: 62 ),
  ( sym: 283; act: 63 ),
  ( sym: 264; act: -103 ),
  ( sym: 295; act: -103 ),
  ( sym: 307; act: -103 ),
{ 33: }
  ( sym: 305; act: 64 ),
  ( sym: 257; act: -45 ),
  ( sym: 264; act: -45 ),
  ( sym: 271; act: -45 ),
  ( sym: 272; act: -45 ),
  ( sym: 273; act: -45 ),
  ( sym: 275; act: -45 ),
  ( sym: 276; act: -45 ),
  ( sym: 277; act: -45 ),
  ( sym: 280; act: -45 ),
  ( sym: 283; act: -45 ),
  ( sym: 286; act: -45 ),
  ( sym: 288; act: -45 ),
  ( sym: 290; act: -45 ),
  ( sym: 295; act: -45 ),
  ( sym: 297; act: -45 ),
  ( sym: 299; act: -45 ),
  ( sym: 307; act: -45 ),
{ 34: }
  ( sym: 257; act: 33 ),
  ( sym: 261; act: 7 ),
  ( sym: 298; act: 67 ),
{ 35: }
{ 36: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 267; act: 72 ),
  ( sym: 268; act: 73 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 74 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 37: }
{ 38: }
{ 39: }
  ( sym: 297; act: 75 ),
  ( sym: 264; act: -105 ),
  ( sym: 307; act: -105 ),
{ 40: }
  ( sym: 306; act: 76 ),
{ 41: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 261; act: 7 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 42: }
  ( sym: 264; act: 36 ),
  ( sym: 271; act: 83 ),
  ( sym: 272; act: 84 ),
  ( sym: 273; act: 85 ),
  ( sym: 275; act: 86 ),
  ( sym: 277; act: -57 ),
  ( sym: 280; act: -57 ),
  ( sym: 286; act: -57 ),
  ( sym: 288; act: -57 ),
  ( sym: 290; act: -57 ),
  ( sym: 299; act: -57 ),
  ( sym: 307; act: -57 ),
{ 43: }
  ( sym: 257; act: 62 ),
  ( sym: 283; act: 63 ),
  ( sym: 264; act: -39 ),
  ( sym: 271; act: -39 ),
  ( sym: 272; act: -39 ),
  ( sym: 273; act: -39 ),
  ( sym: 275; act: -39 ),
  ( sym: 277; act: -39 ),
  ( sym: 280; act: -39 ),
  ( sym: 286; act: -39 ),
  ( sym: 288; act: -39 ),
  ( sym: 290; act: -39 ),
  ( sym: 297; act: -39 ),
  ( sym: 299; act: -39 ),
  ( sym: 307; act: -39 ),
{ 44: }
  ( sym: 297; act: 87 ),
  ( sym: 264; act: -37 ),
  ( sym: 271; act: -37 ),
  ( sym: 272; act: -37 ),
  ( sym: 273; act: -37 ),
  ( sym: 275; act: -37 ),
  ( sym: 277; act: -37 ),
  ( sym: 280; act: -37 ),
  ( sym: 286; act: -37 ),
  ( sym: 288; act: -37 ),
  ( sym: 290; act: -37 ),
  ( sym: 299; act: -37 ),
  ( sym: 307; act: -37 ),
{ 45: }
  ( sym: 286; act: 16 ),
  ( sym: 264; act: -7 ),
  ( sym: 299; act: -7 ),
  ( sym: 307; act: -7 ),
{ 46: }
  ( sym: 261; act: 7 ),
{ 47: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 262; act: -9 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 267; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 271; act: -9 ),
  ( sym: 272; act: -9 ),
  ( sym: 273; act: -9 ),
  ( sym: 275; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 278; act: -9 ),
  ( sym: 279; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 281; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 48: }
{ 49: }
  ( sym: 257; act: 90 ),
{ 50: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 262; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 51: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 263; act: 93 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 52: }
  ( sym: 257; act: 94 ),
  ( sym: 296; act: 95 ),
  ( sym: 262; act: -14 ),
  ( sym: 264; act: -14 ),
  ( sym: 265; act: -14 ),
  ( sym: 266; act: -14 ),
  ( sym: 267; act: -14 ),
  ( sym: 269; act: -14 ),
  ( sym: 270; act: -14 ),
  ( sym: 271; act: -14 ),
  ( sym: 272; act: -14 ),
  ( sym: 273; act: -14 ),
  ( sym: 275; act: -14 ),
  ( sym: 277; act: -14 ),
  ( sym: 278; act: -14 ),
  ( sym: 279; act: -14 ),
  ( sym: 280; act: -14 ),
  ( sym: 281; act: -14 ),
  ( sym: 283; act: -14 ),
  ( sym: 285; act: -14 ),
  ( sym: 286; act: -14 ),
  ( sym: 288; act: -14 ),
  ( sym: 290; act: -14 ),
  ( sym: 297; act: -14 ),
  ( sym: 299; act: -14 ),
  ( sym: 306; act: -14 ),
  ( sym: 307; act: -14 ),
{ 53: }
  ( sym: 257; act: 96 ),
{ 54: }
  ( sym: 297; act: 50 ),
  ( sym: 262; act: -16 ),
{ 55: }
  ( sym: 297; act: 50 ),
  ( sym: 262; act: -17 ),
{ 56: }
  ( sym: 299; act: 97 ),
  ( sym: 306; act: 47 ),
{ 57: }
  ( sym: 286; act: 16 ),
  ( sym: 299; act: 98 ),
{ 58: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 261; act: 7 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 59: }
{ 60: }
  ( sym: 305; act: 99 ),
  ( sym: 257; act: -10 ),
  ( sym: 262; act: -10 ),
  ( sym: 264; act: -10 ),
  ( sym: 265; act: -10 ),
  ( sym: 266; act: -10 ),
  ( sym: 267; act: -10 ),
  ( sym: 269; act: -10 ),
  ( sym: 270; act: -10 ),
  ( sym: 271; act: -10 ),
  ( sym: 272; act: -10 ),
  ( sym: 273; act: -10 ),
  ( sym: 275; act: -10 ),
  ( sym: 277; act: -10 ),
  ( sym: 278; act: -10 ),
  ( sym: 279; act: -10 ),
  ( sym: 280; act: -10 ),
  ( sym: 281; act: -10 ),
  ( sym: 283; act: -10 ),
  ( sym: 285; act: -10 ),
  ( sym: 286; act: -10 ),
  ( sym: 288; act: -10 ),
  ( sym: 290; act: -10 ),
  ( sym: 297; act: -10 ),
  ( sym: 299; act: -10 ),
  ( sym: 306; act: -10 ),
  ( sym: 307; act: -10 ),
{ 61: }
  ( sym: 257; act: 60 ),
  ( sym: 259; act: 24 ),
  ( sym: 262; act: -9 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 267; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 271; act: -9 ),
  ( sym: 272; act: -9 ),
  ( sym: 273; act: -9 ),
  ( sym: 275; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 278; act: -9 ),
  ( sym: 279; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 281; act: -9 ),
  ( sym: 283; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 62: }
{ 63: }
  ( sym: 257; act: 101 ),
{ 64: }
  ( sym: 257; act: 102 ),
{ 65: }
  ( sym: 299; act: 103 ),
{ 66: }
  ( sym: 286; act: 16 ),
  ( sym: 299; act: 104 ),
{ 67: }
  ( sym: 257; act: 33 ),
  ( sym: 298; act: 67 ),
{ 68: }
  ( sym: 267; act: 108 ),
  ( sym: 269; act: 109 ),
  ( sym: 270; act: 110 ),
  ( sym: 285; act: 111 ),
  ( sym: 264; act: -65 ),
  ( sym: 265; act: -65 ),
  ( sym: 266; act: -65 ),
  ( sym: 271; act: -65 ),
  ( sym: 272; act: -65 ),
  ( sym: 273; act: -65 ),
  ( sym: 275; act: -65 ),
  ( sym: 277; act: -65 ),
  ( sym: 280; act: -65 ),
  ( sym: 286; act: -65 ),
  ( sym: 288; act: -65 ),
  ( sym: 290; act: -65 ),
  ( sym: 299; act: -65 ),
  ( sym: 307; act: -65 ),
{ 69: }
{ 70: }
  ( sym: 265; act: 113 ),
  ( sym: 266; act: 114 ),
  ( sym: 264; act: -58 ),
  ( sym: 277; act: -58 ),
  ( sym: 280; act: -58 ),
  ( sym: 286; act: -58 ),
  ( sym: 288; act: -58 ),
  ( sym: 290; act: -58 ),
  ( sym: 299; act: -58 ),
  ( sym: 307; act: -58 ),
{ 71: }
  ( sym: 306; act: 47 ),
  ( sym: 264; act: -67 ),
  ( sym: 265; act: -67 ),
  ( sym: 266; act: -67 ),
  ( sym: 267; act: -67 ),
  ( sym: 269; act: -67 ),
  ( sym: 270; act: -67 ),
  ( sym: 271; act: -67 ),
  ( sym: 272; act: -67 ),
  ( sym: 273; act: -67 ),
  ( sym: 275; act: -67 ),
  ( sym: 277; act: -67 ),
  ( sym: 280; act: -67 ),
  ( sym: 285; act: -67 ),
  ( sym: 286; act: -67 ),
  ( sym: 288; act: -67 ),
  ( sym: 290; act: -67 ),
  ( sym: 299; act: -67 ),
  ( sym: 307; act: -67 ),
{ 72: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 267; act: 72 ),
  ( sym: 268; act: 73 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 74 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 271; act: -9 ),
  ( sym: 272; act: -9 ),
  ( sym: 273; act: -9 ),
  ( sym: 275; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 73: }
  ( sym: 298; act: 116 ),
{ 74: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 261; act: 7 ),
  ( sym: 267; act: 72 ),
  ( sym: 268; act: 73 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 74 ),
  ( sym: 302; act: 30 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 75: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 306; act: -9 ),
  ( sym: 264; act: -113 ),
  ( sym: 297; act: -113 ),
  ( sym: 307; act: -113 ),
{ 76: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 77: }
  ( sym: 299; act: 97 ),
  ( sym: 306; act: 47 ),
  ( sym: 257; act: -21 ),
  ( sym: 283; act: -21 ),
  ( sym: 297; act: -21 ),
{ 78: }
  ( sym: 297; act: 50 ),
  ( sym: 299; act: 121 ),
{ 79: }
  ( sym: 286; act: 16 ),
  ( sym: 299; act: 122 ),
{ 80: }
  ( sym: 257; act: 33 ),
  ( sym: 298; act: 34 ),
{ 81: }
{ 82: }
  ( sym: 280; act: 125 ),
  ( sym: 264; act: -83 ),
  ( sym: 277; act: -83 ),
  ( sym: 286; act: -83 ),
  ( sym: 288; act: -83 ),
  ( sym: 290; act: -83 ),
  ( sym: 299; act: -83 ),
  ( sym: 307; act: -83 ),
{ 83: }
  ( sym: 275; act: 126 ),
{ 84: }
  ( sym: 274; act: 127 ),
  ( sym: 275; act: 128 ),
{ 85: }
  ( sym: 274; act: 129 ),
  ( sym: 275; act: 130 ),
{ 86: }
{ 87: }
  ( sym: 257; act: 33 ),
  ( sym: 298; act: 34 ),
{ 88: }
  ( sym: 286; act: 16 ),
  ( sym: 264; act: -8 ),
  ( sym: 299; act: -8 ),
  ( sym: 307; act: -8 ),
{ 89: }
  ( sym: 306; act: 47 ),
  ( sym: 257; act: -33 ),
  ( sym: 262; act: -33 ),
  ( sym: 264; act: -33 ),
  ( sym: 265; act: -33 ),
  ( sym: 266; act: -33 ),
  ( sym: 267; act: -33 ),
  ( sym: 269; act: -33 ),
  ( sym: 270; act: -33 ),
  ( sym: 271; act: -33 ),
  ( sym: 272; act: -33 ),
  ( sym: 273; act: -33 ),
  ( sym: 275; act: -33 ),
  ( sym: 277; act: -33 ),
  ( sym: 278; act: -33 ),
  ( sym: 279; act: -33 ),
  ( sym: 280; act: -33 ),
  ( sym: 281; act: -33 ),
  ( sym: 283; act: -33 ),
  ( sym: 285; act: -33 ),
  ( sym: 286; act: -33 ),
  ( sym: 288; act: -33 ),
  ( sym: 290; act: -33 ),
  ( sym: 297; act: -33 ),
  ( sym: 299; act: -33 ),
  ( sym: 307; act: -33 ),
{ 90: }
{ 91: }
  ( sym: 257; act: 48 ),
  ( sym: 283; act: 49 ),
  ( sym: 262; act: -19 ),
  ( sym: 297; act: -19 ),
  ( sym: 299; act: -19 ),
{ 92: }
  ( sym: 297; act: 50 ),
  ( sym: 299; act: 132 ),
{ 93: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 94: }
{ 95: }
{ 96: }
{ 97: }
{ 98: }
  ( sym: 257; act: -20 ),
  ( sym: 262; act: -20 ),
  ( sym: 283; act: -20 ),
  ( sym: 297; act: -20 ),
  ( sym: 299; act: -20 ),
  ( sym: 306; act: -36 ),
{ 99: }
  ( sym: 257; act: 94 ),
  ( sym: 262; act: -14 ),
  ( sym: 264; act: -14 ),
  ( sym: 265; act: -14 ),
  ( sym: 266; act: -14 ),
  ( sym: 267; act: -14 ),
  ( sym: 269; act: -14 ),
  ( sym: 270; act: -14 ),
  ( sym: 271; act: -14 ),
  ( sym: 272; act: -14 ),
  ( sym: 273; act: -14 ),
  ( sym: 275; act: -14 ),
  ( sym: 277; act: -14 ),
  ( sym: 278; act: -14 ),
  ( sym: 279; act: -14 ),
  ( sym: 280; act: -14 ),
  ( sym: 281; act: -14 ),
  ( sym: 283; act: -14 ),
  ( sym: 285; act: -14 ),
  ( sym: 286; act: -14 ),
  ( sym: 288; act: -14 ),
  ( sym: 290; act: -14 ),
  ( sym: 297; act: -14 ),
  ( sym: 299; act: -14 ),
  ( sym: 306; act: -14 ),
  ( sym: 307; act: -14 ),
{ 100: }
{ 101: }
{ 102: }
{ 103: }
{ 104: }
{ 105: }
  ( sym: 284; act: 134 ),
{ 106: }
  ( sym: 258; act: 135 ),
{ 107: }
  ( sym: 298; act: 136 ),
{ 108: }
  ( sym: 270; act: 137 ),
  ( sym: 285; act: 138 ),
{ 109: }
  ( sym: 267; act: 139 ),
  ( sym: 284; act: -99 ),
{ 110: }
{ 111: }
{ 112: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 267; act: 72 ),
  ( sym: 268; act: 73 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 74 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 271; act: -9 ),
  ( sym: 272; act: -9 ),
  ( sym: 273; act: -9 ),
  ( sym: 275; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 113: }
{ 114: }
{ 115: }
  ( sym: 265; act: 113 ),
  ( sym: 266; act: 114 ),
  ( sym: 264; act: -62 ),
  ( sym: 271; act: -62 ),
  ( sym: 272; act: -62 ),
  ( sym: 273; act: -62 ),
  ( sym: 275; act: -62 ),
  ( sym: 277; act: -62 ),
  ( sym: 280; act: -62 ),
  ( sym: 286; act: -62 ),
  ( sym: 288; act: -62 ),
  ( sym: 290; act: -62 ),
  ( sym: 299; act: -62 ),
  ( sym: 307; act: -62 ),
{ 116: }
  ( sym: 261; act: 7 ),
{ 117: }
  ( sym: 265; act: 113 ),
  ( sym: 266; act: 114 ),
  ( sym: 299; act: 142 ),
{ 118: }
  ( sym: 299; act: 97 ),
  ( sym: 306; act: 47 ),
  ( sym: 265; act: -67 ),
  ( sym: 266; act: -67 ),
  ( sym: 267; act: -67 ),
  ( sym: 269; act: -67 ),
  ( sym: 270; act: -67 ),
  ( sym: 285; act: -67 ),
{ 119: }
{ 120: }
  ( sym: 306; act: 47 ),
  ( sym: 264; act: -114 ),
  ( sym: 297; act: -114 ),
  ( sym: 307; act: -114 ),
{ 121: }
  ( sym: 306; act: 143 ),
{ 122: }
{ 123: }
  ( sym: 257; act: 62 ),
  ( sym: 276; act: 144 ),
  ( sym: 283; act: 63 ),
{ 124: }
  ( sym: 277; act: 146 ),
  ( sym: 264; act: -74 ),
  ( sym: 286; act: -74 ),
  ( sym: 288; act: -74 ),
  ( sym: 290; act: -74 ),
  ( sym: 299; act: -74 ),
  ( sym: 307; act: -74 ),
{ 125: }
  ( sym: 282; act: 147 ),
{ 126: }
{ 127: }
  ( sym: 275; act: 148 ),
{ 128: }
{ 129: }
  ( sym: 275; act: 149 ),
{ 130: }
{ 131: }
  ( sym: 257; act: 62 ),
  ( sym: 283; act: 63 ),
  ( sym: 264; act: -40 ),
  ( sym: 271; act: -40 ),
  ( sym: 272; act: -40 ),
  ( sym: 273; act: -40 ),
  ( sym: 275; act: -40 ),
  ( sym: 277; act: -40 ),
  ( sym: 280; act: -40 ),
  ( sym: 286; act: -40 ),
  ( sym: 288; act: -40 ),
  ( sym: 290; act: -40 ),
  ( sym: 297; act: -40 ),
  ( sym: 299; act: -40 ),
  ( sym: 307; act: -40 ),
{ 132: }
{ 133: }
  ( sym: 297; act: 50 ),
  ( sym: 299; act: 150 ),
{ 134: }
{ 135: }
{ 136: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 261; act: 7 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 137: }
{ 138: }
{ 139: }
{ 140: }
  ( sym: 265; act: 113 ),
  ( sym: 266; act: 114 ),
  ( sym: 264; act: -61 ),
  ( sym: 271; act: -61 ),
  ( sym: 272; act: -61 ),
  ( sym: 273; act: -61 ),
  ( sym: 275; act: -61 ),
  ( sym: 277; act: -61 ),
  ( sym: 280; act: -61 ),
  ( sym: 286; act: -61 ),
  ( sym: 288; act: -61 ),
  ( sym: 290; act: -61 ),
  ( sym: 299; act: -61 ),
  ( sym: 307; act: -61 ),
{ 141: }
  ( sym: 286; act: 16 ),
  ( sym: 299; act: 153 ),
{ 142: }
{ 143: }
  ( sym: 261; act: 7 ),
  ( sym: 298; act: 155 ),
{ 144: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 267; act: 72 ),
  ( sym: 268; act: 73 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 74 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 271; act: -9 ),
  ( sym: 272; act: -9 ),
  ( sym: 273; act: -9 ),
  ( sym: 275; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 280; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 145: }
  ( sym: 288; act: 158 ),
  ( sym: 290; act: 159 ),
  ( sym: 264; act: -92 ),
  ( sym: 286; act: -92 ),
  ( sym: 299; act: -92 ),
  ( sym: 307; act: -92 ),
{ 146: }
  ( sym: 282; act: 160 ),
{ 147: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 281; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 148: }
{ 149: }
{ 150: }
{ 151: }
  ( sym: 297; act: 50 ),
  ( sym: 299; act: 164 ),
{ 152: }
  ( sym: 286; act: 16 ),
  ( sym: 299; act: 165 ),
{ 153: }
{ 154: }
  ( sym: 286; act: 16 ),
  ( sym: 264; act: -109 ),
  ( sym: 307; act: -109 ),
{ 155: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 29 ),
  ( sym: 302; act: 30 ),
  ( sym: 283; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
{ 156: }
  ( sym: 265; act: 113 ),
  ( sym: 266; act: 114 ),
  ( sym: 264; act: -50 ),
  ( sym: 271; act: -50 ),
  ( sym: 272; act: -50 ),
  ( sym: 273; act: -50 ),
  ( sym: 275; act: -50 ),
  ( sym: 277; act: -50 ),
  ( sym: 280; act: -50 ),
  ( sym: 286; act: -50 ),
  ( sym: 288; act: -50 ),
  ( sym: 290; act: -50 ),
  ( sym: 299; act: -50 ),
  ( sym: 307; act: -50 ),
{ 157: }
{ 158: }
  ( sym: 289; act: 167 ),
{ 159: }
  ( sym: 291; act: 168 ),
{ 160: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 278; act: -9 ),
  ( sym: 279; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 161: }
{ 162: }
  ( sym: 281; act: 173 ),
  ( sym: 297; act: 174 ),
  ( sym: 264; act: -90 ),
  ( sym: 277; act: -90 ),
  ( sym: 286; act: -90 ),
  ( sym: 288; act: -90 ),
  ( sym: 290; act: -90 ),
  ( sym: 299; act: -90 ),
  ( sym: 307; act: -90 ),
{ 163: }
  ( sym: 306; act: 47 ),
  ( sym: 264; act: -89 ),
  ( sym: 277; act: -89 ),
  ( sym: 281; act: -89 ),
  ( sym: 286; act: -89 ),
  ( sym: 288; act: -89 ),
  ( sym: 290; act: -89 ),
  ( sym: 297; act: -89 ),
  ( sym: 299; act: -89 ),
  ( sym: 307; act: -89 ),
{ 164: }
{ 165: }
{ 166: }
  ( sym: 297; act: 50 ),
  ( sym: 299; act: 175 ),
{ 167: }
{ 168: }
  ( sym: 259; act: 176 ),
{ 169: }
  ( sym: 278; act: 177 ),
  ( sym: 279; act: 178 ),
  ( sym: 264; act: -77 ),
  ( sym: 286; act: -77 ),
  ( sym: 288; act: -77 ),
  ( sym: 290; act: -77 ),
  ( sym: 297; act: -77 ),
  ( sym: 299; act: -77 ),
  ( sym: 307; act: -77 ),
{ 170: }
  ( sym: 297; act: 179 ),
  ( sym: 264; act: -75 ),
  ( sym: 286; act: -75 ),
  ( sym: 288; act: -75 ),
  ( sym: 290; act: -75 ),
  ( sym: 299; act: -75 ),
  ( sym: 307; act: -75 ),
{ 171: }
  ( sym: 306; act: 47 ),
  ( sym: 264; act: -80 ),
  ( sym: 278; act: -80 ),
  ( sym: 279; act: -80 ),
  ( sym: 286; act: -80 ),
  ( sym: 288; act: -80 ),
  ( sym: 290; act: -80 ),
  ( sym: 297; act: -80 ),
  ( sym: 299; act: -80 ),
  ( sym: 307; act: -80 ),
{ 172: }
{ 173: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 267; act: 72 ),
  ( sym: 268; act: 73 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 74 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 265; act: -9 ),
  ( sym: 266; act: -9 ),
  ( sym: 269; act: -9 ),
  ( sym: 270; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 285; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 174: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 277; act: -9 ),
  ( sym: 281; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 175: }
{ 176: }
  ( sym: 292; act: 182 ),
{ 177: }
{ 178: }
{ 179: }
  ( sym: 257; act: 22 ),
  ( sym: 258; act: 23 ),
  ( sym: 259; act: 24 ),
  ( sym: 260; act: 25 ),
  ( sym: 296; act: 28 ),
  ( sym: 298; act: 58 ),
  ( sym: 302; act: 30 ),
  ( sym: 264; act: -9 ),
  ( sym: 278; act: -9 ),
  ( sym: 279; act: -9 ),
  ( sym: 286; act: -9 ),
  ( sym: 288; act: -9 ),
  ( sym: 290; act: -9 ),
  ( sym: 297; act: -9 ),
  ( sym: 299; act: -9 ),
  ( sym: 306; act: -9 ),
  ( sym: 307; act: -9 ),
{ 180: }
  ( sym: 265; act: 113 ),
  ( sym: 266; act: 114 ),
  ( sym: 264; act: -91 ),
  ( sym: 277; act: -91 ),
  ( sym: 286; act: -91 ),
  ( sym: 288; act: -91 ),
  ( sym: 290; act: -91 ),
  ( sym: 299; act: -91 ),
  ( sym: 307; act: -91 ),
{ 181: }
{ 182: }
  ( sym: 293; act: 184 ),
{ 183: }
  ( sym: 278; act: 177 ),
  ( sym: 279; act: 178 ),
  ( sym: 264; act: -78 ),
  ( sym: 286; act: -78 ),
  ( sym: 288; act: -78 ),
  ( sym: 290; act: -78 ),
  ( sym: 297; act: -78 ),
  ( sym: 299; act: -78 ),
  ( sym: 307; act: -78 )
{ 184: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -37; act: 1 ),
{ 1: }
  ( sym: -12; act: 3 ),
  ( sym: -11; act: 4 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 6 ),
{ 2: }
{ 3: }
  ( sym: -13; act: 11 ),
{ 4: }
{ 5: }
  ( sym: -7; act: 14 ),
{ 6: }
{ 7: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 21 ),
{ 8: }
  ( sym: -10; act: 31 ),
  ( sym: -9; act: 32 ),
{ 9: }
{ 10: }
{ 11: }
  ( sym: -17; act: 35 ),
{ 12: }
  ( sym: -35; act: 18 ),
  ( sym: -16; act: 37 ),
  ( sym: -15; act: 38 ),
  ( sym: -14; act: 39 ),
  ( sym: -6; act: 40 ),
{ 13: }
{ 14: }
  ( sym: -21; act: 42 ),
{ 15: }
  ( sym: -10; act: 31 ),
  ( sym: -9; act: 43 ),
  ( sym: -8; act: 44 ),
{ 16: }
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 45 ),
{ 17: }
{ 18: }
{ 19: }
{ 20: }
{ 21: }
{ 22: }
{ 23: }
{ 24: }
{ 25: }
{ 26: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 54 ),
{ 27: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 55 ),
{ 28: }
{ 29: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 56 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 57 ),
{ 30: }
  ( sym: -35; act: 59 ),
{ 31: }
{ 32: }
{ 33: }
{ 34: }
  ( sym: -10; act: 65 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 66 ),
{ 35: }
{ 36: }
  ( sym: -35; act: 18 ),
  ( sym: -20; act: 68 ),
  ( sym: -19; act: 69 ),
  ( sym: -18; act: 70 ),
  ( sym: -6; act: 71 ),
{ 37: }
{ 38: }
{ 39: }
{ 40: }
{ 41: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 77 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 78 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 79 ),
{ 42: }
  ( sym: -23; act: 80 ),
  ( sym: -22; act: 81 ),
  ( sym: -17; act: 82 ),
{ 43: }
{ 44: }
{ 45: }
{ 46: }
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 88 ),
{ 47: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 89 ),
{ 48: }
{ 49: }
{ 50: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 91 ),
{ 51: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 92 ),
{ 52: }
{ 53: }
{ 54: }
{ 55: }
{ 56: }
{ 57: }
{ 58: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 56 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 79 ),
{ 59: }
{ 60: }
{ 61: }
  ( sym: -35; act: 100 ),
{ 62: }
{ 63: }
{ 64: }
{ 65: }
{ 66: }
{ 67: }
  ( sym: -10; act: 65 ),
{ 68: }
  ( sym: -27; act: 105 ),
  ( sym: -26; act: 106 ),
  ( sym: -25; act: 107 ),
{ 69: }
{ 70: }
  ( sym: -24; act: 112 ),
{ 71: }
{ 72: }
  ( sym: -35; act: 18 ),
  ( sym: -20; act: 68 ),
  ( sym: -19; act: 69 ),
  ( sym: -18; act: 115 ),
  ( sym: -6; act: 71 ),
{ 73: }
{ 74: }
  ( sym: -35; act: 18 ),
  ( sym: -20; act: 68 ),
  ( sym: -19; act: 69 ),
  ( sym: -18; act: 117 ),
  ( sym: -6; act: 118 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 79 ),
{ 75: }
  ( sym: -35; act: 18 ),
  ( sym: -16; act: 119 ),
  ( sym: -6; act: 40 ),
{ 76: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 120 ),
{ 77: }
{ 78: }
{ 79: }
{ 80: }
  ( sym: -10; act: 31 ),
  ( sym: -9; act: 123 ),
{ 81: }
{ 82: }
  ( sym: -28; act: 124 ),
{ 83: }
{ 84: }
{ 85: }
{ 86: }
{ 87: }
  ( sym: -10; act: 31 ),
  ( sym: -9; act: 131 ),
{ 88: }
{ 89: }
{ 90: }
{ 91: }
{ 92: }
{ 93: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 133 ),
{ 94: }
{ 95: }
{ 96: }
{ 97: }
{ 98: }
{ 99: }
{ 100: }
{ 101: }
{ 102: }
{ 103: }
{ 104: }
{ 105: }
{ 106: }
{ 107: }
{ 108: }
{ 109: }
{ 110: }
{ 111: }
{ 112: }
  ( sym: -35; act: 18 ),
  ( sym: -20; act: 68 ),
  ( sym: -19; act: 69 ),
  ( sym: -18; act: 140 ),
  ( sym: -6; act: 71 ),
{ 113: }
{ 114: }
{ 115: }
  ( sym: -24; act: 112 ),
{ 116: }
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 141 ),
{ 117: }
  ( sym: -24; act: 112 ),
{ 118: }
{ 119: }
{ 120: }
{ 121: }
{ 122: }
{ 123: }
{ 124: }
  ( sym: -32; act: 145 ),
{ 125: }
{ 126: }
{ 127: }
{ 128: }
{ 129: }
{ 130: }
{ 131: }
{ 132: }
{ 133: }
{ 134: }
{ 135: }
{ 136: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 151 ),
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 152 ),
{ 137: }
{ 138: }
{ 139: }
{ 140: }
  ( sym: -24; act: 112 ),
{ 141: }
{ 142: }
{ 143: }
  ( sym: -3; act: 5 ),
  ( sym: -2; act: 154 ),
{ 144: }
  ( sym: -35; act: 18 ),
  ( sym: -20; act: 68 ),
  ( sym: -19; act: 69 ),
  ( sym: -18; act: 156 ),
  ( sym: -6; act: 71 ),
{ 145: }
  ( sym: -36; act: 157 ),
{ 146: }
{ 147: }
  ( sym: -35; act: 18 ),
  ( sym: -30; act: 161 ),
  ( sym: -29; act: 162 ),
  ( sym: -6; act: 163 ),
{ 148: }
{ 149: }
{ 150: }
{ 151: }
{ 152: }
{ 153: }
{ 154: }
{ 155: }
  ( sym: -35; act: 18 ),
  ( sym: -6; act: 19 ),
  ( sym: -5; act: 20 ),
  ( sym: -4; act: 166 ),
{ 156: }
  ( sym: -24; act: 112 ),
{ 157: }
{ 158: }
{ 159: }
{ 160: }
  ( sym: -35; act: 18 ),
  ( sym: -34; act: 169 ),
  ( sym: -33; act: 170 ),
  ( sym: -6; act: 171 ),
{ 161: }
{ 162: }
  ( sym: -31; act: 172 ),
{ 163: }
{ 164: }
{ 165: }
{ 166: }
{ 167: }
{ 168: }
{ 169: }
{ 170: }
{ 171: }
{ 172: }
{ 173: }
  ( sym: -35; act: 18 ),
  ( sym: -20; act: 68 ),
  ( sym: -19; act: 69 ),
  ( sym: -18; act: 180 ),
  ( sym: -6; act: 71 ),
{ 174: }
  ( sym: -35; act: 18 ),
  ( sym: -30; act: 181 ),
  ( sym: -6; act: 163 ),
{ 175: }
{ 176: }
{ 177: }
{ 178: }
{ 179: }
  ( sym: -35; act: 18 ),
  ( sym: -34; act: 183 ),
  ( sym: -6; act: 171 ),
{ 180: }
  ( sym: -24; act: 112 )
{ 181: }
{ 182: }
{ 183: }
{ 184: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 0,
{ 3: } 0,
{ 4: } 0,
{ 5: } 0,
{ 6: } 0,
{ 7: } 0,
{ 8: } 0,
{ 9: } -2,
{ 10: } -5,
{ 11: } 0,
{ 12: } 0,
{ 13: } -4,
{ 14: } -48,
{ 15: } 0,
{ 16: } 0,
{ 17: } -3,
{ 18: } -25,
{ 19: } 0,
{ 20: } 0,
{ 21: } 0,
{ 22: } 0,
{ 23: } -29,
{ 24: } 0,
{ 25: } -28,
{ 26: } 0,
{ 27: } 0,
{ 28: } -27,
{ 29: } 0,
{ 30: } 0,
{ 31: } -42,
{ 32: } 0,
{ 33: } 0,
{ 34: } 0,
{ 35: } -101,
{ 36: } 0,
{ 37: } -111,
{ 38: } -106,
{ 39: } 0,
{ 40: } 0,
{ 41: } 0,
{ 42: } 0,
{ 43: } 0,
{ 44: } 0,
{ 45: } 0,
{ 46: } 0,
{ 47: } 0,
{ 48: } -23,
{ 49: } 0,
{ 50: } 0,
{ 51: } 0,
{ 52: } 0,
{ 53: } 0,
{ 54: } 0,
{ 55: } 0,
{ 56: } 0,
{ 57: } 0,
{ 58: } 0,
{ 59: } -35,
{ 60: } 0,
{ 61: } 0,
{ 62: } -44,
{ 63: } 0,
{ 64: } 0,
{ 65: } 0,
{ 66: } 0,
{ 67: } 0,
{ 68: } 0,
{ 69: } -60,
{ 70: } 0,
{ 71: } 0,
{ 72: } 0,
{ 73: } 0,
{ 74: } 0,
{ 75: } 0,
{ 76: } 0,
{ 77: } 0,
{ 78: } 0,
{ 79: } 0,
{ 80: } 0,
{ 81: } -49,
{ 82: } 0,
{ 83: } 0,
{ 84: } 0,
{ 85: } 0,
{ 86: } -51,
{ 87: } 0,
{ 88: } 0,
{ 89: } 0,
{ 90: } -22,
{ 91: } 0,
{ 92: } 0,
{ 93: } 0,
{ 94: } -12,
{ 95: } -26,
{ 96: } -13,
{ 97: } -30,
{ 98: } 0,
{ 99: } 0,
{ 100: } -34,
{ 101: } -43,
{ 102: } -46,
{ 103: } -47,
{ 104: } -41,
{ 105: } 0,
{ 106: } 0,
{ 107: } 0,
{ 108: } 0,
{ 109: } 0,
{ 110: } -97,
{ 111: } -95,
{ 112: } 0,
{ 113: } -73,
{ 114: } -72,
{ 115: } 0,
{ 116: } 0,
{ 117: } 0,
{ 118: } 0,
{ 119: } -112,
{ 120: } 0,
{ 121: } 0,
{ 122: } -36,
{ 123: } 0,
{ 124: } 0,
{ 125: } 0,
{ 126: } -52,
{ 127: } 0,
{ 128: } -53,
{ 129: } 0,
{ 130: } -55,
{ 131: } 0,
{ 132: } -32,
{ 133: } 0,
{ 134: } -70,
{ 135: } -71,
{ 136: } 0,
{ 137: } -98,
{ 138: } -96,
{ 139: } -100,
{ 140: } 0,
{ 141: } 0,
{ 142: } -63,
{ 143: } 0,
{ 144: } 0,
{ 145: } 0,
{ 146: } 0,
{ 147: } 0,
{ 148: } -54,
{ 149: } -56,
{ 150: } -31,
{ 151: } 0,
{ 152: } 0,
{ 153: } -64,
{ 154: } 0,
{ 155: } 0,
{ 156: } 0,
{ 157: } -6,
{ 158: } 0,
{ 159: } 0,
{ 160: } 0,
{ 161: } -86,
{ 162: } 0,
{ 163: } 0,
{ 164: } -68,
{ 165: } -69,
{ 166: } 0,
{ 167: } -93,
{ 168: } 0,
{ 169: } 0,
{ 170: } 0,
{ 171: } 0,
{ 172: } -84,
{ 173: } 0,
{ 174: } 0,
{ 175: } -108,
{ 176: } 0,
{ 177: } -81,
{ 178: } -82,
{ 179: } 0,
{ 180: } 0,
{ 181: } -87,
{ 182: } 0,
{ 183: } 0,
{ 184: } -94
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 8,
{ 2: } 14,
{ 3: } 15,
{ 4: } 18,
{ 5: } 19,
{ 6: } 20,
{ 7: } 22,
{ 8: } 35,
{ 9: } 37,
{ 10: } 37,
{ 11: } 37,
{ 12: } 39,
{ 13: } 50,
{ 14: } 50,
{ 15: } 50,
{ 16: } 65,
{ 17: } 67,
{ 18: } 67,
{ 19: } 67,
{ 20: } 73,
{ 21: } 78,
{ 22: } 80,
{ 23: } 108,
{ 24: } 108,
{ 25: } 135,
{ 26: } 135,
{ 27: } 146,
{ 28: } 157,
{ 29: } 157,
{ 30: } 167,
{ 31: } 195,
{ 32: } 195,
{ 33: } 200,
{ 34: } 218,
{ 35: } 221,
{ 36: } 221,
{ 37: } 244,
{ 38: } 244,
{ 39: } 244,
{ 40: } 247,
{ 41: } 248,
{ 42: } 260,
{ 43: } 272,
{ 44: } 287,
{ 45: } 300,
{ 46: } 304,
{ 47: } 305,
{ 48: } 337,
{ 49: } 337,
{ 50: } 338,
{ 51: } 350,
{ 52: } 362,
{ 53: } 389,
{ 54: } 390,
{ 55: } 392,
{ 56: } 394,
{ 57: } 396,
{ 58: } 398,
{ 59: } 408,
{ 60: } 408,
{ 61: } 435,
{ 62: } 462,
{ 63: } 462,
{ 64: } 463,
{ 65: } 464,
{ 66: } 465,
{ 67: } 467,
{ 68: } 469,
{ 69: } 487,
{ 70: } 487,
{ 71: } 497,
{ 72: } 516,
{ 73: } 543,
{ 74: } 544,
{ 75: } 561,
{ 76: } 572,
{ 77: } 583,
{ 78: } 588,
{ 79: } 590,
{ 80: } 592,
{ 81: } 594,
{ 82: } 594,
{ 83: } 602,
{ 84: } 603,
{ 85: } 605,
{ 86: } 607,
{ 87: } 607,
{ 88: } 609,
{ 89: } 613,
{ 90: } 639,
{ 91: } 639,
{ 92: } 644,
{ 93: } 646,
{ 94: } 657,
{ 95: } 657,
{ 96: } 657,
{ 97: } 657,
{ 98: } 657,
{ 99: } 663,
{ 100: } 689,
{ 101: } 689,
{ 102: } 689,
{ 103: } 689,
{ 104: } 689,
{ 105: } 689,
{ 106: } 690,
{ 107: } 691,
{ 108: } 692,
{ 109: } 694,
{ 110: } 696,
{ 111: } 696,
{ 112: } 696,
{ 113: } 723,
{ 114: } 723,
{ 115: } 723,
{ 116: } 737,
{ 117: } 738,
{ 118: } 741,
{ 119: } 749,
{ 120: } 749,
{ 121: } 753,
{ 122: } 754,
{ 123: } 754,
{ 124: } 757,
{ 125: } 764,
{ 126: } 765,
{ 127: } 765,
{ 128: } 766,
{ 129: } 766,
{ 130: } 767,
{ 131: } 767,
{ 132: } 782,
{ 133: } 782,
{ 134: } 784,
{ 135: } 784,
{ 136: } 784,
{ 137: } 796,
{ 138: } 796,
{ 139: } 796,
{ 140: } 796,
{ 141: } 810,
{ 142: } 812,
{ 143: } 812,
{ 144: } 814,
{ 145: } 841,
{ 146: } 847,
{ 147: } 848,
{ 148: } 865,
{ 149: } 865,
{ 150: } 865,
{ 151: } 865,
{ 152: } 867,
{ 153: } 869,
{ 154: } 869,
{ 155: } 872,
{ 156: } 883,
{ 157: } 897,
{ 158: } 897,
{ 159: } 898,
{ 160: } 899,
{ 161: } 916,
{ 162: } 916,
{ 163: } 925,
{ 164: } 935,
{ 165: } 935,
{ 166: } 935,
{ 167: } 937,
{ 168: } 937,
{ 169: } 938,
{ 170: } 947,
{ 171: } 954,
{ 172: } 964,
{ 173: } 964,
{ 174: } 986,
{ 175: } 1003,
{ 176: } 1003,
{ 177: } 1004,
{ 178: } 1004,
{ 179: } 1004,
{ 180: } 1021,
{ 181: } 1030,
{ 182: } 1030,
{ 183: } 1031,
{ 184: } 1040
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 7,
{ 1: } 13,
{ 2: } 14,
{ 3: } 17,
{ 4: } 18,
{ 5: } 19,
{ 6: } 21,
{ 7: } 34,
{ 8: } 36,
{ 9: } 36,
{ 10: } 36,
{ 11: } 38,
{ 12: } 49,
{ 13: } 49,
{ 14: } 49,
{ 15: } 64,
{ 16: } 66,
{ 17: } 66,
{ 18: } 66,
{ 19: } 72,
{ 20: } 77,
{ 21: } 79,
{ 22: } 107,
{ 23: } 107,
{ 24: } 134,
{ 25: } 134,
{ 26: } 145,
{ 27: } 156,
{ 28: } 156,
{ 29: } 166,
{ 30: } 194,
{ 31: } 194,
{ 32: } 199,
{ 33: } 217,
{ 34: } 220,
{ 35: } 220,
{ 36: } 243,
{ 37: } 243,
{ 38: } 243,
{ 39: } 246,
{ 40: } 247,
{ 41: } 259,
{ 42: } 271,
{ 43: } 286,
{ 44: } 299,
{ 45: } 303,
{ 46: } 304,
{ 47: } 336,
{ 48: } 336,
{ 49: } 337,
{ 50: } 349,
{ 51: } 361,
{ 52: } 388,
{ 53: } 389,
{ 54: } 391,
{ 55: } 393,
{ 56: } 395,
{ 57: } 397,
{ 58: } 407,
{ 59: } 407,
{ 60: } 434,
{ 61: } 461,
{ 62: } 461,
{ 63: } 462,
{ 64: } 463,
{ 65: } 464,
{ 66: } 466,
{ 67: } 468,
{ 68: } 486,
{ 69: } 486,
{ 70: } 496,
{ 71: } 515,
{ 72: } 542,
{ 73: } 543,
{ 74: } 560,
{ 75: } 571,
{ 76: } 582,
{ 77: } 587,
{ 78: } 589,
{ 79: } 591,
{ 80: } 593,
{ 81: } 593,
{ 82: } 601,
{ 83: } 602,
{ 84: } 604,
{ 85: } 606,
{ 86: } 606,
{ 87: } 608,
{ 88: } 612,
{ 89: } 638,
{ 90: } 638,
{ 91: } 643,
{ 92: } 645,
{ 93: } 656,
{ 94: } 656,
{ 95: } 656,
{ 96: } 656,
{ 97: } 656,
{ 98: } 662,
{ 99: } 688,
{ 100: } 688,
{ 101: } 688,
{ 102: } 688,
{ 103: } 688,
{ 104: } 688,
{ 105: } 689,
{ 106: } 690,
{ 107: } 691,
{ 108: } 693,
{ 109: } 695,
{ 110: } 695,
{ 111: } 695,
{ 112: } 722,
{ 113: } 722,
{ 114: } 722,
{ 115: } 736,
{ 116: } 737,
{ 117: } 740,
{ 118: } 748,
{ 119: } 748,
{ 120: } 752,
{ 121: } 753,
{ 122: } 753,
{ 123: } 756,
{ 124: } 763,
{ 125: } 764,
{ 126: } 764,
{ 127: } 765,
{ 128: } 765,
{ 129: } 766,
{ 130: } 766,
{ 131: } 781,
{ 132: } 781,
{ 133: } 783,
{ 134: } 783,
{ 135: } 783,
{ 136: } 795,
{ 137: } 795,
{ 138: } 795,
{ 139: } 795,
{ 140: } 809,
{ 141: } 811,
{ 142: } 811,
{ 143: } 813,
{ 144: } 840,
{ 145: } 846,
{ 146: } 847,
{ 147: } 864,
{ 148: } 864,
{ 149: } 864,
{ 150: } 864,
{ 151: } 866,
{ 152: } 868,
{ 153: } 868,
{ 154: } 871,
{ 155: } 882,
{ 156: } 896,
{ 157: } 896,
{ 158: } 897,
{ 159: } 898,
{ 160: } 915,
{ 161: } 915,
{ 162: } 924,
{ 163: } 934,
{ 164: } 934,
{ 165: } 934,
{ 166: } 936,
{ 167: } 936,
{ 168: } 937,
{ 169: } 946,
{ 170: } 953,
{ 171: } 963,
{ 172: } 963,
{ 173: } 985,
{ 174: } 1002,
{ 175: } 1002,
{ 176: } 1003,
{ 177: } 1003,
{ 178: } 1003,
{ 179: } 1020,
{ 180: } 1029,
{ 181: } 1029,
{ 182: } 1030,
{ 183: } 1039,
{ 184: } 1039
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 6,
{ 3: } 6,
{ 4: } 7,
{ 5: } 7,
{ 6: } 8,
{ 7: } 8,
{ 8: } 12,
{ 9: } 14,
{ 10: } 14,
{ 11: } 14,
{ 12: } 15,
{ 13: } 20,
{ 14: } 20,
{ 15: } 21,
{ 16: } 24,
{ 17: } 26,
{ 18: } 26,
{ 19: } 26,
{ 20: } 26,
{ 21: } 26,
{ 22: } 26,
{ 23: } 26,
{ 24: } 26,
{ 25: } 26,
{ 26: } 26,
{ 27: } 30,
{ 28: } 34,
{ 29: } 34,
{ 30: } 38,
{ 31: } 39,
{ 32: } 39,
{ 33: } 39,
{ 34: } 39,
{ 35: } 42,
{ 36: } 42,
{ 37: } 47,
{ 38: } 47,
{ 39: } 47,
{ 40: } 47,
{ 41: } 47,
{ 42: } 53,
{ 43: } 56,
{ 44: } 56,
{ 45: } 56,
{ 46: } 56,
{ 47: } 58,
{ 48: } 60,
{ 49: } 60,
{ 50: } 60,
{ 51: } 63,
{ 52: } 67,
{ 53: } 67,
{ 54: } 67,
{ 55: } 67,
{ 56: } 67,
{ 57: } 67,
{ 58: } 67,
{ 59: } 71,
{ 60: } 71,
{ 61: } 71,
{ 62: } 72,
{ 63: } 72,
{ 64: } 72,
{ 65: } 72,
{ 66: } 72,
{ 67: } 72,
{ 68: } 73,
{ 69: } 76,
{ 70: } 76,
{ 71: } 77,
{ 72: } 77,
{ 73: } 82,
{ 74: } 82,
{ 75: } 89,
{ 76: } 92,
{ 77: } 94,
{ 78: } 94,
{ 79: } 94,
{ 80: } 94,
{ 81: } 96,
{ 82: } 96,
{ 83: } 97,
{ 84: } 97,
{ 85: } 97,
{ 86: } 97,
{ 87: } 97,
{ 88: } 99,
{ 89: } 99,
{ 90: } 99,
{ 91: } 99,
{ 92: } 99,
{ 93: } 99,
{ 94: } 103,
{ 95: } 103,
{ 96: } 103,
{ 97: } 103,
{ 98: } 103,
{ 99: } 103,
{ 100: } 103,
{ 101: } 103,
{ 102: } 103,
{ 103: } 103,
{ 104: } 103,
{ 105: } 103,
{ 106: } 103,
{ 107: } 103,
{ 108: } 103,
{ 109: } 103,
{ 110: } 103,
{ 111: } 103,
{ 112: } 103,
{ 113: } 108,
{ 114: } 108,
{ 115: } 108,
{ 116: } 109,
{ 117: } 111,
{ 118: } 112,
{ 119: } 112,
{ 120: } 112,
{ 121: } 112,
{ 122: } 112,
{ 123: } 112,
{ 124: } 112,
{ 125: } 113,
{ 126: } 113,
{ 127: } 113,
{ 128: } 113,
{ 129: } 113,
{ 130: } 113,
{ 131: } 113,
{ 132: } 113,
{ 133: } 113,
{ 134: } 113,
{ 135: } 113,
{ 136: } 113,
{ 137: } 119,
{ 138: } 119,
{ 139: } 119,
{ 140: } 119,
{ 141: } 120,
{ 142: } 120,
{ 143: } 120,
{ 144: } 122,
{ 145: } 127,
{ 146: } 128,
{ 147: } 128,
{ 148: } 132,
{ 149: } 132,
{ 150: } 132,
{ 151: } 132,
{ 152: } 132,
{ 153: } 132,
{ 154: } 132,
{ 155: } 132,
{ 156: } 136,
{ 157: } 137,
{ 158: } 137,
{ 159: } 137,
{ 160: } 137,
{ 161: } 141,
{ 162: } 141,
{ 163: } 142,
{ 164: } 142,
{ 165: } 142,
{ 166: } 142,
{ 167: } 142,
{ 168: } 142,
{ 169: } 142,
{ 170: } 142,
{ 171: } 142,
{ 172: } 142,
{ 173: } 142,
{ 174: } 147,
{ 175: } 150,
{ 176: } 150,
{ 177: } 150,
{ 178: } 150,
{ 179: } 150,
{ 180: } 153,
{ 181: } 154,
{ 182: } 154,
{ 183: } 154,
{ 184: } 154
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 5,
{ 2: } 5,
{ 3: } 6,
{ 4: } 6,
{ 5: } 7,
{ 6: } 7,
{ 7: } 11,
{ 8: } 13,
{ 9: } 13,
{ 10: } 13,
{ 11: } 14,
{ 12: } 19,
{ 13: } 19,
{ 14: } 20,
{ 15: } 23,
{ 16: } 25,
{ 17: } 25,
{ 18: } 25,
{ 19: } 25,
{ 20: } 25,
{ 21: } 25,
{ 22: } 25,
{ 23: } 25,
{ 24: } 25,
{ 25: } 25,
{ 26: } 29,
{ 27: } 33,
{ 28: } 33,
{ 29: } 37,
{ 30: } 38,
{ 31: } 38,
{ 32: } 38,
{ 33: } 38,
{ 34: } 41,
{ 35: } 41,
{ 36: } 46,
{ 37: } 46,
{ 38: } 46,
{ 39: } 46,
{ 40: } 46,
{ 41: } 52,
{ 42: } 55,
{ 43: } 55,
{ 44: } 55,
{ 45: } 55,
{ 46: } 57,
{ 47: } 59,
{ 48: } 59,
{ 49: } 59,
{ 50: } 62,
{ 51: } 66,
{ 52: } 66,
{ 53: } 66,
{ 54: } 66,
{ 55: } 66,
{ 56: } 66,
{ 57: } 66,
{ 58: } 70,
{ 59: } 70,
{ 60: } 70,
{ 61: } 71,
{ 62: } 71,
{ 63: } 71,
{ 64: } 71,
{ 65: } 71,
{ 66: } 71,
{ 67: } 72,
{ 68: } 75,
{ 69: } 75,
{ 70: } 76,
{ 71: } 76,
{ 72: } 81,
{ 73: } 81,
{ 74: } 88,
{ 75: } 91,
{ 76: } 93,
{ 77: } 93,
{ 78: } 93,
{ 79: } 93,
{ 80: } 95,
{ 81: } 95,
{ 82: } 96,
{ 83: } 96,
{ 84: } 96,
{ 85: } 96,
{ 86: } 96,
{ 87: } 98,
{ 88: } 98,
{ 89: } 98,
{ 90: } 98,
{ 91: } 98,
{ 92: } 98,
{ 93: } 102,
{ 94: } 102,
{ 95: } 102,
{ 96: } 102,
{ 97: } 102,
{ 98: } 102,
{ 99: } 102,
{ 100: } 102,
{ 101: } 102,
{ 102: } 102,
{ 103: } 102,
{ 104: } 102,
{ 105: } 102,
{ 106: } 102,
{ 107: } 102,
{ 108: } 102,
{ 109: } 102,
{ 110: } 102,
{ 111: } 102,
{ 112: } 107,
{ 113: } 107,
{ 114: } 107,
{ 115: } 108,
{ 116: } 110,
{ 117: } 111,
{ 118: } 111,
{ 119: } 111,
{ 120: } 111,
{ 121: } 111,
{ 122: } 111,
{ 123: } 111,
{ 124: } 112,
{ 125: } 112,
{ 126: } 112,
{ 127: } 112,
{ 128: } 112,
{ 129: } 112,
{ 130: } 112,
{ 131: } 112,
{ 132: } 112,
{ 133: } 112,
{ 134: } 112,
{ 135: } 112,
{ 136: } 118,
{ 137: } 118,
{ 138: } 118,
{ 139: } 118,
{ 140: } 119,
{ 141: } 119,
{ 142: } 119,
{ 143: } 121,
{ 144: } 126,
{ 145: } 127,
{ 146: } 127,
{ 147: } 131,
{ 148: } 131,
{ 149: } 131,
{ 150: } 131,
{ 151: } 131,
{ 152: } 131,
{ 153: } 131,
{ 154: } 131,
{ 155: } 135,
{ 156: } 136,
{ 157: } 136,
{ 158: } 136,
{ 159: } 136,
{ 160: } 140,
{ 161: } 140,
{ 162: } 141,
{ 163: } 141,
{ 164: } 141,
{ 165: } 141,
{ 166: } 141,
{ 167: } 141,
{ 168: } 141,
{ 169: } 141,
{ 170: } 141,
{ 171: } 141,
{ 172: } 141,
{ 173: } 146,
{ 174: } 149,
{ 175: } 149,
{ 176: } 149,
{ 177: } 149,
{ 178: } 149,
{ 179: } 152,
{ 180: } 153,
{ 181: } 153,
{ 182: } 153,
{ 183: } 153,
{ 184: } 153
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -37 ),
{ 2: } ( len: 2; sym: -37 ),
{ 3: } ( len: 3; sym: -37 ),
{ 4: } ( len: 3; sym: -37 ),
{ 5: } ( len: 2; sym: -37 ),
{ 6: } ( len: 7; sym: -2 ),
{ 7: } ( len: 3; sym: -2 ),
{ 8: } ( len: 4; sym: -2 ),
{ 9: } ( len: 0; sym: -35 ),
{ 10: } ( len: 1; sym: -35 ),
{ 11: } ( len: 1; sym: -35 ),
{ 12: } ( len: 3; sym: -35 ),
{ 13: } ( len: 3; sym: -35 ),
{ 14: } ( len: 2; sym: -35 ),
{ 15: } ( len: 2; sym: -3 ),
{ 16: } ( len: 3; sym: -3 ),
{ 17: } ( len: 3; sym: -3 ),
{ 18: } ( len: 1; sym: -4 ),
{ 19: } ( len: 3; sym: -4 ),
{ 20: } ( len: 3; sym: -5 ),
{ 21: } ( len: 1; sym: -5 ),
{ 22: } ( len: 3; sym: -5 ),
{ 23: } ( len: 2; sym: -5 ),
{ 24: } ( len: 0; sym: -6 ),
{ 25: } ( len: 1; sym: -6 ),
{ 26: } ( len: 3; sym: -6 ),
{ 27: } ( len: 1; sym: -6 ),
{ 28: } ( len: 1; sym: -6 ),
{ 29: } ( len: 1; sym: -6 ),
{ 30: } ( len: 3; sym: -6 ),
{ 31: } ( len: 5; sym: -6 ),
{ 32: } ( len: 4; sym: -6 ),
{ 33: } ( len: 3; sym: -6 ),
{ 34: } ( len: 3; sym: -6 ),
{ 35: } ( len: 2; sym: -6 ),
{ 36: } ( len: 3; sym: -6 ),
{ 37: } ( len: 2; sym: -7 ),
{ 38: } ( len: 0; sym: -8 ),
{ 39: } ( len: 1; sym: -8 ),
{ 40: } ( len: 3; sym: -8 ),
{ 41: } ( len: 3; sym: -9 ),
{ 42: } ( len: 1; sym: -9 ),
{ 43: } ( len: 3; sym: -9 ),
{ 44: } ( len: 2; sym: -9 ),
{ 45: } ( len: 1; sym: -10 ),
{ 46: } ( len: 3; sym: -10 ),
{ 47: } ( len: 3; sym: -10 ),
{ 48: } ( len: 0; sym: -21 ),
{ 49: } ( len: 2; sym: -21 ),
{ 50: } ( len: 4; sym: -22 ),
{ 51: } ( len: 1; sym: -23 ),
{ 52: } ( len: 2; sym: -23 ),
{ 53: } ( len: 2; sym: -23 ),
{ 54: } ( len: 3; sym: -23 ),
{ 55: } ( len: 2; sym: -23 ),
{ 56: } ( len: 3; sym: -23 ),
{ 57: } ( len: 0; sym: -17 ),
{ 58: } ( len: 2; sym: -17 ),
{ 59: } ( len: 0; sym: -18 ),
{ 60: } ( len: 1; sym: -18 ),
{ 61: } ( len: 3; sym: -18 ),
{ 62: } ( len: 2; sym: -18 ),
{ 63: } ( len: 3; sym: -18 ),
{ 64: } ( len: 4; sym: -19 ),
{ 65: } ( len: 1; sym: -19 ),
{ 66: } ( len: 0; sym: -20 ),
{ 67: } ( len: 1; sym: -20 ),
{ 68: } ( len: 5; sym: -20 ),
{ 69: } ( len: 5; sym: -20 ),
{ 70: } ( len: 3; sym: -20 ),
{ 71: } ( len: 3; sym: -20 ),
{ 72: } ( len: 1; sym: -24 ),
{ 73: } ( len: 1; sym: -24 ),
{ 74: } ( len: 0; sym: -32 ),
{ 75: } ( len: 3; sym: -32 ),
{ 76: } ( len: 0; sym: -33 ),
{ 77: } ( len: 1; sym: -33 ),
{ 78: } ( len: 3; sym: -33 ),
{ 79: } ( len: 0; sym: -34 ),
{ 80: } ( len: 1; sym: -34 ),
{ 81: } ( len: 2; sym: -34 ),
{ 82: } ( len: 2; sym: -34 ),
{ 83: } ( len: 0; sym: -28 ),
{ 84: } ( len: 4; sym: -28 ),
{ 85: } ( len: 0; sym: -29 ),
{ 86: } ( len: 1; sym: -29 ),
{ 87: } ( len: 3; sym: -29 ),
{ 88: } ( len: 0; sym: -30 ),
{ 89: } ( len: 1; sym: -30 ),
{ 90: } ( len: 0; sym: -31 ),
{ 91: } ( len: 2; sym: -31 ),
{ 92: } ( len: 0; sym: -36 ),
{ 93: } ( len: 2; sym: -36 ),
{ 94: } ( len: 5; sym: -36 ),
{ 95: } ( len: 1; sym: -25 ),
{ 96: } ( len: 2; sym: -25 ),
{ 97: } ( len: 1; sym: -26 ),
{ 98: } ( len: 2; sym: -26 ),
{ 99: } ( len: 1; sym: -27 ),
{ 100: } ( len: 2; sym: -27 ),
{ 101: } ( len: 3; sym: -11 ),
{ 102: } ( len: 0; sym: -12 ),
{ 103: } ( len: 2; sym: -12 ),
{ 104: } ( len: 0; sym: -13 ),
{ 105: } ( len: 2; sym: -13 ),
{ 106: } ( len: 2; sym: -13 ),
{ 107: } ( len: 0; sym: -15 ),
{ 108: } ( len: 7; sym: -15 ),
{ 109: } ( len: 5; sym: -15 ),
{ 110: } ( len: 0; sym: -14 ),
{ 111: } ( len: 1; sym: -14 ),
{ 112: } ( len: 3; sym: -14 ),
{ 113: } ( len: 0; sym: -16 ),
{ 114: } ( len: 3; sym: -16 )
);

// source: E:\Tools\Develop\Others\dyacclex-1.4\src\yacc\yyparse.cod line# 39

const _error = 256; (* error token *)

function yyact(state, sym : Integer; var act : Integer) : Boolean;
  (* search action table *)
  var k : Integer;
  begin
    k := yyal[state];
    while (k<=yyah[state]) and (yya[k].sym<>sym) do inc(k);
    if k>yyah[state] then
      yyact := false
    else
      begin
        act := yya[k].act;
        yyact := true;
      end;
  end(*yyact*);

function yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
  (* search goto table *)
  var k : Integer;
  begin
    k := yygl[state];
    while (k<=yygh[state]) and (yyg[k].sym<>sym) do inc(k);
    if k>yygh[state] then
      yygoto := false
    else
      begin
        nstate := yyg[k].act;
        yygoto := true;
      end;
  end(*yygoto*);

function yycharsym(i : Integer) : String;
begin
  if (i >= 1) and (i <= 255) then
    begin
      if i < 32 then
        begin
          if i = 9 then
            Result := #39'\t'#39
          else if i = 10 then
            Result := #39'\f'#39
          else if i = 13 then
            Result := #39'\n'#39
          else
            Result := #39'\0x' + IntToHex(i,2) + #39;
        end
      else
        Result := #39 + Char(i) + #39;
      Result := ' literal ' + Result;
    end
  else
    begin
      if i < -1 then
        Result := ' unknown'
      else if i = -1 then
        Result := ' token $accept'
      else if i = 0 then
        Result := ' token $eof'
      else if i = 256 then
        Result := ' token $error'
{$ifdef yyextradebug}
      else if i <= yymaxtoken then
        Result := ' token ' + yytokens[yychar].tokenname
      else
        Result := ' unknown token';
{$else}
      else
        Result := ' token';
{$endif}
    end;
  Result := Result + ' ' + IntToStr(yychar);
end;

label parse, next, error, errlab, shift, reduce, accept, abort;

begin(*yyparse*)

  (* initialize: *)

  yystate := 0; yychar := -1; yynerrs := 0; yyerrflag := 0; yysp := 0;

parse:

  (* push state and value: *)

  inc(yysp);
  if yysp>yymaxdepth then
    begin
      yyerror('yyparse stack overflow');
      goto abort;
    end;
  yys[yysp] := yystate; yyv[yysp] := yyval;

next:

  if (yyd[yystate]=0) and (yychar=-1) then
    (* get next symbol *)
    begin
      yychar := lexer.parse(); if yychar<0 then yychar := 0;
    end;

  {$IFDEF YYDEBUG}writeln('state ', yystate, yycharsym(yychar));{$ENDIF}

  (* determine parse action: *)

  yyn := yyd[yystate];
  if yyn<>0 then goto reduce; (* simple state *)

  (* no default action; search parse table *)

  if not yyact(yystate, yychar, yyn) then goto error
  else if yyn>0 then                      goto shift
  else if yyn<0 then                      goto reduce
  else                                    goto accept;

error:

  (* error; start error recovery: *)

  if yyerrflag=0 then yyerror('syntax error');

errlab:

  if yyerrflag=0 then inc(yynerrs);     (* new error *)

  if yyerrflag<=2 then                  (* incomplete recovery; try again *)
    begin
      yyerrflag := 3;
      (* uncover a state with shift action on error token *)
      while (yysp>0) and not ( yyact(yys[yysp], _error, yyn) and
                               (yyn>0) ) do
        begin
          {$IFDEF YYDEBUG}
            if yysp>1 then
              writeln('error recovery pops state ', yys[yysp], ', uncovers ',
                      yys[yysp-1])
            else
              writeln('error recovery fails ... abort');
          {$ENDIF}
          dec(yysp);
        end;
      if yysp=0 then goto abort; (* parser has fallen from stack; abort *)
      yystate := yyn;            (* simulate shift on error *)
      goto parse;
    end
  else                                  (* no shift yet; discard symbol *)
    begin
      {$IFDEF YYDEBUG}writeln('error recovery discards ' + yycharsym(yychar));{$ENDIF}
      if yychar=0 then goto abort; (* end of input; abort *)
      yychar := -1; goto next;     (* clear lookahead char and try again *)
    end;

shift:

  (* go to new state, clear lookahead character: *)

  yystate := yyn; yychar := -1; yyval := yylval;
  if yyerrflag>0 then dec(yyerrflag);

  goto parse;

reduce:

  (* execute action, pop rule from stack, and go to next state: *)

  {$IFDEF YYDEBUG}writeln('reduce ' + IntToStr(-yyn) {$IFDEF YYEXTRADEBUG} + ' rule ' + yyr[-yyn].symname {$ENDIF});{$ENDIF}

  yyflag := yyfnone; yyaction(-yyn);
  dec(yysp, yyr[-yyn].len);
  if yygoto(yys[yysp], yyr[-yyn].sym, yyn) then yystate := yyn;

  (* handle action calls to yyaccept, yyabort and yyerror: *)

  case yyflag of
    yyfaccept : goto accept;
    yyfabort  : goto abort;
    yyferror  : goto errlab;
  end;

  goto parse;

accept:

  Result := 0; exit;

abort:

  Result := 1; exit;

end(*yyparse*);


{$I sqlLex.pas}

var 
	lexer : TLexer;
	parser : TParser;
	
function getSyntexTree(I_SQL: string): ISQLTreeNode;
begin
  _step := 0;
  G_Init;
  result :=	g_tree;
  
  yyclear;
  yyins := I_SQL;
	lexer := TLexer.Create();
	parser := TParser.Create();
	parser.lexer := lexer;
	parser.parse();

end;
	
exports
  getSyntexTree;
  
begin

end.