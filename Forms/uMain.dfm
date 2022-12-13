inherited FormMain: TFormMain
  Caption = #1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' '#1084#1077#1076#1082#1072#1088#1090
  ClientHeight = 565
  ClientWidth = 972
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 972
    Height = 565
    ActivePage = tsList
    object tsList: TTabSheet
      Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1082#1072#1088#1090#1086#1095#1077#1082
      object pnlTool: TPanel
        Left = 0
        Top = 0
        Width = 964
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnOpen: TSpeedButton
          Left = 0
          Top = 0
          Width = 40
          Height = 41
          Action = actOpen
          Align = alLeft
          Flat = True
        end
        object btnCreate: TSpeedButton
          Left = 40
          Top = 0
          Width = 40
          Height = 41
          Action = actCreate
          Align = alLeft
          Flat = True
        end
        object btnDelete: TSpeedButton
          Left = 80
          Top = 0
          Width = 40
          Height = 41
          Action = actDelete
          Align = alLeft
          Flat = True
        end
        object btnSerch: TSpeedButton
          Left = 120
          Top = 0
          Width = 40
          Height = 41
          Action = actSerch
          Align = alLeft
          Flat = True
        end
      end
      inline FrameCardList: TFrameCardList
        Left = 0
        Top = 41
        Width = 964
        Height = 496
        Align = alClient
        TabOrder = 1
        inherited dbGrid: TDBGridEh
          Width = 964
          Height = 496
        end
        inherited dSetCardList: TpFIBDataSet
          SelectSQL.Strings = (
            'SELECT'
            '  ID, SURNAME, NAME, MIDDLENAME, BIRTHDATE, GENDER, PHONE, JOB,'
            ' ADDRESS, EMAIL'
            'FROM CARDS'
            'ORDER BY SURNAME, NAME')
        end
      end
    end
  end
  object ActionList: TActionList
    Images = DModule.ImageList
    Left = 48
    Top = 328
    object actOpen: TAction
      ImageIndex = 4
      OnExecute = actOpenExecute
    end
    object actCreate: TAction
      ImageIndex = 1
      OnExecute = actCreateExecute
    end
    object actDelete: TAction
      ImageIndex = 3
      OnExecute = actDeleteExecute
    end
    object actSerch: TAction
      ImageIndex = 5
      OnExecute = actSerchExecute
    end
  end
end
