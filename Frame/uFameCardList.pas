unit uFameCardList;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, DBGridEh, Data.DB, FIBDataSet,
  pFIBDataSet, FIBQuery, pFIBQuery, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, uFrameParent;

type
  TOnOpenCard =
    reference to procedure(pCardId: integer);

  TFrameCardList = class(TFrameParent)
    dSetCardList: TpFIBDataSet;
    dSetCardListID: TFIBIntegerField;
    dSetCardListSURNAME: TFIBStringField;
    dSetCardListNAME: TFIBStringField;
    dSetCardListMIDDLENAME: TFIBStringField;
    dSetCardListBIRTHDATE: TFIBDateField;
    dSetCardListGENDER: TFIBStringField;
    dSetCardListPHONE: TFIBStringField;
    dSetCardListJOB: TFIBStringField;
    dSetCardListADDRESS: TFIBStringField;
    dSetCardListEMAIL: TFIBStringField;
    dSourceCardList: TDataSource;
    dbGrid: TDBGridEh;
    pFIBQueryDelete: TpFIBQuery;
    procedure dbGridDblClick(Sender: TObject);
  private
    FOnOpenCard: TOnOpenCard;
    function GetCurrentID: integer;
    procedure SetCurrentID(const Value: integer);
  public
    procedure Init; override;
    function GetCaption: string; override;
    procedure RefreshData;
    procedure DeleteCard(pCardID: integer);
    function GetCurrentFIOCard: string;

    property CurrentID: integer read GetCurrentID write SetCurrentID;
    property OnOpenCard: TOnOpenCard read FOnOpenCard write FOnOpenCard;
  end;

implementation

{$R *.dfm}

uses
  uÑommonCls, uModule;

{ TFrameCardList }

procedure TFrameCardList.dbGridDblClick(Sender: TObject);
begin
  inherited;

  if Assigned(OnOpenCard) then
    OnOpenCard(CurrentID);
end;

procedure TFrameCardList.DeleteCard(pCardID: integer);
begin
  pFIBQueryDelete.ParamByName('CARD_ID').AsInteger := pCardID;
  pFIBQueryDelete.ExecQuery;

  RefreshData;
end;

function TFrameCardList.GetCaption: string;
begin
  Result := 'Ñïèñîê êàðòî÷åê';
end;

function TFrameCardList.GetCurrentFIOCard: string;
begin
  Result := TCmnCls.GetFIO(dSetCardList);
end;

function TFrameCardList.GetCurrentID: integer;
begin
  Result := dSetCardList.FindField('ID').AsInteger;
end;

procedure TFrameCardList.Init;
begin
  inherited;

  DModule.ConnectedBASE;
  dSetCardList.Open;
end;

procedure TFrameCardList.RefreshData;
begin
  dSetCardList.Close;
  dSetCardList.Open;
end;

procedure TFrameCardList.SetCurrentID(const Value: integer);
begin
  dSetCardList.Locate('ID', Value, [loCaseInsensitive]);
end;

end.
