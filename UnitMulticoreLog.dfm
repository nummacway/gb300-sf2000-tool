object FrameMulticoreLog: TFrameMulticoreLog
  Left = 0
  Top = 0
  Width = 640
  Height = 27
  TabOrder = 0
  object LabelDescription: TLabel
    Left = 0
    Top = 4
    Width = 212
    Height = 15
    Caption = 'multicore log file (takes effect instantly):'
  end
  object ButtonEnable: TButton
    Left = 224
    Top = 0
    Width = 120
    Height = 24
    Caption = 'Enable Log'
    TabOrder = 0
    OnClick = ButtonEnableClick
  end
  object ButtonShow: TButton
    Left = 352
    Top = 0
    Width = 120
    Height = 24
    Caption = 'Show Current Log'
    TabOrder = 1
    OnClick = ButtonShowClick
  end
  object ButtonDisable: TButton
    Left = 480
    Top = 0
    Width = 120
    Height = 24
    Caption = 'Delete && Disable Log'
    TabOrder = 2
    OnClick = ButtonDisableClick
  end
  object ActionList: TActionList
    Left = 128
    object FileRun: TFileRun
      Browse = False
      BrowseDlg.Title = 'Run'
      Operation = 'open'
      ShowCmd = scShowNormal
    end
  end
end
