object FrameUserROMs: TFrameUserROMs
  Left = 0
  Top = 0
  Width = 1112
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
      object ButtonAdd: TButton
        Left = 0
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Add...'
        DropDownMenu = PopupMenuAdd
        TabOrder = 0
        OnClick = ButtonAddClick
      end
      object ButtonDelete: TButton
        Left = 80
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Delete'
        TabOrder = 1
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
      Columns = <
        item
          AutoSize = True
        end>
      DoubleBuffered = True
      MultiSelect = True
      RowSelect = True
      ParentDoubleBuffered = False
      PopupMenu = PopupMenu
      ShowColumnHeaders = False
      TabOrder = 1
      ViewStyle = vsReport
      OnCompare = ListViewFilesCompare
      OnEdited = ListViewFilesEdited
      OnKeyDown = ListViewFilesKeyDown
      OnSelectItem = ListViewFilesSelectItem
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
  object TimerLazyLoad: TTimer
    Interval = 1
    OnTimer = TimerLazyLoadTimer
    Left = 616
    Top = 304
  end
  object OpenDialogROMs: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 496
    Top = 408
  end
  object PopupMenuAdd: TPopupMenu
    Left = 176
    Top = 512
    object MenuItemAddVTxx: TMenuItem
      Caption = 'Add VTxx and Ensure iNES Header...'
      OnClick = MenuItemAddVTxxClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemKeepiNES: TMenuItem
      AutoCheck = True
      Caption = 'Keep Most of iNES if PRG Size is Valid'
    end
    object MenuItemOnlyOneBus: TMenuItem
      AutoCheck = True
      Caption = 'Skip Non-OneBus (CHR Size <> 0)'
      Checked = True
    end
  end
  object OpenDialogVTxx: TOpenDialog
    Filter = 
      'Famiclone ROMs (*.nes, *.unf, *.unif, *.bin, *.nfc)|*.nes;*.unf;' +
      '*.unif;*.bin;*.nfc|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 456
    Top = 240
  end
  object PopupMenu: TPopupMenu
    Left = 208
    Top = 304
    object SavetsmfktaxasText1: TMenuItem
      Caption = 'Save tsmfk.tax as Text...'
      OnClick = SavetsmfktaxasText1Click
    end
  end
  object SaveDialogTXT: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'Text files (*.txt)|*.txt'
    Left = 760
    Top = 224
  end
end
