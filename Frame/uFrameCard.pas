unit uFrameCard;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Data.DB, FIBDataSet,
  pFIBDataSet, Vcl.ExtCtrls, FIBQuery, Vcl.ActnList, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.Mask, uFrameParent, uFrameRecordParent, Vcl.Buttons;

type
  TOnSaveCard =
    reference to procedure(pCardId: integer);
  TOnCancelCard =
    reference to procedure(pCardId: integer);

  TFrameCard = class(TFrameRecordParent)
    dsRecord: TDataSource;
    dsetRecord: TpFIBDataSet;
    dsetRecordID: TFIBIntegerField;
    dsetRecordSURNAME: TFIBStringField;
    dsetRecordNAME: TFIBStringField;
    dsetRecordMIDDLENAME: TFIBStringField;
    dsetRecordBIRTHDATE: TFIBDateField;
    dsetRecordGENDER: TFIBStringField;
    dsetRecordPHONE: TFIBStringField;
    dsetRecordJOB: TFIBStringField;
    dsetRecordADDRESS: TFIBStringField;
    dsetRecordEMAIL: TFIBStringField;
    pnlClientData: TPanel;
    lblADDRESS: TLabel;
    lblBIRTHDATE: TLabel;
    lblEMAIL: TLabel;
    lblGENDER: TLabel;
    lblJOB: TLabel;
    lblMIDDLENAME: TLabel;
    lblNAME: TLabel;
    lblPHONE: TLabel;
    lblSURNAME: TLabel;
    dbedtSURNAME: TDBEdit;
    dtpBIRTHDATE: TDateTimePicker;
    dbedtNAME: TDBEdit;
    dbedtPHONE: TDBEdit;
    dbedtEMAIL: TDBEdit;
    dbedtJOB: TDBEdit;
    dbedtMIDDLENAME: TDBEdit;
    dbedtADDRESS: TDBEdit;
    dbedtGENDER: TDBEdit;
    procedure dtpBIRTHDATECloseUp(Sender: TObject);
  private
    FOnAfterSaveCard: TOnSaveCard;
    FOnAfterCancelCard: TOnCancelCard;
  public
    procedure Init; override;
    function GetCaption: string; override;

    procedure Edit;
    procedure Insert;
    procedure Save; override;
    procedure Cancel; override;
    function CanSave: boolean; override;

    function CardIsNotEmpty: boolean;

    property OnAfterSaveCard: TOnSaveCard read FOnAfterSaveCard write FOnAfterSaveCard;
    property OnAfterCancelCard: TOnCancelCard read FOnAfterCancelCard write FOnAfterCancelCard;
  end;

implementation

{$R *.dfm}

uses
  uСommonCls, System.SysUtils, System.DateUtils, System.Types;

{ TFrameCard }

function TFrameCard.CanSave: boolean;
begin
  if (dsetRecord.State = TDataSetState.dsInsert) then
    Exit(CardIsNotEmpty);

  Result := inherited;
end;

function TFrameCard.CardIsNotEmpty: boolean;
var
  i : integer;
  vDate: TDate;
begin
  Result := False;

  for i := 0 to pnlClientData.ControlCount - 1 do
  begin
    if (pnlClientData.Controls[i] is TDBEdit)
      and ((pnlClientData.Controls[i] as TDBEdit).Text <> EmptyStr) then
        Exit(True);

    if (pnlClientData.Controls[i] is TDateTimePicker) then
    begin
      vDate := (pnlClientData.Controls[i] as TDateTimePicker).Date;

      if CompareDate(vDate, Date) <> EqualsValue then
        Exit(True);
    end;
  end;
end;

procedure TFrameCard.dtpBIRTHDATECloseUp(Sender: TObject);
begin
  inherited;

  // пришлось закостылить с не dbaware компонентом
  dtpBIRTHDATE.Date := dsetRecord.FindField('BIRTHDATE').AsDateTime;
end;

function TFrameCard.GetCaption: string;
const
  cEmptyCard = 'Карточка';
  cNewCard = 'Новая карточка';
begin
  if not IsInit then
    Exit(cEmptyCard);

  if dsetRecord.State = dsInsert then
    Result := cNewCard
  else
  begin
    Result := TCmnCls.GetFIO(dsetRecord);
    if Result = EmptyStr then
      Result := cEmptyCard;
  end;
end;

procedure TFrameCard.Init;
begin
  inherited;

  dsetRecord.ParamByName('CARD_ID').AsInteger := Self.Id;
  dsetRecord.AutoCommit := True;
  dsetRecord.Open;
  dtpBIRTHDATE.Date := dsetRecord.FindField('BIRTHDATE').AsDateTime;

  IsInit := True;
end;

procedure TFrameCard.Edit;
begin
  dsetRecord.Open;
  dsetRecord.Edit;
end;

procedure TFrameCard.Insert;
begin
  dsetRecord.ParamByName('CARD_ID').AsInteger := Self.Id;
  dsetRecord.Insert;
end;

procedure TFrameCard.Save;
begin
  inherited;

  // пришлось закостылить с не dbaware компонентом
  dsetRecord.FindField('BIRTHDATE').AsDateTime := dtpBIRTHDATE.Date;
  if dsetRecord.CanEdit then
    dsetRecord.Post;
  dsetRecord.Edit;

  if Assigned(OnAfterSaveCard) then
    OnAfterSaveCard(Self.Id);
end;

procedure TFrameCard.Cancel;
begin
  if dsetRecord.CanEdit then
    dsetRecord.Cancel;

  if Assigned(OnAfterCancelCard) then
    OnAfterCancelCard(Self.Id);
end;

end.
