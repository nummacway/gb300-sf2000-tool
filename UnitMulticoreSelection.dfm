object FormMulticoreSelection: TFormMulticoreSelection
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Select multicore Core'
  ClientHeight = 320
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object LabelFile: TLabel
    Left = 8
    Top = 8
    Width = 34
    Height = 15
    Caption = 'File(s):'
  end
  object LabelFileName: TLabel
    Left = 48
    Top = 8
    Width = 81
    Height = 15
    Caption = 'LabelFileName'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelRecommendedCore: TLabel
    Left = 8
    Top = 32
    Width = 28
    Height = 15
    Caption = 'Core:'
  end
  object LabelBIOS: TLabel
    Left = 8
    Top = 104
    Width = 422
    Height = 15
    Caption = 
      'BIOS files required by this core for this file extension (recomm' +
      'ended cores only):'
  end
  object LabelAnyCore: TLabel
    Left = 150
    Top = 32
    Width = 322
    Height = 15
    Alignment = taRightJustify
    Caption = '[+] = known to work and claims to support this file extension'
  end
  object Label1: TLabel
    Left = 8
    Top = 265
    Width = 459
    Height = 15
    Caption = 
      'You can get blueMSX'#39's BIOS files from its website (full install)' +
      '. Ask Google for all others.'
  end
  object CheckBoxAlwaysUseThisCore: TCheckBox
    Left = 8
    Top = 76
    Width = 464
    Height = 16
    Caption = 
      'Always use this core for this extension (can be disabled in the ' +
      #39'multicore'#39' tab)'
    TabOrder = 1
  end
  object ListViewBIOS: TListView
    Left = 8
    Top = 120
    Width = 464
    Height = 144
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
    TabOrder = 2
    ViewStyle = vsReport
  end
  object ButtonOK: TButton
    Left = 84
    Top = 288
    Width = 72
    Height = 24
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object ButtonSkip: TButton
    Left = 244
    Top = 288
    Width = 72
    Height = 24
    Caption = 'Skip File'
    ModalResult = 5
    TabOrder = 5
  end
  object ComboBoxAnyCore: TComboBox
    Left = 8
    Top = 48
    Width = 464
    Height = 23
    Style = csDropDownList
    TabOrder = 0
    OnSelect = ComboBoxAnyCoreSelect
  end
  object ButtonCopyOnly: TButton
    Left = 164
    Top = 288
    Width = 72
    Height = 24
    Caption = 'Copy Only'
    Enabled = False
    ModalResult = 7
    TabOrder = 4
  end
  object ButtonAbort: TButton
    Left = 324
    Top = 288
    Width = 72
    Height = 24
    Caption = 'Abort All'
    ModalResult = 3
    TabOrder = 6
  end
  object TimerLazyPrepare: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerLazyPrepareTimer
    Left = 376
    Top = 16
  end
end
