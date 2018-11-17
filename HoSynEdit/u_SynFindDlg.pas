{------原作者------------------------------------------------------------------
   单元: SynFindDlg.pas
   作者: 姚乔锋
   日期: 2004.11.26                                                           
   说明: 查找对话框
   版本: 1.00 00
-------------------------------------------------------------------------------}
(*
  -- 使用者 --
  * Uesr : liqj
  * Date : 2006-09-29
  * Modi : xx
  * Var  : 1.0.0.1

  * 2012-07-22 liqj 新增 查找时，ssoPrompt 表示 循环查找
*)

unit u_SynFindDlg;

interface

uses
  // Delphi
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, Buttons,
  // SynEdit
  SynEditTypes, 
  // Local
  u_SynEditSearcher;

type
  TfrmSynFindDlg = class(TSynSearchDialog)
    cbSearchText: TComboBox;
    rgSearchDirection: TRadioGroup;
    btnOK: TButton;
    btnCancel: TButton;
    cbSearchCaseSensitive: TCheckBox;
    cbSearchWholeWords: TCheckBox;
    cbSearchFromCursor: TCheckBox;
    cbSearchSelectedOnly: TCheckBox;
    cbRegularExpression: TCheckBox;
    AssistantMenu: TPopupMenu;
    ETabChar: TMenuItem;
    ECRChar: TMenuItem;
    S1: TMenuItem;
    EAnyChar: TMenuItem;
    ECharInRange: TMenuItem;
    S2: TMenuItem;
    ECharOutRange: TMenuItem;
    EMatchBOL: TMenuItem;
    EMatchEOL: TMenuItem;
    N9: TMenuItem;
    EMatchZeroOrMore: TMenuItem;
    EMatchOneOrMore: TMenuItem;
    EMatchZeroOrOne: TMenuItem;
    EMatchNTimes: TMenuItem;
    EMatchLeastNTimes: TMenuItem;
    EMatchTimesRange: TMenuItem;
    N1: TMenuItem;
    EMatchNumber: TMenuItem;
    EMatchNonNumber: TMenuItem;
    EMatchAnySpace: TMenuItem;
    EMatchAnyNonSpace: TMenuItem;
    ELFChar: TMenuItem;
    lblSearch: TLabel;
    AssistantButton: TSpeedButton;
    cbLoopFind: TCheckBox;
    procedure cbSearchTextChange(Sender: TObject);
    procedure AssistantMenuClick(Sender: TObject);
    procedure AssistantButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    procedure UpdateButton; virtual;
  public
    procedure SetSearchData(const FindText, ReplaceText : string;
      FindHistory, ReplaceHistory : TStrings;
      const SearchOptions : TSynSearchOptions;
      const RegexSearch : Boolean); override;
    procedure getSearchData(var FindText, ReplaceText : string;
      FindHistory, ReplaceHistory : TStrings;
      var SearchOptions : TSynSearchOptions;
      var RegexSearch : Boolean); override;
  end;

implementation

{$R *.DFM}

procedure TfrmSynFindDlg.cbSearchTextChange(Sender: TObject);
begin
  UpdateButton;
end;

procedure TfrmSynFindDlg.UpdateButton;
begin
  btnOk.Enabled := cbSearchText.Text <> '';
end;

procedure TfrmSynFindDlg.AssistantMenuClick(Sender: TObject);
begin
  cbRegularExpression.Checked := true;
  If Sender = ETabChar then
    cbSearchText.SelText := '\t';
  If Sender = ECRChar then
    cbSearchText.SelText := '\r';
  If Sender = ELFChar then
    cbSearchText.SelText := '\n';
  If Sender = EAnyChar then
    cbSearchText.SelText := '.';
  If Sender = ECharInRange then
    cbSearchText.SelText := '[]';
  If Sender = ECharOutRange then
    cbSearchText.SelText := '[^]';
  If Sender = EMatchBOL then
    cbSearchText.SelText := '^';
  If Sender = EMatchEOL then
    cbSearchText.SelText := '$';
  If Sender = EMatchZeroOrMore then
    cbSearchText.SelText := '*';
  If Sender = EMatchOneOrMore then
    cbSearchText.SelText := '+';
  If Sender = EMatchZeroOrOne then
    cbSearchText.SelText := '?';
  If Sender = EMatchNTimes then
    cbSearchText.SelText := '{1}';
  If Sender = EMatchLeastNTimes then
    cbSearchText.SelText := '{1,}';
  If Sender = EMatchTimesRange then
    cbSearchText.SelText := '{1,1}';
  If Sender = EMatchNumber then
    cbSearchText.SelText := '\d';
  If Sender = EMatchNonNumber then
    cbSearchText.SelText := '\D';
  If Sender = EMatchanySpace then
    cbSearchText.SelText := '\s';
  If Sender = EMatchanyNonSpace then
    cbSearchText.SelText := '\S';
end;

procedure TfrmSynFindDlg.getSearchData(var FindText, ReplaceText: string;
  FindHistory, ReplaceHistory: TStrings;
  var SearchOptions: TSynSearchOptions; var RegexSearch: Boolean);
begin
  inherited;
  FindText := cbSearchText.Text;
  FindHistory.Assign(cbSearchText.Items);
  RegexSearch := cbRegularExpression.Checked;
  SearchOptions := [];
  If boolean(rgSearchDirection.ItemIndex) then
    SearchOptions := SearchOptions + [ssoBackwards];
  If cbSearchCaseSensitive.Checked then
    SearchOptions := SearchOptions + [ssoMatchCase];
  If cbSearchWholeWords.Checked then
    SearchOptions := SearchOptions + [ssoWholeWord];
  If cbSearchSelectedOnly.Checked then
    SearchOptions := SearchOptions + [ssoSelectedOnly];
  If not cbSearchFromCursor.Checked then
    SearchOptions := SearchOptions + [ssoEntireScope];
  // 查找时，ssoPrompt 表示 循环查找
  If cbLoopFind.Checked then
    SearchOptions := SearchOptions + [ssoPrompt];
end;

procedure TfrmSynFindDlg.SetSearchData(const FindText, ReplaceText: string;
  FindHistory, ReplaceHistory: TStrings;
  const SearchOptions: TSynSearchOptions; const RegexSearch: Boolean);
begin
  inherited;
  cbSearchText.Text := FindText;
  cbSearchText.Items.Assign(FindHistory);
  rgSearchDirection.ItemIndex := integer(ssoBackwards in SearchOptions);
  cbRegularExpression.Checked := RegexSearch;
  cbSearchCaseSensitive.Checked:= ssoMatchCase in SearchOptions;
  cbSearchWholeWords.Checked:= ssoWholeWord in SearchOptions;
  cbSearchSelectedOnly.Checked:= ssoSelectedOnly in SearchOptions;
  cbSearchFromCursor.Checked:= not (ssoEntireScope in SearchOptions);
  cbLoopFind.Checked:= ssoPrompt in SearchOptions;
end;

procedure TfrmSynFindDlg.AssistantButtonClick(Sender: TObject);
var
  P : TPoint;
begin
  with P do
  begin
    x := AssistantButton.Left;
    y := AssistantButton.Top + AssistantButton.Height;
  end;
  with ClientToScreen(p) do
    AssistantMenu.Popup(x, y);
end;

procedure TfrmSynFindDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // 默认F3键查找
  if (Key = VK_F3) and (cbSearchText.Text<>'') then
    ModalResult := mrOK;
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

initialization
  FindDialogClass := TfrmSynFindDlg;

end.

