unit unt_HoSynEdit;

{*
 2012-06-10 liqj 增加跳转窗口 u_SynJumpDlg
 ....
*}

{.$I SynEdit.Inc}
interface

uses
  Windows, SysUtils, Classes, Controls, SynEdit, SynEditTypes, Graphics, Contnrs
  , Messages;

type
  EDirection = (edLeft, edRight, edAll);

  THoSynEdit = class(TSynEdit)
  private
    { Private declarations }
    F_BracketFG: TColor;
    F_BracketBG: TColor;
    F_Observers: TObjectList;
    procedure L_GotoLineEnd;
  protected
    { Protected declarations }
    fSearchOptions: TSynSearchOptions;
    FFindText, FReplaceText: string;
    fbRegexSearch: boolean; // 是否使用正则表达式
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoOnPaintTransient(TransientType: TTransientType); override;
    procedure Click; override;
  public
    { Public declarations }
    //procedure WndProc(var Msg: TMessage); override;
    property R_BracketFG: TColor read F_BracketFG write F_BracketFG;
    property R_BracketBG: TColor read F_BracketBG write F_BracketBG;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {.$IFNDEF SYN_CLX}
    procedure WndProc(var Msg: TMessage); override;
    {.$ENDIF}
    //取得当前光标处词语(默认只取数字、字母和下划线，可指定增加哪些字符)
    //I_Direction: 取词方向，左边、右边的单词或光标所在的整个单词
    //I_Special: 包含的特殊字符
    function P_GetCursorWord(I_Direction: EDirection; I_Special: string): string;
    function P_GetCursorLeftWord: string; //取得当前光标处左边的词语(遇到空格、逗号等结束，包含点号)
    function P_GetCursorLeftWord2: string; //取得当前光标处左边的词语(从数字或字母开始，遇到非数字且非字母结束，不包含点号)
    procedure P_AddObserver(I_Observer: TControl);
    procedure P_RemoveObserver(I_Observer: TControl);
    function P_GetCurPosition: integer; //取得光标所在位置值，即第几个字符
  published
    { Published declarations }

  end;

procedure Register;

implementation

uses
  u_SynEditSearcher, u_SynFindDlg, u_SynReplaceDlg, u_SynJumpDlg,
  SynEditKeyCmds,
  SynEditHighlighter, Math;

procedure Register;
begin
  RegisterComponents('Samples', [THoSynEdit]);
end;

{ THoSynEdit }

procedure THoSynEdit.Click;
begin
  inherited;
  self.BeginUpdate;
  try
    L_GotoLineEnd
  finally
    self.EndUpdate;
  end;
end;

constructor THoSynEdit.Create(AOwner: TComponent);
begin
  inherited;
  self.R_BracketBG := clBtnFace;
  self.R_BracketFG := clRed;
  F_Observers := TObjectList.Create;
end;

destructor THoSynEdit.Destroy;
begin
  if Assigned(F_Observers) then
    F_Observers.Free;
  inherited;
end;

procedure THoSynEdit.DoOnPaintTransient(TransientType: TTransientType);
const
  AllBrackets = ['(',')' ,'{','}', '[',']' ];  // '<' , '>'
  OpenChars:  array[0..2] of WideChar = ('(', '[', '{' );
  CloseChars: array[0..2] of WideChar = (')', ']', '}' );
var
  Editor: TSynEdit;
  function CharToPixels(P: TBufferCoord): TPoint;
  begin
    Result := Editor.RowColumnToPixels(Editor.BufferToDisplayPos(P));
  end;

var
  pActive, pMatching: TBufferCoord;
  Pix: TPoint;
  D: TDisplayCoord;
  S: string;
  I: Integer;
  Attri: TSynHighlighterAttributes;
  start: Integer;
  TmpCharA, TmpCharB: WideChar;
  fontColor :TColor;
begin
  inherited;
  if SelAvail then exit;
  Editor := self;
  //if you had a highlighter that used a markup language, like html or xml, then you would want to highlight
  //the greater and less than signs as well as illustrated below

  //  if (Editor.Highlighter = shHTML) or (Editor.Highlighter = shXML) then
  //    inc(ArrayLength);

//  for I := 0 to 2 do
//    case I of
//      0: begin
//          OpenChars[I] := '('; CloseChars[I] := ')'; end;
//      1: begin
//          OpenChars[I] := '{'; CloseChars[I] := '}'; end;
//      2: begin
//          OpenChars[I] := '['; CloseChars[I] := ']'; end;
//      //3: begin
//      //    OpenChars[I] := '<'; CloseChars[I] := '>'; end;
//    end;

  pActive := Editor.CaretXY;
  D := Editor.DisplayXY;

  start := Editor.selStart;
  if start<1 then Exit;    // 2017-04-06 liqj add, 会有 -2 出现
  

  if (start > 0) and (start <= Length(Editor.Text)) then
    TmpCharA := Editor.Text[start]
  else TmpCharA := #0;

  if (start < Length(Editor.Text)) then
    TmpCharB := Editor.Text[start + 1]
  else TmpCharB := #0;

  if not (CharInSet(TmpCharA , AllBrackets) ) and not (CharInSet(TmpCharB , AllBrackets)) then exit;
  S := TmpCharB;
  if not (CharInSet(TmpCharB , AllBrackets)) then begin
    pActive.Char := pActive.Char - 1;
    S := TmpCharA;
  end;
  Editor.GetHighlighterAttriAtRowCol(pActive, S, Attri);

  //if (Editor.Highlighter.SymbolAttribute = Attri) then begin
  for I := low(OpenChars) to High(OpenChars) do begin
    if (S = OpenChars[I]) or (S = CloseChars[I]) then begin
      Pix := CharToPixels(pActive);

      Editor.Canvas.Brush.Style := bsSolid; //Clear;
      Editor.Canvas.Font.Assign(Editor.Font);

      if Attri = nil then
        Editor.Canvas.Font.Style := Editor.Font.Style
      else
        Editor.Canvas.Font.Style := Attri.Style;

      if (TransientType = ttAfter) then begin
        Editor.Canvas.Font.Color := F_BracketFG;
        Editor.Canvas.Brush.Color := F_BracketBG;
      end else begin
        if Attri = nil then begin
          Editor.Canvas.Font.Color := clNone;
          Editor.Canvas.Brush.Color := clNone;
        end else begin
          Editor.Canvas.Font.Color := Attri.Foreground;
          Editor.Canvas.Brush.Color := Attri.Background;
        end;
      end;
      if Editor.Canvas.Font.Color = clNone then
        Editor.Canvas.Font.Color := Editor.Font.Color;
      if Editor.Canvas.Brush.Color = clNone then
//        Editor.Canvas.Brush.Color := Editor.ActiveLine.Background;
        Editor.Canvas.Brush.Color := Editor.ActiveLineColor;

      fontColor := Editor.Canvas.Font.Color;
      if Pix.X > Editor.Gutter.Width then begin
        Editor.Canvas.TextOut(Pix.X, Pix.Y, S);
      end;

      pMatching := Editor.GetMatchingBracketEx(pActive);

      if (pMatching.Char > 0) and (pMatching.Line > 0) then begin
        Pix := CharToPixels(pMatching);

        if Pix.X > Editor.Gutter.Width then begin
          if (TransientType = ttBefore) then begin
            if pActive.Line = pMatching.Line then
//              Editor.Canvas.Brush.Color := Editor.ActiveLine.Background
              Editor.Canvas.Brush.Color := Editor.ActiveLineColor
            else
              Editor.Canvas.Brush.Color := Editor.Color;
          end;
          Editor.Canvas.Font.Color := fontColor;
          if S = OpenChars[I] then
            Editor.Canvas.TextOut(Pix.X, Pix.Y, CloseChars[I])
          else
            Editor.Canvas.TextOut(Pix.X, Pix.Y, OpenChars[I]);
        end;

      end;
      Break;
    end; //if
  end; //for i :=
  Editor.Canvas.Brush.Style := bsSolid;
  //end;
end;

procedure THoSynEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  _isUpDown: Boolean;
begin
  _isUpDown := false;
  if (Key = VK_UP) or (Key = VK_DOWN) then begin
    _isUpDown := true;
  end;
  inherited;

  // 2012-06-07 liqj 增加快捷键 转大写 Shift+F5、转小写 Ctrl+F5 
  if (ssShift in Shift) and (Key = vk_f5) then begin
    // Sfift + F5 : UpperCase
    self.CommandProcessor(ecUpperCaseBlock, #0, nil); 
  end;  
  // 2012-06-07 liqj 增加快捷键 转大写 Shift+F5、转小写 Ctrl+F5 
  if (ssCtrl in Shift) and (Key = vk_f5) then begin
    // Ctrl + F5 : LowerCase
    self.CommandProcessor(ecLowerCaseBlock, #0, nil);
  end;


  if (Key = Ord('G')) and (ssCtrl in Shift) then begin
    // Jump
    u_SynJumpDlg.TSynJumpDlg.Execute(self);
  end else if (Key = Ord('F')) and (ssCtrl in Shift) then begin
    //self.Lines.Add('hello');
    Searcher.FindEx(self, fSearchOptions, FFindText, fbRegexSearch);
  end else if (Key = VK_F3) and (ssCtrl in Shift) then begin
    if SelText <> '' then begin
      FFindText := SelText;
      Searcher.Search(self, self.SelText, '', fSearchOptions + [ssoBackwards], fbRegexSearch)
    end else begin
      fSearchOptions := fSearchOptions + [ssoBackwards];
      if FFindText = '' then
        Searcher.FindEx(self, fSearchOptions , FFindText, fbRegexSearch)
      else
        Searcher.Search(self, FFindText, '', fSearchOptions , fbRegexSearch)
    end;
  end else if (Key = VK_F3) then begin
    fSearchOptions := fSearchOptions - [ssoBackwards];
    if SelText <> '' then begin
      FFindText := SelText;
      Searcher.Search(self, self.SelText, '', fSearchOptions , fbRegexSearch)
    end else begin
      if FFindText = '' then
        Searcher.FindEx(self, fSearchOptions , FFindText, fbRegexSearch)
      else
        Searcher.Search(self, FFindText, '', fSearchOptions , fbRegexSearch);
    end;
  end else if (Key = Ord('R')) and (ssCtrl in Shift) then begin
    Searcher.Replace(self);
  end;
  if (_isUpDown) and (SelectionMode = smNormal) then
    L_GotoLineEnd;

end;

procedure THoSynEdit.L_GotoLineEnd;
begin
  if CaretX > Length(LineText) then begin
    if selStart = selEnd then
      CaretX := Length(LineText) + 1;
  end;
end;

procedure THoSynEdit.P_AddObserver(I_Observer: TControl);
begin
  // 主要作用为 代码提示时，键盘消息 截取 unt_TInputHelper.pas
  F_Observers.Add(I_Observer);
end;

function THoSynEdit.P_GetCurPosition: integer;
var
  _strList: TStringList;
  _i: Integer;
begin
  _strList := TStringList.Create;
  try
    _strList.Text := self.Lines.Text;

      //计算光标所在位置的偏移量
    result := 0;
      //光标上面所有行的字符长度累加
    for _i := 0 to self.CaretY - 2 do begin
      result := result + Length(_strList.Strings[_i]) + 2;
    end;
      //加上光标所在行光标前面的字符数
    if self.CaretY - 1 >= _strList.Count then
      _i := 0
    else
      _i := Length(_strList.Strings[self.CaretY - 1]);
      //如果光标位于文字末尾，则取字符总数
    result := result + min(_i, self.CaretX - 1);
  finally
    _strList.Free;
  end;
end;

function THoSynEdit.P_GetCursorLeftWord: string;
var //取得当前光标处左边的词语(遇到空格,tab键盘结束)
  _colBeg, _colEnd: Integer;
  _len: Integer;
  tmpstr: UnicodeString;
  I,i2: integer;
begin
  tmpstr := Self.LineText;
  if tmpstr = '' then
  begin
    Result := '';
    Exit;
  end;
  _len := Length(tmpstr);
  _colEnd := CaretX - 1;
  i2 := _colEnd;
  for I := _colEnd downto 1 do
  begin
    i2 := i;
    if (CaretX - 1 > 0) and (CaretX - 1 <= _len)
//      and (not (tmpstr[i] in [';', '(', ')', ',', Chr(VK_SPACE), Chr(VK_TAB), #10, Chr(VK_RETURN)])) then
    and ( CharInSet ( UpCase( tmpstr[i]) , ['0'..'9', 'A'..'Z', '_', '$', '.', #127..#255])) then
    begin //当前光标前为组成单词的字符才向前搜索
      Continue;
    end else
    begin //单词结束
      _colBeg := i;
      Result := Copy(tmpstr, _colBeg + 1, _colEnd - _colBeg);
//      if Trim(Result) = '' then
//        Continue
//      else
      exit;
    end;
  end;
  _colBeg := i2;
  Result := Copy(tmpstr, _colBeg, _colEnd - _colBeg);
end;

function THoSynEdit.P_GetCursorLeftWord2: string;
var
  _wordBeg, _wordEnd: integer;
  _tmpstr: string;
begin
  _tmpstr := Self.LineText;
  if _tmpstr = '' then
  begin
    Result := '';
    Exit;
  end;

  if CaretX > 1 then begin
    _wordEnd := CaretX;
//    while (_wordEnd > 1) do begin
//      begin
//        if (UpCase(_tmpstr[_wordEnd - 1]) in ['0'..'9', 'A'..'Z', '_', '$', ' ', '.', #127..#255]) then
//        begin
//          break;
//        end else begin
//          if UpCase(_tmpstr[_wordEnd - 1]) = #161 then //全角中文空格
//            break;
//          _wordEnd := _wordEnd - 1;
//        end;
//      end;
//    end;

    _wordBeg := _wordEnd - 1;
    while (_wordBeg > 0) do
    begin
      if not (( CharInSet( UpCase(_tmpstr[_wordBeg]) , ['0'..'9', 'A'..'Z', '_', '$', #127..#255]))) then
      begin
        _wordBeg := _wordBeg + 1;
        break;
      end else begin
        if CharInSet( UpCase(_tmpstr[_wordBeg]) , [#161]) then begin //全角中文空格
          _wordBeg := _wordBeg + 1;
          break;
        end;
        if _wordBeg = 1 then
          break;
        _wordBeg := _wordBeg - 1;
      end;
    end;
    Result := Copy(_tmpstr, _wordBeg, _wordEnd - _wordBeg);
  end else begin
    result := '';
  end;
end;

function THoSynEdit.P_GetCursorWord(I_Direction: EDirection;
  I_Special: string): string;
var
  _colBeg, _colEnd: Integer;
  _len: Integer;
  tmpstr: string;
  I: integer;
  _pos: integer;
begin
  Result := '';
  tmpstr := Self.LineText;
  if tmpstr = '' then
  begin
    Exit;
  end;

  _colBeg := 1;
  if (I_Direction in [edLeft, edAll]) then begin
    _colEnd := CaretX - 1;
    for I := _colEnd downto 1 do
    begin
      _pos := Pos(tmpstr[i], I_Special);
      if (( CharInSet(UpCase(tmpstr[i]) , ['0'..'9', 'A'..'Z', '_', #127..#255]))
        or (_pos > 0))
        then
      begin //当前光标前为组成单词的字符才向前搜索
        Continue;
      end else
      begin //单词结束
        _colBeg := i + 1;
        Break;
      end;
    end;
    Result := Copy(tmpstr, _colBeg, _colEnd - _colBeg + 1);
  end;

  _len := Length(tmpstr);
  _colEnd := _len;
  if (I_Direction in [edRight, edAll]) then begin
    _colBeg := CaretX;
    for I := _colBeg to _len do
    begin
      _pos := Pos(tmpstr[i], I_Special);
      if (( CharInSet(UpCase(tmpstr[i]) , ['0'..'9', 'A'..'Z', '_', #127..#255]))
        or (_pos > 0))
        then
      begin //当前光标前为组成单词的字符才向前搜索
        Continue;
      end else
      begin //单词结束
        _colEnd := i - 1;
        Break;
      end;
    end;
    Result := Result + Copy(tmpstr, _colBeg, _colEnd - _colBeg + 1);
  end;
end;

procedure THoSynEdit.P_RemoveObserver(I_Observer: TControl);
begin
  F_Observers.Remove(I_Observer);
end;

{.$IFNDEF SYN_CLX}
procedure THoSynEdit.WndProc(var Msg: TMessage);
var
  _i: integer;
  _result: Integer;
//  s: string;
begin
  if Assigned(F_Observers) then
  begin
    for _i := 0 to F_Observers.Count - 1 do begin
//      if (I_Msg.Msg = V_RefreshMsg) then
//        _result := TControl(F_Observers.Items[_i]).Perform(I_Msg.Msg, I_Msg.WParam, I_Msg.LParam)
//      else
      _result := TControl(F_Observers.Items[_i]).Perform(Msg.Msg, Msg.WParam, Msg.LParam);

      if Msg.Result = 0 then
        if _result = 1 then
          Msg.Result := _result;

//      if I_Msg.WParam = VK_DOWN then begin
//        self.SelText := IntToStr(I_Msg.Msg)
//          + '-' + IntToStr(I_Msg.WParam)
//          + '-' + IntToStr(I_Msg.Result) + '  ';
//
//        if ((I_Msg.Msg = 45102) or (I_Msg.Msg = 45102) or (I_Msg.Msg = 45102)
//          or (I_Msg.Msg = 45102) or (I_Msg.Msg = 45102))
//          then
//          I_Msg.Result := 1;
//      end;

    end;
  end;
  inherited;
end;
{.$ENDIF}
end.

