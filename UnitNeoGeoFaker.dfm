object FormNeoGeoFaker: TFormNeoGeoFaker
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Neo Geo ROM Faker'
  ClientHeight = 563
  ClientWidth = 1060
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 1020
    Height = 15
    Caption = 
      'This tool makes any Neo Geo set'#39's ZIP name, ROM names and ROM si' +
      'zes match those of '#39'kof98n'#39' or '#39'garoup'#39', tricking FBA into loadi' +
      'ng it (or at least trying to, as some just don'#39't work and freeze' +
      ').'
  end
  object Label2: TLabel
    Left = 8
    Top = 23
    Width = 1027
    Height = 15
    Caption = 
      'Of the 256 sets known by the stock emulator, '#39'kof98n'#39' and '#39'garou' +
      'p'#39' are the largest sets without Init core. Any Init code is set-' +
      'specific and would break almost any other set, except for clones' +
      '/hacks.'
  end
  object Label3: TLabel
    Left = 8
    Top = 68
    Width = 1039
    Height = 15
    Caption = 
      'Despite being identical to '#39'garoup'#39', '#39'kof98n'#39' often causes weird' +
      ' issues if used as a "host" ROM, so '#39'garoup'#39' became the default.' +
      ' Don'#39't worry about exceeding M- and S-ROM size '#8211' they'#39're overdum' +
      'ps.'
  end
  object Label4: TLabel
    Left = 8
    Top = 89
    Width = 1038
    Height = 15
    Caption = 
      'Load a non-merged FBNeo ROM set ZIP file. The tool knows the set' +
      'tings for all working FBNeo sets and will arrange them according' +
      'ly by using the ROMs'#39' CRC32. You can still arrange them yourself' +
      '.'
  end
  object Label6: TLabel
    Left = 8
    Top = 509
    Width = 144
    Height = 15
    Caption = 'Character ROM load mode:'
  end
  object Label7: TLabel
    Left = 412
    Top = 509
    Width = 619
    Height = 15
    Caption = 
      'Even-Odd is by far the most common. Quad is used only by alpham2' +
      'p. Progressive is for sets without actual graphics.'
  end
  object Label5: TLabel
    Left = 8
    Top = 104
    Width = 1002
    Height = 15
    Caption = 
      'Go to the seventh static list (usually ARCADE) in GB300 Tool and' +
      ' drop (or otherwise add) the created file there. Enter a subfold' +
      'er to avoid conflicts caused by faked sets sharing the same name' +
      '.'
  end
  object Label8: TLabel
    Left = 8
    Top = 483
    Width = 139
    Height = 15
    Caption = 'Program ROM load mode:'
  end
  object Label9: TLabel
    Left = 412
    Top = 483
    Width = 643
    Height = 15
    Caption = 
      'Progressive is by far the most common. Many sets with 2 MiB P lo' +
      'ad the last 1 MiB first. Seven prototypes use interleaving.'
  end
  object Label10: TLabel
    Left = 8
    Top = 53
    Width = 1050
    Height = 15
    Caption = 
      'Because some games require more P-ROM than said two sets, GB300 ' +
      'Tool'#39's BIOS tab can patch the stock emulator to expect a larger ' +
      'P-ROM for sets called '#39'garoup'#39'. The actual set doesn'#39't load anyw' +
      'ay.'
  end
  object Label11: TLabel
    Left = 8
    Top = 535
    Width = 118
    Height = 15
    Caption = 'Make output look like:'
  end
  object Label12: TLabel
    Left = 8
    Top = 38
    Width = 1036
    Height = 15
    Caption = 
      'Sets without Init code however can be forced into another set wi' +
      'thout such code, as long as it allocates enough memory. For ROMs' +
      ' that require Init code, there are often clones that don'#39't ('#39'fd'#39 +
      ', '#39'nd'#39').'
  end
  object Label13: TLabel
    Left = 712
    Top = 535
    Width = 56
    Height = 15
    Caption = 'Compress:'
  end
  object GroupBoxP: TGroupBox
    Left = 536
    Top = 232
    Width = 256
    Height = 136
    Caption = 'Program (0 / 5120 KiB)'
    TabOrder = 1
    object ListViewP: TListView
      Tag = 2
      Left = 8
      Top = 16
      Width = 240
      Height = 112
      Columns = <
        item
          Caption = 'File Name'
          Width = 144
        end
        item
          Alignment = taRightJustify
          Caption = 'Size'
          Width = 64
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ViewStyle = vsReport
      OnDragDrop = ListViewDragDrop
      OnDragOver = ListViewDragOver
      OnKeyDown = ListViewKeyDown
      OnStartDrag = ListViewStartDrag
    end
  end
  object GroupBoxM: TGroupBox
    Left = 536
    Top = 128
    Width = 256
    Height = 96
    Caption = 'Music (0 / 256 KiB)'
    TabOrder = 2
    object ListViewM: TListView
      Tag = 1
      Left = 8
      Top = 16
      Width = 240
      Height = 72
      Columns = <
        item
          Caption = 'File Name'
          Width = 144
        end
        item
          Alignment = taRightJustify
          Caption = 'Size'
          Width = 64
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ViewStyle = vsReport
      OnDragDrop = ListViewDragDrop
      OnDragOver = ListViewDragOver
      OnKeyDown = ListViewKeyDown
      OnStartDrag = ListViewStartDrag
    end
  end
  object GroupBoxS: TGroupBox
    Left = 536
    Top = 376
    Width = 256
    Height = 96
    Caption = 'Strings (0 / 128 KiB)'
    TabOrder = 3
    object ListViewS: TListView
      Tag = 3
      Left = 8
      Top = 16
      Width = 240
      Height = 72
      Columns = <
        item
          Caption = 'File Name'
          Width = 144
        end
        item
          Alignment = taRightJustify
          Caption = 'Size'
          Width = 64
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ViewStyle = vsReport
      OnDragDrop = ListViewDragDrop
      OnDragOver = ListViewDragOver
      OnKeyDown = ListViewKeyDown
      OnStartDrag = ListViewStartDrag
    end
  end
  object GroupBoxV: TGroupBox
    Left = 800
    Top = 128
    Width = 256
    Height = 344
    Caption = 'Voice (0 / 16384 KiB)'
    TabOrder = 4
    object ListViewV: TListView
      Tag = 4
      Left = 8
      Top = 16
      Width = 240
      Height = 320
      Columns = <
        item
          Caption = 'File Name'
          Width = 144
        end
        item
          Alignment = taRightJustify
          Caption = 'Size'
          Width = 64
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ViewStyle = vsReport
      OnDragDrop = ListViewDragDrop
      OnDragOver = ListViewDragOver
      OnKeyDown = ListViewKeyDown
      OnStartDrag = ListViewStartDrag
    end
  end
  object GroupBoxC: TGroupBox
    Left = 272
    Top = 128
    Width = 256
    Height = 344
    Caption = 'Character (0 / 65536 KiB)'
    TabOrder = 5
    object ListViewC: TListView
      Left = 8
      Top = 16
      Width = 240
      Height = 320
      Columns = <
        item
          Caption = 'File Name'
          Width = 144
        end
        item
          Alignment = taRightJustify
          Caption = 'Size'
          Width = 64
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ViewStyle = vsReport
      OnDragDrop = ListViewDragDrop
      OnDragOver = ListViewDragOver
      OnKeyDown = ListViewKeyDown
      OnStartDrag = ListViewStartDrag
    end
  end
  object ComboBoxCharacterMode: TComboBox
    Left = 160
    Top = 506
    Width = 248
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 6
    Text = 'Even-Odd Interleaving (01, 23)'
    Items.Strings = (
      'Byte-Swapped Progressive'
      'Even-Odd Interleaving (01, 23)'
      'Quad Interleaving (1, 0, 3, 2)'
      'All First Halves, All Second Halves')
  end
  object ButtonExport: TButton
    Left = 976
    Top = 532
    Width = 80
    Height = 24
    Caption = 'Export...'
    Enabled = False
    TabOrder = 7
    OnClick = ButtonExportClick
  end
  object ButtonClear: TButton
    Left = 888
    Top = 532
    Width = 80
    Height = 24
    Caption = 'Clear Lists'
    TabOrder = 8
    OnClick = ButtonClearClick
  end
  object ComboBoxProgramMode: TComboBox
    Left = 160
    Top = 480
    Width = 248
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 9
    Text = 'Byte-Swapped Progressive'
    Items.Strings = (
      'Byte-Swapped Progressive'
      'Byte-Swapped Progressive (last 1 MiB first)'
      'Even-Odd Interleaving')
  end
  object ButtonParseDAT: TButton
    Left = 808
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Parse DAT'
    TabOrder = 10
    Visible = False
    OnClick = ButtonParseDATClick
  end
  object GroupBoxZIP: TGroupBox
    Left = 8
    Top = 128
    Width = 256
    Height = 344
    Caption = 'Available ROMs in ZIP File'
    TabOrder = 0
    object ListViewZIP: TListView
      Tag = 4
      Left = 8
      Top = 16
      Width = 240
      Height = 288
      Columns = <
        item
          Caption = 'File Name'
          Width = 144
        end
        item
          Alignment = taRightJustify
          Caption = 'Size'
          Width = 64
        end>
      DoubleBuffered = True
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 1
      ViewStyle = vsReport
      OnDragDrop = ListViewDragDrop
      OnDragOver = ListViewDragOver
      OnStartDrag = ListViewStartDrag
    end
    object ButtonOpen: TButton
      Left = 168
      Top = 312
      Width = 80
      Height = 24
      Caption = 'Open Input...'
      TabOrder = 0
      OnClick = ButtonOpenClick
    end
  end
  object ComboBoxOutputType: TComboBox
    Left = 160
    Top = 532
    Width = 536
    Height = 23
    Style = csDropDownList
    DropDownCount = 32
    ItemIndex = 0
    TabOrder = 11
    Text = 
      'garoup (unencrypted only, 9 MiB P-ROM patch must be enabled in B' +
      'IOS tab, best compatibility)'
    OnSelect = ComboBoxOutputTypeSelect
    Items.Strings = (
      
        'garoup (unencrypted only, 9 MiB P-ROM patch must be enabled in B' +
        'IOS tab, best compatibility)'
      
        'kof98n (unencrypted only, working out-of-the-box, unexplainable ' +
        'weird glitches for some sets)'
      
        'mslugx (related unencrypted clones with copy protection issues o' +
        'nly)'
      'garou (related encrypted clones only)'
      'jockeygp (related encrypted clones only)'
      'kof99 (related encrypted clones only)'
      'kof2003 (related encrypted clones only, no audio)'
      'matrim (related encrypted clones only, no audio)'
      'pnyaa (related encrypted clones only, no audio)'
      'rotd (related encrypted clones only, no audio)'
      'samsh5sp (related encrypted clones only, no audio)'
      'samsho5 (related encrypted clones only, no audio)'
      'ct2k3sa (related encrypted clones only, no known working sets)'
      'ct2k3sp (related encrypted clones only, no known working sets)'
      'cthd2003 (related encrypted clones only, no known working sets)'
      'kf10thep (related encrypted clones only, no known working sets)'
      'kf2k3bl (related encrypted clones only, no known working sets)'
      'kf2k3bla (related encrypted clones only, no known working sets)'
      'kf2k3pl (related encrypted clones only, no known working sets)'
      'kf2k5uni (related encrypted clones only, no known working sets)'
      'kof2000 (related encrypted clones only, no known working sets)'
      'kof2001 (related encrypted clones only, no known working sets)'
      'kof2002 (related encrypted clones only, no known working sets)'
      'ms5plus (related encrypted clones only, no known working sets)'
      'mslug3 (related encrypted clones only, no known working sets)'
      'mslug3b6 (related encrypted clones only, no known working sets)'
      'mslug3h (related encrypted clones only, no known working sets)'
      'mslug3hd (related encrypted clones only, no known working sets)'
      'mslug4 (related encrypted clones only, no known working sets)'
      'mslug5 (related encrypted clones only, no known working sets)'
      'sengoku3 (related encrypted clones only, no known working sets)'
      'svcboot (related encrypted clones only, no known working sets)')
  end
  object Panel1: TPanel
    Left = 292
    Top = 242
    Width = 480
    Height = 80
    BevelOuter = bvSpace
    Caption = 
      'Processing... (This can take up to half a minute for large sets ' +
      'at maximum compression.)'
    TabOrder = 12
    Visible = False
  end
  object ComboBoxCompressionLevel: TComboBox
    Left = 776
    Top = 532
    Width = 64
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 13
    Text = 'fastest'
    OnSelect = ComboBoxOutputTypeSelect
    Items.Strings = (
      'fastest'
      'default'
      'max')
  end
  object SaveDialog: TSaveDialog
    FileName = 'kof98n.zip'
    Filter = 
      'The King of Fighters '#39'98 - The Slugfest / King of Fighters '#39'98 -' +
      ' dream match never ends (not encrypted)|kof98n.zip'
    Left = 1000
    Top = 424
  end
  object OpenDialogXML: TOpenDialog
    Filter = 'DAT|*.dat'
    Left = 840
    Top = 424
  end
  object OpenDialog: TOpenDialog
    Filter = 'Final Burn Neo Non-Merged ROM Sets|*.zip'
    Left = 200
    Top = 384
  end
end
