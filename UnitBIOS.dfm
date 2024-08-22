object FrameBIOS: TFrameBIOS
  Left = 0
  Top = 0
  Width = 1200
  Height = 648
  TabOrder = 0
  object GroupBoxBootloader: TGroupBox
    Left = 0
    Top = 0
    Width = 1200
    Height = 95
    Caption = 'Bootloader'
    TabOrder = 0
    object LabelPatchBootloader: TLabel
      Left = 32
      Top = 32
      Width = 1124
      Height = 15
      Caption = 
        'This patch improves FAT32 compatibility, especially if there are' +
        '/were more files in the '#39'bios'#39' folder. It does not work if the d' +
        'evice already doesn'#39't boot and will not run if already patched. ' +
        'Make sure your battery is full!'
    end
    object LabelPointlessFile: TLabel
      Left = 32
      Top = 72
      Width = 1095
      Height = 15
      Caption = 
        'If your device doesn'#39't boot, check any one of these checkboxes t' +
        'ry to boot. If the device still doesn'#39't boot, check one more an ' +
        'try again. Repeat until it boots. Then patch the bootloader to f' +
        'ix this bug for good.'
    end
    object CheckBoxPatchBootloader: TCheckBox
      Left = 8
      Top = 16
      Width = 224
      Height = 16
      Caption = 'Patch bootloader on next boot'
      TabOrder = 0
      OnClick = CheckBoxPatchBootloaderClick
    end
    object CheckBoxPointlessFile1: TCheckBox
      Tag = 1
      Left = 8
      Top = 56
      Width = 144
      Height = 16
      Caption = 'Create pointless file 1'
      TabOrder = 1
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile2: TCheckBox
      Tag = 2
      Left = 160
      Top = 56
      Width = 144
      Height = 16
      Caption = 'Create pointless file 2'
      TabOrder = 2
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile3: TCheckBox
      Tag = 3
      Left = 312
      Top = 56
      Width = 144
      Height = 16
      Caption = 'Create pointless file 3'
      TabOrder = 3
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile4: TCheckBox
      Tag = 4
      Left = 464
      Top = 56
      Width = 144
      Height = 16
      Caption = 'Create pointless file 4'
      TabOrder = 4
      OnClick = CheckBoxPointlessFileClick
    end
  end
  object GroupBoxGBABIOS: TGroupBox
    Left = 0
    Top = 111
    Width = 1200
    Height = 57
    Caption = 'GBA BIOS (Stock GBA Emulator) '#8211' gba_bios.bin'
    TabOrder = 1
    object LabelGBABIOS: TLabel
      Left = 32
      Top = 34
      Width = 1143
      Height = 15
      Caption = 
        'Improves compatibility with a few games (but not performance). S' +
        'ave states created with and without the official BIOS are mutual' +
        'ly incompatible. '#39'bios\gba_bios.bin'#39' must be present on the TF c' +
        'ard like it is on delivery.'
    end
    object LabelGBABIOS1: TLabel
      Left = 8
      Top = 16
      Width = 152
      Height = 15
      Caption = 'Use official BIOS for ROMs in'
    end
    object CheckBoxGBABIOS0: TCheckBox
      Left = 176
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 0
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS1: TCheckBox
      Tag = 1
      Left = 248
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 1
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS2: TCheckBox
      Tag = 2
      Left = 320
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 2
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS3: TCheckBox
      Tag = 3
      Left = 392
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 3
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS4: TCheckBox
      Tag = 4
      Left = 464
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 4
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS5: TCheckBox
      Tag = 5
      Left = 536
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 5
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS6: TCheckBox
      Tag = 6
      Left = 608
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 6
      OnClick = CheckBoxGBABIOSClick
    end
    object CheckBoxGBABIOS7: TCheckBox
      Tag = 7
      Left = 680
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 7
      OnClick = CheckBoxGBABIOSClick
    end
  end
  object GroupBoxBIOS: TGroupBox
    Left = 0
    Top = 184
    Width = 1200
    Height = 208
    Caption = 'GB300 BIOS (Firmware) '#8211' bisrv.asd'
    TabOrder = 2
    object LabelCRC: TLabel
      Left = 656
      Top = 20
      Width = 60
      Height = 15
      Caption = 'CRC status:'
    end
    object LabelCRCStatus: TLabel
      Left = 728
      Top = 20
      Width = 9
      Height = 15
      Caption = '...'
    end
    object LabelCRCInfo: TLabel
      Left = 960
      Top = 20
      Width = 223
      Height = 15
      Caption = 'Fix CRC after manual changes to the BIOS.'
    end
    object LabelBootLogo: TLabel
      Left = 8
      Top = 164
      Width = 110
      Height = 15
      Caption = 'Boot logo (640'#215'136):'
    end
    object LabelBootLogo1: TLabel
      Left = 8
      Top = 185
      Width = 413
      Height = 15
      Caption = 
        'Click '#39'Replace...'#39' or drop a correctly-sized image on the boot l' +
        'ogo to change it.'
    end
    object LabelScreen: TLabel
      Left = 656
      Top = 98
      Width = 38
      Height = 15
      Caption = 'Screen:'
    end
    object LabelScreen2: TLabel
      AlignWithMargins = True
      Left = 944
      Top = 98
      Width = 191
      Height = 15
      Caption = 'This does not affect multicore cores.'
    end
    object LabelSearchResultSelColor: TLabel
      Left = 656
      Top = 67
      Width = 150
      Height = 15
      Caption = 'Search result selection color:'
    end
    object LabelSearchResultSelColor2: TLabel
      Left = 944
      Top = 67
      Width = 160
      Height = 15
      Caption = 'The default color here is black.'
    end
    object Label3: TLabel
      Left = 656
      Top = 48
      Width = 104
      Height = 15
      Caption = 'BIOS modifications:'
    end
    object PanelBootLogoDoubleBufferer: TPanel
      Left = 8
      Top = 16
      Width = 640
      Height = 136
      Color = clBlack
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      TabOrder = 0
      object ImageBootLogo: TImage
        Left = 0
        Top = 0
        Width = 640
        Height = 136
        Enabled = False
        Stretch = True
      end
    end
    object ButtonCRCFix: TButton
      Left = 784
      Top = 16
      Width = 80
      Height = 24
      Caption = 'Fix CRC'
      TabOrder = 1
      OnClick = ButtonCRCFixClick
    end
    object ButtonCRCRefresh: TButton
      Left = 872
      Top = 16
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = ButtonCRCRefreshClick
    end
    object ButtonBootLogoSave: TButton
      Left = 136
      Top = 160
      Width = 80
      Height = 24
      Caption = 'Save...'
      TabOrder = 3
      OnClick = ButtonBootLogoSaveClick
    end
    object ButtonBootLogoReplace: TButton
      Left = 224
      Top = 160
      Width = 80
      Height = 24
      Caption = 'Replace...'
      TabOrder = 4
      OnClick = ButtonBootLogoReplaceClick
    end
    object ButtonBootLogoRefresh: TButton
      Left = 312
      Top = 160
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 5
      OnClick = ButtonBootLogoRefreshClick
    end
    object ComboBoxScreen: TComboBox
      Left = 712
      Top = 94
      Width = 224
      Height = 23
      Style = csDropDownList
      TabOrder = 7
      OnSelect = ComboBoxScreenSelect
      Items.Strings = (
        'I'#39'm using the original GB300 screen'
        'I swapped in the SF2000'#39's screen')
    end
    object CheckBoxVT03: TCheckBox
      Left = 656
      Top = 149
      Width = 536
      Height = 16
      Caption = 
        'Enable VT02/VT03 support for .nfc files (note: very bad compatib' +
        'ility; MUST have .nfc extension!)'
      TabOrder = 9
      OnClick = CheckBoxVT03Click
    end
    object ColorBoxSearchResultSelColor: TColorBox
      Left = 816
      Top = 64
      Width = 120
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 6
      OnChange = ColorBoxSearchResultSelColorChange
    end
    object CheckBoxPatchVT03LUT: TCheckBox
      Left = 672
      Top = 165
      Width = 520
      Height = 16
      Caption = 
        'Patch VT03 LUT from RGB555 to RGB565 (fixes color issues for VT0' +
        '3 ROMs)'
      TabOrder = 10
      OnClick = CheckBoxPatchVT03LUTClick
    end
    object CheckBoxFDS: TCheckBox
      Left = 656
      Top = 125
      Width = 536
      Height = 16
      Caption = 
        'Enable Famicom Disk System support in FCEUmm (requires '#39'disksys.' +
        'rom'#39' in '#39'ROMS'#39')'
      TabOrder = 8
      OnClick = CheckBoxFDSClick
    end
  end
  object GroupBoxROMFixes: TGroupBox
    Left = 0
    Top = 408
    Width = 1200
    Height = 112
    Caption = 'General ROM Fixes'
    TabOrder = 3
    object LabelFixMDThumbs: TLabel
      Left = 144
      Top = 20
      Width = 1029
      Height = 15
      Caption = 
        '45 MD files have a thumbnail in an incorrect format (BGRA8888 in' +
        'stead of RGB565). This will analyse all .zmd files in the '#39'MD'#39' f' +
        'older and fix the broken ones. The process takes around half a m' +
        'inute.'
    end
    object LabelFixGlazedThumb: TLabel
      Left = 144
      Top = 52
      Width = 778
      Height = 15
      Caption = 
        'Fixes the thumbnail of '#39'Pokemon - Glazed Version (CN).zgb'#39' which' +
        ' features a way too large thumbnail. The correct one is hardcode' +
        'd inside this tool.'
    end
    object Label1: TLabel
      Left = 144
      Top = 84
      Width = 1022
      Height = 15
      Caption = 
        'Changes the file extension in the .zfc files'#39' header in '#39'FC'#39' fro' +
        'm .nfc to .nes to make them run with FCEUmm. Breaks their existi' +
        'ng save states. Improves compatibility. Takes little over half a' +
        ' minute.'
    end
    object ButtonFixMDThumbs: TButton
      Left = 8
      Top = 16
      Width = 128
      Height = 24
      Caption = 'Fix MD Thumbnails'
      TabOrder = 0
      OnClick = ButtonFixMDThumbsClick
    end
    object ButtonFixGlazedThumb: TButton
      Left = 8
      Top = 48
      Width = 128
      Height = 24
      Caption = 'Fix Glazed Thumbnail'
      TabOrder = 1
      OnClick = ButtonFixGlazedThumbClick
    end
    object ButtonAlwaysUseFCEUmm: TButton
      Left = 8
      Top = 80
      Width = 128
      Height = 24
      Caption = 'Always Use FCEUmm'
      TabOrder = 2
      OnClick = ButtonAlwaysUseFCEUmmClick
    end
  end
  object GroupBoxReset: TGroupBox
    Left = 0
    Top = 536
    Width = 1200
    Height = 48
    Caption = 'Reset User Files'
    TabOrder = 4
    object LabelReset: TLabel
      Left = 320
      Top = 20
      Width = 531
      Height = 15
      Caption = 
        'Deletes the corresponding files. The GB300 and GB300 Tool will b' +
        'oth create them again when needed.'
    end
    object ButtonClearFavorites: TButton
      Left = 8
      Top = 16
      Width = 96
      Height = 24
      Caption = 'Clear Favorites'
      TabOrder = 0
      OnClick = ButtonClearFavoritesClick
    end
    object ButtonClearHistory: TButton
      Left = 112
      Top = 16
      Width = 96
      Height = 24
      Caption = 'Clear History'
      TabOrder = 1
      OnClick = ButtonClearHistoryClick
    end
    object ButtonClearKeyMap: TButton
      Left = 216
      Top = 16
      Width = 96
      Height = 24
      Caption = 'Reset Key Map'
      TabOrder = 2
      OnClick = ButtonClearKeyMapClick
    end
  end
  object TimerLazyLoad: TTimer
    Interval = 1
    OnTimer = TimerLazyLoadTimer
    Left = 64
    Top = 240
  end
  object SaveDialogBootLogo: TSaveDialog
    DefaultExt = '.dib'
    Filter = 'Device Independent Bitmap (*.dib, *.bmp)|*.dib;*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 176
    Top = 240
  end
  object OpenDialogBootLogo: TOpenDialog
    Filter = 
      'Images (*.bmp, *.dib, *.png, *.jpg, *.jpeg)|*.bmp;*.dib;*.png;*.' +
      'jpg;*.jpeg'
    Left = 304
    Top = 240
  end
end
