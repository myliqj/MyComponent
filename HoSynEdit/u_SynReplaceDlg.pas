{--------原作者---------------------------------------------------------------
   单元: SynReplaceDlg.pas 
   作者: 姚乔锋
   日期: 2004.11.26
   说明: 替换对话框 
   版本: 1.00 00
-------------------------------------------------------------------------------}

(*
  -- 使用者 --
  * Uesr : liqj
  * Date : 2006-09-29
  * Modi : xx
  * Var  : 1.0.0.1
*)

unit u_SynReplaceDlg;

interface

uses
  // Delphi
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, Menus, ComCtrls,
  ToolWin, Buttons, 
  // Synedit
  SynEdit, SynEditTypes, 
  SynEditRegexSearch, SynEditMiscClasses,   
  // Local
  u_SynEditSearcher, u_SynFindDlg;

type
  TSynReplaceDlg = class(TfrmSynFindDlg)
    btnReplaceAll: TButton;
    chkShowReplace: TCheckBox;
    cbReplaceText: TComboBox;
    lblReplace: TLabel;
  protected
    procedure UpdateButton; override;
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

{$R *.dfm}

{ TSynReplaceForm }

procedure TSynReplaceDlg.UpdateButton;
begin
  inherited;
  btnReplaceAll.Enabled := cbSearchText.Text <> '';
end;

procedure TSynReplaceDlg.getSearchData(var FindText, ReplaceText: string;
  FindHistory, ReplaceHistory: TStrings;
  var SearchOptions: TSynSearchOptions; var RegexSearch: Boolean);
begin
  inherited;
  ReplaceText := cbReplaceText.Text;
  ReplaceHistory.Assign(cbReplaceText.Items);
  If chkShowReplace.Checked then
    include(SearchOptions, ssoPrompt);
end;

procedure TSynReplaceDlg.SetSearchData(const FindText, ReplaceText: string;
  FindHistory, ReplaceHistory: TStrings;
  const SearchOptions: TSynSearchOptions; const RegexSearch: Boolean);
begin
  inherited;
  cbReplaceText.Text := ReplaceText;
  cbReplaceText.Items.Assign(ReplaceHistory);
  chkShowReplace.Checked := ssoPrompt in SearchOptions;
end;

initialization
  ReplaceDialogClass := TSynReplaceDlg;

end.
