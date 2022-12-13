unit uСommonCls;

interface

uses
  pFIBDataSet, Forms, Winapi.Windows, Vcl.Controls, Vcl.Graphics,
  System.TypInfo;

type
  TTypeKinds = set of TTypeKind;
  TCmnCls = class
  private
    class function ShowMessage(pText: string; Flags: Cardinal): Integer;
  public
    class function GetFIO(pDataSet: TpFIBDataSet): string;
    class procedure AddDisableBMP(pSpeedBtnArr: array of TObject);

    class function ShowMessageYN(pText: String): boolean;
    class procedure ShowMessageOk(pText: String);
    class procedure ShowMessageError(pText: string);
  end;

implementation

uses
  Vcl.Buttons;

{ TСmnCls }

class function TCmnCls.GetFIO(pDataSet: TpFIBDataSet): string;
begin
  Result := pDataSet.FindField('SURNAME').AsString;

  if Length(pDataSet.FindField('NAME').AsString) > 1 then
    Result := Result + ' ' + pDataSet.FindField('NAME').AsString[1] + '.';

  if Length(pDataSet.FindField('MIDDLENAME').AsString) > 1 then
    Result := Result + pDataSet.FindField('MIDDLENAME').AsString[1] + '.';
end;

class function TCmnCls.ShowMessage(pText: string; Flags: Cardinal): Integer;
begin
  Result := Application.MessageBox(PChar(pText), PChar(Application.Title), Flags);
end;

class procedure TCmnCls.ShowMessageOk(pText: String);
begin
  ShowMessage(pText, MB_OK or MB_ICONQUESTION);
end;

class function TCmnCls.ShowMessageYN(pText: String): boolean;
begin
  Result := ShowMessage(pText, MB_YESNO or MB_ICONQUESTION) = mrYes;
end;

class procedure TCmnCls.ShowMessageError(pText: string);
begin
  ShowMessage(pText, MB_OK or MB_ICONERROR);
end;

class procedure TCmnCls.AddDisableBMP(pSpeedBtnArr: array of TObject);
var
  vBitMap, vBitMapGrey: TBitmap;
  vWidth, x, y, vNewColor, i: integer;
  vPixelColor: TColor;
begin
  // TODO: можно оптимихировать но некогда
  vBitMap := TBitmap.Create;
  vBitMapGrey := TBitmap.Create;
  try
    for i := 0 to High(pSpeedBtnArr) do
    begin
      if (pSpeedBtnArr[i] is TSpeedButton) then
        vBitMap.Assign((pSpeedBtnArr[i] as TSpeedButton).Glyph)
      else
      begin
        if (pSpeedBtnArr[i] is TBitBtn) then
          vBitMap.Assign((pSpeedBtnArr[i] as TBitBtn).Glyph)
        else
          Exit;
      end;

      if not Assigned(vBitMap) or (vBitMap.Width <> vBitMap.Height) then
        Exit;

      vWidth := vBitMap.Width;
      vBitMapGrey.Width := vWidth * 2;
      vBitMapGrey.Height := vWidth;
      vBitMapGrey.Canvas.Draw(0, 0, vBitMap);
      for x := 0 to vWidth - 1 do
      begin
        for y := 0 to vWidth - 1 do
        begin
          vPixelColor := ColorToRGB(vBitMap.Canvas.Pixels[x, y]);
          vNewColor := Round((((vPixelColor shr 16) + ((vPixelColor shr 8) and
            $00FF) + (vPixelColor and $0000FF)) div 3)) div 2 + 96;
          vBitMap.Canvas.Pixels[x, y] := RGB(vNewColor, vNewColor, vNewColor);
        end;
      end;
      vBitMapGrey.Canvas.Draw(vWidth, 0, vBitMap);
      if (pSpeedBtnArr[i] is TSpeedButton) then
        with (pSpeedBtnArr[i] as TSpeedButton) do
        begin
          Glyph.Assign(vBitMapGrey);
          NumGlyphs := 2;
        end
      else
      begin
        with (pSpeedBtnArr[i] as TBitBtn) do
        begin
          Glyph.Assign(vBitMapGrey);
          NumGlyphs := 2;
        end;
      end;
      vBitMap := TBitmap.Create;
      vBitMapGrey := TBitmap.Create;
    end;
  finally
    vBitMap.Free;
    vBitMapGrey.Free;
  end;
end;

end.
