

//˵����
// c       --       �κηǿ����ַ� ���� a
// \c      --       c���ַ����塣���� \* ��ʾ�ַ�*
// "s"     --       �ַ���s���塣���� "**"
// .       --       ��������������ַ�
// \n      --       ����
// *       --       0�λ����޴��ظ�ǰ��ı��ʽ
// +       --       1�λ������ظ�ǰ��ı��ʽ
// ?       --       0�λ�1�γ���ǰ��ı��ʽ
// ^       --       �еĿ�ʼ
// $       --       �еĽ�β
// a|b     --       a����b
// (a|b)+  --       1�λ����ظ�ab
// "a+b"   --       �ַ���a+b����(C�е������ַ���Ȼ��Ч)
// [s]     --       s�е�����һ���ַ�������[abc]��ʾa,b,c����һ��
// [^s]    --       ��������s�е�����һ���ַ�������[^abc]��ʾ��a,b,c������һ���ַ�
// r{m,n}  --       ��m��n�ظ��ַ�r������a{1,5}
// r{m}    --       �ظ�m���ַ�r������a{5}
// r1r2    --       �ַ�r1��r2������ab
// (r)     --       r������(a|b)
// r1/r2   --       r1�����������r2������a/b
// <x>r    --       r��x��ʼ������<x>abc
// {s}     --       s������ı��ʽ�����綨�塰NQUOTE [^']������ʾ�����ŵ������ַ�����ô{s}����[^']��
                    
//����              
// ���ʽ           ƥ���ַ�
// abc              abc
// abc*             ab,abc,abcc,abccc...
// abc+             abc,abcc,abccc...
// a(bc)+           abc,abcbc,abcbcbc...
// a(bc)?           a,abc
// [abc]            a,b,c�е�һ��
// [a-z]            ��a��z�е������ַ�
// [a\-z]           a,-,z�е�һ��
// [-az]            -,a,z�е�һ��
// [A-Za-z0-9]+     һ����������ĸ������
// [\t\n]+          �հ���
// [^ab]            ��a,b��������ַ�
// [a^b]            a,^,b�е�һ��
// [a|b]            a,|,b�е�һ��
// a|b              a,b�е�һ��
                    
// ����             ����
// intyylex(void)   ����ɨ���������ر��
// char*yytext      ָ�룬ָ����ƥ����ַ���
// yyleng           ��ƥ����ַ����ĳ���
// yylval           �������Ӧ��ֵ
// intyywrap(void)  Լ�����������1��ʾɨ����ɺ����ͽ����ˣ����򷵻�0
// FILE*yyout       ����ļ�
// FILE*yyin        �����ļ�
// INITIAL          ��ʼ����ʼ����
// BEGIN            ������ת����ʼ����
// ECHO             �����ƥ����ַ��� 

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
    //�� -- ע�͵Ĵ���
  end;

  15:
    
  begin
    //�� /*...*/ ע�͵Ĵ���
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



