unit UnitCoreOption;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MulticoreUtils, pngimage,
  Vcl.StdCtrls;

type
  TFrameCoreOption = class(TFrame)
    ComboBoxValue: TComboBox;
    LabelDescription: TLabel;
    LabelDefault: TLabel;
  private
    { Private declarations }
    var
      FOption: TCoreOption;
    function GetOption: TCoreOption;
    procedure SetOption(const Value: TCoreOption);
  public
    { Public declarations }
    property Option: TCoreOption read GetOption write SetOption;
  end;

implementation

uses
  GUIHelpers, GambatteColors, Types;

{$R *.dfm}

{ TFrameCoreOption }

function TFrameCoreOption.GetOption: TCoreOption;
begin
  Result := FOption;
  if ComboBoxValue.ItemIndex = -1 then // nearly impossible to happen
  raise Exception.CreateFmt('Invalid value for option %s because of an error in the current file. This is a multicore issue.', [FOption.Name]);
  Result.Value := ComboBoxValue.Text;
end;

procedure TFrameCoreOption.SetOption(const Value: TCoreOption);
var
  sl: TStringList;
begin
  FOption := Value;
  sl := TStringList.Create();
  try
    sl.Text := StringReplace(Value.Values, '|', #13#10, [rfReplaceAll]);
    ComboBoxValue.Items.Assign(sl);
    ComboBoxValue.ItemIndex := sl.IndexOf(Value.Value); // I believe there was a bug with TComboBox.Items not being readable during form creation
  finally
    sl.Free();
  end;
  LabelDescription.Caption := StringReplace(Value.Name, '&', '&&', [rfReplaceAll]) + ':';
  LabelDefault.Caption := '(default: ' + StringReplace(Value.Default, '&', '&&', [rfReplaceAll]) + ')';
end;

end.
