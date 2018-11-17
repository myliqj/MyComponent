

//说明：
// c       --       任何非控制字符 比如 a
// \c      --       c的字符本义。比如 \* 表示字符*
// "s"     --       字符串s本义。比如 "**"
// .       --       除换行外的所有字符
// \n      --       换行
// *       --       0次或无限次重复前面的表达式
// +       --       1次或更多次重复前面的表达式
// ?       --       0次或1次出现前面的表达式
// ^       --       行的开始
// $       --       行的结尾
// a|b     --       a或者b
// (a|b)+  --       1次或多次重复ab
// "a+b"   --       字符串a+b本身(C中的特殊字符仍然有效)
// [s]     --       s中的任意一个字符。比如[abc]表示a,b,c其中一个
// [^s]    --       不存在于s中的任意一个字符。比如[^abc]表示除a,b,c外任意一个字符
// r{m,n}  --       从m到n重复字符r。比如a{1,5}
// r{m}    --       重复m次字符r。比如a{5}
// r1r2    --       字符r1和r2。比如ab
// (r)     --       r。比如(a|b)
// r1/r2   --       r1当后面跟的是r2。比如a/b
// <x>r    --       r当x开始。比如<x>abc
// {s}     --       s所代表的表达式。比如定义“NQUOTE [^']”，表示非引号的任意字符，那么{s}等于[^']。
                    
//举例              
// 表达式           匹配字符
// abc              abc
// abc*             ab,abc,abcc,abccc...
// abc+             abc,abcc,abccc...
// a(bc)+           abc,abcbc,abcbcbc...
// a(bc)?           a,abc
// [abc]            a,b,c中的一个
// [a-z]            从a到z中的任意字符
// [a\-z]           a,-,z中的一个
// [-az]            -,a,z中的一个
// [A-Za-z0-9]+     一个或更多个字母或数字
// [\t\n]+          空白区
// [^ab]            除a,b外的任意字符
// [a^b]            a,^,b中的一个
// [a|b]            a,|,b中的一个
// a|b              a,b中的一个
                    
// 名称             功能
// intyylex(void)   调用扫描器，返回标记
// char*yytext      指针，指向所匹配的字符串
// yyleng           所匹配的字符串的长度
// yylval           与标记相对应的值
// intyywrap(void)  约束，如果返回1表示扫描完成后程序就结束了，否则返回0
// FILE*yyout       输出文件
// FILE*yyin        输入文件
// INITIAL          初始化开始环境
// BEGIN            按条件转换开始环境
// ECHO             输出所匹配的字符串 

function is_keyword(id : string; var token : integer) : boolean;
  (* checks whether id is Pascal keyword; if so, returns corresponding
     token number in token *)
  const
    id_len = 20;
  type
    Ident = string[id_len];
  const
    (* table of Pascal keywords: *)
    no_of_keywords = 35;
    keyword : array [1..no_of_keywords] of Ident = (
      'ALL', 'AND', 'AS', 'ASC', 'BY'
      , 'DESC', 'DISTINCT', 'EXISTS', 'FETCH', 'FIRST'
      , 'FROM', 'GROUP', 'HAVING', 'IN', 'INNER'
      , 'IS', 'JOIN', 'LEFT', 'LIKE', 'NOT'
      , 'NULL', 'ON', 'ONLY', 'OR', 'ORDER'
      , 'OUTER', 'RIGHT', 'ROWS', 'SELECT', 'SET'
      , 'UNION', 'UPDATE', 'UR', 'WHERE', 'WITH'
    );
    keyword_token : array [1..no_of_keywords] of integer = (
      TK_ALL, TK_AND, TK_AS, TK_ASC, TK_BY
      , TK_DESC, TK_QUANTIFIER, TK_EXISTS, TK_FETCH, TK_FIRST
      , TK_FROM, TK_GROUP, TK_HAVING, TK_IN, TK_INNER
      , TK_IS, TK_JOIN, TK_LEFT, TK_LIKE, TK_NOT
      , TK_NULL, TK_ON, TK_ONLY, TK_OR, TK_ORDER
      , TK_OUTER, TK_RIGHT, TK_ROWS, TK_SELECT, TK_SET
      , TK_UNION, TK_UPDATE, TK_UR, TK_WHERE, TK_WITH
    );
  var m, n, k : integer;
  begin
    id := upperCase(id);
    (* binary search: *)
    m := 1; n := no_of_keywords;
    while m<=n do
      begin
        k := m+(n-m) div 2;
        if id=keyword[k] then
          begin
            is_keyword := true;
            token := keyword_token[k];
            exit
          end
        else if id>keyword[k] then
          m := k+1
        else
          n := k-1
      end;
    is_keyword := false
  end(*is_keyword*);





function TLexer.parse() : integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)


var
  _kw : integer;
  _pos: integer;
  _str: string;
  _c  : char;


begin
  (* actions: *)
  case yyruleno of
  1:
    begin
    yylval.yyString := yytext;
    return(TK_COMMA); 
  end;
  
  2:
    begin
    yylval.yyString := yytext;
    return(TK_LEFT_PARENT); 
  end;
  
  3:
    begin
    yylval.yyString := yytext;
    return(TK_RIGHT_PARENT); 
  end;
  
  4:
           
  begin
    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    yylval.yyTSQLTreeNode.R_Text := yytext;
    yylval.yyTSQLTreeNode.R_Keyword := snkIdentifier;
    yylval.yyTSQLTreeNode.R_Type := sntNode;
    if pos('|', yytext) > 0 then
      yylval.yyTSQLTreeNode.R_IsCurrent := true; 
    return(TK_ASTERISK);
  end;
  
  5:
                                      
  begin
    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    yylval.yyTSQLTreeNode.R_Text := yytext;
    yylval.yyTSQLTreeNode.R_Keyword := snkOperator;
    yylval.yyTSQLTreeNode.R_Type := sntNode;
    if pos('|', yytext) > 0 then
      yylval.yyTSQLTreeNode.R_IsCurrent := true; 
    return(TK_OPERATOR);
  end;

  6:
   
  begin
    yylval.yyString := yytext;
    return(TK_COLON); 
  end;

  7:
   
  begin
    yylval.yyString := yytext;
    return(TK_QUESTION); 
  end;

  8:
   
  begin
    yylval.yyString := yytext;
    return(TK_WELL);
  end;

  9:
   
  begin
    yylval.yyString := yytext;
    return(TK_SPOT);
  end;

  10:
                                              
  begin
    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    _pos := pos('|', yytext);
    if _pos > 0 then begin
      _str := Copy(yytext, 1, _pos-1) + Copy(yytext, _pos+1, Length(yytext));
      yylval.yyTSQLTreeNode.R_IsCurrent := true;
    end else begin
      _str := yytext;
    end;
    
    yylval.yyTSQLTreeNode.R_Text := _str;
    if is_keyword(_str, _kw) then begin
      yylval.yyTSQLTreeNode.R_Keyword := snkKeyword;
      yylval.yyTSQLTreeNode.R_Type := sntNode;
      return(_kw);
    end else begin
      yylval.yyTSQLTreeNode.R_Keyword := snkIdentifier;
      yylval.yyTSQLTreeNode.R_Type := sntNode;
      return(TK_IDENTIFIER);
    end;
  end;

  11:
   
  begin
    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    yylval.yyTSQLTreeNode.R_Text := '';
    yylval.yyTSQLTreeNode.R_Keyword := snkIdentifier;
    yylval.yyTSQLTreeNode.R_Type := sntNode;
    yylval.yyTSQLTreeNode.R_IsCurrent := true; 
    return(TK_IDENTIFIER);
  end;

  12:
         ; 

  13:
   
  begin
    repeat
      _c := get_char;
      yytext := yytext + _c;
      case _c of
        '''' : begin
          _c := get_char;
          if _c<>'''' then begin
            break; 
          end;
        end;
        #0 : begin
          break;
        end;
      end;
    until false;
    unget_char(_c);

    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    yylval.yyTSQLTreeNode.R_Text := yytext;
    yylval.yyTSQLTreeNode.R_Keyword := snkString;
    yylval.yyTSQLTreeNode.R_Type := sntNode;
    if pos('|', yytext) > 0 then
      yylval.yyTSQLTreeNode.R_IsCurrent := true; 
    return(TK_STRING);
  end;

  14:
       
  begin
    //对 -- 注释的处理
  end;

  15:
    
  begin
    //对 /*...*/ 注释的处理
    repeat
      _c := get_char;
      case _c of
        '*' : begin
          _c := get_char;
          if _c='/' then exit else unget_char(_c)
        end;
        #0 : begin
          exit;
        end;
      end;
    until false
  end;

  16:
          
  begin
    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    yylval.yyTSQLTreeNode.R_Text := yytext;
    yylval.yyTSQLTreeNode.R_Keyword := snkNumber;
    yylval.yyTSQLTreeNode.R_Type := sntNode;
    if pos('|', yytext) > 0 then
      yylval.yyTSQLTreeNode.R_IsCurrent := true; 
    return(TK_INT);
  end;

  17:
                      
  begin
    yylval.yyTSQLTreeNode := g_tree.P_NewNode;
    yylval.yyTSQLTreeNode.R_Text := yytext;
    yylval.yyTSQLTreeNode.R_Keyword := snkFloat;
    yylval.yyTSQLTreeNode.R_Type := sntNode;
    if pos('|', yytext) > 0 then
      yylval.yyTSQLTreeNode.R_IsCurrent := true; 
    return(TK_NUM);
  end;

  18:
    return(TK_END)
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 30;
yynmatches = 30;
yyntrans   = 61;
yynstates  = 30;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  { 3: }
  2,
  { 4: }
  3,
  { 5: }
  11,
  { 6: }
  4,
  { 7: }
  5,
  { 8: }
  5,
  { 9: }
  5,
  { 10: }
  5,
  { 11: }
  5,
  { 12: }
  6,
  { 13: }
  7,
  { 14: }
  8,
  { 15: }
  9,
  { 16: }
  10,
  { 17: }
  12,
  { 18: }
  13,
  { 19: }
  16,
  17,
  { 20: }
  18,
  { 21: }
  4,
  { 22: }
  14,
  { 23: }
  15,
  { 24: }
  10,
  { 25: }
  16,
  17,
  { 26: }
  16,
  17,
  { 27: }
  { 28: }
  17,
  { 29: }
  17
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
{ 3: }
  2,
{ 4: }
  3,
{ 5: }
  11,
{ 6: }
  4,
{ 7: }
  5,
{ 8: }
  5,
{ 9: }
  5,
{ 10: }
  5,
{ 11: }
  5,
{ 12: }
  6,
{ 13: }
  7,
{ 14: }
  8,
{ 15: }
  9,
{ 16: }
  10,
{ 17: }
  12,
{ 18: }
  13,
{ 19: }
  16,
  17,
{ 20: }
  18,
{ 21: }
  4,
{ 22: }
  14,
{ 23: }
  15,
{ 24: }
  10,
{ 25: }
  16,
  17,
{ 26: }
  16,
  17,
{ 27: }
{ 28: }
  17,
{ 29: }
  17
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #9,#10,' ' ]; s: 17),
  ( cc: [ '#' ]; s: 14),
  ( cc: [ '''' ]; s: 18),
  ( cc: [ '(' ]; s: 3),
  ( cc: [ ')' ]; s: 4),
  ( cc: [ '*' ]; s: 6),
  ( cc: [ '+','=' ]; s: 7),
  ( cc: [ ',' ]; s: 2),
  ( cc: [ '-' ]; s: 8),
  ( cc: [ '.' ]; s: 15),
  ( cc: [ '/' ]; s: 11),
  ( cc: [ '0'..'9' ]; s: 19),
  ( cc: [ ':' ]; s: 12),
  ( cc: [ ';' ]; s: 20),
  ( cc: [ '<' ]; s: 10),
  ( cc: [ '>' ]; s: 9),
  ( cc: [ '?' ]; s: 13),
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 16),
  ( cc: [ '|' ]; s: 5),
{ 1: }
  ( cc: [ #9,#10,' ' ]; s: 17),
  ( cc: [ '#' ]; s: 14),
  ( cc: [ '''' ]; s: 18),
  ( cc: [ '(' ]; s: 3),
  ( cc: [ ')' ]; s: 4),
  ( cc: [ '*' ]; s: 6),
  ( cc: [ '+','=' ]; s: 7),
  ( cc: [ ',' ]; s: 2),
  ( cc: [ '-' ]; s: 8),
  ( cc: [ '.' ]; s: 15),
  ( cc: [ '/' ]; s: 11),
  ( cc: [ '0'..'9' ]; s: 19),
  ( cc: [ ':' ]; s: 12),
  ( cc: [ ';' ]; s: 20),
  ( cc: [ '<' ]; s: 10),
  ( cc: [ '>' ]; s: 9),
  ( cc: [ '?' ]; s: 13),
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 16),
  ( cc: [ '|' ]; s: 5),
{ 2: }
{ 3: }
{ 4: }
{ 5: }
  ( cc: [ '*' ]; s: 6),
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 16),
{ 6: }
  ( cc: [ '|' ]; s: 21),
{ 7: }
{ 8: }
  ( cc: [ '-' ]; s: 22),
{ 9: }
  ( cc: [ '=' ]; s: 7),
{ 10: }
  ( cc: [ '=','>' ]; s: 7),
{ 11: }
  ( cc: [ '*' ]; s: 23),
{ 12: }
{ 13: }
{ 14: }
{ 15: }
{ 16: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 16),
  ( cc: [ '|' ]; s: 24),
{ 17: }
  ( cc: [ #9,#10,' ' ]; s: 17),
{ 18: }
{ 19: }
  ( cc: [ '.','[' ]; s: 27),
  ( cc: [ '0'..'9' ]; s: 25),
  ( cc: [ '|' ]; s: 26),
{ 20: }
{ 21: }
{ 22: }
  ( cc: [ #1..#9,#11..#255 ]; s: 22),
{ 23: }
{ 24: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 24),
{ 25: }
  ( cc: [ '.','[' ]; s: 27),
  ( cc: [ '0'..'9' ]; s: 25),
  ( cc: [ ']' ]; s: 28),
  ( cc: [ '|' ]; s: 26),
{ 26: }
{ 27: }
  ( cc: [ '.','0'..'9','[' ]; s: 27),
  ( cc: [ ']' ]; s: 28),
{ 28: }
  ( cc: [ '.','0'..'9','[' ]; s: 27),
  ( cc: [ '|' ]; s: 29)
{ 29: }
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 2,
{ 4: } 3,
{ 5: } 4,
{ 6: } 5,
{ 7: } 6,
{ 8: } 7,
{ 9: } 8,
{ 10: } 9,
{ 11: } 10,
{ 12: } 11,
{ 13: } 12,
{ 14: } 13,
{ 15: } 14,
{ 16: } 15,
{ 17: } 16,
{ 18: } 17,
{ 19: } 18,
{ 20: } 20,
{ 21: } 21,
{ 22: } 22,
{ 23: } 23,
{ 24: } 24,
{ 25: } 25,
{ 26: } 27,
{ 27: } 29,
{ 28: } 29,
{ 29: } 30
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 1,
{ 3: } 2,
{ 4: } 3,
{ 5: } 4,
{ 6: } 5,
{ 7: } 6,
{ 8: } 7,
{ 9: } 8,
{ 10: } 9,
{ 11: } 10,
{ 12: } 11,
{ 13: } 12,
{ 14: } 13,
{ 15: } 14,
{ 16: } 15,
{ 17: } 16,
{ 18: } 17,
{ 19: } 19,
{ 20: } 20,
{ 21: } 21,
{ 22: } 22,
{ 23: } 23,
{ 24: } 24,
{ 25: } 26,
{ 26: } 28,
{ 27: } 28,
{ 28: } 29,
{ 29: } 30
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 2,
{ 4: } 3,
{ 5: } 4,
{ 6: } 5,
{ 7: } 6,
{ 8: } 7,
{ 9: } 8,
{ 10: } 9,
{ 11: } 10,
{ 12: } 11,
{ 13: } 12,
{ 14: } 13,
{ 15: } 14,
{ 16: } 15,
{ 17: } 16,
{ 18: } 17,
{ 19: } 18,
{ 20: } 20,
{ 21: } 21,
{ 22: } 22,
{ 23: } 23,
{ 24: } 24,
{ 25: } 25,
{ 26: } 27,
{ 27: } 29,
{ 28: } 29,
{ 29: } 30
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 1,
{ 3: } 2,
{ 4: } 3,
{ 5: } 4,
{ 6: } 5,
{ 7: } 6,
{ 8: } 7,
{ 9: } 8,
{ 10: } 9,
{ 11: } 10,
{ 12: } 11,
{ 13: } 12,
{ 14: } 13,
{ 15: } 14,
{ 16: } 15,
{ 17: } 16,
{ 18: } 17,
{ 19: } 19,
{ 20: } 20,
{ 21: } 21,
{ 22: } 22,
{ 23: } 23,
{ 24: } 24,
{ 25: } 26,
{ 26: } 28,
{ 27: } 28,
{ 28: } 29,
{ 29: } 30
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 20,
{ 2: } 39,
{ 3: } 39,
{ 4: } 39,
{ 5: } 39,
{ 6: } 41,
{ 7: } 42,
{ 8: } 42,
{ 9: } 43,
{ 10: } 44,
{ 11: } 45,
{ 12: } 46,
{ 13: } 46,
{ 14: } 46,
{ 15: } 46,
{ 16: } 46,
{ 17: } 48,
{ 18: } 49,
{ 19: } 49,
{ 20: } 52,
{ 21: } 52,
{ 22: } 52,
{ 23: } 53,
{ 24: } 53,
{ 25: } 54,
{ 26: } 58,
{ 27: } 58,
{ 28: } 60,
{ 29: } 62
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 19,
{ 1: } 38,
{ 2: } 38,
{ 3: } 38,
{ 4: } 38,
{ 5: } 40,
{ 6: } 41,
{ 7: } 41,
{ 8: } 42,
{ 9: } 43,
{ 10: } 44,
{ 11: } 45,
{ 12: } 45,
{ 13: } 45,
{ 14: } 45,
{ 15: } 45,
{ 16: } 47,
{ 17: } 48,
{ 18: } 48,
{ 19: } 51,
{ 20: } 51,
{ 21: } 51,
{ 22: } 52,
{ 23: } 52,
{ 24: } 53,
{ 25: } 57,
{ 26: } 57,
{ 27: } 59,
{ 28: } 61,
{ 29: } 61
);


var yyn : Integer;

label start, scan, action;

begin

start:

  (* initialize: *)

  yynew;

scan:

  (* mark positions and matches: *)

  for yyn := yykl[yystate] to     yykh[yystate] do yymark(yyk[yyn]);
  for yyn := yymh[yystate] downto yyml[yystate] do yymatch(yym[yyn]);

  if yytl[yystate]>yyth[yystate] then goto action; (* dead state *)

  (* get next character: *)

  yyscan;

  (* determine action: *)

  yyn := yytl[yystate];
  while (yyn<=yyth[yystate]) and not (yyactchar in yyt[yyn].cc) do inc(yyn);
  if yyn>yyth[yystate] then goto action;
    (* no transition on yyactchar in this state *)

  (* switch to new state: *)

  yystate := yyt[yyn].s;

  goto scan;

action:

  (* execute action: *)

  if yyfind(yyrule) then
    begin
      yyaction(yyrule);
      if yyreject then goto action;
    end
  else if not yydefault and yywrap then
    begin
      yyclear;
      return(0);
    end;

  if not yydone then goto start;

  Result := yyretval;

end(*yylex*);



