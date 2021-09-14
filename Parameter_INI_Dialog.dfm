object ParameterINIDlg: TParameterINIDlg
  Left = 227
  Top = 108
  Caption = 'Command Line Parameter INI File'
  ClientHeight = 573
  ClientWidth = 729
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 526
    Top = 0
    Height = 573
    Align = alRight
    ExplicitLeft = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 526
    Height = 573
    Hint = 'Double-Click line to execute it'
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnClick = Memo1Click
    OnDblClick = BitBtnExecuteFileClick
    OnKeyUp = Memo1KeyUp
  end
  object Panel1: TPanel
    Left = 529
    Top = 0
    Width = 200
    Height = 573
    Align = alRight
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object GroupBoxParamHelp: TGroupBox
      Left = 1
      Top = 183
      Width = 198
      Height = 389
      Hint = 'Double click on a parameter to go to help page'
      Align = alClient
      Caption = 'Parameter Help'
      Padding.Top = 5
      TabOrder = 0
      object ListBoxParamHelp: TListBox
        Left = 2
        Top = 48
        Width = 194
        Height = 339
        Hint = 'Double-Click to Insert in Editor'
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnDblClick = ListBoxParamMakeDblClick
        OnKeyUp = Memo1KeyUp
      end
      object Panel2: TPanel
        Left = 2
        Top = 23
        Width = 194
        Height = 25
        Align = alTop
        AutoSize = True
        BevelOuter = bvNone
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 1
        DesignSize = (
          194
          25)
        object BitBtnSeeCommandLine: TBitBtn
          Left = 114
          Top = 1
          Width = 78
          Height = 23
          Hint = 'Display the Command Line that Realterm was started with'
          Anchors = [akTop, akRight]
          Caption = '&CmdLine'
          Kind = bkHelp
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = BitBtnSeeCommandLineClick
        end
        object BitBtnHelp: TBitBtn
          Left = 59
          Top = 0
          Width = 53
          Height = 23
          Hint = 'Online help for selected parameter'
          Kind = bkHelp
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BitBtnHelpClick
        end
        object BitBtnMakeParamList: TBitBtn
          Left = 4
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Reload and change sort / display order'
          Caption = '.'
          Kind = bkRetry
          NumGlyphs = 2
          TabOrder = 2
          OnClick = BitBtnMakeParamListClick
        end
      end
      object ValueListEditorParams: TValueListEditor
        Left = 2
        Top = 48
        Width = 194
        Height = 339
        Hint = 'dbl-click to copy to editor'
        Align = alClient
        DefaultRowHeight = 16
        DisplayOptions = [doColumnTitles]
        KeyOptions = [keyEdit]
        TabOrder = 2
        TitleCaptions.Strings = (
          'Param'
          'Value')
        Visible = False
        OnDblClick = ValueListEditorParamsMakeDblClick
        ColWidths = (
          92
          96)
        RowHeights = (
          16
          16)
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 198
      Height = 182
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        198
        182)
      object ComboBoxIniFName: TComboBox
        Left = 0
        Top = 158
        Width = 198
        Height = 24
        Align = alBottom
        TabOrder = 0
        Text = '%APPDATA%\Realterm\Realterm.ini'
        OnChange = ComboBoxIniFNameChange
        OnDblClick = BitBtnLoadClick
        Items.Strings = (
          '%APPDATA%\Realterm\Realterm_Macro1.ini'
          '%APPDATA%\Realterm\Realterm_Macro2.ini'
          '%APPDATA%\Realterm\Realterm_Default.ini'
          '%APPDATA%\Realterm\Realterm_Always.ini'
          '%APPDATA%\Realterm\Realterm.ini'
          '%LOCALAPPDATA%\Realterm\Realterm.ini'
          '%PROGRAMDATA%\Realterm\Realterm.ini'
          '%HOMEPATH%\'
          '%TEMP%\Realterm\Realterm.ini')
      end
      object BitBtnExecuteSingleParam: TBitBtn
        Left = 2
        Top = 66
        Width = 87
        Height = 25
        Hint = 
          'Test only highlighted selection. You cab dbl-click a single line' +
          ' to test it.'
        Caption = '&Selected'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00324433224333
          33333333FF333333333333330000322443222433333333333FF3333FF3333333
          00003222443222443333333333FF3333FF333333000032222443222443333333
          333FF3333FF333330000322222443222443333333333FF3333FF333300003222
          222443222443333333333FF3333FF33300003222222244A222443333333333FF
          7333FF33000032222222AAA2222443333333337773333FF300003222222AAA22
          2222433333333777333333F30000322222AAA222222AA3333333777333333773
          000032222AAA222222AAA333333777333333777300003222AAA222222AAA3333
          33777333333777330000322AAA222222AAA333333777333333777333000032AA
          A322222AAA333333777333333777333300003AAA332222AAA333333777333333
          7773333300003AA332222AAA33333337733333377733333300003A333222AAA3
          33333337333333777333333300003333222AAA33333333333333377733333333
          0000}
        ModalResult = 4
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BitBtnExecuteSingleParamClick
      end
      object BitBtnExecuteParams: TBitBtn
        Left = 2
        Top = 32
        Width = 87
        Height = 30
        Hint = 
          'Execute  ALL Parameters: If text is selected, test only the sele' +
          'ction. N.B. Some parameters behave differently to what they will' +
          ' at startup / command line'
        Caption = '&Execute'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00324433224333
          33333333FF333333333333330000322443222433333333333FF3333FF3333333
          00003222443222443333333333FF3333FF333333000032222443222443333333
          333FF3333FF333330000322222443222443333333333FF3333FF333300003222
          222443222443333333333FF3333FF33300003222222244A222443333333333FF
          7333FF33000032222222AAA2222443333333337773333FF300003222222AAA22
          2222433333333777333333F30000322222AAA222222AA3333333777333333773
          000032222AAA222222AAA333333777333333777300003222AAA222222AAA3333
          33777333333777330000322AAA222222AAA333333777333333777333000032AA
          A322222AAA333333777333333777333300003AAA332222AAA333333777333333
          7773333300003AA332222AAA33333337733333377733333300003A333222AAA3
          33333337333333777333333300003333222AAA33333333333333377733333333
          0000}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BitBtnExecuteParamsClick
      end
      object BitBtnDone: TBitBtn
        Left = 104
        Top = 98
        Width = 88
        Height = 51
        Hint = 
          'INIFiles and CommandLines are macros you can use to automate, as' +
          ' well as save settings.\rINI Files are used by having INIFILE=<f' +
          'ile> on commandline.\rThey can also be sent to a running instanc' +
          'e by FIRST.\r You should delete parameters you don'#39't need to set' +
          '.\rSome parameters behave differently at start-up vs test button'
        Anchors = [akTop]
        Caption = '&Done'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        Kind = bkOK
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 3
        OnClick = BitBtnDoneClick
      end
      object BitBtnSave: TBitBtn
        Left = 116
        Top = 34
        Width = 76
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '&Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
          7700333333337777777733333333008088003333333377F73377333333330088
          88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
          000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
          FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
          99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 4
        OnClick = BitBtnSaveClick
      end
      object BitBtnLoad: TBitBtn
        AlignWithMargins = True
        Left = 116
        Top = 3
        Width = 76
        Height = 25
        Hint = 
          'Load into edit box to edit or view here. Does not affect Realter' +
          'm, until you press "Execute"'
        Anchors = [akTop, akRight]
        Caption = '&Load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
          07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
          0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BitBtnLoadClick
      end
      object BitBtnClear: TBitBtn
        Left = 2
        Top = 3
        Width = 59
        Height = 23
        Hint = 'Clear the Edit box'
        Caption = 'Clear'
        Kind = bkAbort
        NumGlyphs = 2
        TabOrder = 6
        OnClick = BitBtnClearClick
      end
      object BitBtnRecover: TBitBtn
        Left = 63
        Top = 3
        Width = 25
        Height = 23
        Hint = 'Undo last Clear or Load'
        Caption = '.'
        Enabled = False
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
          33333333333F8888883F33330000324334222222443333388F3833333388F333
          000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
          F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
          223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
          3338888300003AAAAAAA33333333333888888833333333330000333333333333
          333333333333333333FFFFFF000033333333333344444433FFFF333333888888
          00003A444333333A22222438888F333338F3333800003A2243333333A2222438
          F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
          22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
          33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
          3333333333338888883333330000333333333333333333333333333333333333
          0000}
        ModalResult = 4
        NumGlyphs = 2
        TabOrder = 7
        OnClick = BitBtnRecoverClick
      end
      object BitBtn1: TBitBtn
        Left = 116
        Top = 66
        Width = 76
        Height = 25
        Hint = 'Execute file directly'
        Anchors = [akTop, akRight]
        Caption = '&File'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00324433224333
          33333333FF333333333333330000322443222433333333333FF3333FF3333333
          00003222443222443333333333FF3333FF333333000032222443222443333333
          333FF3333FF333330000322222443222443333333333FF3333FF333300003222
          222443222443333333333FF3333FF33300003222222244A222443333333333FF
          7333FF33000032222222AAA2222443333333337773333FF300003222222AAA22
          2222433333333777333333F30000322222AAA222222AA3333333777333333773
          000032222AAA222222AAA333333777333333777300003222AAA222222AAA3333
          33777333333777330000322AAA222222AAA333333777333333777333000032AA
          A322222AAA333333777333333777333300003AAA332222AAA333333777333333
          7773333300003AA332222AAA33333337733333377733333300003A333222AAA3
          33333337333333777333333300003333222AAA33333333333333377733333333
          0000}
        ModalResult = 4
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = BitBtnExecuteFileClick
      end
      object BitBtnMacro1: TBitBtn
        Left = 2
        Top = 98
        Width = 87
        Height = 25
        Hint = 'shift+F10, file: Realterm_Macro1'
        Caption = 'Macro1'
        Kind = bkIgnore
        NumGlyphs = 2
        TabOrder = 9
        OnClick = BitBtnMacro1Click
      end
      object BitBtnMacro2: TBitBtn
        Left = 2
        Top = 124
        Width = 87
        Height = 25
        Hint = 'shift+F11, file: Realterm_Macro2'
        Caption = 'Macro2'
        Kind = bkIgnore
        NumGlyphs = 2
        TabOrder = 10
        OnClick = BitBtnMacro2Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.ini|*.ini|*.txt|*.txt|*.*|*.*'
    InitialDir = '%APPDATA%\Realterm'
    Options = [ofFileMustExist, ofEnableSizing]
    Title = 'Load File of Command Line Parameters'
    Left = 240
  end
  object SaveDialog1: TSaveDialog
    Filter = '*.ini|*.ini|*.txt|*.txt|*.*|*.*'
    InitialDir = '%APPDATA%\Realterm'
    Title = 'Save File of Command Line Parameters'
    Left = 144
  end
end
