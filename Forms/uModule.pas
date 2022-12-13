unit uModule;

interface

uses
  System.Classes, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, Vcl.Controls,
  Vcl.ImgList;

type
  TDModule = class(TDataModule)
    BASE: TpFIBDatabase;
    DefaultTrans: TpFIBTransaction;
    fbqryGetNewCardID: TpFIBQuery;
    ImageList: TImageList;
    procedure BASEBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
      var DoConnect: Boolean);
  private
  public
    function GetNewID: integer;
    procedure ConnectedBASE;
  end;

var
  DModule: TDModule;

implementation

{$R *.dfm}

uses
  uSetings, System.SysUtils;

procedure TDModule.BASEBeforeConnect(Database: TFIBDatabase;
  LoginParams: TStrings; var DoConnect: Boolean);
begin
  BASE.DBName := Settings.DBName;
  BASE.LibraryName := Settings.LibraryName;
end;

procedure TDModule.ConnectedBASE;
begin
  try
  if not BASE.Connected then
    BASE.Connected := True;
  except on E: Exception do
    raise Exception.Create(e.Message + #13#10 + SysErrorMessage(GetLastError()));
  end;
end;

function TDModule.GetNewID: integer;
begin
  fbqryGetNewCardID.ExecQuery;
  Result := fbqryGetNewCardID.FieldByName('NUMBER').AsInteger;
end;

end.
