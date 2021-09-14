object FrameI2CMem: TFrameI2CMem
  Left = 0
  Top = 0
  Width = 715
  Height = 205
  TabOrder = 0
  object GroupBoxI2CMem: TGroupBox
    Left = 6
    Top = 3
    Width = 705
    Height = 198
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'I2C EEProm'
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 18
      Width = 183
      Height = 178
      Align = alLeft
      TabOrder = 0
      object Label30: TLabel
        Left = 8
        Top = 67
        Width = 74
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Pointer Bytes'
      end
      object Label41: TLabel
        Left = 8
        Top = 101
        Width = 95
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Write Time (ms)'
      end
      object Label42: TLabel
        Left = 8
        Top = 138
        Width = 91
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Write Page Size'
      end
      object LabelI2CMemMemSize: TLabel
        Left = 8
        Top = 43
        Width = 103
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Size: ?????? bytes'
      end
      object ComboBoxI2CMemType: TComboBox
        Left = 8
        Top = 12
        Width = 169
        Height = 24
        Hint = 'Select eeprom type'
        TabOrder = 0
        Text = 'ComboBoxI2CMemType'
      end
      object SpinEditI2CMemPointerBytes: TSpinEdit
        Left = 126
        Top = 67
        Width = 51
        Height = 26
        Hint = 'Number of bytes in the internal address pointer'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        MaxValue = 2
        MinValue = 1
        TabOrder = 1
        Value = 2
      end
      object SpinEditIMWriteTime: TSpinEdit
        Left = 126
        Top = 101
        Width = 51
        Height = 26
        Hint = 'Maximum write time from datasheet.'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        MaxValue = 20
        MinValue = 0
        TabOrder = 2
        Value = 5
      end
      object ComboBox1: TComboBox
        Left = 126
        Top = 134
        Width = 51
        Height = 24
        Hint = 'Write page size of eeprom from datasheet'
        ItemIndex = 6
        TabOrder = 3
        Text = '256'
        Items.Strings = (
          '1'
          '8'
          '16'
          '32'
          '64'
          '128'
          '256')
      end
    end
    object Panel6: TPanel
      Left = 191
      Top = 119
      Width = 338
      Height = 76
      TabOrder = 1
      object ButtonWriteFromFile: TButton
        Left = 9
        Top = 8
        Width = 54
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Write'
        TabOrder = 0
      end
      object ButtonI2CMemBrowseWriteFiles: TButton
        Left = 297
        Top = 38
        Width = 27
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = ButtonI2CMemBrowseWriteFilesClick
      end
      object ComboBoxI2CMemWriteFName: TComboBox
        Left = 9
        Top = 40
        Width = 280
        Height = 24
        Hint = 'HEX data file, S19 or inhex8 formats'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 2
        Text = 'c:\temp\hexfile.s19'
      end
    end
    object GroupBox11: TGroupBox
      Left = 191
      Top = 10
      Width = 338
      Height = 87
      TabOrder = 2
      object Label43: TLabel
        Left = 70
        Top = 19
        Width = 46
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Address'
      end
      object Label45: TLabel
        Left = 197
        Top = 19
        Width = 30
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'bytes'
      end
      object EditI2CMemStartAdd: TEdit
        Left = 129
        Top = 17
        Width = 60
        Height = 24
        Hint = 'Address in HEX, 2 or 4 chars'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 0
        Text = '0x00000'
      end
      object EditI2CMemNumBytesToRead: TEdit
        Left = 238
        Top = 17
        Width = 59
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 1
        Text = '0x10000'
      end
      object UpDown1: TUpDown
        Left = 304
        Top = 16
        Width = 20
        Height = 30
        TabOrder = 2
      end
      object ComboBoxI2CMemReadFName: TComboBox
        Left = 9
        Top = 58
        Width = 280
        Height = 24
        Hint = 'HEX data file, S19 or inhex8 formats'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 3
        Text = 'c:\temp\hexfile.s19'
      end
      object ButtonI2CMemBrowseReadFiles: TButton
        Left = 297
        Top = 58
        Width = 27
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = ButtonI2CMemBrowseReadFilesClick
      end
      object ButtonReadToFile: TButton
        Left = 8
        Top = 16
        Width = 54
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Read'
        TabOrder = 5
      end
    end
  end
  object OpenDialogI2CMem: TOpenDialog
    DefaultExt = 's19'
    Filter = 'S record|*.s19;*.srec|inhex8|*.*|*.*|*.*'
    Title = 'Select I2C EEProm Hex File'
    Left = 584
    Top = 24
  end
end
