{-------------------------------------------------------------------------------
   单元: SynMsgDialog.pas
   作者: 姚乔锋 - yaoqiaofeng@sohu.com
   日期: 2005-5-20
   版本: 1.00
   说明: 提供了message Dialog 函数,其实这是我一个很宝贝的单元HDialogs其中一部分
-------------------------------------------------------------------------------}
(*
  -- 使用者 --
  * Uesr : liqj
  * Date : 2006-09-29
  * Modi : xx
  * Var  : 1.0.0.1
*)

unit u_SynMsgDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, StdCtrls,
  Graphics, ExtCtrls, Consts, Math;

// Create Message Dialog
function CreateMessageDialog(
  const Msg: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer;
  const ButtonWidth, ButtonHeight : integer): TForm;
function ShowMessageDlg(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer;
  const HelpIndex, HelpCtx: Longint; const HelpFileName: string;
  const X, Y: Integer): Integer;
function MessageDlgPos(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer;
  const X, Y: Integer): Integer;
function MessageDlg(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer
  ): Integer; overload;
function MessageDlg(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string
  ): Integer; overload;
function MessageDlg(const Msg, Title: string): boolean; overload;
procedure ShowMessagePos(const Msg, Title: string; const X, Y: Integer);
procedure ShowMessage(const Msg, Title: string); overload;
procedure ShowMessage(const Msg: string); overload;

implementation

type
  TMessageDialog = class(TForm)
  private
    Message: TLabel;
    Image : TImage;
    Btns : array of TButton;
    procedure ButtonClick(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WriteToClipBoard(Text: String);
    function GetFormText: String;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

procedure TMessageDialog.ButtonClick(Sender: TObject);
begin
  ModalResult := TButton(Sender).Tag;
end;

procedure TMessageDialog.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    MessageBeep(0);
    WriteToClipBoard(GetFormText);
  end;
end;

procedure TMessageDialog.WriteToClipBoard(Text: String);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if OpenClipBoard(0) then
  begin
    try
      Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Length(Text) + 1);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(PChar(Text)^, DataPtr^, Length(Text) + 1);
          EmptyClipBoard;
          SetClipboardData(CF_TEXT, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipBoard;
    end;
  end
  else raise Exception.CreateRes(@SCannotOpenClipboard);
end;

function TMessageDialog.GetFormText: String;
var
  DividerLine, ButtonCaptions: string;
  I: integer;
begin
  DividerLine := StringOfChar('-', 27) + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TButton then
      ButtonCaptions := ButtonCaptions + TButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions,'&','', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, Message.Caption, sLineBreak, DividerLine, ButtonCaptions,
    sLineBreak, DividerLine]);
end;

constructor TMessageDialog.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
  Image := TImage.Create(Self);
  with Image do
  begin
    Parent := self;
    Left := 16;
    Top := 16;
    width := 32;
    Height := 32;
  end;
  Message := TLabel.Create(Self);
  with Message do
  begin
    Parent := Self;
    Left := 64;
    Top :=  16;
    Constraints.MinHeight := 32;
    Layout := tlCenter;
  end;
  AutoScroll := False;
  BiDiMode := Application.BiDiMode;
  BorderStyle := bsDialog;
  Canvas.Font := Font;
  KeyPreview := True;
  OnKeyDown := CustomKeyDown;
end;

function GetDlgIcon(DlgType: TMsgDlgType): HIcon;
const
  IconIDs: array[TMsgDlgType] of PChar = (
    IDI_EXCLAMATION, IDI_HAND, IDI_ASTERISK, IDI_QUESTION, nil);
var
  IconID: PChar;
begin
  IconID := IconIDs[DlgType];
  Result := LoadIcon(0, IconID);
end;

function CreateMessageDialog(
  const Msg: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer;
  const ButtonWidth, ButtonHeight : integer): TForm;
var
  I,
  ButtonsLeft,
  ButtonsTop,
  ButtonsWidth,
  IconTextWidth : Integer;
begin
  Result := TMessageDialog.CreateNew(Application);
  with TMessageDialog(Result) do
  begin
    Image.Picture.Icon.Handle := GetDlgIcon(DlgType);
    Message.Caption := Msg;
    ButtonsTop := Message.Top + Message.Height + 15;
    IconTextWidth := 48 + Message.Width;
    ButtonsWidth := 0;
    SetLength(Btns, Length(Buttons));
    for i := Low(Buttons) to High(Buttons) do
    begin
      Btns[i] := TButton.Create(Result);
      with Btns[i] do
      begin
        If i = DefaultIndex then
          default := True
        else if i = CancelIndex then
          Cancel := true;
        Parent := Result;
        Tag := i + 1;
        Caption := Buttons[i];
        OnClick := ButtonClick;
        Height := ButtonHeight;
        Width := Max(ButtonWidth, Canvas.TextWidth(Buttons[i]) + 20);
        ButtonsWidth := ButtonsWidth + Width + 3;
        Top := ButtonsTop;
      end;
    end;
    dec(ButtonsWidth, 3);
    ClientWidth := Max(ButtonsWidth, IconTextWidth) + 32;
    ClientHeight := ButtonsTop + ButtonHeight + 16;
    ButtonsLeft := (clientWidth - ButtonsWidth) div 2;
    for i := Low(Btns) to High(Btns) do
    begin
      Btns[i].Left := ButtonsLeft;
      ButtonsLeft := ButtonsLeft + Btns[i].Width + 4;
    end;
  end;
end;

function ShowMessageDlg(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer;
  const HelpIndex, HelpCtx: Longint; const HelpFileName: string;
  const X, Y: Integer): Integer;
var
  Dialog : TMessageDialog;
begin
  Dialog := TMessageDialog(CreateMessageDialog(Msg, DlgType, Buttons,
    DefaultIndex, CancelIndex, 80, 23));
  with Dialog do
    try
      Caption := Title;
      HelpFile := HelpFileName;
      If HelpIndex in [low(buttons)..High(Buttons)] then begin
        btns[HelpIndex].HelpContext := HelpCtx;
        btns[HelpIndex].Tag := 0;
      end;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function MessageDlgPos(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer;
  const X, Y: Integer): Integer;
begin
  Result := ShowMessageDlg(Msg, Title, DlgType, Buttons, DefaultIndex,
    CancelIndex, -1, 0, '', X, Y);
end;

function MessageDlg(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string;
  const DefaultIndex, CancelIndex : integer
  ): Integer;
begin
  Result := MessageDlgPos(Msg, Title, DlgType, Buttons, DefaultIndex,
    CancelIndex, -1, -1);
end;

function MessageDlg(
  const Msg, Title: string; const DlgType: TMsgDlgType;
  const Buttons: array of string
  ): Integer;
begin
  result := MessageDlg(Msg, Title, dlgType, Buttons, 0, -1);
end;

function MessageDlg(const Msg, Title: string): boolean;
begin
  result := MessageDlg(Msg, Title, mtInformation, ['是(&Y)', '否(&N)']) = 1;
end;

procedure ShowMessagePos(const Msg, Title: string; const X, Y: Integer);
begin
  MessageDlgPos(Msg, Title, mtInformation, ['确定(&O)'], 0, -1, X, Y);
end;

procedure ShowMessage(const Msg, Title: string);
begin
  ShowMessagePos(Msg, Title, -1, -1);
end;

procedure ShowMessage(const Msg: string);
begin
  ShowMessage(Msg, Application.Title);
end;

end.
