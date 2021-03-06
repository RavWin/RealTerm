object InstallTour: TInstallTour
  Left = 227
  Top = 50
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Realterm'
  ClientHeight = 268
  ClientWidth = 708
  Color = clInfoBk
  ParentFont = True
  OldCreateOrder = True
  Position = poDesigned
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 46
    Width = 41
    Height = 18
    Caption = 'Label1'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 224
    Width = 708
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 0
    object ButtonNext: TBitBtn
      Left = 6
      Top = 4
      Width = 126
      Height = 36
      Caption = 'Next'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      Kind = bkOK
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonNextClick
    end
    object ButtonDone: TBitBtn
      Left = 255
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Done'
      Kind = bkAbort
      NumGlyphs = 2
      TabOrder = 1
      OnClick = ButtonDoneClick
    end
    object ButtonChangeTour: TBitBtn
      Left = 584
      Top = 8
      Width = 89
      Height = 25
      Kind = bkRetry
      NumGlyphs = 2
      TabOrder = 2
      Visible = False
      OnClick = ButtonChangeTourClick
    end
    object ButtonHelp: TBitBtn
      Left = 335
      Top = 4
      Width = 132
      Height = 35
      Hint = 'Launch Online Help and News'
      Caption = '&News && Help'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      Kind = bkHelp
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = ButtonHelpClick
    end
    object ComboBoxTour: TComboBox
      Left = 144
      Top = 10
      Width = 113
      Height = 26
      AutoCloseUp = True
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnSelect = ComboBoxTourSelect
    end
  end
  object PanelTitle: TPanel
    Left = 0
    Top = 0
    Width = 708
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Realterm Install Tour'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
  end
  object PanelHeading: TPanel
    Left = 0
    Top = 19
    Width = 708
    Height = 28
    Align = alTop
    AutoSize = True
    Caption = 'Heading'
    Color = 33023
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object ComboBoxHeading: TComboBox
      Left = 1
      Top = 1
      Width = 706
      Height = 26
      Align = alTop
      AutoCloseUp = True
      BevelEdges = []
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      Style = csDropDownList
      Color = clInfoBk
      DropDownCount = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
      TabOrder = 0
      StyleElements = []
      OnSelect = ComboBoxHeadingSelect
    end
  end
end
