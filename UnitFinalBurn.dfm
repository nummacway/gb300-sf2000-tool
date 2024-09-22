object FormFinalBurn: TFormFinalBurn
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Add FBA ROM'
  ClientHeight = 284
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 31
    Width = 412
    Height = 15
    Caption = 
      'This is the seventh stock list. ZIP files you place here must be' +
      ' arcade ROM sets.'
  end
  object LabelFile: TLabel
    Left = 8
    Top = 8
    Width = 21
    Height = 15
    Caption = 'File:'
  end
  object LabelFileName: TLabel
    Left = 40
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
  object GroupBoxZIPFileName: TGroupBox
    Left = 8
    Top = 79
    Width = 416
    Height = 94
    Caption = 'Where to Place the ROM Set'
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 358
      Height = 15
      Caption = 
        'Enter an optional subfolder if there'#39's a conflict (yellow backgr' +
        'ound).'
    end
    object LabelBin: TLabel
      Left = 8
      Top = 42
      Width = 22
      Height = 15
      Caption = 'bin/'
    end
    object LabelSlash: TLabel
      Left = 207
      Top = 42
      Width = 5
      Height = 15
      Caption = '/'
    end
    object Label5: TLabel
      Left = 389
      Top = 42
      Width = 18
      Height = 15
      Caption = '.zip'
    end
    object Label7: TLabel
      Left = 8
      Top = 70
      Width = 312
      Height = 15
      Caption = 'Do not rename the ZIP unless you know what you'#39're doing.'
    end
    object EditFolder: TEdit
      Left = 33
      Top = 39
      Width = 169
      Height = 23
      TabOrder = 0
      OnChange = EditFileNameChange
    end
    object EditZIPFileName: TEdit
      Left = 216
      Top = 39
      Width = 169
      Height = 23
      TabOrder = 1
      OnChange = EditFileNameChange
    end
  end
  object CheckBoxZFB: TCheckBox
    Left = 8
    Top = 55
    Width = 416
    Height = 16
    Caption = 
      'Create ZFB (to add thumbnail, set display name and avoid conflic' +
      'ts)'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = CheckBoxZFBClick
  end
  object GroupBoxDisplayName: TGroupBox
    Left = 8
    Top = 181
    Width = 416
    Height = 63
    Caption = 'How to Access the ROM Set'
    TabOrder = 1
    object Label6: TLabel
      Left = 8
      Top = 16
      Width = 112
      Height = 15
      Caption = 'Enter a display name:'
    end
    object Label9: TLabel
      Left = 389
      Top = 35
      Width = 19
      Height = 15
      Caption = '.zfb'
    end
    object EditZFBFileName: TEdit
      Left = 8
      Top = 32
      Width = 377
      Height = 23
      TabOrder = 0
      OnChange = EditZFBFileNameChange
    end
  end
  object ButtonCancel: TButton
    Left = 180
    Top = 252
    Width = 72
    Height = 24
    Cancel = True
    Caption = 'Skip File'
    ModalResult = 5
    TabOrder = 4
  end
  object ButtonMulticore: TButton
    Left = 8
    Top = 252
    Width = 72
    Height = 24
    Caption = 'Multicore...'
    ModalResult = 12
    TabOrder = 2
  end
  object ButtonOK: TButton
    Left = 100
    Top = 252
    Width = 72
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object ButtonAbort: TButton
    Left = 260
    Top = 252
    Width = 72
    Height = 24
    Caption = 'Abort All'
    ModalResult = 3
    TabOrder = 5
  end
end
