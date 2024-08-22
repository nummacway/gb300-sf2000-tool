object FrameMulticore: TFrameMulticore
  Left = 0
  Top = 0
  Width = 1112
  Height = 648
  Align = alClient
  TabOrder = 0
  DesignSize = (
    1112
    648)
  object PanelNotInstalled: TPanel
    Left = 0
    Top = 208
    Width = 1112
    Height = 136
    Anchors = [akTop]
    BevelOuter = bvNone
    TabOrder = 0
    OnClick = PanelNotInstalledClick
    object ShapeNotInstalled: TShape
      Left = 0
      Top = 0
      Width = 1112
      Height = 136
      Align = alClient
      Brush.Color = 10079487
      Enabled = False
      ExplicitTop = 8
      ExplicitWidth = 65
      ExplicitHeight = 65
    end
    object LabelNotInstalled1: TLabel
      Left = 16
      Top = 16
      Width = 856
      Height = 15
      Caption = 
        'multicore is not currently installed on this TF card. It is a fr' +
        'ee download and adds support for many more emulators, including ' +
        'one for improved GBA performance.'
      OnClick = PanelNotInstalledClick
    end
    object LabelNotInstalled2: TLabel
      Left = 16
      Top = 40
      Width = 795
      Height = 15
      Caption = 
        'Before you install multicore, make sure that you have already pa' +
        'tched the bootloader. See this tool'#39's "BIOS / Device" tab for mo' +
        're information.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = PanelNotInstalledClick
    end
    object LabelNotInstalled4: TLabel
      Left = 16
      Top = 104
      Width = 477
      Height = 15
      Caption = 
        'multicore for SF2000 was created by kobil, osaka and madcock. Pr' +
        'osty brought it to GB300.'
      OnClick = PanelNotInstalledClick
    end
    object LabelNotInstalled3: TLabel
      Left = 16
      Top = 64
      Width = 893
      Height = 15
      Caption = 
        'Click here to visit the downloads page of multicore. Simply down' +
        'load the most recent 7-Zip archive and extract it to your TF car' +
        'd (root directory). Then restart GB300 Tool.'
      OnClick = PanelNotInstalledClick
    end
  end
  object PanelInstalled: TPanel
    Left = 0
    Top = 0
    Width = 1112
    Height = 648
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object ListViewFiles: TListView
      Left = 0
      Top = 0
      Width = 128
      Height = 648
      Align = alLeft
      BorderStyle = bsNone
      Columns = <
        item
          AutoSize = True
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      Groups = <
        item
          Header = 'General'
          GroupID = 0
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'multicore Cores'
          GroupID = 1
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end>
      GroupView = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      ShowColumnHeaders = False
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = ListViewFilesSelectItem
    end
    object PanelSpacer: TPanel
      Left = 128
      Top = 0
      Width = 8
      Height = 648
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
    object PanelCoreInfo: TPanel
      Left = 136
      Top = 0
      Width = 976
      Height = 648
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object PanelCorePreferences: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 294
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object LabelEmuName: TLabel
          Left = 0
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
        object Label1: TLabel
          Left = 0
          Top = 28
          Width = 187
          Height = 15
          Caption = 'Supported platforms and BIOS files:'
        end
        object Label2: TLabel
          Left = 520
          Top = 28
          Width = 154
          Height = 15
          Caption = 'Is default core for extensions:'
        end
        object Label3: TLabel
          Left = 688
          Top = 28
          Width = 138
          Height = 15
          Caption = 'Always use for extensions:'
        end
        object LabelConfig: TLabel
          Left = 0
          Top = 276
          Width = 126
          Height = 15
          Caption = 'Configure core settings:'
        end
        object LabelBIOSInfo: TLabel
          Left = 0
          Top = 253
          Width = 937
          Height = 15
          Caption = 
            'You can get blueMSX'#39's BIOS files from its website. Ask Google fo' +
            'r all others cores'#39'. NOTE: The lists above are not available for' +
            ' all cores, especially those that are known to not work.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object ListViewDefault: TListView
          Left = 520
          Top = 44
          Width = 160
          Height = 208
          Checkboxes = True
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
          TabOrder = 1
          ViewStyle = vsReport
          OnItemChecked = ListViewDefaultItemChecked
        end
        object ListViewAlways: TListView
          Left = 688
          Top = 44
          Width = 160
          Height = 208
          Checkboxes = True
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
          TabOrder = 2
          ViewStyle = vsReport
          OnItemChecked = ListViewAlwaysItemChecked
        end
        object ListViewBIOS: TListView
          Left = 0
          Top = 44
          Width = 512
          Height = 208
          Columns = <
            item
              Caption = 'File'
              Width = 200
            end
            item
              Caption = 'Required'
              Width = 60
            end
            item
              Caption = 'Present'
              Width = 60
            end
            item
              Caption = 'Valid'
              Width = 60
            end>
          DoubleBuffered = True
          GroupView = True
          ReadOnly = True
          RowSelect = True
          ParentDoubleBuffered = False
          SmallImages = Form1.ImageListCheckResults
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object PanelConfigActions: TPanel
        Left = 0
        Top = 616
        Width = 976
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object ButtonSaveConfig: TButton
          Left = 0
          Top = 8
          Width = 128
          Height = 24
          Caption = 'Save Core Settings'
          TabOrder = 0
          OnClick = ButtonSaveConfigClick
        end
      end
    end
  end
  object TimerLazyLoad: TTimer
    Interval = 1
    OnTimer = TimerLazyLoadTimer
    Left = 512
    Top = 280
  end
end
