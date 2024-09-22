object FrameUI: TFrameUI
  Left = 0
  Top = 0
  Width = 1248
  Height = 669
  Align = alClient
  TabOrder = 0
  object PanelRight: TPanel
    Left = 392
    Top = 0
    Width = 856
    Height = 669
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    ExplicitLeft = 368
    ExplicitWidth = 832
    object ScrollBoxPreview: TScrollBox
      Left = 0
      Top = 32
      Width = 856
      Height = 637
      HorzScrollBar.Tracking = True
      VertScrollBar.Tracking = True
      Align = alClient
      BorderStyle = bsNone
      DoubleBuffered = True
      Color = clGray
      ParentColor = False
      ParentDoubleBuffered = False
      TabOrder = 0
      OnMouseDown = ImagePreviewMouseDown
      ExplicitWidth = 832
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
        OnMouseDown = ImagePreviewMouseDown
      end
    end
    object PanelTop: TPanel
      Left = 0
      Top = 0
      Width = 856
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 832
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
    end
  end
  object PanelRightStrings: TPanel
    Left = 392
    Top = 0
    Width = 856
    Height = 669
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    ExplicitLeft = 368
    ExplicitWidth = 832
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 224
      Height = 637
      Align = alLeft
      Lines.Strings = (
        'Loading......'
        'Folder is empty'#12290
        'Resume Quit Load Save'
        'Archive already exists,'
        'overwrite this archive?'
        'Archive save failed .'
        'Please check TF card'
        'after power off .'
        'LOW BATTERY!'
        'Please charge it in time.'
        'Save the progress, Power off and charge.'
        'Search'
        'No games match the keyword.'
        'Favorites'
        'Favorites are full!'
        'Remove from favorites?'
        'History'
        'Key Mapping')
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
    object MemoStrings: TMemo
      Left = 224
      Top = 0
      Width = 632
      Height = 637
      Align = alClient
      TabOrder = 1
      WordWrap = False
      ExplicitWidth = 608
    end
    object Panel1: TPanel
      Left = 0
      Top = 637
      Width = 856
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitWidth = 832
      object ButtonStringsSave: TButton
        Left = 0
        Top = 8
        Width = 80
        Height = 24
        Caption = 'Save'
        TabOrder = 0
        OnClick = ButtonStringsSaveClick
      end
    end
  end
  object PanelRightFoldername: TPanel
    Left = 392
    Top = 0
    Width = 856
    Height = 669
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    ExplicitLeft = 368
    ExplicitWidth = 832
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
      Width = 556
      Height = 15
      Caption = 
        'Default font color: used in lists and the entered search text; i' +
        't is reset to white as soon as you enter a game'
    end
    object Label5: TLabel
      Left = 208
      Top = 80
      Width = 397
      Height = 15
      Caption = 
        'Selected font color, and the downloaded ROM folder to whose list' +
        ' it applies'
    end
    object Label6: TLabel
      Left = 208
      Top = 105
      Width = 351
      Height = 15
      Caption = 
        'Selected font color, and the first ROM folder to whose list it a' +
        'pplies'
    end
    object Label7: TLabel
      Left = 208
      Top = 130
      Width = 369
      Height = 15
      Caption = 
        'Selected font color, and the second ROM folder to whose list it ' +
        'applies'
    end
    object Label8: TLabel
      Left = 208
      Top = 155
      Width = 356
      Height = 15
      Caption = 
        'Selected font color, and the third ROM folder to whose list it a' +
        'pplies'
    end
    object Label9: TLabel
      Left = 208
      Top = 180
      Width = 364
      Height = 15
      Caption = 
        'Selected font color, and the fourth ROM folder to whose list it ' +
        'applies'
    end
    object Label10: TLabel
      Left = 208
      Top = 205
      Width = 353
      Height = 15
      Caption = 
        'Selected font color, and the fifth ROM folder to whose list it a' +
        'pplies'
    end
    object Label11: TLabel
      Left = 208
      Top = 230
      Width = 356
      Height = 15
      Caption = 
        'Selected font color, and the sixth ROM folder to whose list it a' +
        'pplies'
    end
    object Label12: TLabel
      Left = 208
      Top = 255
      Width = 634
      Height = 15
      Caption = 
        'Selected font color, and the seventh ROM folder to whose list it' +
        ' applies '#8211' this is the only folder that hands ZIP to FBAlpha'
    end
    object Label13: TLabel
      Left = 208
      Top = 280
      Width = 500
      Height = 15
      Caption = 
        'Selected font color, and the eighth ROM folder to whose list it ' +
        'applies '#8211' not available on SF2000'
    end
    object Label14: TLabel
      Left = 208
      Top = 305
      Width = 560
      Height = 15
      Caption = 
        'Unknown (this is not the color for favorites, history and search' +
        ' results, because that color is always orange)'
    end
    object Label15: TLabel
      Left = 40
      Top = 331
      Width = 459
      Height = 15
      Caption = 
        'Number of categories '#8211' editing is not supported because it would' +
        ' have odd side effects'
    end
    object Label16: TLabel
      Left = 80
      Top = 355
      Width = 109
      Height = 15
      Caption = 'Selected tab on boot'
    end
    object Label17: TLabel
      Left = 80
      Top = 379
      Width = 548
      Height = 15
      Caption = 
        'Where to place the User Settings menu '#8211' editing is not supported' +
        ' because it would have odd side effects'
    end
    object Label23: TLabel
      Left = 80
      Top = 404
      Width = 487
      Height = 15
      Caption = 
        'On-screen position of thumbnail ('#39'appvc.ikb'#39' is positioned 3 pix' +
        'els to the left and top of this)'
    end
    object Label24: TLabel
      Left = 80
      Top = 428
      Width = 661
      Height = 15
      Caption = 
        'Thumbnail size ('#39'appvc.ikb'#39' is 6 pixels wider and higher) '#8211' edit' +
        'ing is locked because all thumbnails would need to be recreated'
    end
    object Label25: TLabel
      Left = 80
      Top = 454
      Width = 281
      Height = 15
      Caption = 'Size of selection icons (could be used as background)'
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
      Width = 72
      Height = 23
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 24
    end
    object ComboBoxFoldernameInitialSelectedTab: TComboBox
      Left = 0
      Top = 375
      Width = 72
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 25
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
    object EditFoldernameThumbnailPositionX: TEdit
      Left = 0
      Top = 401
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 26
    end
    object EditFoldernameThumbnailPositionY: TEdit
      Left = 40
      Top = 401
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 27
    end
    object EditFoldernameThumbnailSizeWidth: TEdit
      Left = 0
      Top = 425
      Width = 32
      Height = 23
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      NumbersOnly = True
      TabOrder = 28
    end
    object EditFoldernameThumbnailSizeHeight: TEdit
      Left = 40
      Top = 425
      Width = 32
      Height = 23
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      NumbersOnly = True
      TabOrder = 29
    end
    object EditFoldernameSelectionSizeWidth: TEdit
      Left = 0
      Top = 451
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 30
    end
    object EditFoldernameSelectionSizeHeight: TEdit
      Left = 40
      Top = 451
      Width = 32
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 31
    end
    object ButtonFoldernameReload: TButton
      Left = 0
      Top = 483
      Width = 80
      Height = 24
      Caption = 'Reload File'
      TabOrder = 32
      OnClick = ButtonFoldernameReloadClick
    end
    object ButtonFoldernameUndo: TButton
      Left = 88
      Top = 483
      Width = 80
      Height = 24
      Caption = 'Undo'
      TabOrder = 33
      OnClick = ButtonFoldernameUndoClick
    end
    object ButtonFoldernameDefaults: TButton
      Left = 176
      Top = 483
      Width = 80
      Height = 24
      Caption = 'Defaults'
      TabOrder = 34
      OnClick = ButtonFoldernameDefaultsClick
    end
    object ButtonFoldernameSave: TButton
      Left = 264
      Top = 483
      Width = 80
      Height = 24
      Caption = 'Save'
      TabOrder = 35
      OnClick = ButtonFoldernameSaveClick
    end
  end
  object ListViewFiles: TListView
    Left = 0
    Top = 0
    Width = 384
    Height = 669
    Align = alLeft
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'File Name'
        Width = 90
      end
      item
        AutoSize = True
        Caption = 'Description'
      end>
    DoubleBuffered = True
    Groups = <
      item
        Header = 'Main Menu Backgrounds'
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Main Menu Elements'
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Game List Background'
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Game List Elements'
        GroupID = 3
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Sub Menu Images'
        GroupID = 4
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Pause Menu Backgrounds'
        GroupID = 5
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Pause Menu Elements'
        GroupID = 6
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Other'
        GroupID = 7
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Text Files'
        GroupID = 8
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Probably Unused'
        GroupID = 9
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Unused Alternate Main Menu Backgrounds'
        GroupID = 10
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Unused Other'
        GroupID = 11
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
    Left = 384
    Top = 0
    Width = 8
    Height = 669
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 360
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
    OnPopup = PopupMenuSavePopup
    Left = 168
    Top = 432
    object MenuItemCopy: TMenuItem
      Caption = 'Copy Current Image to Clipboard'
      OnClick = MenuItemCopyClick
    end
    object MenuItemCopySmall: TMenuItem
      Caption = 'Copy Small Preview to Clipboard'
      OnClick = MenuItemCopySmallClick
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
