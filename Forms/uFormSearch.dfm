object FormSearch: TFormSearch
  Left = 0
  Top = 0
  Caption = #1055#1086#1080#1089#1082' '#1082#1072#1088#1090#1086#1095#1082#1080
  ClientHeight = 533
  ClientWidth = 906
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  inline FrameCardList: TFrameCardList
    Left = 0
    Top = 98
    Width = 906
    Height = 435
    Align = alClient
    TabOrder = 0
    inherited dbGrid: TDBGridEh
      Width = 906
      Height = 435
    end
    inherited dSetCardList: TpFIBDataSet
      RefreshSQL.Strings = (
        '')
      SelectSQL.Strings = (
        'SELECT'
        
          '  ID, SURNAME, NAME, MIDDLENAME, BIRTHDATE, GENDER, PHONE, JOB, ' +
          'EMAIL, ADDRESS'
        'FROM SEARCHCARD(:SURNAME, :NAME, :MIDDLENAME, :PHONE, :EMAIL)')
      AllowedUpdateKinds = []
    end
  end
  object pnlFindRec: TPanel
    Left = 0
    Top = 0
    Width = 906
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblSURNAME: TLabel
      Left = 6
      Top = 7
      Width = 44
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103
    end
    object lblNAME: TLabel
      Left = 176
      Top = 8
      Width = 19
      Height = 13
      Caption = #1048#1084#1103
    end
    object lblMIDDLENAME: TLabel
      Left = 345
      Top = 7
      Width = 49
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    end
    object lblPHONE: TLabel
      Left = 514
      Top = 7
      Width = 44
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
    end
    object lblEMAIL: TLabel
      Left = 685
      Top = 7
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object lblAnd1: TLabel
      Left = 163
      Top = 26
      Width = 6
      Height = 13
      Caption = #1080
    end
    object lblAnd2: TLabel
      Left = 331
      Top = 26
      Width = 6
      Height = 13
      Caption = #1080
    end
    object lblAnd3: TLabel
      Left = 501
      Top = 26
      Width = 6
      Height = 13
      Caption = #1080
    end
    object lblAnd4: TLabel
      Left = 671
      Top = 26
      Width = 6
      Height = 13
      Caption = #1080
    end
    object edtSURNAME: TEdit
      Left = 6
      Top = 23
      Width = 150
      Height = 21
      TabOrder = 0
      OnKeyDown = edtSURNAMEKeyDown
    end
    object edtNAME: TEdit
      Left = 176
      Top = 24
      Width = 150
      Height = 21
      TabOrder = 1
      OnKeyDown = edtSURNAMEKeyDown
    end
    object edtMIDDLENAME: TEdit
      Left = 345
      Top = 23
      Width = 150
      Height = 21
      TabOrder = 2
      OnKeyDown = edtSURNAMEKeyDown
    end
    object edtPHONE: TEdit
      Left = 513
      Top = 23
      Width = 150
      Height = 21
      TabOrder = 3
      OnKeyDown = edtSURNAMEKeyDown
    end
    object edtEMAIL: TEdit
      Left = 685
      Top = 23
      Width = 150
      Height = 21
      TabOrder = 4
      OnKeyDown = edtSURNAMEKeyDown
    end
  end
  object pnlButton: TPanel
    Left = 0
    Top = 57
    Width = 906
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnOpen: TSpeedButton
      Left = 80
      Top = 0
      Width = 40
      Height = 41
      Action = actOpen
      Align = alLeft
      Flat = True
    end
    object btnCancel: TSpeedButton
      Left = 40
      Top = 0
      Width = 40
      Height = 41
      Action = actCancel
      Align = alLeft
      Flat = True
    end
    object btnSerch: TSpeedButton
      Left = 0
      Top = 0
      Width = 40
      Height = 41
      Action = actSerch
      Align = alLeft
      Flat = True
    end
  end
  object ActionList: TActionList
    Images = DModule.ImageList
    Left = 352
    Top = 216
    object actSerch: TAction
      ImageIndex = 5
      OnExecute = actSerchExecute
      OnUpdate = actSerchUpdate
    end
    object actCancel: TAction
      ImageIndex = 2
      OnExecute = actCancelExecute
      OnUpdate = actCancelUpdate
    end
    object actOpen: TAction
      ImageIndex = 4
      OnExecute = actOpenExecute
      OnUpdate = actOpenUpdate
    end
  end
end
