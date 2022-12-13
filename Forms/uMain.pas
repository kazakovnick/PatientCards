unit uMain;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.SysUtils, Vcl.Buttons, Vcl.ActnList, uModule, uFormPage, uFrameCard,
  uFameCardList, uFrameParent;

type
  TFormMain = class(TFormPage)
    tsList: TTabSheet;
    pnlTool: TPanel;
    FrameCardList: TFrameCardList;
    btnOpen: TSpeedButton;
    ActionList: TActionList;
    actOpen: TAction;
    actCreate: TAction;
    actDelete: TAction;
    actSerch: TAction;
    btnCreate: TSpeedButton;
    btnDelete: TSpeedButton;
    btnSerch: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSerchExecute(Sender: TObject);
  private
    // ������� �� �������������� ��������
    procedure EditCard(pCardID: integer);

    // ������� ����� ��������
    function CreateCard(pSheet: TTabSheet; pCardID: integer): TFrameCard;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  u�ommonCls, uFormSearch;

procedure TFormMain.actCreateExecute(Sender: TObject);
var
  vCard: TFrameCard;
  vNewID: integer;
  vSheet: TTabSheet;
begin
  inherited;

  // ��� ������� ���������� ����� ��������� ID, ������� ��� �������
  vNewID := DModule.GetNewID;

  // ��������� ����� �������
  vSheet := AddPage(vNewID);

  // ������� ����� ��������
  vCard := CreateCard(vSheet, vNewID);
  vCard.Insert;
  // ���������� �������� �� �������
  vSheet.Caption := vCard.GetCaption;
end;

procedure TFormMain.actDeleteExecute(Sender: TObject);
var
  vCardID: integer;
begin
  inherited;

  if not TCmnCls.ShowMessageYN(
    Format('������� �������� %s ?', [FrameCardList.GetCurrentFIOCard])) then
      Exit;

  vCardID := FrameCardList.CurrentID;

  // ������� �������� ���� ��� �������
  ClosePage(vCardID);

  // �������
  FrameCardList.DeleteCard(vCardID);
end;

procedure TFormMain.actOpenExecute(Sender: TObject);
begin
  inherited;

  EditCard(FrameCardList.CurrentID);
end;

procedure TFormMain.actSerchExecute(Sender: TObject);
var
  vFormSearch: TFormSearch;
begin
  inherited;

  vFormSearch := TFormSearch.Create(nil);
  try
    vFormSearch.OnOpenCard :=
      procedure(pCardId: integer)
      begin
        FormMain.FrameCardList.CurrentID := pCardId;
        FormMain.EditCard(pCardID);
      end;

    vFormSearch.ShowModal;
  finally
    FreeAndNil(vFormSearch);
  end;
end;

function TFormMain.CreateCard(pSheet: TTabSheet; pCardID: integer): TFrameCard;
begin
  Result := TFrameCard.Create(pSheet);
  Result.Name := Format('FrameCard_%d', [Self.ComponentCount]);
  Result.Id := pCardID;
  Result.Align := alClient;
  Result.OnAfterSaveCard :=
    procedure (pCardId: integer)
    begin
      // ��� ���������� �������� ������� �
      FormMain.CloseCurrentPage;
      FormMain.FrameCardList.RefreshData;
      FormMain.FrameCardList.CurrentID := pCardID;
    end;
  Result.OnAfterCancelCard :=
    procedure (pCardId: integer)
    begin
      // ��� ������ ������� ��������
      FormMain.CloseCurrentPage;
    end;
  Result.Init;

  pSheet.InsertControl(Result);
end;

procedure TFormMain.EditCard(pCardID: integer);
var
  vCard: TFrameCard;
  vSheet: TTabSheet;
begin
  inherited;

  // ���������� ������ �� �������� � ������
  FrameCardList.CurrentID := pCardID;

  // ���� �������� � ����� ID ��� ������� �� ��������� �� ��
  if ActivePageCard(pCardID) then
    Exit;

  // ��������� ����� �������
  vSheet := AddPage(pCardID);

  // ������� �������� �� ����� �������
  vCard := CreateCard(vSheet, pCardID);
  vCard.Edit;
  // ���������� �������� �� �������
  vSheet.Caption := vCard.GetCaption;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  inherited;

  // �������������� �������� ��������
  FrameCardList.OnOpenCard :=
    procedure(pCardId: integer)
    begin
      FormMain.EditCard(pCardID);
    end;
  FrameCardList.Init;
end;

end.

