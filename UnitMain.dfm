object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'GB300+SF2000 Tool [v2.0-beta]'
  ClientHeight = 760
  ClientWidth = 1280
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1280
    760)
  TextHeight = 15
  object PanelFrame: TPanel
    AlignWithMargins = True
    Left = 16
    Top = 128
    Width = 1248
    Height = 616
    Margins.Left = 16
    Margins.Top = 16
    Margins.Right = 16
    Margins.Bottom = 16
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1244
    ExplicitHeight = 615
  end
  object PanelOnboarding: TPanel
    Left = 384
    Top = 218
    Width = 512
    Height = 326
    Anchors = []
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 382
    ExplicitTop = 217
    DesignSize = (
      512
      326)
    object ShapeOnboarding: TShape
      Left = 0
      Top = 0
      Width = 512
      Height = 326
      Align = alClient
      Pen.Color = clSilver
      Shape = stRoundRect
      ExplicitHeight = 310
    end
    object ImageOnboardingDevice: TImage
      Left = 24
      Top = 32
      Width = 64
      Height = 64
    end
    object LabelOnboardingName: TLabel
      Left = 96
      Top = 24
      Width = 392
      Height = 59
      Caption = 'GB300+SF2000 Tool'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -43
      Font.Name = 'Segoe UI Semilight'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelOnboardingWelcome: TLabel
      Left = 96
      Top = 80
      Width = 53
      Height = 15
      Caption = 'Welcome!'
    end
    object LabelOnboardingWorkingDir: TLabel
      Left = 108
      Top = 123
      Width = 129
      Height = 15
      Caption = 'Working drive/directory:'
    end
    object ImageOnboardingClyde: TImage
      Left = 103
      Top = 293
      Width = 16
      Height = 16
      Anchors = [akLeft, akBottom]
    end
    object LabelUnboardingDiscordHandle: TLabel
      Left = 122
      Top = 291
      Width = 76
      Height = 17
      Cursor = crHandPoint
      Anchors = [akLeft, akBottom]
      Caption = 'numma_cway'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = LabelUnboardingDiscordHandleClick
    end
    object ImageOnboardingOctocat: TImage
      Left = 207
      Top = 293
      Width = 16
      Height = 16
      Anchors = [akLeft, akBottom]
    end
    object LabelOnboardingGithubRepository: TLabel
      Left = 226
      Top = 291
      Width = 184
      Height = 17
      Cursor = crHandPoint
      Anchors = [akLeft, akBottom]
      Caption = 'nummacway/gb300-sf2000-tool'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = LabelOnboardingGithubRepositoryClick
    end
    object EditOnboardingWorkingDir: TEdit
      Left = 244
      Top = 120
      Width = 113
      Height = 23
      TabOrder = 0
      OnChange = EditOnboardingWorkingDirChange
    end
    object ButtonOnboardingStart: TButton
      Left = 364
      Top = 119
      Width = 56
      Height = 25
      Caption = 'Start'
      Default = True
      Enabled = False
      TabOrder = 1
      OnClick = ButtonOnboardingStartClick
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 160
      Width = 480
      Height = 116
      Caption = 'Settings'
      TabOrder = 2
      object Label15: TLabel
        Left = 152
        Top = 87
        Width = 314
        Height = 15
        Caption = 'For manual experiments (it'#39's usually invoked automatically)'
      end
      object CheckBoxOnboardingChinese: TCheckBox
        Left = 8
        Top = 16
        Width = 464
        Height = 17
        Caption = 
          'Show Chinese/Pinyin names (double-click stock list items to edit' +
          ')'
        TabOrder = 0
      end
      object CheckBoxOnboardingPrettyNames: TCheckBox
        Left = 8
        Top = 32
        Width = 464
        Height = 16
        Caption = 'Use pretty file names when adding games (not yet implemented)'
        Enabled = False
        TabOrder = 1
      end
      object CheckBoxOnboardingMaxCompression: TCheckBox
        Left = 8
        Top = 64
        Width = 464
        Height = 16
        Caption = 
          'Use maximum Deflate compression when Neo Geo Faker is auto-invok' +
          'ed (slow)'
        TabOrder = 3
      end
      object ButtonNeoGeoFaker: TButton
        Left = 28
        Top = 83
        Width = 116
        Height = 24
        Caption = 'Start Neo Geo Faker'
        TabOrder = 4
        OnClick = ButtonNeoGeoFakerClick
      end
      object CheckBoxOnboardingMulticoreZFB: TCheckBox
        Left = 8
        Top = 48
        Width = 464
        Height = 16
        Caption = 
          'Use ZFB when creating multicore stubs (allows arbitrary filename' +
          's)'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    Visible = False
    ExplicitWidth = 1276
    object ShapeFrame: TShape
      Left = 16
      Top = -16
      Width = 1248
      Height = 128
      Brush.Style = bsClear
      Pen.Color = clSilver
      Shape = stRoundRect
    end
    object ShapeDivider: TShape
      Left = 815
      Top = 8
      Width = 2
      Height = 96
      Pen.Color = 15263976
      Shape = stRoundRect
    end
    object Shape1: TShape
      Tag = 1
      Left = 24
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape2: TShape
      Tag = 2
      Left = 112
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape3: TShape
      Tag = 3
      Left = 200
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape4: TShape
      Tag = 4
      Left = 288
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape5: TShape
      Tag = 5
      Left = 376
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape6: TShape
      Tag = 6
      Left = 464
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape7: TShape
      Tag = 7
      Left = 552
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape8: TShape
      Tag = 8
      Left = 640
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape14: TShape
      Tag = 14
      Left = 824
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape10: TShape
      Tag = 10
      Left = 912
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape11: TShape
      Tag = 11
      Left = 1088
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape12: TShape
      Tag = 12
      Left = 1176
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Image1: TImage
      Left = 32
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image12: TImage
      Left = 1184
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image8: TImage
      Left = 648
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image2: TImage
      Left = 120
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image3: TImage
      Left = 208
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image4: TImage
      Left = 296
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image5: TImage
      Left = 384
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image6: TImage
      Left = 472
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image7: TImage
      Left = 560
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image14: TImage
      Left = 832
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image11: TImage
      Left = 1096
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image10: TImage
      Left = 920
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Label1: TLabel
      Left = 24
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'FC List'
    end
    object Label12: TLabel
      Left = 1176
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'UI Editor'
    end
    object Label8: TLabel
      Left = 640
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'My ROMs'
    end
    object Label14: TLabel
      Left = 824
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Favorites'
    end
    object Label2: TLabel
      Left = 112
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'PCE List'
    end
    object Label3: TLabel
      Left = 200
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'SFC List'
    end
    object Label4: TLabel
      Left = 288
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'MD List'
    end
    object Label5: TLabel
      Left = 376
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GB List'
    end
    object Label6: TLabel
      Left = 464
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GBC List'
    end
    object Label7: TLabel
      Left = 552
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GBA List'
    end
    object Label10: TLabel
      Left = 912
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'BIOS && Device'
    end
    object Label11: TLabel
      Left = 1088
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Keys'
    end
    object Shape13: TShape
      Tag = 13
      Left = 1000
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Image13: TImage
      Left = 1008
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Label13: TLabel
      Left = 1000
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'multicore'
    end
    object Shape9: TShape
      Tag = 9
      Left = 728
      Top = 8
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Image9: TImage
      Left = 736
      Top = 16
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Label9: TLabel
      Left = 728
      Top = 83
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GBA List'
    end
  end
  object ImageListFileTypes: TImageList
    ColorDepth = cd32Bit
    Left = 216
    Top = 336
  end
  object TimerLazyLoad: TTimer
    Interval = 1
    OnTimer = TimerLazyLoadTimer
    Left = 920
    Top = 336
  end
  object ActionList: TActionList
    Left = 728
    Top = 640
    object BrowseURL: TBrowseURL
    end
    object ActionFind: TAction
      Caption = 'ActionFind'
      ShortCut = 16454
      OnExecute = ActionFindExecute
    end
    object ActionFindNext: TAction
      Caption = 'ActionFindNext'
      ShortCut = 114
      OnExecute = FindDialogFind
    end
    object FileRunNeoGeo: TFileRun
      Browse = False
      BrowseDlg.Title = 'Run'
      Operation = 'open'
      Parameters = '-neogeo'
      ShowCmd = scShowNormal
    end
  end
  object ImageListCheckResults: TImageList
    ColorDepth = cd32Bit
    Left = 216
    Top = 400
  end
  object FindDialog: TFindDialog
    Options = [frDown, frHideWholeWord]
    OnFind = FindDialogFind
    Left = 200
    Top = 560
  end
end
