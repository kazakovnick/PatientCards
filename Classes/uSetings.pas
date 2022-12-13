unit uSetings;

interface

type
  TSettings = class (TObject)
  private
    FDBName: string;
    FLibraryName: string;
  private
    procedure Init;
  public
    procedure AfterConstruction; override;

    property DBName: string read FDBName;
    property LibraryName: string read FLibraryName;
  end;

var
  Settings: TSettings;

implementation

uses
  System.SysUtils, System.IniFiles, uСommonCls;

{ TSetings }

procedure TSettings.AfterConstruction;
begin
  inherited;
end;

procedure TSettings.Init;
var
  vAppPath: string;
begin
  vAppPath := ExtractFilePath(ParamStr(0));

  FDBName := vAppPath + 'LIBRARY.FDB';
  FLibraryName := vAppPath + 'fbembed.dll';

  if not FileExists(Settings.DBName) then
  begin
    TCmnCls.ShowMessageError('Не удалось найти файл базы данных:'#13#10 + Settings.DBName);
    Halt;
  end;

  if not FileExists(Settings.LibraryName) then
  begin
    TCmnCls.ShowMessageError('Не удалось найти файл клиента:'#13#10 + Settings.LibraryName);
    Halt;
  end;
end;

initialization
  Settings := TSettings.Create;
  Settings.Init;

finalization
  if Assigned(Settings) then
    FreeAndNil(Settings);

end.
