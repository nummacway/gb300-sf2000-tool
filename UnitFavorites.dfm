object FrameFavorites: TFrameFavorites
  Left = 0
  Top = 0
  Width = 1112
  Height = 648
  Align = alClient
  TabOrder = 0
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 648
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object PanelListActions: TPanel
      Left = 0
      Top = 616
      Width = 392
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object ButtonAlphaSort: TButton
        Left = 0
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Alphasort'
        TabOrder = 0
        OnClick = ButtonAlphaSortClick
      end
      object ButtonDelete: TButton
        Left = 80
        Top = 8
        Width = 72
        Height = 24
        Caption = 'Remove'
        TabOrder = 1
        OnClick = ButtonDeleteClick
      end
    end
    object ListViewFiles: TListView
      Left = 0
      Top = 0
      Width = 392
      Height = 616
      Align = alClient
      BorderStyle = bsNone
      Columns = <
        item
          AutoSize = True
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      ShowColumnHeaders = False
      TabOrder = 0
      ViewStyle = vsReport
      OnDeletion = ListViewFilesDeletion
      OnDragDrop = ListViewFilesDragDrop
      OnDragOver = ListViewFilesDragOver
      OnKeyDown = ListViewFilesKeyDown
      OnSelectItem = ListViewFilesSelectItem
      OnStartDrag = ListViewFilesStartDrag
    end
  end
  object PanelSpacer: TPanel
    Left = 392
    Top = 0
    Width = 8
    Height = 648
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object TimerLazyLoad: TTimer
    Interval = 1
    OnTimer = TimerLazyLoadTimer
    Left = 184
    Top = 392
  end
  object TimerDnDScroll: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerDnDScrollTimer
    Left = 288
    Top = 392
  end
end
