{-------------------------------------------------------------------------------
   ��Ԫ: SynJumpDlg.pas
   ����: Ҧ�Ƿ�       
   ����: 2004.11.27
   ˵��: ��ת�Ի���
   �汾: 1.00 00                   
                                                                              
-------------------------------------------------------------------------------}

unit u_SynJumpDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, SynEditKeyCmds, SynEditTypes, StdCtrls, SynEdit;

type
  TSynJumpDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    bsLine: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Hint: TLabel;
    procedure bsLineKeyPress(Sender: TObject; var Key: Char);
    procedure ListBox1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure UpdateHint;
  public
    class procedure Execute(SynEdit : TCustomSynEdit);
  end;

implementation

{$R *.dfm}

procedure TSynJumpDlg.bsLineKeyPress(Sender: TObject; var Key: Char);
begin
  If not (CharInSet(key , [#8, #127, '0'..'9'])) then
    Key := #0;
end;

procedure TSynJumpDlg.ListBox1Click(Sender: TObject);
begin
  UpdateHint;
  bsLine.SetFocus;
end;

procedure TSynJumpDlg.UpdateHint;
begin
  If Listbox1.ItemIndex < 0 then
    Listbox1.ItemIndex := 0;
  case Listbox1.ItemIndex of
    0 : Hint.Caption := 'Ҫ��ת����λ�õ��к�';
    1 : Hint.Caption := 'Ҫ��ת��λ�õ��к�';
    2 : Hint.Caption := 'Ҫ��ת������ǩ��(0-9)';
    3 : Hint.Caption := 'Ҫ��ת����λ�õ�ƫ����';
    4 : Hint.Caption := '�ɵ�ǰ��������ƶ�ָ����';
    5 : Hint.Caption := '�ɵ�ǰ��������ƶ�ָ����';
  end;
end;

procedure TSynJumpDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not ListBox1.Focused then
  begin
    case Key of
      VK_UP : ListBox1.ItemIndex := ListBox1.ItemIndex -1;
      VK_DOWN : ListBox1.ItemIndex := ListBox1.ItemIndex +1;
    end;
    ListBox1Click(ListBox1);
  end;
end;

class procedure TSynJumpDlg.Execute(SynEdit: TCustomSynEdit);
begin
  if SynEdit <> nil then
  begin
    with TSynJumpDlg.Create(Application) do
    try
      //bsLine.Clear;
      Listbox1.ItemIndex := 0;
      if ShowModal = mrok then
      begin
        If Listbox1.ItemIndex < 0 then
          Listbox1.ItemIndex := 0;
        case Listbox1.ItemIndex of
          0 : SynEdit.GotoLineAndCenter(strtoint(bsLine.Text));
          1 : SynEdit.CaretX := strtoint(bsLine.Text);
          2 : SynEdit.GotoBookMark(strtoint(bsLine.Text));
          3 : SynEdit.SelStart := strtoint(bsLine.Text);
          4 : SynEdit.SelStart := SynEdit.SelStart + strtoint(bsLine.Text);
          5 : SynEdit.SelStart := SynEdit.SelStart - strtoint(bsLine.Text);
        end;
      end;
    finally
      Free;  
    end;
  end;
end;

end.
