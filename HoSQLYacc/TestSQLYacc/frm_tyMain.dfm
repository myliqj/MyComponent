object Form1: TForm1
  Left = 293
  Top = 139
  Width = 791
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 425
    Width = 783
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnPrnTree: TButton
      Left = 23
      Top = 8
      Width = 75
      Height = 25
      Caption = 'PrintTree'
      TabOrder = 0
      OnClick = btnPrnTreeClick
    end
    object Button2: TButton
      Left = 108
      Top = 8
      Width = 75
      Height = 25
      Caption = 'GetFields1'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'GetFields2'
      TabOrder = 2
      OnClick = Button3Click
    end
    object btnRefreshList: TButton
      Left = 278
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Refresh List'
      TabOrder = 3
      OnClick = btnRefreshListClick
    end
    object btnSave: TButton
      Left = 363
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Save To List'
      TabOrder = 4
      OnClick = btnSaveClick
    end
    object btnNew: TButton
      Left = 450
      Top = 9
      Width = 75
      Height = 25
      Caption = 'New Item'
      TabOrder = 5
      OnClick = btnNewClick
    end
    object btnDel: TButton
      Left = 537
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Delete Item'
      TabOrder = 6
      OnClick = btnDelClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 783
    Height = 425
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 185
      Top = 0
      Width = 4
      Height = 425
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 425
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object lbSQLs: TListBox
        Left = 0
        Top = 0
        Width = 185
        Height = 425
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = lbSQLsDblClick
      end
    end
    object Panel4: TPanel
      Left = 189
      Top = 0
      Width = 594
      Height = 425
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 0
        Top = 165
        Width = 594
        Height = 4
        Cursor = crVSplit
        Align = alTop
      end
      object edSQL: THoSynEdit
        Left = 0
        Top = 0
        Width = 594
        Height = 165
        Align = alTop
        CodeFolding.CaseSensitive = False
        CodeFolding.FolderBarLinesColor = 9617866
        ActiveLine.Background = clYellow
        ActiveLine.Foreground = clNavy
        ActiveLine.Visible = True
        LineDivider.Visible = False
        LineDivider.Color = clRed
        LineDivider.Style = psSolid
        RightEdge.MouseMove = False
        RightEdge.Visible = True
        RightEdge.Position = 80
        RightEdge.Color = clSilver
        RightEdge.Style = psSolid
        LineSpacing = 0
        LineSpacingRule = lsSingle
        Background.Visible = False
        Background.RepeatMode = brmNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        Gutter.ShowLineModified = False
        Gutter.LineModifiedColor = clYellow
        Gutter.LineNormalColor = clLime
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.LeftOffsetColor = clNone
        Gutter.RightOffsetColor = clNone
        Highlighter = SynSQLSyn1
        WordWrap.Enabled = False
        WordWrap.Position = 80
        WordWrap.Style = wwsClientWidth
      end
      object mmRst: TRichEdit
        Left = 0
        Top = 169
        Width = 594
        Height = 256
        Align = alClient
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
  object SynSQLSyn1: TSynSQLSyn
    KeyAttri.Foreground = clBlue
    Left = 282
    Top = 61
  end
end
