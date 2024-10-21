unit UnitConvertToMulticore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormConvertToMulticore = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBoxFC: TComboBox;
    Label2: TLabel;
    ComboBoxSFC: TComboBox;
    Label3: TLabel;
    ComboBoxMD: TComboBox;
    Label4: TLabel;
    ComboBoxDMG: TComboBox;
    Label5: TLabel;
    ComboBoxCGB: TComboBox;
    Label6: TLabel;
    ComboBoxAGB: TComboBox;
    Label7: TLabel;
    ComboBoxPCE: TComboBox;
    CheckBoxStatesMD: TCheckBox;
    CheckBoxStatesDMG: TCheckBox;
    CheckBoxStatesCGB: TCheckBox;
    CheckBoxStatesPCE: TCheckBox;
    LabelStateInfo: TLabel;
    Label8: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    CheckBoxDeleteOldStates: TCheckBox;
    CheckBoxDeleteOldROMs: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxMDChange(Sender: TObject);
    procedure CheckBoxDeleteOldROMsClick(Sender: TObject);
    procedure ComboBoxDMGChange(Sender: TObject);
    procedure ComboBoxCGBChange(Sender: TObject);
    procedure ComboBoxPCEChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormConvertToMulticore: TFormConvertToMulticore;

implementation

uses
  MulticoreUtils, Math;

{$R *.dfm}

procedure TFormConvertToMulticore.CheckBoxDeleteOldROMsClick(Sender: TObject);
begin
  CheckBoxDeleteOldStates.Enabled := CheckBoxDeleteOldROMs.Checked;
  if not CheckBoxDeleteOldROMs.Checked then
  CheckBoxDeleteOldStates.Checked := False;
end;

procedure TFormConvertToMulticore.ComboBoxCGBChange(Sender: TObject);
begin
  CheckBoxStatesCGB.Checked := (ComboBoxCGB.Text = 'TGB Dual') or (ComboBoxCGB.Text = 'DoubleCherryGB');
  CheckBoxStatesCGB.Enabled := CheckBoxStatesCGB.Checked;
end;

procedure TFormConvertToMulticore.ComboBoxDMGChange(Sender: TObject);
begin
  CheckBoxStatesDMG.Checked := (ComboBoxDMG.Text = 'TGB Dual') or (ComboBoxDMG.Text = 'DoubleCherryGB');
  CheckBoxStatesDMG.Enabled := CheckBoxStatesDMG.Checked;
end;

procedure TFormConvertToMulticore.ComboBoxMDChange(Sender: TObject);
begin
  CheckBoxStatesMD.Checked := ComboBoxMD.Text = 'PicoDrive';
  CheckBoxStatesMD.Enabled := CheckBoxStatesMD.Checked;
end;

procedure TFormConvertToMulticore.ComboBoxPCEChange(Sender: TObject);
begin
  CheckBoxStatesPCE.Checked := ComboBoxPCE.Text = Beetle+'PCE Fast';
  CheckBoxStatesPCE.Enabled := CheckBoxStatesPCE.Checked;
end;

procedure TFormConvertToMulticore.FormCreate(Sender: TObject);
procedure HandlePlatform(Target: TComboBox; const Ext, Default: string);
var
  i: Integer;
  Console: TCoreConsole;
  Core: TCore;
begin
  Target.Items.BeginUpdate();
  try
    Target.Items.AddObject('(skip)', Pointer($ffffffff));
    for i := Low(CoreConsoles) to High(CoreConsoles) do
    begin
      Console := CoreConsoles[i];
      if Console.Core <> 'Stock' then
      if Pos('|'+Ext+'|', '|'+Console.Extensions+'|') > 0 then
      begin
        Core := CoresDict[Console.Core];
        if Target.Items.IndexOf(Core.Name) = -1 then
        Target.Items.AddObject(Core.Name, Pointer(i));
      end;
    end;
  finally
    Target.Items.EndUpdate();
    Target.ItemIndex := Min(Max(1, Target.Items.IndexOf(Default)), Target.Items.Count - 1);
    if Assigned(Target.OnChange) then
    Target.OnChange(Target);
  end;
end;
begin
  HandlePlatform(ComboBoxFC,  'nes', 'FCEUmm');
  HandlePlatform(ComboBoxSFC, 'sfc', 'Snes9x 2002');
  HandlePlatform(ComboBoxMD,  'md',  'PicoDrive');
  HandlePlatform(ComboBoxDMG, 'gb',  'Gambatte');
  HandlePlatform(ComboBoxCGB, 'gbc', 'TGB Dual');
  HandlePlatform(ComboBoxAGB, 'gba', 'gpSP');
  HandlePlatform(ComboBoxPCE, 'pce', Beetle+'PCE Fast');
end;

end.
