unit uFormPage;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, uFrameParent;

type
  TFormPage = class(TForm)
    PageControl: TPageControl;
  private
    // �������� ����� �� �������
    function SheetToFrameCard(pSheet: TTabSheet): TFrameParent;

    // ������� �������
    procedure ClosePage(pSheet: TTabSheet); overload;

    // ����� ������� �� ID
    function GetTabByCard(pCardID: integer): TTabSheet;
  public
    // �������� ����� �������
    function AddPage(pID: integer): TTabSheet;

    // ������� ������� �������
    procedure CloseCurrentPage;

    // ������� ������� � �������� ID
    procedure ClosePage(pCardID: integer); overload;

    // ������������ ������� � �������� id
    function ActivePageCard(pCardID: integer): boolean;
  end;

implementation

{$R *.dfm}

{ TFormPage }

function TFormPage.ActivePageCard(pCardID: integer): boolean;
var
  vSheet: TTabSheet;
begin
  Result := False;
  vSheet := GetTabByCard(pCardID);
  if Assigned(vSheet) then
  begin
    PageControl.ActivePage := vSheet;
    Result := True;
  end;
end;

function TFormPage.AddPage(pID: integer): TTabSheet;
begin
  Result := TTabSheet.Create(PageControl);
  Result.Visible := True;
  Result.Pagecontrol := PageControl;
  Result.Tag := pID;

  PageControl.ActivePage := Result;
end;

procedure TFormPage.CloseCurrentPage;
begin
  ClosePage(PageControl.ActivePage);
end;

procedure TFormPage.ClosePage(pCardID: integer);
var
  vSheet: TTabSheet;
begin
  vSheet := GetTabByCard(pCardID);
  if Assigned(vSheet) then
    ClosePage(vSheet);
end;

procedure TFormPage.ClosePage(pSheet: TTabSheet);
begin
  pSheet.Free;
  PageControl.ActivePageIndex := 0;
end;

function TFormPage.GetTabByCard(pCardID: integer): TTabSheet;
var
  i: integer;
  vSheet: TTabSheet;
  vFrame: TFrameParent;
begin
  Result := nil;
  for i := 0 to PageControl.PageCount - 1 do
  begin
    vSheet := PageControl.Pages[i];

    vFrame := SheetToFrameCard(vSheet);
    if not Assigned(vFrame) then
      Continue;

    if vFrame.Id = pCardID then
      Exit(vSheet);
  end;
end;

function TFormPage.SheetToFrameCard(pSheet: TTabSheet): TFrameParent;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to pSheet.ControlCount - 1 do
  begin
    if (pSheet.Controls[i] is TFrameParent) then
      Exit(pSheet.Controls[i] as TFrameParent);
  end;
end;

end.

