object FrameBIOS: TFrameBIOS
  Left = 0
  Top = 0
  Width = 1248
  Height = 616
  TabOrder = 0
  object GroupBoxBIOSSF2000: TGroupBox
    Left = 0
    Top = 167
    Width = 1248
    Height = 273
    Caption = 'SF2000 BIOS (Firmware) '#8211' bisrv.asd'
    TabOrder = 5
    Visible = False
    object Label2: TLabel
      Left = 528
      Top = 20
      Width = 60
      Height = 15
      Caption = 'CRC status:'
    end
    object LabelCRCStatusSF2000: TLabel
      Left = 600
      Top = 20
      Width = 9
      Height = 15
      Caption = '...'
    end
    object Label5: TLabel
      Left = 832
      Top = 20
      Width = 223
      Height = 15
      Caption = 'Fix CRC after manual changes to the BIOS.'
    end
    object Label6: TLabel
      Left = 528
      Top = 60
      Width = 110
      Height = 15
      Caption = 'Boot logo (512'#215'200):'
    end
    object Label7: TLabel
      Left = 528
      Top = 81
      Width = 413
      Height = 15
      Caption = 
        'Click '#39'Replace...'#39' or drop a correctly-sized image on the boot l' +
        'ogo to change it.'
    end
    object Label4: TLabel
      Left = 528
      Top = 112
      Width = 104
      Height = 15
      Caption = 'BIOS modifications:'
    end
    object Panel1: TPanel
      Left = 8
      Top = 16
      Width = 512
      Height = 200
      Color = clBlack
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      TabOrder = 0
      object ImageBootLogoSF2000: TImage
        Left = 0
        Top = 0
        Width = 512
        Height = 200
        Enabled = False
        Stretch = True
      end
    end
    object ButtonCRCFixSF2000: TButton
      Left = 656
      Top = 16
      Width = 80
      Height = 24
      Caption = 'Fix CRC'
      TabOrder = 1
      OnClick = ButtonCRCFixClick
    end
    object ButtonCRCRefreshSF2000: TButton
      Left = 744
      Top = 16
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = ButtonCRCRefreshClick
    end
    object ButtonBootLogoSaveSF2000: TButton
      Left = 656
      Top = 56
      Width = 80
      Height = 24
      Caption = 'Save...'
      TabOrder = 3
      OnClick = ButtonBootLogoSaveClick
    end
    object ButtonBootLogoReplaceSF2000: TButton
      Left = 744
      Top = 56
      Width = 80
      Height = 24
      Caption = 'Replace...'
      TabOrder = 4
      OnClick = ButtonBootLogoReplaceClick
    end
    object ButtonBootLogoRefreshSF2000: TButton
      Left = 832
      Top = 56
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 5
      OnClick = ButtonBootLogoRefreshClick
    end
    object CheckBoxGaroupSF2000: TCheckBox
      Left = 528
      Top = 128
      Width = 536
      Height = 17
      Caption = 
        'Make stock FBAlpha expect a 9 MiB P-ROM for '#39'garoup'#39' (required f' +
        'or Neo Geo ROM Faker)'
      TabOrder = 6
      OnClick = CheckBoxGaroupClick
    end
  end
  object GroupBoxBootloader: TGroupBox
    Left = 0
    Top = 0
    Width = 1248
    Height = 94
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
      Top = 71
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
      Top = 55
      Width = 144
      Height = 16
      Caption = 'Create pointless file 1'
      TabOrder = 1
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile2: TCheckBox
      Tag = 2
      Left = 160
      Top = 55
      Width = 144
      Height = 16
      Caption = 'Create pointless file 2'
      TabOrder = 2
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile3: TCheckBox
      Tag = 3
      Left = 312
      Top = 55
      Width = 144
      Height = 16
      Caption = 'Create pointless file 3'
      TabOrder = 3
      OnClick = CheckBoxPointlessFileClick
    end
    object CheckBoxPointlessFile4: TCheckBox
      Tag = 4
      Left = 464
      Top = 55
      Width = 144
      Height = 16
      Caption = 'Create pointless file 4'
      TabOrder = 4
      OnClick = CheckBoxPointlessFileClick
    end
  end
  object GroupBoxGBABIOS: TGroupBox
    Left = 0
    Top = 102
    Width = 1248
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
    object CheckBoxGBABIOS8: TCheckBox
      Tag = 8
      Left = 752
      Top = 16
      Width = 64
      Height = 16
      TabOrder = 8
      OnClick = CheckBoxGBABIOSClick
    end
  end
  object GroupBoxBIOSGB300: TGroupBox
    Left = 0
    Top = 167
    Width = 1248
    Height = 273
    Caption = 'GB300 BIOS (Firmware) '#8211' bisrv.asd'
    TabOrder = 2
    Visible = False
    object LabelCRC: TLabel
      Left = 264
      Top = 20
      Width = 60
      Height = 15
      Caption = 'CRC status:'
    end
    object LabelCRCStatusGB300: TLabel
      Left = 336
      Top = 20
      Width = 9
      Height = 15
      Caption = '...'
    end
    object LabelCRCInfo: TLabel
      Left = 568
      Top = 20
      Width = 223
      Height = 15
      Caption = 'Fix CRC after manual changes to the BIOS.'
    end
    object LabelBootLogo: TLabel
      Left = 264
      Top = 60
      Width = 110
      Height = 15
      Caption = 'Boot logo (248'#215'249):'
    end
    object LabelBootLogo1: TLabel
      Left = 264
      Top = 81
      Width = 413
      Height = 15
      Caption = 
        'Click '#39'Replace...'#39' or drop a correctly-sized image on the boot l' +
        'ogo to change it.'
    end
    object LabelScreen: TLabel
      Left = 264
      Top = 154
      Width = 38
      Height = 15
      Caption = 'Screen:'
    end
    object LabelScreen2: TLabel
      AlignWithMargins = True
      Left = 320
      Top = 154
      Width = 272
      Height = 15
      Caption = 'SF2000 screen swap patch is said to not be required.'
    end
    object Label3: TLabel
      Left = 264
      Top = 112
      Width = 104
      Height = 15
      Caption = 'BIOS modifications:'
    end
    object PanelBootLogoDoubleBufferer: TPanel
      Left = 8
      Top = 16
      Width = 248
      Height = 249
      Color = clBlack
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      TabOrder = 0
      object ImageBootLogoGB300: TImage
        Left = 0
        Top = 0
        Width = 248
        Height = 249
        Enabled = False
        Stretch = True
      end
    end
    object ButtonCRCFixGB300: TButton
      Left = 392
      Top = 16
      Width = 80
      Height = 24
      Caption = 'Fix CRC'
      TabOrder = 1
      OnClick = ButtonCRCFixClick
    end
    object ButtonCRCRefreshGB300: TButton
      Left = 480
      Top = 16
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = ButtonCRCRefreshClick
    end
    object ButtonBootLogoSaveGB300: TButton
      Left = 392
      Top = 56
      Width = 80
      Height = 24
      Caption = 'Save...'
      TabOrder = 3
      OnClick = ButtonBootLogoSaveClick
    end
    object ButtonBootLogoReplaceGB300: TButton
      Left = 480
      Top = 56
      Width = 80
      Height = 24
      Caption = 'Replace...'
      TabOrder = 4
      OnClick = ButtonBootLogoReplaceClick
    end
    object ButtonBootLogoRefreshGB300: TButton
      Left = 568
      Top = 56
      Width = 80
      Height = 24
      Caption = 'Refresh'
      TabOrder = 5
      OnClick = ButtonBootLogoRefreshClick
    end
    object CheckBoxVT03: TCheckBox
      Left = 264
      Top = 213
      Width = 536
      Height = 16
      Caption = 
        'Enable VT02/VT03 support for .nfc files (note: very bad compatib' +
        'ility; MUST have .nfc extension!)'
      TabOrder = 7
      Visible = False
      OnClick = CheckBoxVT03Click
    end
    object CheckBoxPatchVT03LUT: TCheckBox
      Left = 280
      Top = 229
      Width = 520
      Height = 16
      Caption = 
        'Patch VT03 LUT from RGB555 to RGB565 (fixes color issues for VT0' +
        '3 ROMs)'
      TabOrder = 8
      Visible = False
      OnClick = CheckBoxPatchVT03LUTClick
    end
    object CheckBoxFDS: TCheckBox
      Left = 264
      Top = 189
      Width = 536
      Height = 16
      Caption = 
        'Enable Famicom Disk System support in FCEUmm (requires '#39'disksys.' +
        'rom'#39' in '#39'ROMS'#39')'
      TabOrder = 6
      Visible = False
      OnClick = CheckBoxFDSClick
    end
    object CheckBoxGaroupGB300: TCheckBox
      Left = 264
      Top = 128
      Width = 536
      Height = 17
      Caption = 
        'Make stock FBAlpha expect a 9 MiB P-ROM for '#39'garoup'#39' (required f' +
        'or Neo Geo ROM Faker)'
      TabOrder = 9
      OnClick = CheckBoxGaroupClick
    end
  end
  object GroupBoxROMFixes: TGroupBox
    Left = 0
    Top = 448
    Width = 1248
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
      Width = 1087
      Height = 15
      Caption = 
        'Changes the file extension in the .zfc files'#39' header in '#39'FC'#39' fro' +
        'm .nfc to .nes to make them run with FCEUmm. Breaks their existi' +
        'ng save states. Improves compatibility. Takes little over half a' +
        ' minute. GB300 only.'
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
    Top = 568
    Width = 1248
    Height = 48
    Caption = 'Reset User Files'
    TabOrder = 4
    object LabelReset: TLabel
      Left = 320
      Top = 20
      Width = 522
      Height = 15
      Caption = 
        'Deletes the corresponding files. Your device and this tool will ' +
        'both create them again when needed.'
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
    Left = 32
    Top = 391
  end
  object SaveDialogBootLogo: TSaveDialog
    DefaultExt = '.dib'
    Filter = 'Device Independent Bitmap (*.dib, *.bmp)|*.dib;*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 144
    Top = 391
  end
  object OpenDialogBootLogo: TOpenDialog
    Filter = 
      'Images (*.bmp, *.dib, *.png, *.jpg, *.jpeg)|*.bmp;*.dib;*.png;*.' +
      'jpg;*.jpeg'
    Left = 72
    Top = 319
  end
end
