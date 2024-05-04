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
end
