inherited FrameCardList: TFrameCardList
  Width = 903
  Height = 432
  object dbGrid: TDBGridEh
    Left = 0
    Top = 0
    Width = 903
    Height = 432
    Align = alClient
    DataSource = dSourceCardList
    DynProps = <>
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghIncSearch, dghDialogFind, dghExtendVertLines]
    SearchPanel.FilterOnTyping = True
    SortLocal = True
    STFilter.InstantApply = False
    TabOrder = 0
    TitleParams.SortMarkerStyle = smstDefaultEh
    OnDblClick = dbGridDblClick
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Visible = False
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SURNAME'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'MIDDLENAME'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'BIRTHDATE'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'GENDER'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PHONE'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'JOB'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object dSetCardList: TpFIBDataSet
    RefreshSQL.Strings = (
      'SELECT'
      
        '  ID, SURNAME, NAME, MIDDLENAME, BIRTHDATE, GENDER, PHONE, JOB, ' +
        'ADDRESS, EMAIL'
      'FROM CARDS'
      'WHERE'
      '  ID = :OLD_ID')
    SelectSQL.Strings = (
      'SELECT'
      '  ID, SURNAME, NAME, MIDDLENAME, BIRTHDATE, GENDER, PHONE, JOB,'
      ' ADDRESS, EMAIL'
      'FROM CARDS')
    Transaction = DModule.DefaultTrans
    Database = DModule.BASE
    Left = 40
    Top = 136
    object dSetCardListID: TFIBIntegerField
      FieldName = 'ID'
    end
    object dSetCardListSURNAME: TFIBStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      DisplayWidth = 24
      FieldName = 'SURNAME'
      Size = 300
      EmptyStrToNull = True
    end
    object dSetCardListNAME: TFIBStringField
      DisplayLabel = #1048#1084#1103
      DisplayWidth = 24
      FieldName = 'NAME'
      Size = 300
      EmptyStrToNull = True
    end
    object dSetCardListMIDDLENAME: TFIBStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      DisplayWidth = 24
      FieldName = 'MIDDLENAME'
      Size = 300
      EmptyStrToNull = True
    end
    object dSetCardListBIRTHDATE: TFIBDateField
      DisplayLabel = #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
      DisplayWidth = 14
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object dSetCardListGENDER: TFIBStringField
      DisplayLabel = #1055#1086#1083
      DisplayWidth = 9
      FieldName = 'GENDER'
      Size = 50
      EmptyStrToNull = True
    end
    object dSetCardListPHONE: TFIBStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 19
      FieldName = 'PHONE'
      Size = 50
      EmptyStrToNull = True
    end
    object dSetCardListJOB: TFIBStringField
      DisplayLabel = #1052#1077#1089#1090#1086' '#1088#1072#1073#1086#1090#1099
      DisplayWidth = 24
      FieldName = 'JOB'
      Size = 300
      EmptyStrToNull = True
    end
    object dSetCardListADDRESS: TFIBStringField
      FieldName = 'ADDRESS'
      Size = 300
      EmptyStrToNull = True
    end
    object dSetCardListEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 300
      EmptyStrToNull = True
    end
  end
  object dSourceCardList: TDataSource
    DataSet = dSetCardList
    Left = 40
    Top = 192
  end
  object pFIBQueryDelete: TpFIBQuery
    Transaction = DModule.DefaultTrans
    Database = DModule.BASE
    SQL.Strings = (
      'DELETE FROM CARDS WHERE ID = :CARD_ID')
    Left = 136
    Top = 136
    qoAutoCommit = True
  end
end
