object SynJumpDlg: TSynJumpDlg
  Left = 240
  Top = 208
  ActiveControl = bsLine
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = #36339#36716
  ClientHeight = 158
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    397
    158)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 102
    Top = 6
    Width = 62
    Height = 13
    Caption = #26032#30340#20301#32622'(&S)'
  end
  object Label2: TLabel
    Left = 6
    Top = 6
    Width = 40
    Height = 13
    Caption = #26041#24335'(&M)'
    FocusControl = ListBox1
  end
  object Hint: TLabel
    Left = 102
    Top = 50
    Width = 120
    Height = 13
    Caption = #35201#36339#36716#21040#30340#20301#32622#30340#34892#21495
  end
  object Button1: TButton
    Left = 221
    Top = 124
    Width = 81
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = #30830#23450'(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 304
    Top = 124
    Width = 81
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 1
  end
  object bsLine: TEdit
    Left = 102
    Top = 24
    Width = 283
    Height = 21
    TabOrder = 2
    OnKeyPress = bsLineKeyPress
  end
  object ListBox1: TListBox
    Left = 6
    Top = 24
    Width = 83
    Height = 121
    Style = lbOwnerDrawFixed
    Items.Strings = (
      #34892#21495
      #21015#21495
      #20070#31614
      #23383#31526
      #21521#19979#31227#21160
      #21521#19978#31227#21160)
    TabOrder = 3
    OnClick = ListBox1Click
  end
end
