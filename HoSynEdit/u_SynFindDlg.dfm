object frmSynFindDlg: TfrmSynFindDlg
  Left = 229
  Top = 290
  BorderStyle = bsDialog
  Caption = #26597#25214
  ClientHeight = 124
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = cbSearchTextChange
  PixelsPerInch = 96
  TextHeight = 13
  object lblSearch: TLabel
    Left = 10
    Top = 14
    Width = 38
    Height = 13
    Caption = #26597#25214'(&S)'
    FocusControl = cbSearchText
  end
  object AssistantButton: TSpeedButton
    Left = 338
    Top = 10
    Width = 21
    Height = 20
    Glyph.Data = {
      AE000000424DAE00000000000000360000002800000007000000050000000100
      18000000000078000000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFF000000000000000000FFFFFFFFFFFF00
      0000FFFFFF000000000000000000000000000000FFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    OnClick = AssistantButtonClick
  end
  object cbSearchText: TComboBox
    Left = 57
    Top = 10
    Width = 279
    Height = 21
    Hint = #21333#20987#21491#38190#26377#36741#21161#33756#21333
    ImeName = 'Chinese (Simplified) - US Keyboard'
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = cbSearchTextChange
  end
  object rgSearchDirection: TRadioGroup
    Left = 256
    Top = 46
    Width = 81
    Height = 64
    Caption = #26041#21521
    ItemIndex = 0
    Items.Strings = (
      #21521#19979'(&B)'
      #21521#19978'(&F)')
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 368
    Top = 10
    Width = 91
    Height = 23
    Caption = #26597#25214'(&O)'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 368
    Top = 42
    Width = 91
    Height = 23
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 3
  end
  object cbSearchCaseSensitive: TCheckBox
    Left = 10
    Top = 46
    Width = 100
    Height = 17
    Caption = #21306#20998#22823#23567#20889'(&C)'
    TabOrder = 4
  end
  object cbSearchWholeWords: TCheckBox
    Left = 10
    Top = 69
    Width = 92
    Height = 17
    Caption = #20840#23383#21305#37197'(&W)'
    TabOrder = 5
  end
  object cbSearchFromCursor: TCheckBox
    Left = 120
    Top = 46
    Width = 132
    Height = 17
    Caption = #20174#20809#26631#22788#24320#22987#26597#25214'(&E)'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cbSearchSelectedOnly: TCheckBox
    Left = 120
    Top = 69
    Width = 116
    Height = 17
    Caption = #21482#26597#25214#36873#20013#37096#20998'(&L)'
    TabOrder = 7
  end
  object cbRegularExpression: TCheckBox
    Left = 10
    Top = 93
    Width = 100
    Height = 17
    Caption = #27491#35268#34920#36798#24335'(&R)'
    TabOrder = 8
  end
  object cbLoopFind: TCheckBox
    Left = 120
    Top = 94
    Width = 97
    Height = 17
    Caption = #24490#29615#26597#25214'(&Q)'
    TabOrder = 9
  end
  object AssistantMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 376
    Top = 80
    object ETabChar: TMenuItem
      Caption = #21046#34920#31526
      OnClick = AssistantMenuClick
    end
    object ECRChar: TMenuItem
      Caption = #22238#36710#31526
      OnClick = AssistantMenuClick
    end
    object ELFChar: TMenuItem
      Caption = #25442#34892#31526
      OnClick = AssistantMenuClick
    end
    object S1: TMenuItem
      Caption = '-'
    end
    object EAnyChar: TMenuItem
      Caption = #20219#20309#23383#31526
      OnClick = AssistantMenuClick
    end
    object ECharInRange: TMenuItem
      Caption = #23383#31526#22312#33539#22260#20869
      OnClick = AssistantMenuClick
    end
    object ECharOutRange: TMenuItem
      Caption = #23383#31526#19981#22312#33539#22260#20869
      OnClick = AssistantMenuClick
    end
    object S2: TMenuItem
      Caption = '-'
    end
    object EMatchBOL: TMenuItem
      Caption = #21305#37197#34892#39318
      OnClick = AssistantMenuClick
    end
    object EMatchEOL: TMenuItem
      Caption = #21305#37197#34892#23614
      OnClick = AssistantMenuClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object EMatchZeroOrMore: TMenuItem
      Caption = #21305#37197'0'#27425#25110#26356#22810
      OnClick = AssistantMenuClick
    end
    object EMatchOneOrMore: TMenuItem
      Caption = #21305#37197'1'#27425#25110#26356#22810
      OnClick = AssistantMenuClick
    end
    object EMatchZeroOrOne: TMenuItem
      Caption = #21305#37197'0'#27425#25110'1'#27425
      OnClick = AssistantMenuClick
    end
    object EMatchNTimes: TMenuItem
      Caption = #21305#37197#25351#23450#30340#27425#25968
      OnClick = AssistantMenuClick
    end
    object EMatchLeastNTimes: TMenuItem
      Caption = #26368#23569#21305#37197#30340#27425#25968
      OnClick = AssistantMenuClick
    end
    object EMatchTimesRange: TMenuItem
      Caption = #21305#37197#25351#23450#30340#27425#25968#33539#22260
      OnClick = AssistantMenuClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object EMatchNumber: TMenuItem
      Caption = #21305#37197#20219#24847#19968#20010#25968#23383#23383#31526
      OnClick = AssistantMenuClick
    end
    object EMatchNonNumber: TMenuItem
      Caption = #21305#37197#20219#24847#19968#20010#38750#25968#23383#23383#31526
      OnClick = AssistantMenuClick
    end
    object EMatchAnySpace: TMenuItem
      Caption = #21305#37197#20219#24847#31354#26684#23383#31526
      OnClick = AssistantMenuClick
    end
    object EMatchAnyNonSpace: TMenuItem
      Caption = #21305#37197#20219#24847#38750#31354#26684#23383#31526
      OnClick = AssistantMenuClick
    end
  end
end
