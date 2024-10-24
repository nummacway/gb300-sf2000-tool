object FrameStockROMs: TFrameStockROMs
  Left = 0
  Top = 0
  Width = 1000
  Height = 640
  Align = alClient
  TabOrder = 0
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 640
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object PanelListActions: TPanel
      Left = 0
      Top = 608
      Width = 392
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object ButtonCheckAll: TButton
        Left = 0
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Check All'
        TabOrder = 0
        OnClick = ButtonCheckAllClick
      end
      object ButtonUncheckAll: TButton
        Left = 80
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Uncheck All'
        TabOrder = 1
        OnClick = ButtonUncheckAllClick
      end
      object ButtonAdd: TButton
        Left = 240
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Add...'
        TabOrder = 2
        OnClick = ButtonAddClick
      end
      object ButtonAlphaSort: TButton
        Left = 160
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Alphasort'
        TabOrder = 3
        OnClick = ButtonAlphaSortClick
      end
      object ButtonDelete: TButton
        Left = 320
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Delete'
        TabOrder = 4
        OnClick = ButtonDeleteClick
      end
    end
    object ListViewFiles: TListView
      Left = 0
      Top = 0
      Width = 392
      Height = 608
      Align = alClient
      BorderStyle = bsNone
      Checkboxes = True
      Columns = <
        item
          AutoSize = True
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      RowSelect = True
      ParentDoubleBuffered = False
      PopupMenu = PopupMenu
      ShowColumnHeaders = False
      TabOrder = 1
      ViewStyle = vsReport
      OnDblClick = ListViewFilesDblClick
      OnEdited = ListViewFilesEdited
      OnDragDrop = ListViewFilesDragDrop
      OnDragOver = ListViewFilesDragOver
      OnKeyDown = ListViewFilesKeyDown
      OnKeyPress = ListViewFilesKeyPress
      OnSelectItem = ListViewFilesSelectItem
      OnItemChecked = ListViewFilesItemChecked
      OnStartDrag = ListViewFilesStartDrag
    end
  end
  object PanelSpacer: TPanel
    Left = 392
    Top = 0
    Width = 8
    Height = 640
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object TimerSave: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerSaveTimer
    Left = 136
    Top = 264
  end
  object OpenDialogROMs: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 496
    Top = 408
  end
  object TimerDnDScroll: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerDnDScrollTimer
    Left = 288
    Top = 392
  end
  object PopupMenu: TPopupMenu
    Left = 272
    Top = 256
    object MenuItemImportAllImages: TMenuItem
      Caption = 'Import All Images...'
      OnClick = MenuItemImportAllImagesClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemExportAllWQWROMs: TMenuItem
      Caption = 'Export All WQW ROMs...'
      OnClick = MenuItemExportAllWQWROMsClick
    end
    object MenuItemExportAllWQWImages: TMenuItem
      Caption = 'Export All WQW/ZFB Images...'
      OnClick = MenuItemExportAllWQWImagesClick
    end
    object MenuItemConvertAllWQWToMulticore: TMenuItem
      Caption = 'Convert All WQW to Multicore...'
      OnClick = MenuItemConvertAllWQWToMulticoreClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuItemExportSelectedWQWROMs: TMenuItem
      Caption = 'Export Selected WQW ROMs...'
      OnClick = MenuItemExportAllWQWROMsClick
    end
    object MenuItemExportSelectedWQWImages: TMenuItem
      Caption = 'Export Selected WQW/ZFB Images...'
      OnClick = MenuItemExportAllWQWImagesClick
    end
    object MenuItemConvertSelectedWQWToMulticore: TMenuItem
      Caption = 'Convert Selected WQW to Multicore...'
      OnClick = MenuItemConvertAllWQWToMulticoreClick
    end
  end
  object FileOpenDialogFolder: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Title = 'Destination'
    Left = 504
    Top = 208
  end
end
