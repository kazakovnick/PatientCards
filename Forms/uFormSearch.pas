unit uFormSearch;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ActnList, Vcl.Buttons, uFameCardList, uFrameParent;

type
  TFormSearch = class(TForm)
    FrameCardList: TFrameCardList;
    pnlFindRec: TPanel;
    lblSURNAME: TLabel;
    lblNAME: TLabel;
    lblMIDDLENAME: TLabel;
    lblPHONE: TLabel;
    lblEMAIL: TLabel;
    edtSURNAME: TEdit;
    edtNAME: TEdit;
    edtMIDDLENAME: TEdit;
    edtPHONE: TEdit;
    edtEMAIL: TEdit;
    lblAnd1: TLabel;
    lblAnd2: TLabel;
    lblAnd3: TLabel;
    lblAnd4: TLabel;
    pnlButton: TPanel;
    ActionList: TActionList;
    actSerch: TAction;
    actCancel: TAction;
    actOpen: TAction;
    btnOpen: TSpeedButton;
    btnCancel: TSpeedButton;
    btnSerch: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actSerchExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actSerchUpdate(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actOpenUpdate(Sender: TObject);
    procedure edtSURNAMEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actCancelExecute(Sender: TObject);
  private
    FOnOpenCard: TOnOpenCard;
  private
    procedure DoOpenCard(pCardId: integer);
  public
    property OnOpenCard: TOnOpenCard read FOnOpenCard write FOnOpenCard;
  end;

implementation

{$R *.dfm}

uses
  uСommonCls, Winapi.Windows, Variants;

procedure TFormSearch.DoOpenCard(pCardId: integer);
begin
  if Assigned(OnOpenCard) then
    OnOpenCard(pCardId);
  Self.Close;
end;

procedure TFormSearch.edtSURNAMEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // по Enter жмем кнопку поиска
  if (Key = VK_RETURN) then
    actSerch.Execute;
end;

procedure TFormSearch.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormSearch.actCancelUpdate(Sender: TObject);
begin
  actCancel.Enabled := True;
end;

procedure TFormSearch.actOpenExecute(Sender: TObject);
begin
  DoOpenCard(FrameCardList.CurrentID);
end;

procedure TFormSearch.actOpenUpdate(Sender: TObject);
begin
  actOpen.Enabled := FrameCardList.dSetCardList.RecordCount > 0;
end;

procedure TFormSearch.actSerchExecute(Sender: TObject);

  procedure AddFilterParem(pFiledName, pValue: string);
  begin
    if pValue <> EmptyStr then
      FrameCardList.dSetCardList.FindParam(pFiledName).AsString := pValue
    else
      FrameCardList.dSetCardList.FindParam(pFiledName).Value := null;
  end;

begin
  AddFilterParem('SURNAME', edtSURNAME.Text);
  AddFilterParem('NAME', edtNAME.Text);
  AddFilterParem('MIDDLENAME', edtMIDDLENAME.Text);
  AddFilterParem('PHONE', edtPHONE.Text);
  AddFilterParem('EMAIL', edtEMAIL.Text);

  FrameCardList.RefreshData;
  if FrameCardList.dSetCardList.IsEmpty then
  begin
    FrameCardList.RefreshData;
    TCmnCls.ShowMessageOk('Карточка не найдена');
  end;
end;

procedure TFormSearch.actSerchUpdate(Sender: TObject);

  function isNotEmpty(pEdit: TEdit): boolean;
  begin
    Result := pEdit.Text <> EmptyStr;
  end;

begin
  actSerch.Enabled :=
    isNotEmpty(edtSURNAME) or
    isNotEmpty(edtNAME) or
    isNotEmpty(edtMIDDLENAME) or
    isNotEmpty(edtPHONE) or
    isNotEmpty(edtEMAIL);
end;

procedure TFormSearch.FormCreate(Sender: TObject);
begin
  FrameCardList.OnOpenCard := DoOpenCard;

  // контрол TSpeedButton не умеет сам дисейблить иконку, помогаем ему
  TCmnCls.AddDisableBMP([btnOpen, btnCancel, btnSerch]);
end;

procedure TFormSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // по Esc закрываем форму
  if (Key = VK_ESCAPE) then
     ModalResult := mrCancel;
end;

end.
