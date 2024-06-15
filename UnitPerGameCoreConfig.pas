unit UnitPerGameCoreConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitCoreOptions, Vcl.StdCtrls,
  Vcl.ExtCtrls, MulticoreUtils;

type
  TFormPerGameCoreConfig = class(TForm)
    PanelFrameParent: TPanel;
    ButtonOK: TButton;
    ButtonDelete: TButton;
    ButtonCancel: TButton;
    PanelButtons: TPanel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure Init(Core: TCore; ROMFullFileName: string);
    var
      Frame: TFrameCoreOptions;
  end;

var
  FormPerGameCoreConfig: TFormPerGameCoreConfig;

implementation

{$R *.dfm}

{ TFormPerGameCoreConfig }

procedure TFormPerGameCoreConfig.Init(Core: TCore; ROMFullFileName: string);
begin
  Frame := TFrameCoreOptions.Create(Self);
  Frame.Parent := PanelFrameParent;
  Frame.LoadCore(Core, ROMFullFileName);
  Caption := Format(Caption, [Core.Core, ExtractFileName(ROMFullFileName)]);
end;

end.
