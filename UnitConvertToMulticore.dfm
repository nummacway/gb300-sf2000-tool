object FormConvertToMulticore: TFormConvertToMulticore
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Convert WQW to multicore'
  ClientHeight = 304
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label8: TLabel
    Left = 8
    Top = 8
    Width = 442
    Height = 15
    Caption = 
      'GBA is the only platform to profit from multicore, thanks to dyn' +
      'amic recompilation.'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 31
    Width = 448
    Height = 209
    Caption = 'Emulator Mapping'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 95
      Height = 15
      Caption = 'Family Computer:'
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 86
      Height = 15
      Caption = 'Super Famicom:'
    end
    object Label3: TLabel
      Left = 8
      Top = 68
      Width = 63
      Height = 15
      Caption = 'Mega Drive:'
    end
    object Label4: TLabel
      Left = 8
      Top = 92
      Width = 93
      Height = 15
      Caption = 'Dot Matrix Game:'
    end
    object Label5: TLabel
      Left = 8
      Top = 116
      Width = 89
      Height = 15
      Caption = 'Color Game Boy:'
    end
    object Label6: TLabel
      Left = 8
      Top = 140
      Width = 106
      Height = 15
      Caption = 'Advance Game Boy:'
    end
    object Label7: TLabel
      Left = 8
      Top = 164
      Width = 57
      Height = 15
      Caption = 'PC Engine:'
    end
    object LabelStateInfo: TLabel
      Left = 8
      Top = 186
      Width = 421
      Height = 15
      Caption = 
        'States can be kept for: Picodrive, TGB Dual, DoublecherryGB, Med' +
        'nafen PCE Fast'
    end
    object ComboBoxFC: TComboBox
      Left = 136
      Top = 16
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
    object ComboBoxSFC: TComboBox
      Left = 136
      Top = 40
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 1
    end
    object ComboBoxMD: TComboBox
      Left = 136
      Top = 64
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 2
      OnChange = ComboBoxMDChange
    end
    object ComboBoxDMG: TComboBox
      Left = 136
      Top = 88
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 3
      OnChange = ComboBoxDMGChange
    end
    object ComboBoxCGB: TComboBox
      Left = 136
      Top = 112
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 4
      OnChange = ComboBoxCGBChange
    end
    object ComboBoxAGB: TComboBox
      Left = 136
      Top = 136
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 5
    end
    object ComboBoxPCE: TComboBox
      Left = 136
      Top = 160
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 6
      OnChange = ComboBoxPCEChange
    end
    object CheckBoxStatesMD: TCheckBox
      Left = 288
      Top = 64
      Width = 152
      Height = 23
      Caption = 'Convert my save states'
      TabOrder = 7
    end
    object CheckBoxStatesDMG: TCheckBox
      Left = 288
      Top = 88
      Width = 152
      Height = 23
      Caption = 'Convert my save states'
      TabOrder = 8
    end
    object CheckBoxStatesCGB: TCheckBox
      Left = 288
      Top = 112
      Width = 152
      Height = 23
      Caption = 'Convert my save states'
      TabOrder = 9
    end
    object CheckBoxStatesPCE: TCheckBox
      Left = 288
      Top = 160
      Width = 152
      Height = 23
      Caption = 'Convert my save states'
      TabOrder = 10
    end
  end
  object ButtonOK: TButton
    Left = 156
    Top = 272
    Width = 72
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object ButtonCancel: TButton
    Left = 236
    Top = 272
    Width = 72
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object CheckBoxDeleteOldStates: TCheckBox
    Left = 232
    Top = 248
    Width = 224
    Height = 16
    Caption = 'Delete states that are no longer used'
    TabOrder = 4
  end
  object CheckBoxDeleteOldROMs: TCheckBox
    Left = 8
    Top = 248
    Width = 224
    Height = 16
    Caption = 'Delete successfully-converted WQWs'
    TabOrder = 3
    OnClick = CheckBoxDeleteOldROMsClick
  end
end
