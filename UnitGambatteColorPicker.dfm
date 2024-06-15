object FrameGambatteColorPicker: TFrameGambatteColorPicker
  Left = 0
  Top = 0
  Width = 752
  Height = 26
  TabOrder = 0
  object LabelDescriptionGambatte: TLabel
    Left = 0
    Top = 4
    Width = 217
    Height = 15
    Caption = 'Preview for Background/Sprite 1/Sprite 2:'
  end
  object Shape1: TShape
    Left = 224
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape2: TShape
    Left = 248
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape3: TShape
    Left = 272
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape4: TShape
    Left = 296
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape5: TShape
    Left = 324
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape6: TShape
    Left = 348
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape7: TShape
    Left = 372
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape8: TShape
    Left = 396
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape9: TShape
    Left = 424
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape10: TShape
    Left = 448
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape11: TShape
    Left = 472
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object Shape12: TShape
    Left = 496
    Top = 0
    Width = 23
    Height = 23
    OnMouseUp = ShapeMouseUp
  end
  object LabelHint: TLabel
    Left = 527
    Top = 4
    Width = 135
    Height = 15
    Caption = 'Click colors to customize.'
  end
  object LabelDescriptionNonGambatte: TLabel
    Left = 0
    Top = 4
    Width = 189
    Height = 15
    Caption = 'Palette preview (left = background):'
  end
  object ColorDialog: TColorDialog
    Left = 24
  end
end
