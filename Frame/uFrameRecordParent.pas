unit uFrameRecordParent;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, uFrameParent, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.StdCtrls, uModule, Vcl.Buttons;

type
  TFrameRecordParent = class(TFrameParent)
    ActionList: TActionList;
    actSave: TAction;
    pnlButton: TPanel;
    acCancel: TAction;
    btnSave: TSpeedButton;
    btnacCancel: TSpeedButton;
    procedure actSaveUpdate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure acCancelExecute(Sender: TObject);
    procedure acCancelUpdate(Sender: TObject);
  public
    function CanSave: boolean; virtual;
    procedure Save; virtual;
    procedure Cancel; virtual;
    procedure Init; override;
  end;

var
  FrameRecordParent: TFrameRecordParent;

implementation

{$R *.dfm}

uses
  Vcl.DBCtrls, Data.DB, System.DateUtils, System.Types, System.SysUtils,
  Vcl.ComCtrls, uСommonCls;

procedure TFrameRecordParent.acCancelExecute(Sender: TObject);
begin
  inherited;

  Cancel;
end;

procedure TFrameRecordParent.acCancelUpdate(Sender: TObject);
begin
  inherited;

  acCancel.Enabled := True;
end;

procedure TFrameRecordParent.actSaveExecute(Sender: TObject);
begin
  inherited;

  Save;
end;

procedure TFrameRecordParent.actSaveUpdate(Sender: TObject);
begin
  inherited;

  actSave.Enabled := CanSave;
end;

procedure TFrameRecordParent.btnCancelClick(Sender: TObject);
begin
  inherited;

  Cancel;
end;

procedure TFrameRecordParent.Cancel;
begin
  //
end;

function TFrameRecordParent.CanSave: boolean;
var
  i: integer;
  vDataSet: TDataSet;
  vDBEdit: TDBEdit;
  vField: TField;
  vDBComboBox : TDBComboBox;
  vDate: TDate;
begin
  inherited;

  Result := False;

  // проходим по контролам находим первый измененый
  // риализация кривая но побыстрому ничего умнее непридумал.
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TDBEdit) then
    begin
      vDBEdit := (Components[i] as TDBEdit);
      vDataSet := vDBEdit.DataSource.DataSet;
      if Assigned(vDataSet) then
      begin
        vField := vDataSet.FindField(vDBEdit.DataField);

        if Assigned(vField) and (vField.OldValue <> vDBEdit.Text) then
          Exit(True);
      end;
    end
    else
    if (Components[i] is TDBComboBox) then
    begin
      vDBComboBox := (Components[i] as TDBComboBox);
      vDataSet := vDBComboBox.DataSource.DataSet;
      if Assigned(vDataSet) then
      begin
        vField := vDataSet.FindField(vDBComboBox.DataField);

        if Assigned(vField) and (vField.OldValue <> vDBComboBox.Text) then
          Exit(True);
      end;
    end
    else
    if (Components[i] is TDateTimePicker) then
    begin
      vDate := (Components[i] as TDateTimePicker).Date;

      if CompareDate(vDate, Date) <> EqualsValue then
        Exit(True);
    end;
  end;
end;

procedure TFrameRecordParent.Init;
begin
  inherited;
  // контрол TSpeedButton не умеет сам дисейблить иконку, помогаем ему
  TCmnCls.AddDisableBMP([btnSave, btnacCancel]);
end;

procedure TFrameRecordParent.Save;
begin
  //
end;

end.
