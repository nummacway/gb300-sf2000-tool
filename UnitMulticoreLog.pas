unit UnitMulticoreLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Vcl.ExtActns, Vcl.StdCtrls;

type
  TFrameMulticoreLog = class(TFrame)
    ActionList: TActionList;
    FileRun: TFileRun;
    LabelDescription: TLabel;
    ButtonEnable: TButton;
    ButtonShow: TButton;
    ButtonDisable: TButton;
    procedure ButtonEnableClick(Sender: TObject);
    procedure ButtonDisableClick(Sender: TObject);
    procedure ButtonShowClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateStatus();
  public
    { Public declarations }
    constructor Create(AOWner: TComponent); override;
  end;

implementation

uses
  GB300Utils;

{$R *.dfm}

{ TFrameMulticoreLog }

procedure TFrameMulticoreLog.ButtonDisableClick(Sender: TObject);
begin
  if not DeleteFile(Path + 'log.txt') then
  raise Exception.Create('Could not delete log.txt in root dir to disable logging');
  UpdateStatus();
end;

procedure TFrameMulticoreLog.ButtonEnableClick(Sender: TObject);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(Path + 'log.txt', fmCreate);
  FS.Free();
  UpdateStatus();
end;

procedure TFrameMulticoreLog.ButtonShowClick(Sender: TObject);
begin
  FileRun.FileName := Path + 'log.txt';
  FileRun.Execute();
end;

constructor TFrameMulticoreLog.Create(AOWner: TComponent);
begin
  inherited;
  UpdateStatus();
end;

procedure TFrameMulticoreLog.UpdateStatus();
var
  b: Boolean;
begin
  b := FileExists(Path + 'log.txt');
  ButtonEnable.Enabled := not b;
  ButtonShow.Enabled := b;
  ButtonDisable.Enabled := b;
end;

end.
