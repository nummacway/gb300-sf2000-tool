object FrameROMDetails: TFrameROMDetails
  Left = 0
  Top = 0
  Width = 777
  Height = 646
  Align = alClient
  TabOrder = 0
  Visible = False
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 777
    Height = 240
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      777
      240)
    object LabelROMName: TLabel
      Left = 168
      Top = 0
      Width = 46
      Height = 23
      Caption = 'Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object LabelRename: TLabel
      Left = 272
      Top = 44
      Width = 410
      Height = 15
      Caption = 
        'Rename (menu: duplicate, (de)compress) the file and update the R' +
        'OM list file.'
    end
    object LabelExportROM: TLabel
      Left = 272
      Top = 80
      Width = 240
      Height = 15
      Caption = 'Export the ROM to use it in another emulator.'
    end
    object LabelImportROM: TLabel
      Left = 272
      Top = 112
      Width = 436
      Height = 15
      Caption = 
        'Replace the ROM with another one but keep the thumbnail. Overwri' +
        'tes current file.'
    end
    object LabelPatchROM: TLabel
      Left = 272
      Top = 144
      Width = 423
      Height = 15
      Caption = 
        'Apply an IPS patch (overwrite or new file). Be sure to have the ' +
        'correct base ROM!'
    end
    object LabelExportThumb: TLabel
      Left = 272
      Top = 180
      Width = 288
      Height = 15
      Caption = 'Export the image. Whyever you would want to do that.'
    end
    object LabelImportThumb: TLabel
      Left = 272
      Top = 212
      Width = 430
      Height = 15
      Caption = 
        'Add a thumbnail or replace the existing one. Must have the corre' +
        'ct size (%d'#215'%d).'
    end
    object LabelCRC: TLabel
      Left = 754
      Top = 4
      Width = 23
      Height = 15
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'CRC'
      OnClick = LabelCRCClick
    end
    object LabelNoIntro: TLabel
      Left = 168
      Top = 21
      Width = 46
      Height = 15
      Caption = 'No-Intro'
      OnClick = LabelNoIntroClick
    end
    object ImageFavorite: TImage
      Left = 224
      Top = 2
      Width = 16
      Height = 16
      OnClick = ImageFavoriteClick
    end
    object ButtonExportROM: TButton
      Left = 168
      Top = 76
      Width = 96
      Height = 24
      Caption = 'Export ROM...'
      TabOrder = 0
      OnClick = ButtonExportROMClick
    end
    object ButtonImportROM: TButton
      Left = 168
      Top = 108
      Width = 96
      Height = 24
      Caption = 'Replace ROM...'
      TabOrder = 1
      OnClick = ButtonImportROMClick
    end
    object ButtonExportThumb: TButton
      Left = 168
      Top = 176
      Width = 96
      Height = 24
      Caption = 'Export Thumb...'
      TabOrder = 2
    end
    object ButtonImportThumb: TButton
      Left = 168
      Top = 208
      Width = 96
      Height = 24
      Caption = 'Import Thumb...'
      TabOrder = 3
      OnClick = ButtonImportThumbClick
    end
    object ButtonPatchROM: TButton
      Left = 168
      Top = 140
      Width = 96
      Height = 24
      Caption = 'Apply Patch...'
      TabOrder = 4
      OnClick = ButtonPatchROMClick
    end
    object ButtonRename: TButton
      Left = 168
      Top = 40
      Width = 96
      Height = 24
      Caption = 'Rename...'
      DropDownMenu = PopupMenuRename
      Style = bsSplitButton
      TabOrder = 5
      OnClick = ButtonRenameClick
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 160
      Height = 232
      Caption = 'Thumbnail'
      TabOrder = 6
      object ImageThumbnailBackground: TImage
        Left = 5
        Top = 13
        Width = 150
        Height = 214
      end
      object ImageThumbnail: TImage
        Left = 8
        Top = 16
        Width = 144
        Height = 208
      end
    end
  end
  object ListViewStates: TListView
    Left = 0
    Top = 240
    Width = 777
    Height = 406
    Align = alClient
    BorderStyle = bsNone
    Columns = <>
    DoubleBuffered = True
    LargeImages = ImageListStates
    ReadOnly = True
    ParentDoubleBuffered = False
    PopupMenu = PopupMenuState
    TabOrder = 1
    OnDblClick = MenuItemStateSaveDIBClick
    OnKeyDown = ListViewStatesKeyDown
  end
  object PopupMenuRename: TPopupMenu
    OnPopup = PopupMenuRenamePopup
    Left = 528
    Top = 272
    object MenuItemDuplicate: TMenuItem
      Caption = 'Duplicate...'
      OnClick = MenuItemDuplicateClick
    end
    object MenuItemCompress: TMenuItem
      Caption = 'Compress'
      OnClick = MenuItemCompressClick
    end
    object MenuItemDecompress: TMenuItem
      Caption = 'Decompress'
      OnClick = MenuItemDecompressClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuItemMakeMulticore: TMenuItem
      Caption = 'Duplicate as multicore...'
      OnClick = MenuItemMakeMulticoreClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemConvertDAT: TMenuItem
      Caption = 'Convert DAT...'
      OnClick = MenuItemConvertDATClick
    end
  end
  object ImageListStates: TImageList
    Left = 640
    Top = 272
  end
  object SaveDialogROM: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 352
    Top = 384
  end
  object OpenDialogROM: TOpenDialog
    Left = 448
    Top = 384
  end
  object OpenDialogPatch: TOpenDialog
    Filter = 
      'International Patching System patch (*.ips)|*.ips|All files (*.*' +
      ')|*.*'
    Left = 552
    Top = 384
  end
  object PopupMenuState: TPopupMenu
    OnPopup = PopupMenuStatePopup
    Left = 384
    Top = 272
    object MenuItemStateSaveDIB: TMenuItem
      Caption = 'Save Screenshot...'
      Default = True
      OnClick = MenuItemStateSaveDIBClick
    end
  end
  object SaveDialogImage: TSaveDialog
    DefaultExt = '.png'
    Filter = 
      'Portable Network Graphics (*.png)|*.png|Device Independent Bitma' +
      'p (*.dib, *.bmp)|*.dib;*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    OnTypeChange = SaveDialogImageTypeChange
    Left = 656
    Top = 384
  end
  object OpenDialogDAT: TOpenDialog
    Filter = 'No-Intro DAT [XML] (*.dat)|*.dat'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 368
    Top = 528
  end
  object OpenDialogImageRGB565: TOpenDialog
    Filter = 
      'Images (*.bmp, *.dib, *.png, *.jpg, *.jpeg)|*.bmp;*.dib;*.png;*.' +
      'jpg;*.jpeg'
    Left = 512
    Top = 518
  end
end
