{-------------------------------------------------------------------------------
   单元: SynEditSearcher.pas
   作者: 姚乔锋
   日期: 2005-05-17 17:20
   说明: 实现SynEdit的搜索简化
   版本: 1.00
-------------------------------------------------------------------------------}
(*
  -- 使用者 --
  * Uesr : liqj
  * Date : 2006-09-29
  * Modi : xx
  * Var  : 1.0.0.1
                                              
  * 2012-07-22 liqj 新增 查找时，ssoPrompt 表示 循环查找
  * 2012-06-10 liqj 去除 选择的正式表达式查询作默认值
*)

unit u_SynEditSearcher;

interface

uses
  // Delphi
  SysUtils, Classes, Controls, Forms, Windows, Dialogs, Graphics,
  // SynEdit
  SynEdit, SynEditPrint, SynEditTypes,
  SynEditMiscClasses, SynEditSearch, SynEditRegexSearch,
  // Local
  u_SynMsgDialog, u_SynEditStrRes ;

type

  // 搜索对话框
  TSynSearchDialog = class(TForm)
  public
    procedure SetSearchData(const FindText, ReplaceText : string;
      FindHistory, ReplaceHistory : TStrings;
      const SearchOptions : TSynSearchOptions;
      const RegexSearch : Boolean); virtual;
    procedure getSearchData(var FindText, ReplaceText : string;
      FindHistory, ReplaceHistory : TStrings;
      var SearchOptions : TSynSearchOptions;
      var RegexSearch : Boolean); virtual;
  end;
  TSynSearchDialogClass = class of TSynSearchDialog;

  // 实现搜索
  TSynEditSearcher = class(TPersistent)
  private
    FFindText, FReplaceText : string;
    FFindHistory, FReplaceHistory : TStrings;
    FSearchOptions : TSynSearchOptions;
    FRegexSearch : Boolean;
    FSynSearch: TSynEditSearch;
    FSynRegexSearch: TSynEditRegexSearch;
    function CreateFindDialog : TSynSearchDialog;
    function CreateReplaceDialog : TSynSearchDialog;
    procedure OnReplaceText(Sender: TObject; const ASearch, AReplace:
      string; Line, Column: integer; var Action: TSynReplaceAction);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Search(
      SynEdit : TcustomSynEdit;
      FindText, ReplaceText: string;
      SearchOptions : TSynSearchOptions;
      RegexSearch : Boolean);
    procedure Find(SynEdit : TcustomSynEdit);
    procedure FindNext(SynEdit : TcustomSynEdit);
    procedure FindLast(SynEdit : TcustomSynEdit);
    procedure FindNextForWord(SynEdit : TcustomSynEdit);
    procedure FindLastForWord(SynEdit : TcustomSynEdit);
    procedure Replace(SynEdit : TcustomSynEdit);
    procedure ReplaceNext(SynEdit : TcustomSynEdit);
    procedure ReplaceLast(SynEdit : TcustomSynEdit);

    // new add by liqj 2006-09
    procedure FindEx(ASynEdit : TcustomSynEdit;var ASearchOptions : TSynSearchOptions;
      var psFindText:string;var pbRegexSearch:boolean);
  end;

var
  Searcher : TSynEditSearcher;
  FindDialogClass, ReplaceDialogClass : TSynSearchDialogClass;

implementation

{ TSynEditSearcher }

constructor TSynEditSearcher.Create;
begin
  inherited;
  FFindHistory := TStringList.Create;
  FReplaceHistory := TStringList.Create;
  FSynSearch:= TSynEditSearch.Create(nil);
  FSynRegexSearch:= TSynEditRegexSearch.Create(nil);
  // #20120610-liqj FRegexSearch := true;
end;

function TSynEditSearcher.CreateFindDialog: TSynSearchDialog;
begin
  result := FindDialogClass.Create(nil);
end;

function TSynEditSearcher.CreateReplaceDialog: TSynSearchDialog;
begin
  result := ReplaceDialogClass.Create(nil);
end;

destructor TSynEditSearcher.Destroy;
begin
  inherited;
  FFindHistory.Free;
  FReplaceHistory.Free;
  FSynSearch.Free;
  FSynRegexSearch.Free;
end;

procedure TSynEditSearcher.OnReplaceText(Sender: TObject; const ASearch,
  AReplace: string; Line, Column: integer; var Action: TSynReplaceAction);
var
  APos: TPoint; 
begin
  with TSynEdit(Sender) do
    APos := ClientToScreen(RowColumnToPixels(BufferToDisplayPos(
    BufferCoord(Column, Line+1))));
  case MessageDlgPos(format(sReplacePromptText, [ASearch, AReplace]),
    sReplacePromptTitle, mtConfirmation, [sReplacePromptYesBtn,
    sReplacePromptSkipBtn, sReplacePromptAllBtn, sReplacePromptCancelBtn ],
    1, 4, APos.X, APos.Y) of
    1: Action := raReplace;
    3: Action := raReplaceAll;
    2: Action := raSkip;
    else Action := raCancel;
  end;
end;

procedure TSynEditSearcher.Find(SynEdit : TcustomSynEdit);
var
  s : string;
begin
  with CreateFindDialog do
  begin
    Exclude(FSearchOptions, ssoReplace);
    Exclude(FSearchOptions, ssoReplaceall);
    If SynEdit.SelAvail then
      s := SynEdit.SelText else
      s := FFindText;
    SetSearchData(s, '', FFindHistory, nil, FSearchOptions, FRegexSearch);
    IF ShowModal = mrOk then
    begin
      GetSearchData(FFindText, s, FFindHistory, nil, FSearchOptions, FRegexSearch);
      Hide;
      Search(SynEdit, FFindText, '', FSearchOptions, FRegexSearch);
    end;
    free;
  end;
end;

procedure TSynEditSearcher.FindEx(ASynEdit: TcustomSynEdit;
  var ASearchOptions: TSynSearchOptions;
  var psFindText:string;
  var pbRegexSearch:boolean);
var
  s : string;
begin
  with CreateFindDialog do
  begin
    fSearchOptions := ASearchOptions;
    Exclude(fSearchOptions, ssoReplace);
    Exclude(fSearchOptions, ssoReplaceall);
    If ASynEdit.SelAvail then
      s := ASynEdit.SelText else
      s := fFindText;
    SetSearchData(s, '', fFindHistory, nil, fSearchOptions, fRegexSearch);
    IF ShowModal = mrOk then
    begin
      GetSearchData(fFindText, s, fFindHistory, nil, fSearchOptions, fRegexSearch);
      Hide;
      Search(ASynEdit, fFindText, '', fSearchOptions, fRegexSearch);
      ASearchOptions := fSearchOptions;
      psFindText := fFindText;
      pbRegexSearch := fRegexSearch;
    end;
    Free;
  end;
  
end;


procedure TSynEditSearcher.FindLast(SynEdit : TcustomSynEdit);
begin
  If FFindText = '' then Find(SynEdit)
  else Search(SynEdit, FFindText, '', FSearchOptions + [ssoBackwards] -
    [ssoReplace, ssoReplaceAll], fRegexSearch);
end;

procedure TSynEditSearcher.FindLastForWord(SynEdit : TcustomSynEdit);
begin
  If FFindText = '' then Find(SynEdit)
  else Search(SynEdit, FFindText, '', fSearchOptions + [ssoBackwards, ssoWholeWord] -
    [ssoReplace, ssoReplaceAll], fRegexSearch);
end;

procedure TSynEditSearcher.FindNext(SynEdit : TcustomSynEdit);
begin
  If FFindText = '' then Find(SynEdit)
  else Search(SynEdit, FFindText, '', fSearchOptions -
    [ssoReplace, ssoReplaceAll, ssoBackwards], fRegexSearch);
end;

procedure TSynEditSearcher.FindNextForWord(SynEdit : TcustomSynEdit);
begin
  If FFindText = '' then Find(SynEdit)
  else Search(SynEdit, FFindText, '', fSearchOptions + [ssoWholeWord] -
    [ssoReplace, ssoReplaceAll, ssoBackwards], fRegexSearch);
end;

procedure TSynEditSearcher.Replace(SynEdit : TcustomSynEdit);
var
  s : string;
begin
  with CreateReplaceDialog do
  begin
    Exclude(FSearchOptions, ssoReplace);
    Exclude(FSearchOptions, ssoReplaceall);
    If SynEdit.SelAvail then
      s := SynEdit.SelText else
      s := FFindText;
    SetSearchData(s, FReplaceText, FFindHistory, FReplaceHistory,
      FSearchOptions, FRegexSearch);
    IF ShowModal in [mrOk, mrall] then
    begin
      GetSearchData(FFindText, FReplaceText, FFindHistory, FReplaceHistory,
        FSearchOptions, FRegexSearch);
      If modalResult = mrOk then
        Include(FSearchOptions, ssoReplace);
      If modalResult = mrall then
        Include(FSearchOptions, ssoReplaceall);
      hide;
      Search(SynEdit, FFindText, FReplaceText, FSearchOptions, FRegexSearch);
    end;
    free;
  end;
end;

procedure TSynEditSearcher.ReplaceLast(SynEdit : TcustomSynEdit);
begin
  If FFindText = '' then Replace(SynEdit)
  else Search(SynEdit, FFindText, FReplaceText, FSearchOptions -
   [ssoReplaceall] + [ssoReplace, ssoBackwards], FRegexSearch);
end;

procedure TSynEditSearcher.ReplaceNext(SynEdit : TcustomSynEdit);
begin
  If FFindText = '' then Replace(SynEdit)
  else Search(SynEdit, FFindText, FReplaceText, FSearchOptions + [ssoReplace] -
   [ssoReplaceall, ssoBackwards], FRegexSearch);
end;

procedure TSynEditSearcher.Search(
  SynEdit : TcustomSynEdit;
  FindText, ReplaceText: string;
  SearchOptions : TSynSearchOptions;
  RegexSearch : Boolean);
var
  P ,I: integer;
  oldEvent : TReplaceTextEvent;
  bAll_Not_Found :Boolean;
  bc_first,bc_old,bc_blockBegin :TBufferCoord;
begin
  with SynEdit do
  begin
    oldEvent := OnReplaceText;
    OnReplaceText := self.OnReplaceText;
    if RegexSearch then
      SearchEngine := FSynRegexSearch else
      SearchEngine := FSynSearch;
    if SearchReplace(FindText, ReplaceText, SearchOptions) = 0 then
    begin
                             
      bAll_Not_Found := True;
      bc_old := CaretXY;
      bc_blockBegin := BlockBegin;
       
      if ssoSelectedOnly in SearchOptions then begin
        if ssoBackwards in SearchOptions then
          bc_first := SynEdit.BlockEnd
        else
          bc_first := SynEdit.BlockBegin;
      end
      else begin
        bc_first.Char := 1; bc_first.Line :=1;
        if ssoBackwards in SearchOptions then begin
          bc_first.Line := SynEdit.Lines.Count;
          bc_first.Char := Length(Lines[bc_first.Line - 1]) + 1;
        end;
      end;

      if not (ssoReplace in SearchOptions)
         and not (ssoReplaceAll in SearchOptions)
         and (ssoPrompt in SearchOptions) then
      begin
        // 循环查找
        CaretXY := bc_first; 
        bAll_Not_Found := SearchReplace(FindText, ReplaceText, SearchOptions) =0;// then
      end;

      if bAll_Not_Found then
      begin
        // 2015-10-02 liqj 增加到尾提示从开始
        I := windows.MessageBox(Application.Handle,PChar(format(sNotFindText, [FindText])+', 是否从头开始搜索？'),PChar(Application.Title),MB_YESNOCANCEL);
        if I = IDYes then
        begin
          CaretXY := bc_first;
          bAll_Not_Found := SearchReplace(FindText, ReplaceText, SearchOptions) =0;
        end;

        if bAll_Not_Found then
        begin
          MessageBeep(MB_ICONASTERISK);
          //ShowMessage(format(sNotFindText, [FindText]));
          if ssoBackwards in SearchOptions then
            BlockEnd := BlockBegin else
            BlockBegin := BlockEnd;
          //CaretXY := BlockBegin;
          if i = idno then
            CaretXY := bc_blockBegin
          else
            CaretXY := BlockBegin;

        end;
      end;

    end;
    OnReplaceText := oldEvent;
  end;
  P := FFindHistory.IndexOf(FindText);
  If P > -1 then FFindHistory.Delete(P);
  FFindHistory.Insert(0, FindText);
  FFindText := FindText;
  If (ssoReplace in SearchOptions) or (ssoReplaceAll in SearchOptions) then
  begin
    P := FReplaceHistory.IndexOf(ReplaceText);
    If P > -1 then FReplaceHistory.Delete(P);
    FReplaceHistory.Insert(0, ReplaceText);
    FReplaceText := ReplaceText;
  end;
end;

{ TSynSearchDialog }

procedure TSynSearchDialog.getSearchData(var FindText, ReplaceText: string;
  FindHistory, ReplaceHistory: TStrings;
  var SearchOptions: TSynSearchOptions; var RegexSearch: Boolean);
begin

end;

procedure TSynSearchDialog.SetSearchData(const FindText,
  ReplaceText: string; FindHistory, ReplaceHistory: TStrings;
  const SearchOptions: TSynSearchOptions; const RegexSearch: Boolean);
begin

end;

initialization
  Searcher := TSynEditSearcher.Create;

finalization
  Searcher.Free;

end.
