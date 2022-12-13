program CardLibrary;

uses
  Vcl.Forms,
  uMain in 'Forms\uMain.pas' {FormMain},
  uFormPage in 'Forms\uFormPage.pas' {FormPage},
  uFrameParent in 'Frame\uFrameParent.pas' {FrameParent: TFrame},
  uSetings in 'Classes\uSetings.pas',
  uFrameCard in 'Frame\uFrameCard.pas' {FrameCard: TFrame},
  uModule in 'Forms\uModule.pas' {DModule: TDataModule},
  uFameCardList in 'Frame\uFameCardList.pas' {FrameCardList: TFrame},
  uFrameRecordParent in 'Frame\uFrameRecordParent.pas' {FrameRecordParent: TFrame},
  u—ommonCls in 'Classes\u—ommonCls.pas',
  uFormSearch in 'Forms\uFormSearch.pas' {FormSearch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDModule, DModule);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
