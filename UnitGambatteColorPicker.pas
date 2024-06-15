unit UnitGambatteColorPicker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, GambatteColors, GB300Utils,
  PaletteColors;

type
  TFrameGambatteColorPicker = class(TFrame)
    LabelDescriptionGambatte: TLabel;
    ColorDialog: TColorDialog;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    LabelHint: TLabel;
    LabelDescriptionNonGambatte: TLabel;
    procedure ShapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure HandleComboBoxSelect(Sender: TObject);
    procedure HandleComboBoxSelectGearboy(Sender: TObject);
    procedure HandleComboBoxSelectPotator(Sender: TObject);
    procedure HandleComboBoxSelectPokeMini(Sender: TObject);
    procedure HandleComboBoxSelectBeetleCygne(Sender: TObject);
    function GetGambatteColorMap: TGambatteColorMap;
    procedure SetGambatteColorMap(const Value: array of Integer);
    procedure SetSwatchCount(Count: Byte);
    var
      gambatte_gb_colorization, gambatte_gb_internal_palette, gambatte_gb_palette_twb64_1, gambatte_gb_palette_twb64_2, gambatte_gb_palette_twb64_3, gambatte_gb_palette_pixelshift_1: TComboBox;
      ROMFullFilename: string;
      GameName: RawByteString;
      Shapes: array[1..12] of TShape;
      LastCustom: TGambatteColorMap;
      PalFileName: string;
  public
    { Public declarations }
    procedure Init(gambatte_gb_colorization, gambatte_gb_internal_palette, gambatte_gb_palette_twb64_1, gambatte_gb_palette_twb64_2, gambatte_gb_palette_twb64_3, gambatte_gb_palette_pixelshift_1: TComboBox; const ROMFullFilename: string);
    procedure InitGearboy(gearboy_palette: TComboBox);
    procedure InitPotator(potator_palette: TComboBox);
    procedure InitPokeMini(pokemini_palette: TComboBox);
    procedure InitBeetleCygne(wswan_mono_palette: TComboBox);
    constructor Create(AOwner: TComponent); override;
    //property ColorMap: TGambatteColorMap read GetGambatteColorMap write SetGambatteColorMap;
    procedure SavePal();
    procedure DeletePal();
    var
      InitDone: Boolean;
  end;

implementation

uses
  Math, inifiles, AnsiStrings, System.UITypes;

{$R *.dfm}

{ TFrameGambatteColorPicker }

constructor TFrameGambatteColorPicker.Create(AOwner: TComponent);
var
  i: Byte;
begin
  inherited;
  for i := Low(Shapes) to High(Shapes) do
  Shapes[i] := FindComponent('Shape' + IntToStr(i)) as TShape;
end;

procedure TFrameGambatteColorPicker.DeletePal;
begin
  if PalFileName <> '' then
  DeleteFile(PalFileName);
end;

function TFrameGambatteColorPicker.GetGambatteColorMap: TGambatteColorMap;
var
  i: Byte;
begin
  for i := Low(Shapes) to High(Shapes) do
  Result[i] := SwapColor(Shapes[i].Brush.Color);
end;

procedure TFrameGambatteColorPicker.HandleComboBoxSelect(Sender: TObject);
function GetPalette(): TGambatteColorMap;
var
  Mapping: TGambatteColorMapping;
begin
  //if gambatte_gb_colorization.Text = 'disabled' then
  //Exit(default);

  if (gambatte_gb_colorization.Text = 'auto') or (gambatte_gb_colorization.Text = 'SGB') then
  for Mapping in sgbTitlePalettes do
  if Mapping.GameName = GameName then
  Exit(Mapping.ColorMap^);

  if (gambatte_gb_colorization.Text = 'auto') or (gambatte_gb_colorization.Text = 'GBC') then
  for Mapping in gbcTitlePalettes do
  if Mapping.GameName = GameName then
  Exit(Mapping.ColorMap^);

  if gambatte_gb_colorization.Text = 'internal' then
  begin
    if gambatte_gb_internal_palette.Text = 'TWB64 - Pack 1' then
    if InRange(gambatte_gb_palette_twb64_1.ItemIndex, Low(GambatteColors.gambatte_gb_palette_twb64_1), High(GambatteColors.gambatte_gb_palette_twb64_1)) then
    Exit(GambatteColors.gambatte_gb_palette_twb64_1[gambatte_gb_palette_twb64_1.ItemIndex]^);

    if gambatte_gb_internal_palette.Text = 'TWB64 - Pack 2' then
    if InRange(gambatte_gb_palette_twb64_2.ItemIndex, Low(GambatteColors.gambatte_gb_palette_twb64_2), High(GambatteColors.gambatte_gb_palette_twb64_2)) then
    Exit(GambatteColors.gambatte_gb_palette_twb64_2[gambatte_gb_palette_twb64_2.ItemIndex]^);

    if gambatte_gb_internal_palette.Text = 'TWB64 - Pack 3' then
    if InRange(gambatte_gb_palette_twb64_3.ItemIndex, Low(GambatteColors.gambatte_gb_palette_twb64_3), High(GambatteColors.gambatte_gb_palette_twb64_3)) then
    Exit(GambatteColors.gambatte_gb_palette_twb64_3[gambatte_gb_palette_twb64_3.ItemIndex]^);

    if gambatte_gb_internal_palette.Text = 'PixelShift - Pack 1' then
    if InRange(gambatte_gb_palette_pixelshift_1.ItemIndex, Low(GambatteColors.gambatte_gb_palette_pixelshift_1), High(GambatteColors.gambatte_gb_palette_pixelshift_1)) then
    Exit(GambatteColors.gambatte_gb_palette_pixelshift_1[gambatte_gb_palette_pixelshift_1.ItemIndex]^);

    if InRange(gambatte_gb_internal_palette.ItemIndex, Low(GambatteColors.gambatte_gb_internal_palette), High(GambatteColors.gambatte_gb_internal_palette)) then
    Exit(GambatteColors.gambatte_gb_internal_palette[gambatte_gb_internal_palette.ItemIndex]^);
  end;

  if gambatte_gb_colorization.Text = 'custom' then
  Exit(LastCustom);

  Exit(default);
end;
begin
  SetGambatteColorMap(GetPalette());
end;

procedure TFrameGambatteColorPicker.HandleComboBoxSelectBeetleCygne(Sender: TObject);
var
  i: Integer;
  b1, g1, r1, b4, g4, r4: Byte;
  c2, c3: Integer;
begin
  i := (Sender as TComboBox).ItemIndex;
  if InRange(i, Low(wswan_mono_palette), High(wswan_mono_palette)) then
  begin
    // note: color order in const is swapped compared to other machines and has to be interpolated by the user
    b1 := Byte(wswan_mono_palette[i][2] shr 16);
    g1 := Byte(wswan_mono_palette[i][2] shr 8);
    r1 := Byte(wswan_mono_palette[i][2]);
    b4 := Byte(wswan_mono_palette[i][1] shr 16);
    g4 := Byte(wswan_mono_palette[i][1] shr 8);
    r4 := Byte(wswan_mono_palette[i][1]);

    // code taken from the source, but arguments 5 and 9 taken from screenshots of the Windows version (which can only do default palette) and confirmed with GB300 screenshots
    c2 := Trunc(((15 - 5) * r1 + 5 * r4) / 15 + 0.5) or
          Trunc(((15 - 5) * g1 + 5 * g4) / 15 + 0.5) shl 8 or
          Trunc(((15 - 5) * b1 + 5 * b4) / 15 + 0.5) shl 16;
    c3 := Trunc(((15 - 9) * r1 + 9 * r4) / 15 + 0.5) or
          Trunc(((15 - 9) * g1 + 9 * g4) / 15 + 0.5) shl 8 or
          Trunc(((15 - 9) * b1 + 9 * b4) / 15 + 0.5) shl 16;

    SetGambatteColorMap([wswan_mono_palette[i][2], c2, c3, wswan_mono_palette[i][1]]);
  end;
end;

procedure TFrameGambatteColorPicker.HandleComboBoxSelectGearboy(Sender: TObject);
begin
  if InRange((Sender as TComboBox).ItemIndex, Low(gearboy_palette), High(gearboy_palette)) then
  SetGambatteColorMap(gearboy_palette[(Sender as TComboBox).ItemIndex]^);
end;

procedure TFrameGambatteColorPicker.HandleComboBoxSelectPokeMini(Sender: TObject);
begin
  if InRange((Sender as TComboBox).ItemIndex, Low(pokem_palette), High(pokem_palette)) then
  SetGambatteColorMap(pokem_palette[(Sender as TComboBox).ItemIndex]^);
end;

procedure TFrameGambatteColorPicker.HandleComboBoxSelectPotator(Sender: TObject);
begin
  if InRange((Sender as TComboBox).ItemIndex, Low(potator_palette), High(potator_palette)) then
  SetGambatteColorMap(potator_palette[(Sender as TComboBox).ItemIndex]^);
end;

procedure TFrameGambatteColorPicker.Init(gambatte_gb_colorization,
  gambatte_gb_internal_palette, gambatte_gb_palette_twb64_1,
  gambatte_gb_palette_twb64_2, gambatte_gb_palette_twb64_3,
  gambatte_gb_palette_pixelshift_1: TComboBox; const ROMFullFilename: string);
var
  FS: TStream;
  INI: TINIFile;
  PalFilePath: string;
  TempPalFileName: string;
  DefaultPalFileName: string;
  PerGamePalFileName: string;
begin
  Self.gambatte_gb_colorization := gambatte_gb_colorization;
  Self.gambatte_gb_internal_palette := gambatte_gb_internal_palette;
  Self.gambatte_gb_palette_twb64_1 := gambatte_gb_palette_twb64_1;
  Self.gambatte_gb_palette_twb64_2 := gambatte_gb_palette_twb64_2;
  Self.gambatte_gb_palette_twb64_3 := gambatte_gb_palette_twb64_3;
  Self.gambatte_gb_palette_pixelshift_1 := gambatte_gb_palette_pixelshift_1;
  Self.ROMFullFilename := ROMFullFilename; // as this is multicore, we always have an actual ROM

  // Add listeners
  gambatte_gb_colorization.OnSelect := HandleComboBoxSelect;
  gambatte_gb_internal_palette.OnSelect := HandleComboBoxSelect;
  gambatte_gb_palette_twb64_1.OnSelect := HandleComboBoxSelect;
  gambatte_gb_palette_twb64_2.OnSelect := HandleComboBoxSelect;
  gambatte_gb_palette_twb64_3.OnSelect := HandleComboBoxSelect;
  gambatte_gb_palette_pixelshift_1.OnSelect := HandleComboBoxSelect;

  LabelDescriptionNonGambatte.Hide();

  if FileExists(ROMFullFilename) then // load internal ROM name
  begin
    FS := TFileStream.Create(ROMFullFilename, fmOpenRead or fmShareDenyNone);
    try
      FS.Position := 308;
      SetLength(GameName, 17);
      FS.Read(GameName[1], Length(GameName));
      GameName := Copy(GameName, 1, System.Pos(AnsiChar(#0), GameName)-1);
    finally
      FS.Free();
    end;
  end;

  // as per-game settings are explicitly per-file, we do not use the internal name (GameName field in this class) to make palettes per-file too
  PalFilePath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'bios') + 'palettes');
  DefaultPalFileName := PalFilePath + 'default.pal';
  PerGamePalFileName := PalFilePath + ChangeFileExt(ExtractFileName(ROMFullFilename), '.pal');

  // what palette to SAVE to
  if ROMFullFilename = '' then
  PalFileName := DefaultPalFileName
  else
  PalFileName := PerGamePalFileName;

  // what palette to LOAD from - if there is no per-game palette saved, load from default.pal but save to per-game palette
  TempPalFileName := DefaultPalFileName;
  if ROMFullFilename <> '' then
  if FileExists(PerGamePalFileName) then
  TempPalFileName := PerGamePalFileName;

  LastCustom := default;
  if FileExists(TempPalFileName) then
  begin
    INI := TIniFile.Create(TempPalFileName);
    try
      LastCustom[1]  := INI.ReadInteger('General', 'Background0', LastCustom[1]);
      LastCustom[2]  := INI.ReadInteger('General', 'Background1', LastCustom[2]);
      LastCustom[3]  := INI.ReadInteger('General', 'Background2', LastCustom[3]);
      LastCustom[4]  := INI.ReadInteger('General', 'Background3', LastCustom[4]);
      LastCustom[5]  := INI.ReadInteger('General', 'Sprite%2010', LastCustom[5]);
      LastCustom[6]  := INI.ReadInteger('General', 'Sprite%2011', LastCustom[6]);
      LastCustom[7]  := INI.ReadInteger('General', 'Sprite%2012', LastCustom[7]);
      LastCustom[8]  := INI.ReadInteger('General', 'Sprite%2013', LastCustom[8]);
      LastCustom[9]  := INI.ReadInteger('General', 'Sprite%2020', LastCustom[9]);
      LastCustom[10] := INI.ReadInteger('General', 'Sprite%2021', LastCustom[10]);
      LastCustom[11] := INI.ReadInteger('General', 'Sprite%2022', LastCustom[11]);
      LastCustom[12] := INI.ReadInteger('General', 'Sprite%2023', LastCustom[12]);
    finally
      INI.Free();
    end;
  end;

  InitDone := True;
  HandleComboBoxSelect(nil);
end;

procedure TFrameGambatteColorPicker.InitBeetleCygne(wswan_mono_palette: TComboBox);
begin
  wswan_mono_palette.OnSelect := HandleComboBoxSelectBeetleCygne;
  HandleComboBoxSelectBeetleCygne(wswan_mono_palette);
  LabelHint.Free();
  LabelDescriptionGambatte.Free();
  SetSwatchCount(4);
  Enabled := False;
  InitDone := True;
end;

procedure TFrameGambatteColorPicker.InitGearboy(gearboy_palette: TComboBox);
begin
  gearboy_palette.OnSelect := HandleComboBoxSelectGearboy;
  HandleComboBoxSelectGearboy(gearboy_palette);
  LabelHint.Free();
  LabelDescriptionGambatte.Free();
  SetSwatchCount(4);
  Enabled := False;
  InitDone := True;
end;

procedure TFrameGambatteColorPicker.InitPokeMini(pokemini_palette: TComboBox);
begin
  pokemini_palette.OnSelect := HandleComboBoxSelectPokeMini;
  HandleComboBoxSelectPokeMini(pokemini_palette);
  LabelHint.Free();
  LabelDescriptionGambatte.Free();
  SetSwatchCount(3);
  Enabled := False;
  InitDone := True;
end;

procedure TFrameGambatteColorPicker.InitPotator(potator_palette: TComboBox);
begin
  potator_palette.OnSelect := HandleComboBoxSelectPotator;
  HandleComboBoxSelectPotator(potator_palette);
  LabelHint.Free();
  LabelDescriptionGambatte.Free();
  SetSwatchCount(4);
  Enabled := False;
  InitDone := True;
end;

procedure TFrameGambatteColorPicker.SavePal;
var
  INI: TMemIniFile;
begin
  ForceDirectories(ExtractFilePath(PalFileName));
  INI := TMemIniFile.Create(PalFileName);
  try
    INI.WriteInteger('General', 'Background0', LastCustom[1]);
    INI.WriteInteger('General', 'Background1', LastCustom[2]);
    INI.WriteInteger('General', 'Background2', LastCustom[3]);
    INI.WriteInteger('General', 'Background3', LastCustom[4]);
    INI.WriteInteger('General', 'Sprite%2010', LastCustom[5]);
    INI.WriteInteger('General', 'Sprite%2011', LastCustom[6]);
    INI.WriteInteger('General', 'Sprite%2012', LastCustom[7]);
    INI.WriteInteger('General', 'Sprite%2013', LastCustom[8]);
    INI.WriteInteger('General', 'Sprite%2020', LastCustom[9]);
    INI.WriteInteger('General', 'Sprite%2021', LastCustom[10]);
    INI.WriteInteger('General', 'Sprite%2022', LastCustom[11]);
    INI.WriteInteger('General', 'Sprite%2023', LastCustom[12]);
    INI.UpdateFile();
  finally
    INI.Free();
  end;
end;

procedure TFrameGambatteColorPicker.SetGambatteColorMap(const Value: array of Integer);
var
  i: Byte;
begin
  for i := Low(Value) to High(Value) do
  Shapes[i+1].Brush.Color := SwapColor(Value[i]);
end;

procedure TFrameGambatteColorPicker.SetSwatchCount(Count: Byte);
begin
  for Count := Count + 1 to High(Shapes) do
  Shapes[Count].Hide();
end;

procedure TFrameGambatteColorPicker.ShapeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = TMouseButton.mbLeft then
  begin
    ColorDialog.Color := (Sender as TShape).Brush.Color;

    if ColorDialog.Execute() then
    begin
      (Sender as TShape).Brush.Color := ColorDialog.Color;
      LastCustom := GetGambatteColorMap();
      gambatte_gb_colorization.ItemIndex := gambatte_gb_colorization.Items.IndexOf('custom');
    end;
  end;
end;

end.
