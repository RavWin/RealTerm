object BL233EEPromDlg: TBL233EEPromDlg
  Left = 195
  Top = 108
  BorderStyle = bsDialog
  Caption = 'BL233 EEProm Configuration'
  ClientHeight = 571
  ClientWidth = 716
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 716
    Height = 488
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    ExplicitWidth = 314
    ExplicitHeight = 111
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 706
      Height = 478
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 304
      ExplicitHeight = 101
      object TabSheet3: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'All EEprom'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 757
        ExplicitHeight = 434
        object MemoBL233WholeEEprom: TMemo
          Left = 0
          Top = 3
          Width = 186
          Height = 262
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Terminal_Ctrl+Hex'
          Font.Pitch = fpFixed
          Font.Style = []
          Lines.Strings = (
            'Whole EEProm HEX data'
            ''
            ''
            '')
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          WantReturns = False
          WordWrap = False
        end
        object BitBtnReadWholeEEProm: TBitBtn
          Left = 203
          Top = 9
          Width = 141
          Height = 40
          Hint = 
            'Read whole eeprom. You should save it after this, and before mak' +
            'ing changes'
          Caption = '&Read EEProm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333336633
            3333333333333FF3333333330000333333364463333333333333388F33333333
            00003333333E66433333333333338F38F3333333000033333333E66333333333
            33338FF8F3333333000033333333333333333333333338833333333300003333
            3333446333333333333333FF3333333300003333333666433333333333333888
            F333333300003333333E66433333333333338F38F333333300003333333E6664
            3333333333338F38F3333333000033333333E6664333333333338F338F333333
            0000333333333E6664333333333338F338F3333300003333344333E666433333
            333F338F338F3333000033336664333E664333333388F338F338F33300003333
            E66644466643333338F38FFF8338F333000033333E6666666663333338F33888
            3338F3330000333333EE666666333333338FF33333383333000033333333EEEE
            E333333333388FFFFF8333330000333333333333333333333333388888333333
            0000}
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BitBtnReadWholeEEPromClick
        end
        object BitBtnLoadEeprom: TBitBtn
          Left = 203
          Top = 72
          Width = 141
          Height = 41
          Hint = 'Load saved eeprom dump from file'
          Caption = '&Load File'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
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
          TabOrder = 2
          OnClick = BitBtnLoadEepromClick
        end
        object BitBtnSaveEEProm: TBitBtn
          Left = 203
          Top = 133
          Width = 141
          Height = 41
          Hint = 'Save HEX eeprom dump data to file'
          Caption = '&Save File'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = BitBtnSaveEEPromClick
        end
        object BitBtnWriteAllEEProm: TBitBtn
          Left = 203
          Top = 231
          Width = 141
          Height = 34
          Hint = 'Can only write if data is exactly 128bytes of HEX'
          Caption = '&Write EEProm'
          Default = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333F33333333333
            00003333344333333333333333388F3333333333000033334224333333333333
            338338F3333333330000333422224333333333333833338F3333333300003342
            222224333333333383333338F3333333000034222A22224333333338F338F333
            8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
            33333338F83338F338F33333000033A33333A222433333338333338F338F3333
            0000333333333A222433333333333338F338F33300003333333333A222433333
            333333338F338F33000033333333333A222433333333333338F338F300003333
            33333333A222433333333333338F338F00003333333333333A22433333333333
            3338F38F000033333333333333A223333333333333338F830000333333333333
            333A333333333333333338330000333333333333333333333333333333333333
            0000}
          ModalResult = 6
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = BitBtnWriteAllEEPromClick
        end
      end
      object TabSheet1: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Settings'
        OnContextPopup = TabSheet1ContextPopup
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 296
        ExplicitHeight = 70
        object Label1: TLabel
          Left = 24
          Top = 395
          Width = 46
          Height = 16
          Caption = 'Address'
        end
        object Label2: TLabel
          Left = 229
          Top = 395
          Width = 57
          Height = 16
          Caption = 'Hex Value'
        end
        object Label7: TLabel
          Left = 475
          Top = 339
          Width = 52
          Height = 16
          Hint = 'B'
          Caption = 'Baud_Div'
        end
        object EditData1: TEdit
          Left = 299
          Top = 392
          Width = 121
          Height = 24
          MaxLength = 4
          TabOrder = 0
          Text = '00'
        end
        object BitBtnChangeData1: TBitBtn
          Left = 435
          Top = 392
          Width = 75
          Height = 25
          Caption = 'Change'
          TabOrder = 1
          OnClick = BitBtnChangeData1Click
        end
        object ComboBoxDataAddress1: TComboBox
          Left = 77
          Top = 392
          Width = 137
          Height = 24
          Hint = 
            'Address (with 0 in R/W position eg "0x40" for PCF8574. Don'#39't try' +
            ' 10 bit addressing here, though BL233 handles it OK. You can inc' +
            'lude the chip name, string just ENDS with address'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ItemIndex = 0
          TabOrder = 2
          Text = '0xF7 fSerial'
          Items.Strings = (
            '0xF7 fSerial'
            '0xF8 Baud Div'
            '0xF9 TimerDivL'
            '0xFA TimerDivH'
            '0xFB fControl'
            '0xFC fControl2'
            '0xFD <unused>'
            '0xFE Watchdog Vector'
            '0xFF IRQ Vector')
        end
        object StringGridSettings: TStringGrid
          Left = 24
          Top = 24
          Width = 641
          Height = 297
          ColCount = 4
          FixedCols = 0
          RowCount = 10
          TabOrder = 3
          ColWidths = (
            64
            64
            64
            64)
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
        object BitBtnReadSettings: TBitBtn
          Left = 24
          Top = 327
          Width = 161
          Height = 40
          Hint = 'Read Settings from eeprom'
          Caption = '&Read Settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333336633
            3333333333333FF3333333330000333333364463333333333333388F33333333
            00003333333E66433333333333338F38F3333333000033333333E66333333333
            33338FF8F3333333000033333333333333333333333338833333333300003333
            3333446333333333333333FF3333333300003333333666433333333333333888
            F333333300003333333E66433333333333338F38F333333300003333333E6664
            3333333333338F38F3333333000033333333E6664333333333338F338F333333
            0000333333333E6664333333333338F338F3333300003333344333E666433333
            333F338F338F3333000033336664333E664333333388F338F338F33300003333
            E66644466643333338F38FFF8338F333000033333E6666666663333338F33888
            3338F3330000333333EE666666333333338FF33333383333000033333333EEEE
            E333333333388FFFFF8333330000333333333333333333333333388888333333
            0000}
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = BitBtnReadSettingsClick
        end
        object ButtonControlRegisters: TButton
          Left = 533
          Top = 336
          Width = 116
          Height = 25
          Hint = 'Set Flag bits in control register eeprom intialise values'
          Caption = 'Control Registers'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = ButtonControlRegistersClick
        end
        object ComboBoxBaud: TComboBox
          Left = 364
          Top = 336
          Width = 105
          Height = 24
          Hint = 'Change initial Baud rate (Changes after Reset)'
          ItemIndex = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Text = '0x0F  57.6k'
          OnChange = ComboBoxBaudChange
          Items.Strings = (
            '0x03  230k '
            '0x07  115k'
            '0x0F  57.6k'
            '0x2F  19.2k'
            '0x5F    9.6k')
        end
        object ButtonfSerial: TButton
          Left = 229
          Top = 336
          Width = 75
          Height = 25
          Caption = 'fSerial'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = ButtonfSerialClick
        end
      end
      object TabsheetMacros: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Macros'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 757
        ExplicitHeight = 434
        object Label4: TLabel
          Left = 8
          Top = 331
          Width = 46
          Height = 16
          Caption = 'Address'
        end
        object Label3: TLabel
          Left = 213
          Top = 331
          Width = 64
          Height = 16
          Caption = 'Macro Text'
        end
        object MemoBL233Macros: TMemo
          Left = -1
          Top = 3
          Width = 145
          Height = 134
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Terminal_Ctrl+Hex'
          Font.Pitch = fpFixed
          Font.Style = []
          Lines.Strings = (
            'Macros in EEProm'
            ''
            ''
            '')
          MaxLength = 256
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          WantReturns = False
          WordWrap = False
        end
        object BitBtnReadMacros: TBitBtn
          Left = 3
          Top = 161
          Width = 141
          Height = 40
          Hint = 'Read Macros from EEProm'
          Caption = '&Read Macros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Kind = bkHelp
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BitBtnReadMacrosClick
        end
        object MemoBL233MacrosSplit: TMemo
          Left = 176
          Top = 3
          Width = 545
          Height = 310
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Terminal_Ctrl+Hex'
          Font.Pitch = fpFixed
          Font.Style = []
          Lines.Strings = (
            '     BL233  Macro Editor'
            ''
            'Macros are split at the Return command "<"'
            ''
            'You can edit within the macro lines, add or delete charcters.'
            
              'New lines will be added when a return command "<" is entered. Do' +
              'n'#39't try to add exta lines.'
            'Above each macro line is the address key.'
            'Macro lines begin at column 4, under the address digit.'
            ''
            'All macros end with the return command "<"'
            
              'Make sure that the Watchdog and IRQ vectors point at the start o' +
              'f a valid macro.'
            ''
            'SAVE to file before changing your eeprom.'
            'You cannot write to eeprom until after Update.'
            ''
            'You may see non-ansi values (Hi-Chars) by the special font.'
            ''
            'BL233C allows quoted strings, eg T"Hi!"'
            'BL233B strings must be hex e.g T486921'
            ''
            '')
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 2
          WantReturns = False
          WordWrap = False
          OnChange = MemoBL233MacrosSplitChange
        end
        object ComboBoxMacroAddress1: TComboBox
          Left = 61
          Top = 328
          Width = 137
          Height = 24
          Hint = 
            'Address (with 0 in R/W position eg "0x40" for PCF8574. Don'#39't try' +
            ' 10 bit addressing here, though BL233 handles it OK. You can inc' +
            'lude the chip name, string just ENDS with address'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ItemIndex = 2
          TabOrder = 3
          Text = '0x40'
          Items.Strings = (
            '0x00 Reset Macro'
            '0x20'
            '0x40'
            '')
        end
        object EditMacro1: TEdit
          Left = 283
          Top = 328
          Width = 190
          Height = 24
          TabOrder = 4
          Text = 'T545556'
        end
        object BitBtnChangeMacro1: TBitBtn
          Left = 491
          Top = 328
          Width = 86
          Height = 25
          Hint = 
            'Write just this text into macro area at Address. ReadMacros afte' +
            'rwards to update editor'
          Caption = 'Write Macro'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = BitBtnChangeMacro1Click
        end
        object CheckBoxCompactAscii: TCheckBox
          Left = 599
          Top = 330
          Width = 80
          Height = 21
          Hint = 
            'Compacts ASCII using BL233 special mode where  chars<128 have 12' +
            '8 added. Mode must be enabled through BL233 control register.'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Compact'
          TabOrder = 6
          Visible = False
        end
        object GroupBox1: TGroupBox
          Left = 3
          Top = 378
          Width = 441
          Height = 58
          Caption = 'Vectors'
          TabOrder = 7
          object Label6: TLabel
            Left = 208
            Top = 21
            Width = 21
            Height = 16
            Caption = 'IRQ'
          end
          object Label5: TLabel
            Left = 11
            Top = 21
            Width = 57
            Height = 16
            Caption = 'Watchdog'
          end
          object EditWatchdogVector: TEdit
            Left = 74
            Top = 17
            Width = 41
            Height = 24
            Hint = 'HEX address of the watchdog routine'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = '??'
          end
          object EditIRQVector: TEdit
            Left = 235
            Top = 17
            Width = 41
            Height = 24
            Hint = 'HEX address of the IRQ routine'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '??'
          end
          object BitBtn4: TBitBtn
            Left = 121
            Top = 16
            Width = 32
            Height = 25
            Default = True
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333333333333333330000333333333333333333333333F33333333333
              00003333344333333333333333388F3333333333000033334224333333333333
              338338F3333333330000333422224333333333333833338F3333333300003342
              222224333333333383333338F3333333000034222A22224333333338F338F333
              8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
              33333338F83338F338F33333000033A33333A222433333338333338F338F3333
              0000333333333A222433333333333338F338F33300003333333333A222433333
              333333338F338F33000033333333333A222433333333333338F338F300003333
              33333333A222433333333333338F338F00003333333333333A22433333333333
              3338F38F000033333333333333A223333333333333338F830000333333333333
              333A333333333333333338330000333333333333333333333333333333333333
              0000}
            ModalResult = 1
            NumGlyphs = 2
            TabOrder = 2
            OnClick = ButtonChangeWatchdogVectorClick
          end
          object BitBtn5: TBitBtn
            Left = 296
            Top = 16
            Width = 32
            Height = 25
            Default = True
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333333333333333330000333333333333333333333333F33333333333
              00003333344333333333333333388F3333333333000033334224333333333333
              338338F3333333330000333422224333333333333833338F3333333300003342
              222224333333333383333338F3333333000034222A22224333333338F338F333
              8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
              33333338F83338F338F33333000033A33333A222433333338333338F338F3333
              0000333333333A222433333333333338F338F33300003333333333A222433333
              333333338F338F33000033333333333A222433333333333338F338F300003333
              33333333A222433333333333338F338F00003333333333333A22433333333333
              3338F38F000033333333333333A223333333333333338F830000333333333333
              333A333333333333333338330000333333333333333333333333333333333333
              0000}
            ModalResult = 1
            NumGlyphs = 2
            TabOrder = 3
            OnClick = ButtonChangeIRQVectorClick
          end
        end
        object BitBtnUpdateSplitMacroLines: TBitBtn
          Left = 3
          Top = 207
          Width = 141
          Height = 34
          Hint = 
            'Updates the Split Macro editor. Checkbox allows live update. Wri' +
            'te enabled after update'
          Caption = '&Update'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Kind = bkRetry
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = BitBtnUpdateSplitMacroLinesClick
        end
        object BitBtnWriteSplitMacros: TBitBtn
          Left = 3
          Top = 247
          Width = 141
          Height = 34
          Hint = 'Write whole macro are back to eeprom. '
          Caption = '&Write Macros'
          Default = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333F33333333333
            00003333344333333333333333388F3333333333000033334224333333333333
            338338F3333333330000333422224333333333333833338F3333333300003342
            222224333333333383333338F3333333000034222A22224333333338F338F333
            8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
            33333338F83338F338F33333000033A33333A222433333338333338F338F3333
            0000333333333A222433333333333338F338F33300003333333333A222433333
            333333338F338F33000033333333333A222433333333333338F338F300003333
            33333333A222433333333333338F338F00003333333333333A22433333333333
            3338F38F000033333333333333A223333333333333338F830000333333333333
            333A333333333333333338330000333333333333333333333333333333333333
            0000}
          ModalResult = 6
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = BitBtnWriteSplitMacrosClick
        end
        object CheckBoxLiveUpdate: TCheckBox
          Left = 150
          Top = 217
          Width = 26
          Height = 17
          Hint = 'Update live while editing'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 10
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Help'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 757
        ExplicitHeight = 434
        object Memo1: TMemo
          Left = 3
          Top = 3
          Width = 545
          Height = 433
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Terminal_Ctrl+Hex'
          Font.Style = []
          Lines.Strings = (
            '     BL233  Macro Editor'
            ''
            'Macros are split at the Return command "<"'
            ''
            'You can edit within the macro lines, add or delete charcters.'
            
              'New lines will be added when a return command "<" is entered. Do' +
              'n'#39't try to add exta lines.'
            'Above each macro line is the address key.'
            'Macro lines begin at column 4, under the address digit.'
            ''
            'All macros end with the return command "<"'
            
              'Make sure that the Watchdog and IRQ vectors point at the start o' +
              'f a valid macro.'
            ''
            'SAVE to file before changing your eeprom.'
            'You cannot write to eeprom until after Update.'
            ''
            'You may see non-ansi values (Hi-Chars) by the special font.'
            ''
            'BL233C allows quoted strings, eg T"Hi!"'
            'BL233B strings must be hex e.g T486921'
            ''
            '')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WantReturns = False
          WordWrap = False
          OnChange = MemoBL233MacrosSplitChange
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 488
    Width = 716
    Height = 83
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object LabelBL233CommandString: TLabel
      Left = 5
      Top = -2
      Width = 93
      Height = 16
      Caption = 'Command Sent:'
    end
    object LabelBL233AddressRange: TLabel
      Left = 5
      Top = 16
      Width = 86
      Height = 16
      Caption = 'Address Range'
    end
    object HelpBtn: TButton
      Left = 596
      Top = 43
      Width = 92
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&Help'
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 252
      Top = 42
      Width = 101
      Height = 34
      Caption = 'Done'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Kind = bkOK
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 5
      Top = 42
      Width = 148
      Height = 34
      Hint = 'Most eeproms settings only take effect after reset'
      Caption = '&Reset BL233'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Kind = bkRetry
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object EditBL233CommandStrSent: TEdit
      Left = 117
      Top = 2
      Width = 537
      Height = 24
      Hint = 'This is the command string sent to write the eeprom'
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
      Text = 'EditCommandStrSent'
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bl233'
    Filter = '*.bl233|*.bl233|*.txt|*.txt|*.*|*.*'
    Title = 'Save File of Command Line Parameters'
    Left = 384
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.bl233|*.bl233|*.txt|*.txt|*.*|*.*'
    Options = [ofEnableSizing]
    Title = 'Load File of Command Line Parameters'
    Left = 448
    Top = 16
  end
  object PopupMenufSerial: TPopupMenu
    Left = 520
    Top = 16
    object fSerialeeprom1: TMenuItem
      Caption = 'fSerial eeprom'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PopupMenufSerial7: TMenuItem
      AutoCheck = True
      Caption = '&7  EEWriteProtect'
      Hint = 
        'Once set,EEProm is protected (BL233C -  can be cleared in Specia' +
        'l Pins Mode)'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial6: TMenuItem
      AutoCheck = True
      Caption = '&6  Enable Sleep'
      Hint = 'BL233C:  Must be set for Sleep command to execute.'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial5: TMenuItem
      AutoCheck = True
      Caption = '&5  Hi Chars As Ascii'
      Checked = True
      Hint = 
        'Allows compact encoding of some data. Treat any character with b' +
        'it 7 set as a whole ascii char without bit 7 set'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial4: TMenuItem
      AutoCheck = True
      Caption = '&4'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial3: TMenuItem
      AutoCheck = True
      Caption = '&3  Rx Watchdog Always On'
      Hint = 
        'BL233C - RX watchdog is alwasy on (from reset) cannot be stopped' +
        ' with J command'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial2: TMenuItem
      AutoCheck = True
      Caption = '&2  Use &XON'
      Hint = 
        'XON/XOFF handshaking. (only when a two wire serial has to be use' +
        'd) BL233C should be used for XON/XOFF'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial1: TMenuItem
      AutoCheck = True
      Caption = '&1  Use &RTS'
      Hint = 'RTS from PC controls chars SENT from BL233. (faster when off)'
      OnClick = PopupMenufSerialClick
    end
    object PopupMenufSerial0: TMenuItem
      AutoCheck = True
      Caption = '&0  Baud Hi'
      Checked = True
      Hint = 'set for baud rates above 4800Bd'
      OnClick = PopupMenufSerialClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object PopupMenufSerialDefault: TMenuItem
      Caption = '&reset to default'
      OnClick = PopupMenufSerialDefaultClick
    end
  end
end
