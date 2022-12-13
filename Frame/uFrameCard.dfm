inherited FrameCard: TFrameCard
  Width = 560
  Height = 261
  inherited pnlButton: TPanel
    Width = 560
    Height = 40
    inherited btnSave: TSpeedButton
      Height = 40
    end
    inherited btnacCancel: TSpeedButton
      Height = 40
    end
  end
  object pnlClientData: TPanel [1]
    Left = 0
    Top = 40
    Width = 560
    Height = 221
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lblADDRESS: TLabel
      Left = 16
      Top = 106
      Width = 96
      Height = 13
      Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1078#1080#1074#1072#1088#1080#1103
    end
    object lblBIRTHDATE: TLabel
      Left = 16
      Top = 57
      Width = 80
      Height = 13
      Caption = #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
    end
    object lblEMAIL: TLabel
      Left = 231
      Top = 160
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object lblGENDER: TLabel
      Left = 184
      Top = 57
      Width = 19
      Height = 13
      Caption = #1055#1086#1083
    end
    object lblJOB: TLabel
      Left = 280
      Top = 110
      Width = 72
      Height = 13
      Caption = #1052#1077#1089#1090#1086' '#1088#1072#1073#1086#1090#1099
    end
    object lblMIDDLENAME: TLabel
      Left = 352
      Top = 8
      Width = 49
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    end
    object lblNAME: TLabel
      Left = 184
      Top = 8
      Width = 19
      Height = 13
      Caption = #1048#1084#1103
    end
    object lblPHONE: TLabel
      Left = 16
      Top = 160
      Width = 44
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
    end
    object lblSURNAME: TLabel
      Left = 16
      Top = 8
      Width = 44
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103
    end
    object dbedtSURNAME: TDBEdit
      Left = 16
      Top = 24
      Width = 150
      Height = 21
      DataField = 'SURNAME'
      DataSource = dsRecord
      TabOrder = 0
    end
    object dtpBIRTHDATE: TDateTimePicker
      Left = 16
      Top = 77
      Width = 150
      Height = 21
      Date = 44855.387616828700000000
      Time = 44855.387616828700000000
      TabOrder = 3
      OnCloseUp = dtpBIRTHDATECloseUp
    end
    object dbedtNAME: TDBEdit
      Left = 184
      Top = 24
      Width = 150
      Height = 21
      DataField = 'NAME'
      DataSource = dsRecord
      TabOrder = 1
    end
    object dbedtPHONE: TDBEdit
      Left = 16
      Top = 175
      Width = 201
      Height = 21
      DataField = 'PHONE'
      DataSource = dsRecord
      TabOrder = 7
    end
    object dbedtEMAIL: TDBEdit
      Left = 231
      Top = 175
      Width = 201
      Height = 21
      DataField = 'EMAIL'
      DataSource = dsRecord
      TabOrder = 8
    end
    object dbedtJOB: TDBEdit
      Left = 280
      Top = 125
      Width = 249
      Height = 21
      DataField = 'JOB'
      DataSource = dsRecord
      TabOrder = 6
    end
    object dbedtMIDDLENAME: TDBEdit
      Left = 352
      Top = 24
      Width = 150
      Height = 21
      DataField = 'MIDDLENAME'
      DataSource = dsRecord
      TabOrder = 2
    end
    object dbedtADDRESS: TDBEdit
      Left = 16
      Top = 125
      Width = 249
      Height = 21
      DataField = 'ADDRESS'
      DataSource = dsRecord
      TabOrder = 5
    end
    object dbedtGENDER: TDBEdit
      Left = 184
      Top = 77
      Width = 150
      Height = 21
      DataField = 'GENDER'
      DataSource = dsRecord
      TabOrder = 4
    end
  end
  inherited ActionList: TActionList
    Left = 376
    Top = 9
  end
  object dsRecord: TDataSource
    DataSet = dsetRecord
    Left = 250
    Top = 10
  end
  object dsetRecord: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE CARDS'
      'SET SURNAME = :SURNAME,'
      '    NAME = :NAME,'
      '    MIDDLENAME = :MIDDLENAME,'
      '    BIRTHDATE = :BIRTHDATE,'
      '    GENDER = :GENDER,'
      '    PHONE = :PHONE,'
      '    JOB = :JOB,'
      '    EMAIL = :EMAIL,'
      '    ADDRESS = :ADDRESS'
      'WHERE ID = :CARD_ID')
    InsertSQL.Strings = (
      
        'INSERT INTO CARDS (ID, SURNAME, NAME, MIDDLENAME, BIRTHDATE, GEN' +
        'DER, PHONE, JOB, EMAIL, ADDRESS)'
      
        'VALUES (:CARD_ID, :SURNAME, :NAME, :MIDDLENAME, :BIRTHDATE, :GEN' +
        'DER, :PHONE, :JOB, :EMAIL, :ADDRESS);')
    SelectSQL.Strings = (
      'SELECT'
      
        '  ID, SURNAME, NAME, MIDDLENAME, BIRTHDATE, GENDER, PHONE, JOB, ' +
        'EMAIL, ADDRESS'
      'FROM CARDS'
      'WHERE'
      '  ID = :CARD_ID')
    Transaction = DModule.DefaultTrans
    Database = DModule.BASE
    Left = 312
    Top = 10
    object dsetRecordID: TFIBIntegerField
      FieldName = 'ID'
    end
    object dsetRecordSURNAME: TFIBStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      DisplayWidth = 24
      FieldName = 'SURNAME'
      Size = 300
      EmptyStrToNull = True
    end
    object dsetRecordNAME: TFIBStringField
      DisplayLabel = #1048#1084#1103
      DisplayWidth = 24
      FieldName = 'NAME'
      Size = 300
      EmptyStrToNull = True
    end
    object dsetRecordMIDDLENAME: TFIBStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      DisplayWidth = 24
      FieldName = 'MIDDLENAME'
      Size = 300
      EmptyStrToNull = True
    end
    object dsetRecordBIRTHDATE: TFIBDateField
      DisplayLabel = #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
      DisplayWidth = 14
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object dsetRecordGENDER: TFIBStringField
      DisplayLabel = #1055#1086#1083
      DisplayWidth = 9
      FieldName = 'GENDER'
      Size = 50
      EmptyStrToNull = True
    end
    object dsetRecordPHONE: TFIBStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 19
      FieldName = 'PHONE'
      Size = 50
      EmptyStrToNull = True
    end
    object dsetRecordJOB: TFIBStringField
      DisplayLabel = #1052#1077#1089#1090#1086' '#1088#1072#1073#1086#1090#1099
      DisplayWidth = 24
      FieldName = 'JOB'
      Size = 300
      EmptyStrToNull = True
    end
    object dsetRecordADDRESS: TFIBStringField
      FieldName = 'ADDRESS'
      Size = 300
      EmptyStrToNull = True
    end
    object dsetRecordEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 300
      EmptyStrToNull = True
    end
  end
end
