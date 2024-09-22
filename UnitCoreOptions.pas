unit UnitCoreOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MulticoreUtils,
  Vcl.StdCtrls, Generics.Collections, UnitCoreOption, UnitGambatteColorPicker,
  UnitMulticoreLog;

type
  TFrameCoreOptions = class(TFrame)
    LabelError: TLabel;
  private
    { Private declarations }
    Core: TCore;
    ConfigComps: TObjectList<TFrameCoreOption>;
    ConfigCompDict: TDictionary<string, TFrameCoreOption>;
    ROMFullFileName: string; // Full filename is needed for Gambatte preview to load internal DMG ROM name
    GambatteColorPicker: TFrameGambatteColorPicker;
    MulticoreLog: TFrameMulticoreLog;
  public
    { Public declarations }
    function LoadCore(Core: TCore; ROMFullFileName: string): Boolean;
    function GetConfig(): TCoreOptions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure Reset();
    procedure Save();
    procedure Delete();
  end;

implementation

{$R *.dfm}

{ TFrameCoreOptions }

constructor TFrameCoreOptions.Create(AOwner: TComponent);
begin
  inherited;
  ConfigComps := TObjectList<TFrameCoreOption>.Create(True);
  ConfigCompDict := TDictionary<string, TFrameCoreOption>.Create();
end;

procedure TFrameCoreOptions.Delete();
begin
  if ROMFullFileName = '' then
  raise Exception.Create('Cannot delete base config');
  DeleteFile(Core.GetConfigPath(ExtractFileName(ROMFullFileName)));
  if Assigned(GambatteColorPicker) then
  if Core.Config = 'Gambatte' then
  GambatteColorPicker.DeletePal();
end;

destructor TFrameCoreOptions.Destroy;
begin
  ConfigComps.Free();
  ConfigCompDict.Free();
  inherited;
end;

function TFrameCoreOptions.GetConfig: TCoreOptions;
var
  i: Integer;
begin
  SetLength(Result, ConfigComps.Count);
  for i := 0 to ConfigComps.Count - 1 do
  Result[i] := ConfigComps[i].Option;
end;

function TFrameCoreOptions.LoadCore(Core: TCore; ROMFullFileName: string): Boolean;
var
  Top: Integer;
  Option: TCoreOption;
  Temp: TFrameCoreOption;
begin
  Reset();
  Self.Core := Core;
  Self.ROMFullFileName := ROMFullFileName;
  if (Core.Config = 'Gambatte') or (Core.Config = 'Gearboy') or (Core.Config = 'Potator') or (Core.Config = 'PokeMini') or (Core.Config = 'Beetle WonderSwan') then
  begin
    GambatteColorPicker := TFrameGambatteColorPicker.Create(Self);
    GambatteColorPicker.Parent := Self;
    Top := GambatteColorPicker.Height;
  end
  else
  if Core.Config = 'multicore' then
  begin
    MulticoreLog := TFrameMulticoreLog.Create(Self);
    MulticoreLog.Parent := Self;
    Top := MulticoreLog.Height;
  end
  else
  Top := 0;
  try
    if Core.Config = '' then
    raise Exception.Create('GB300+SF2000 Tool does not know the configuration file''s name for this core (probably this core cannot be configured)');
    for Option in Core.GetConfig(ExtractFileName(ROMFullFileName)) do
    begin
      Temp := TFrameCoreOption.Create(Self);
      ConfigComps.Add(Temp);
      Temp.Parent := Self;
      Temp.Name := '';
      Temp.Option := Option;
      Temp.Top := Top;
      ConfigCompDict.Add(Option.Name, Temp);
      Inc(Top, Temp.Height);
    end;
  except
    on E: Exception do
    begin
      Reset();
      LabelError.Caption := E.Message;
      LabelError.Top := Top;
      LabelError.Show();
      Exit(False);
    end;
  end;
  Result := ConfigComps.Count > 0;
  if Core.Config = 'Gambatte' then
  GambatteColorPicker.Init(ConfigCompDict['gambatte_gb_colorization'].ComboBoxValue,
                           ConfigCompDict['gambatte_gb_internal_palette'].ComboBoxValue,
                           ConfigCompDict['gambatte_gb_palette_twb64_1'].ComboBoxValue,
                           ConfigCompDict['gambatte_gb_palette_twb64_2'].ComboBoxValue,
                           ConfigCompDict['gambatte_gb_palette_twb64_3'].ComboBoxValue,
                           ConfigCompDict['gambatte_gb_palette_pixelshift_1'].ComboBoxValue,
                           ROMFullFileName);
  if ConfigCompDict.ContainsKey('gearboy_palette') then
  GambatteColorPicker.InitGearboy(ConfigCompDict['gearboy_palette'].ComboBoxValue);
  if ConfigCompDict.ContainsKey('potator_palette') then
  GambatteColorPicker.InitPotator(ConfigCompDict['potator_palette'].ComboBoxValue);
  if ConfigCompDict.ContainsKey('pokemini_palette') then
  GambatteColorPicker.InitPokeMini(ConfigCompDict['pokemini_palette'].ComboBoxValue);
  if ConfigCompDict.ContainsKey('wswan_mono_palette') then
  GambatteColorPicker.InitBeetleCygne(ConfigCompDict['wswan_mono_palette'].ComboBoxValue);
  if Assigned(GambatteColorPicker) then
  if not GambatteColorPicker.InitDone then
  FreeAndNil(GambatteColorPicker);
end;

procedure TFrameCoreOptions.Reset;
begin
  ConfigComps.Clear();
  ConfigCompDict.Clear();
  FreeAndNil(GambatteColorPicker);
  FreeAndNil(MulticoreLog);
  Self.VertScrollBar.Position := 0; // does funny things if you don't do that and the user has scrolled down in the previous core
  LabelError.Hide();
end;

procedure TFrameCoreOptions.Save;
begin
  Core.SetConfig(Self.GetConfig(), ExtractFileName(ROMFullFileName));
  if Assigned(GambatteColorPicker) then
  begin
    if Core.Config = 'Gambatte' then
    if ConfigCompDict['gambatte_gb_colorization'].ComboBoxValue.Text = 'custom' then
    GambatteColorPicker.SavePal();
  end;
end;

end.
