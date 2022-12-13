unit uFrameParent;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms;

type
  TFrameParent = class(TFrame)
  private
    FisInit: boolean;
    FId: integer;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Init; virtual;
    function GetCaption: string; virtual;

    property isInit: boolean read FisInit write FisInit;
    property Id: integer read FId write FId;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

constructor TFrameParent.Create(AOwner: TComponent);
begin
  inherited;

  FId := -1;
  FIsInit := False;
end;

function TFrameParent.GetCaption: string;
begin
  //
end;

procedure TFrameParent.Init;
begin
 //
end;

end.
