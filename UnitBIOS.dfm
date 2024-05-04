object FrameBIOS: TFrameBIOS
  Left = 0
  Top = 0
  Width = 1112
  Height = 552
  TabOrder = 0
  object GroupBoxBootloader: TGroupBox
    Left = 0
    Top = 0
    Width = 1112
    Height = 143
    Caption = 'Bootloader'
    TabOrder = 0
    object LabelPatchBootloader: TLabel
      Left = 32
      Top = 32
      Width = 1058
      Height = 15
      Caption = 
        'Improves FAT32 compatibility, especially if there are/were more ' +
        'files in the '#39'bios'#39' folder. Does not work if the device already ' +
        'doesn'#39't boot and will not run if already patched. Make sure your' +
        ' battery is full!'
    end
    object LabelPointlessFile: TLabel
      Left = 32
      Top = 120
      Width = 1059
      Height = 15
      Caption = 
        'If your device doesn'#39't boot, check any one of these checkboxes t' +
        'ry to boot. If the device still doesn'#39't boot, check one more an ' +
        'try again. Repeat until it boots. Then patch the bootloader to f' +
        'ix it for good.'
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
      Width = 224
      Height = 16
      Caption = 'Create pointless file 1'
      TabOrder = 1
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile2: TCheckBox
      Tag = 2
      Left = 8
      Top = 72
      Width = 224
      Height = 16
      Caption = 'Create pointless file 2'
      TabOrder = 2
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile3: TCheckBox
      Tag = 3
      Left = 8
      Top = 88
      Width = 224
      Height = 16
      Caption = 'Create pointless file 3'
      TabOrder = 3
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile4: TCheckBox
      Tag = 4
      Left = 8
      Top = 104
      Width = 224
      Height = 16
      Caption = 'Create pointless file 4'
      TabOrder = 4
      OnClick = CheckBoxPointlessFileClick
    end
  end
  object GroupBoxGBABIOS: TGroupBox
    Left = 0
    Top = 159
    Width = 1112
    Height = 57
    Caption = 'GBA BIOS (Stock GBA Emulator)'
    TabOrder = 1
    object LabelGBABIOS: TLabel
      Left = 32
      Top = 34
      Width = 1040
      Height = 15
      Caption = 
        'Improves compatibility with a few games (but not performance). S' +
        'ave states created with and without the official BIOS are mutual' +
        'ly incompatible. '#39'bios\gba_bios.bin'#39' must be present on the TF c' +
        'ard.'
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
    Top = 232
    Width = 1112
    Height = 160
    Caption = 'BIOS (Firmware)'
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
      Left = 656
      Top = 44
      Width = 372
      Height = 15
      Caption = 
        'If you made any manual change to the BIOS file, you must fix the' +
        ' CRC.'
    end
    object LabelBootLogo: TLabel
      Left = 656
      Top = 76
      Width = 113
      Height = 15
      Caption = 'Boot Logo (640'#215'136):'
    end
    object LabelBootLogo1: TLabel
      Left = 656
      Top = 100
      Width = 344
      Height = 15
      Caption = 
        'Click '#39'Replace...'#39' or drop the image on the boot logo to change ' +
        'it.'
    end
    object LabelScreen: TLabel
      Left = 656
      Top = 133
      Width = 38
      Height = 15
      Caption = 'Screen:'
    end
    object PanelBootLogoDoubleBufferer: TPanel
      Left = 8
      Top = 16
      Width = 640
      Height = 136
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      object ImageBootLogo: TImage
        Left = 0
        Top = 0
        Width = 640
        Height = 136
        Enabled = False
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
      Left = 784
      Top = 72
      Width = 80
      Height = 24
      Caption = 'Save...'
      TabOrder = 3
      OnClick = ButtonBootLogoSaveClick
    end
    object ButtonBootLogoReplace: TButton
      Left = 872
      Top = 72
      Width = 80
      Height = 24
      Caption = 'Replace...'
      TabOrder = 4
      OnClick = ButtonBootLogoReplaceClick
    end
    object ButtonBootLogoRefresh: TButton
      Left = 960
      Top = 72
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 5
      OnClick = ButtonBootLogoRefreshClick
    end
    object ComboBoxScreen: TComboBox
      Left = 712
      Top = 129
      Width = 224
      Height = 23
      Style = csDropDownList
      TabOrder = 6
      OnSelect = ComboBoxScreenSelect
      Items.Strings = (
        'I'#39'm using the original GB300 screen'
        'I swapped in the SF2000'#39's screen')
    end
  end
  object GroupBoxROMFixes: TGroupBox
    Left = 0
    Top = 408
    Width = 1112
    Height = 80
    Caption = 'General ROM Fixes'
    TabOrder = 3
    object LabelFixMDThumbs: TLabel
      Left = 144
      Top = 20
      Width = 918
      Height = 15
      Caption = 
        '45 MD files have a thumbnail in an incorrect format (BGRA8888 in' +
        'stead of RGB565). This will analyse all .zmd files in the MD fol' +
        'der and fix the broken ones. Takes half a minute.'
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
  end
  object GroupBoxReset: TGroupBox
    Left = 0
    Top = 504
    Width = 1112
    Height = 48
    Caption = 'Reset User Files'
    TabOrder = 4
    object LabelReset: TLabel
      Left = 320
      Top = 20
      Width = 419
      Height = 15
      Caption = 
        'Deletes the corresponding files. The GB300 will create them agai' +
        'n when needed.'
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
    Top = 288
  end
  object SaveDialogBootLogo: TSaveDialog
    DefaultExt = '.dib'
    Filter = 'Device Independent Bitmap (*.dib, *.bmp)|*.dib;*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 176
    Top = 288
  end
  object OpenDialogBootLogo: TOpenDialog
    Filter = 
      'Images (*.bmp, *.dib, *.png, *.jpg, *.jpeg)|*.bmp;*.dib;*.png;*.' +
      'jpg;*.jpeg'
    Left = 304
    Top = 288
  end
end
