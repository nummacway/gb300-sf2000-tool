object FrameUI: TFrameUI
  Left = 0
  Top = 0
  Width = 1200
  Height = 669
  Align = alClient
  TabOrder = 0
  object PanelRightFoldername: TPanel
    Left = 360
    Top = 0
    Width = 840
    Height = 669
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object Label2: TLabel
      Left = 72
      Top = 3
      Width = 421
      Height = 15
      Caption = 
        'Name of the device '#8211' editing not supported, because it would bre' +
        'ak your device'
    end
    object Label3: TLabel
      Left = 40
      Top = 29
      Width = 451
      Height = 15
      Caption = 
        'Number of languages '#8211' editing not supported, because it would ha' +
        've odd side effects'
    end
    object Label4: TLabel
      Left = 136
      Top = 55
      Width = 484
      Height = 15
      Caption = 
        'Default font color: used in lists, the input search text and the' +
        ' game name in the pause menu'
    end
    object Label5: TLabel
      Left = 208
      Top = 80
      Width = 351
      Height = 15
      Caption = 
        'Selected font color, and the first ROM folder to whose list it a' +
        'pplies'
    end
    object Label6: TLabel
      Left = 208
      Top = 105
      Width = 369
      Height = 15
      Caption = 
        'Selected font color, and the second ROM folder to whose list it ' +
        'applies'
    end
    object Label7: TLabel
      Left = 208
      Top = 130
      Width = 356
      Height = 15
      Caption = 
        'Selected font color, and the third ROM folder to whose list it a' +
        'pplies'
    end
    object Label8: TLabel
      Left = 208
      Top = 155
      Width = 364
      Height = 15
      Caption = 
        'Selected font color, and the fourth ROM folder to whose list it ' +
        'applies'
    end
    object Label9: TLabel
      Left = 208
      Top = 180
      Width = 353
      Height = 15
      Caption = 
        'Selected font color, and the fifth ROM folder to whose list it a' +
        'pplies'
    end
    object Label10: TLabel
      Left = 208
      Top = 205
      Width = 356
      Height = 15
      Caption = 
        'Selected font color, and the sixth ROM folder to whose list it a' +
        'pplies'
    end
    object Label11: TLabel
      Left = 208
      Top = 230
      Width = 372
      Height = 15
      Caption = 
        'Selected font color, and the seventh ROM folder to whose list it' +
        ' applies'
    end
    object Label12: TLabel
      Left = 208
      Top = 255
      Width = 397
      Height = 15
      Caption = 
        'Selected font color, and the downloaded ROM folder to whose list' +
        ' it applies'
    end
    object Label13: TLabel
      Left = 208
      Top = 280
      Width = 371
      Height = 15
      Caption = 
        'Selected font color for Favorites and a folder which is normally' +
        ' unused'
    end
    object Label14: TLabel
      Left = 208
      Top = 305
      Width = 362
      Height = 15
      Caption = 
        'Selected font color for History and a folder which is normally u' +
        'nused'
    end
    object Label15: TLabel
      Left = 40
      Top = 331
      Width = 470
      Height = 15
      Caption = 
        'Number of bottom tabs '#8211' editing is not supported because it woul' +
        'd have odd side effects'
    end
    object Label16: TLabel
      Left = 104
      Top = 355
      Width = 112
      Height = 15
      Caption = 'Leftmost tab on boot'
    end
    object Label17: TLabel
      Left = 104
      Top = 379
      Width = 109
      Height = 15
      Caption = 'Selected tab on boot'
    end
    object Label18: TLabel
      Left = 104
      Top = 405
      Width = 527
      Height = 15
      Caption = 
        'Write custom ROM list to this file '#8211' has no effect on what the t' +
        'abs use ('#39'tsmfk.tax'#39' for the eighth tab)'
    end
    object Label19: TLabel
      Left = 104
      Top = 429
      Width = 493
      Height = 15
      Caption = 
        'Use this file for Favorites '#8211' has no effect on what the tabs use' +
        ' ('#39'Favorites.bin'#39' for the ninth tab)'
    end
    object Label20: TLabel
      Left = 104
      Top = 453
      Width = 475
      Height = 15
      Caption = 
        'Use this file for History '#8211' has no effect on what the tabs use (' +
        #39'History.bin'#39' for the tenth tab)'
    end
    object Label21: TLabel
      Left = 104
      Top = 477
      Width = 65
      Height = 15
      Caption = 'Eleventh tab'
    end
    object Label22: TLabel
      Left = 104
      Top = 501
      Width = 58
      Height = 15
      Caption = 'Twelfth tab'
    end
    object Label23: TLabel
      Left = 80
      Top = 526
      Width = 487
      Height = 15
      Caption = 
        'On-screen position of thumbnail ('#39'appvc.ikb'#39' is positioned 3 pix' +
        'els to the left and top of this)'
    end
    object Label24: TLabel
      Left = 80
      Top = 550
      Width = 661
      Height = 15
      Caption = 
        'Thumbnail size ('#39'appvc.ikb'#39' is 6 pixels wider and higher) '#8211' edit' +
        'ing is locked because all thumbnails would need to be recreated'
    end
    object Label25: TLabel
      Left = 80
      Top = 576
      Width = 215
      Height = 15
      Caption = 'Size of '#39'sdclt.occ'#39' (selection background)'
    end
    object Label26: TLabel
      Left = 0
      Top = 600
      Width = 635
      Height = 15
      Caption = 
        'Changing anything related to the last five tabs has inconsistent' +
        ' effects on the device and is not supported by GB300 Tool.'
    end
    object EditFoldernameHeader: TEdit
      Left = 0
      Top = 0
      Width = 64
      Height = 23
      Color = clBtnFace
      Enabled = False
      TabOrder = 0
    end
    object EditFoldernameLanguages: TEdit
      Left = 0
      Top = 26
      Width = 32
      Height = 23
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      NumbersOnly = True
      TabOrder = 1
    end
    object ColorBoxFoldernameDefaultColor: TColorBox
      Left = 0
      Top = 52
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 2
      OnGetColors = ColorBoxGetColors
    end
    object ColorBoxFoldernameSelectedColor0: TColorBox
      Left = 0
      Top = 77
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 3
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder0: TEdit
      Left = 136
      Top = 77
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 4
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor1: TColorBox
      Left = 0
      Top = 102
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 5
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder1: TEdit
      Left = 136
      Top = 102
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 6
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor2: TColorBox
      Left = 0
      Top = 127
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 7
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder2: TEdit
      Left = 136
      Top = 127
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 8
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor3: TColorBox
      Left = 0
      Top = 152
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 9
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder3: TEdit
      Left = 136
      Top = 152
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 10
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor4: TColorBox
      Left = 0
      Top = 177
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 11
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder4: TEdit
      Left = 136
      Top = 177
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 12
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor5: TColorBox
      Left = 0
      Top = 202
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 13
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder5: TEdit
      Left = 136
      Top = 202
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 14
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor6: TColorBox
      Left = 0
      Top = 227
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 15
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder6: TEdit
      Left = 136
      Top = 227
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 16
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor7: TColorBox
      Left = 0
      Top = 252
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 17
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder7: TEdit
      Left = 136
      Top = 252
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 18
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor8: TColorBox
      Left = 0
      Top = 277
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 19
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder8: TEdit
      Left = 136
      Top = 277
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 20
      OnChange = EditFoldernameFolderChange
    end
    object ColorBoxFoldernameSelectedColor9: TColorBox
      Left = 0
      Top = 302
      Width = 128
      Height = 22
      Style = [cbStandardColors, cbCustomColor, cbPrettyNames, cbCustomColors]
      DropDownCount = 20
      TabOrder = 21
      OnGetColors = ColorBoxGetColors
    end
    object EditFoldernameFolder9: TEdit
      Left = 136
      Top = 302
      Width = 64
      Height = 22
      AutoSize = False
      TabOrder = 22
      OnChange = EditFoldernameFolderChange
    end
    object EditFoldernameTabCount: TEdit
      Left = 0
      Top = 327
      Width = 32
      Height = 23
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      NumbersOnly = True
      TabOrder = 23
    end
    object ComboBoxFoldernameInitialLeftTab: TComboBox
      Left = 0
      Top = 351
      Width = 96
      Height = 23
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 24
      OnSelect = ComboBoxFoldernameInitialLeftTabSelect
    end
    object ComboBoxFoldernameInitialSelectedTab: TComboBox
      Left = 0
      Top = 375
      Width = 96
      Height = 23
      Style = csDropDownList
      TabOrder = 25
    end
    object ComboBoxFoldernameDownloadROMsFile: TComboBox
      Left = 0
      Top = 401
      Width = 96
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 26
      Items.Strings = (
        'rdbui.tax'
        'urefs.tax'
        'scksp.tax'
        'vdsdc.tax'
        'pnpui.tax'
        'vfnet.tax'
        'mswb7.tax'
        'tsmfk.tax'
        'Favorites.bin'
        'History.bin'
        'Search'
        'Setting')
    end
    object ComboBoxFoldernameFavoritesFile: TComboBox
      Left = 0
      Top = 425
      Width = 96
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 27
    end
    object ComboBoxFoldernameHistoryFile: TComboBox
      Left = 0
      Top = 449
      Width = 96
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 28
    end
    object ComboBoxFoldernameSearchTab: TComboBox
      Left = 0
      Top = 473
      Width = 96
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 29
    end
    object ComboBoxFoldernameSystemTab: TComboBox
      Left = 0
      Top = 497
      Width = 96
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 30
    end
    object EditFoldernameThumbnailPositionX: TEdit
      Left = 0
      Top = 523
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 31
    end
    object EditFoldernameThumbnailPositionY: TEdit
      Left = 40
      Top = 523
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 32
    end
    object EditFoldernameThumbnailSizeWidth: TEdit
      Left = 0
      Top = 547
      Width = 32
      Height = 23
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      NumbersOnly = True
      TabOrder = 33
    end
    object EditFoldernameThumbnailSizeHeight: TEdit
      Left = 40
      Top = 547
      Width = 32
      Height = 23
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      NumbersOnly = True
      TabOrder = 34
    end
    object EditFoldernameSelectionSizeWidth: TEdit
      Left = 0
      Top = 573
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 35
    end
    object EditFoldernameSelectionSizeHeight: TEdit
      Left = 40
      Top = 573
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 36
    end
    object ButtonFoldernameReload: TButton
      Left = 0
      Top = 617
      Width = 80
      Height = 24
      Caption = 'Reload File'
      TabOrder = 37
      OnClick = ButtonFoldernameReloadClick
    end
    object ButtonFoldernameUndo: TButton
      Left = 88
      Top = 617
      Width = 80
      Height = 24
      Caption = 'Undo'
      TabOrder = 38
      OnClick = ButtonFoldernameUndoClick
    end
    object ButtonFoldernameDefaults: TButton
      Left = 176
      Top = 617
      Width = 80
      Height = 24
      Caption = 'Defaults'
      TabOrder = 39
      OnClick = ButtonFoldernameDefaultsClick
    end
    object ButtonFoldernameSave: TButton
      Left = 264
      Top = 617
      Width = 80
      Height = 24
      Caption = 'Save'
      TabOrder = 40
      OnClick = ButtonFoldernameSaveClick
    end
  end
  object ListViewFiles: TListView
    Left = 0
    Top = 0
    Width = 352
    Height = 669
    Align = alLeft
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'File Name'
        Width = 75
      end
      item
        AutoSize = True
        Caption = 'Description'
      end>
    DoubleBuffered = True
    Groups = <
      item
        Header = 'Main Screen Backgrounds'
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Main Screen Elements'
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Main Screen Language'
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Pause Menu Backgrounds'
        GroupID = 3
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Pause Menu Elements'
        GroupID = 4
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Pause Menu Language'
        GroupID = 5
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Other'
        GroupID = 6
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Unknown'
        GroupID = 7
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = ListViewFilesSelectItem
  end
  object PanelSpacer: TPanel
    Left = 352
    Top = 0
    Width = 8
    Height = 669
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object PanelRight: TPanel
    Left = 360
    Top = 0
    Width = 840
    Height = 669
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object ScrollBoxPreview: TScrollBox
      Left = 0
      Top = 32
      Width = 840
      Height = 637
      Align = alClient
      BorderStyle = bsNone
      DoubleBuffered = True
      Color = clGray
      ParentColor = False
      ParentDoubleBuffered = False
      TabOrder = 0
      OnMouseDown = ImagePreviewMouseDown
      object ImagePreview: TImage
        Left = 0
        Top = 0
        Width = 105
        Height = 105
        AutoSize = True
        Transparent = True
        OnMouseDown = ImagePreviewMouseDown
      end
      object ImagePreview2: TImage
        Left = 0
        Top = 488
        Width = 320
        Height = 240
        Stretch = True
        Transparent = True
        OnMouseDown = ImagePreviewMouseDown
      end
    end
    object PanelTop: TPanel
      Left = 0
      Top = 0
      Width = 840
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object LabelFormat: TLabel
        Left = 0
        Top = 4
        Width = 38
        Height = 15
        Caption = 'Format'
      end
      object Label1: TLabel
        Left = 304
        Top = 4
        Width = 32
        Height = 15
        Caption = 'Show:'
      end
      object LabelSliceLanguage: TLabel
        Left = 688
        Top = 4
        Width = 56
        Height = 15
        Caption = 'Slice Lang:'
        Visible = False
      end
      object ButtonSave: TButton
        Left = 120
        Top = 0
        Width = 80
        Height = 24
        Caption = 'Save File...'
        DropDownMenu = PopupMenuSave
        Style = bsSplitButton
        TabOrder = 0
        OnClick = ButtonSaveClick
      end
      object ButtonReplace: TButton
        Left = 208
        Top = 0
        Width = 80
        Height = 24
        Caption = 'Replace...'
        TabOrder = 1
        OnClick = ButtonReplaceClick
      end
      object ComboBoxDisplayMode: TComboBox
        Left = 344
        Top = 1
        Width = 104
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'Image / Slices'
        OnSelect = ComboBoxDisplayModeSelect
        Items.Strings = (
          'Image / Slices'
          'Live Previews')
      end
      object ComboBoxImageList: TComboBox
        Left = 456
        Top = 1
        Width = 224
        Height = 23
        Style = csDropDownList
        DropDownCount = 30
        TabOrder = 3
        OnSelect = ComboBoxImageListSelect
      end
      object ComboBoxSliceLanguage: TComboBox
        Left = 752
        Top = 1
        Width = 88
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'English'
        Visible = False
        OnSelect = ComboBoxSliceLanguageSelect
        Items.Strings = (
          'English'
          'Chinese'
          'Arabic'
          'Russian'
          'Spanish'
          'Portuguese'
          'Korean')
      end
    end
  end
  object TimerLazyLoad: TTimer
    Interval = 1
    OnTimer = TimerLazyLoadTimer
    Left = 40
    Top = 366
  end
  object SaveDialogImage: TSaveDialog
    DefaultExt = '.png'
    Filter = 'Portable Network Graphics (*.png)|*.png'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
    Top = 302
  end
  object OpenDialogImageRGB565: TOpenDialog
    Filter = 
      'Images (*.bmp, *.dib, *.png, *.jpg, *.jpeg)|*.bmp;*.dib;*.png;*.' +
      'jpg;*.jpeg'
    Left = 168
    Top = 302
  end
  object OpenDialogImageBGRA8888: TOpenDialog
    Filter = 'Portable Network Graphics (*.png)|*.png'
    Left = 168
    Top = 366
  end
  object PopupMenuSave: TPopupMenu
    Left = 168
    Top = 432
    object MenuItemCopy: TMenuItem
      Caption = 'Copy Current Image to Clipboard'
      OnClick = MenuItemCopyClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ExportAllImagestoDirectory1: TMenuItem
      Caption = 'Export UI Files to Directory...'
      OnClick = ExportAllImagestoDirectory1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemReloadXML: TMenuItem
      Caption = 'Reload XML'
      OnClick = MenuItemReloadXMLClick
    end
  end
end
