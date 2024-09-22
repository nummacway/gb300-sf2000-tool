unit UnitFinalBurn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormFinalBurn = class(TForm)
    GroupBoxZIPFileName: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    CheckBoxZFB: TCheckBox;
    LabelBin: TLabel;
    EditFolder: TEdit;
    LabelSlash: TLabel;
    EditZIPFileName: TEdit;
    Label5: TLabel;
    GroupBoxDisplayName: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    EditZFBFileName: TEdit;
    Label7: TLabel;
    ButtonCancel: TButton;
    ButtonMulticore: TButton;
    ButtonOK: TButton;
    LabelFile: TLabel;
    LabelFileName: TLabel;
    ButtonAbort: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxZFBClick(Sender: TObject);
    procedure EditFileNameChange(Sender: TObject);
    procedure EditZFBFileNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetZIPFileName(Bin: Boolean): string;
    function GetZFBFileName(): string;
  end;

var
  FormFinalBurn: TFormFinalBurn;

implementation

uses
  GB300Utils, StrUtils;

{$R *.dfm}

{ TFormFinalBurn }

procedure TFormFinalBurn.CheckBoxZFBClick(Sender: TObject);
begin
  LabelBin.Visible := CheckBoxZFB.Checked;
  EditFolder.Visible := CheckBoxZFB.Checked;
  LabelSlash.Visible := CheckBoxZFB.Checked;
  GroupBoxDisplayName.Visible := CheckBoxZFB.Checked;
  EditFileNameChange(Sender);
end;

procedure TFormFinalBurn.EditFileNameChange(Sender: TObject);
begin
  if FileExists(Foldername.AbsoluteFolder[ArcadeFolderIndex] + GetZIPFileName(True)) then
  EditZIPFileName.Color := $33ccff
  else
  EditZIPFileName.Color := clWindow;
  EditFolder.Color := EditZIPFileName.Color;
end;

procedure TFormFinalBurn.EditZFBFileNameChange(Sender: TObject);
begin
  if FileExists(Foldername.AbsoluteFolder[ArcadeFolderIndex] + GetZFBFileName()) then
  EditZFBFileName.Color := $33ccff
  else
  EditZFBFileName.Color := clWindow;
end;

procedure TFormFinalBurn.FormCreate(Sender: TObject);
begin
  ButtonMulticore.Visible := HasMulticore;
end;

function TFormFinalBurn.GetZFBFileName: string;
begin
  Result := EditZFBFileName.Text + '.zfb';
end;

function TFormFinalBurn.GetZIPFileName(Bin: Boolean): string;
begin
  if CheckBoxZFB.Checked then
  Result := IncludeTrailingPathDelimiter(IfThen(Bin, IncludeTrailingPathDelimiter('bin')) + StringReplace(EditFolder.Text, '/', '\', [rfReplaceAll])) + EditZIPFileName.Text + '.zip'
  else
  Result := EditZIPFileName.Text + '.zip';
end;

end.
