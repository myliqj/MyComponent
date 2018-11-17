inherited SynReplaceDlg: TSynReplaceDlg
  Left = 276
  Top = 212
  Caption = #26367#25442
  ClientHeight = 154
  ClientWidth = 466
  OldCreateOrder = True
  ExplicitWidth = 472
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 13
  object lblReplace: TLabel [1]
    Left = 10
    Top = 40
    Width = 38
    Height = 13
    Caption = #26367#25442'(&T)'
  end
  inherited AssistantButton: TSpeedButton
    Left = 339
    ExplicitLeft = 339
  end
  inherited cbSearchText: TComboBox
    Left = 58
    ExplicitLeft = 58
  end
  inherited rgSearchDirection: TRadioGroup
    Top = 75
    Width = 69
    Height = 70
    TabOrder = 2
    ExplicitTop = 75
    ExplicitWidth = 69
    ExplicitHeight = 70
  end
  inherited btnOK: TButton
    TabOrder = 3
  end
  inherited btnCancel: TButton
    Top = 70
    TabOrder = 4
    ExplicitTop = 70
  end
  inherited cbSearchCaseSensitive: TCheckBox
    Top = 75
    TabOrder = 5
    ExplicitTop = 75
  end
  inherited cbSearchWholeWords: TCheckBox
    Top = 101
    TabOrder = 6
    ExplicitTop = 101
  end
  inherited cbSearchFromCursor: TCheckBox
    Top = 75
    TabOrder = 7
    ExplicitTop = 75
  end
  inherited cbSearchSelectedOnly: TCheckBox
    Top = 111
    TabOrder = 8
    ExplicitTop = 111
  end
  object btnReplaceAll: TButton [11]
    Left = 368
    Top = 40
    Width = 91
    Height = 23
    Caption = #20840#37096#26367#25442'(&A)'
    Enabled = False
    ModalResult = 12
    TabOrder = 11
  end
  object chkShowReplace: TCheckBox [12]
    Left = 120
    Top = 128
    Width = 81
    Height = 17
    Caption = #25552#31034#26367#25442'(&P)'
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object cbReplaceText: TComboBox [13]
    Left = 58
    Top = 37
    Width = 279
    Height = 21
    ImeName = 'Chinese (Simplified) - US Keyboard'
    TabOrder = 1
    OnChange = cbSearchTextChange
  end
  inherited cbRegularExpression: TCheckBox
    Top = 128
    TabOrder = 10
    ExplicitTop = 128
  end
  inherited AssistantMenu: TPopupMenu
    Left = 368
    Top = 88
  end
end
