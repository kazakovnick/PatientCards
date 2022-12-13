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
    // открыть на редактирование карточку
    procedure EditCard(pCardID: integer);

    // создать новую карточку
    function CreateCard(pSheet: TTabSheet; pCardID: integer): TFrameCard;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  uСommonCls, uFormSearch;

procedure TFormMain.actCreateExecute(Sender: TObject);
var
  vCard: TFrameCard;
  vNewID: integer;
  vSheet: TTabSheet;
begin
  inherited;

  // Для текущей риализации нужет известный ID, создаем его заранее
  vNewID := DModule.GetNewID;

  // открываем новую вкладку
  vSheet := AddPage(vNewID);

  // создаем новую карточку
  vCard := CreateCard(vSheet, vNewID);
  vCard.Insert;
  // встраиваем карточку на вкладку
  vSheet.Caption := vCard.GetCaption;
end;

procedure TFormMain.actDeleteExecute(Sender: TObject);
var
  vCardID: integer;
begin
  inherited;

  if not TCmnCls.ShowMessageYN(
    Format('Удалить карточку %s ?', [FrameCardList.GetCurrentFIOCard])) then
      Exit;

  vCardID := FrameCardList.CurrentID;

  // Закроем карточку если она открыта
  ClosePage(vCardID);

  // Удаляем
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
      // при сохранении карточки закроем её
      FormMain.CloseCurrentPage;
      FormMain.FrameCardList.RefreshData;
      FormMain.FrameCardList.CurrentID := pCardID;
    end;
  Result.OnAfterCancelCard :=
    procedure (pCardId: integer)
    begin
      // при отмене закроем карточку
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

  // переставим курсор на карточку в списке
  FrameCardList.CurrentID := pCardID;

  // Если карточка с таким ID уже открыта то переходим на неё
  if ActivePageCard(pCardID) then
    Exit;

  // открываем новую вкладку
  vSheet := AddPage(pCardID);

  // создаем карточку на новой вкладке
  vCard := CreateCard(vSheet, pCardID);
  vCard.Edit;
  // встраиваем карточку на вкладку
  vSheet.Caption := vCard.GetCaption;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  inherited;

  // Инициализируем перечень карточек
  FrameCardList.OnOpenCard :=
    procedure(pCardId: integer)
    begin
      FormMain.EditCard(pCardID);
    end;
  FrameCardList.Init;
end;

end.

