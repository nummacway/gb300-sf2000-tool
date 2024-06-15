object FormPerGameCoreConfig: TFormPerGameCoreConfig
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #39'%s'#39' Core Configuration for '#39'%s'#39
  ClientHeight = 544
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    800
    544)
  TextHeight = 15
  object PanelFrameParent: TPanel
    Left = 8
    Top = 8
    Width = 784
    Height = 496
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 704
    ExplicitHeight = 432
  end
  object PanelButtons: TPanel
    Left = 284
    Top = 512
    Width = 232
    Height = 24
    Anchors = [akBottom]
    BevelOuter = bvNone
    Caption = 'PanelButtons'
    TabOrder = 1
    ExplicitLeft = 244
    ExplicitTop = 448
    object ButtonCancel: TButton
      Left = 160
      Top = 0
      Width = 72
      Height = 24
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object ButtonDelete: TButton
      Left = 80
      Top = 0
      Width = 72
      Height = 24
      Caption = 'Delete'
      ModalResult = 3
      TabOrder = 1
    end
    object ButtonOK: TButton
      Left = 0
      Top = 0
      Width = 72
      Height = 24
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
  end
end
