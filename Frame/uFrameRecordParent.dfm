inherited FrameRecordParent: TFrameRecordParent
  Width = 532
  Height = 493
  object pnlButton: TPanel
    Left = 0
    Top = 0
    Width = 532
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnSave: TSpeedButton
      Left = 40
      Top = 0
      Width = 40
      Height = 35
      Action = actSave
      Align = alLeft
      Flat = True
    end
    object btnacCancel: TSpeedButton
      Left = 0
      Top = 0
      Width = 40
      Height = 35
      Action = acCancel
      Align = alLeft
      Flat = True
    end
  end
  object ActionList: TActionList
    Images = DModule.ImageList
    Left = 16
    Top = 56
    object actSave: TAction
      ImageIndex = 0
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object acCancel: TAction
      ImageIndex = 2
      OnExecute = acCancelExecute
      OnUpdate = acCancelUpdate
    end
  end
end
