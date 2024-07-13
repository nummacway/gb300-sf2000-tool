object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'GB300 Tool [v1.0-final]'
  ClientHeight = 808
  ClientWidth = 1232
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1232
    808)
  TextHeight = 15
  object PanelFrame: TPanel
    Left = 16
    Top = 144
    Width = 1200
    Height = 648
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1196
    ExplicitHeight = 647
  end
  object PanelOnboarding: TPanel
    Left = 396
    Top = 266
    Width = 440
    Height = 216
    Anchors = []
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 394
    object ShapeOnboarding: TShape
      Left = 0
      Top = 0
      Width = 440
      Height = 216
      Pen.Color = clSilver
      Shape = stRoundRect
    end
    object ImageOnboardingDevice: TImage
      Left = 72
      Top = 32
      Width = 64
      Height = 64
    end
    object LabelOnboardingName: TLabel
      Left = 136
      Top = 24
      Width = 222
      Height = 59
      Caption = 'GB300 Tool'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -43
      Font.Name = 'Segoe UI Semilight'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelOnboardingWelcome: TLabel
      Left = 136
      Top = 80
      Width = 53
      Height = 15
      Caption = 'Welcome!'
    end
    object LabelOnboardingWorkingDir: TLabel
      Left = 64
      Top = 123
      Width = 129
      Height = 15
      Caption = 'Working drive/directory:'
    end
    object ImageOnboardingClyde: TImage
      Left = 88
      Top = 192
      Width = 16
      Height = 16
    end
    object LabelUnboardingDiscordHandle: TLabel
      Left = 107
      Top = 190
      Width = 76
      Height = 17
      Caption = 'numma_cway'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object ImageOnboardingOctocat: TImage
      Left = 192
      Top = 192
      Width = 16
      Height = 16
    end
    object LabelOnboardingGithubRepository: TLabel
      Left = 211
      Top = 190
      Width = 136
      Height = 17
      Caption = 'nummacway/gb300tool'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object LabelOnboardingChinese: TLabel
      Left = 152
      Top = 168
      Width = 142
      Height = 15
      Caption = '(double-click to edit them)'
      Visible = False
    end
    object EditOnboardingWorkingDir: TEdit
      Left = 200
      Top = 120
      Width = 113
      Height = 23
      TabOrder = 0
      OnChange = EditOnboardingWorkingDirChange
    end
    object ButtonOnboardingStart: TButton
      Left = 320
      Top = 119
      Width = 56
      Height = 25
      Caption = 'Start'
      Default = True
      Enabled = False
      TabOrder = 1
      OnClick = ButtonOnboardingStartClick
    end
    object CheckBoxOnboardingChinese: TCheckBox
      Left = 128
      Top = 152
      Width = 184
      Height = 17
      Caption = 'Show Chinese/Pinyin names'
      TabOrder = 2
      OnClick = CheckBoxOnboardingChineseClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1232
    Height = 136
    Align = alTop
    BevelOuter = bvNone
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    Visible = False
    ExplicitWidth = 1228
    object ShapeFrame3: TShape
      Left = 856
      Top = 16
      Width = 360
      Height = 112
      Brush.Style = bsClear
      Pen.Color = clSilver
      Shape = stRoundRect
    end
    object ShapeFrame2: TShape
      Left = 656
      Top = 16
      Width = 184
      Height = 112
      Brush.Style = bsClear
      Pen.Color = clSilver
      Shape = stRoundRect
    end
    object ShapeFrame1: TShape
      Left = 16
      Top = 16
      Width = 625
      Height = 112
      Brush.Style = bsClear
      Pen.Color = clSilver
      Shape = stRoundRect
    end
    object Shape1: TShape
      Tag = 1
      Left = 24
      Top = 24
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
      Top = 24
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
      Top = 24
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
      Top = 24
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
      Top = 24
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
      Top = 24
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
      Top = 24
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
      Left = 664
      Top = 24
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Shape9: TShape
      Tag = 9
      Left = 752
      Top = 24
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
      Left = 864
      Top = 24
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
      Left = 1040
      Top = 24
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
      Left = 1128
      Top = 24
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
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image12: TImage
      Left = 1136
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image8: TImage
      Left = 672
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image2: TImage
      Left = 120
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image3: TImage
      Left = 208
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image4: TImage
      Left = 296
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image5: TImage
      Left = 384
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image6: TImage
      Left = 472
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image7: TImage
      Left = 560
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image9: TImage
      Left = 760
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image11: TImage
      Left = 1048
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Image10: TImage
      Left = 872
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Label1: TLabel
      Left = 24
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'FC List'
    end
    object Label12: TLabel
      Left = 1128
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'UI Editor'
    end
    object Label8: TLabel
      Left = 664
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'My ROMs'
    end
    object Label9: TLabel
      Left = 752
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Favorites'
    end
    object Label2: TLabel
      Left = 112
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'PCE List'
    end
    object Label3: TLabel
      Left = 200
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'SFC List'
    end
    object Label4: TLabel
      Left = 288
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'MD List'
    end
    object Label5: TLabel
      Left = 376
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GB List'
    end
    object Label6: TLabel
      Left = 464
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GBC List'
    end
    object Label7: TLabel
      Left = 552
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'GBA List'
    end
    object Label10: TLabel
      Left = 864
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'BIOS && Device'
    end
    object Label11: TLabel
      Left = 1040
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Keys'
    end
    object Shape13: TShape
      Tag = 13
      Left = 952
      Top = 24
      Width = 80
      Height = 96
      Pen.Color = clSilver
      Shape = stRoundRect
      OnMouseDown = ShapeMouseUp
      OnMouseEnter = ShapeMouseEnter
      OnMouseLeave = ShapeMouseLeave
    end
    object Image13: TImage
      Left = 960
      Top = 32
      Width = 64
      Height = 64
      Enabled = False
      Stretch = True
    end
    object Label13: TLabel
      Left = 952
      Top = 99
      Width = 80
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'multicore'
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
  end
  object ImageListCheckResults: TImageList
    ColorDepth = cd32Bit
    Left = 216
    Top = 400
  end
end
