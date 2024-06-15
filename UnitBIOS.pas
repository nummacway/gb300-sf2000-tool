unit UnitBIOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GB300Utils, GUIHelpers, System.IOUtils;

type
  TFrameBIOS = class(TFrame)
    GroupBoxBootloader: TGroupBox;
    LabelPatchBootloader: TLabel;
    CheckBoxPatchBootloader: TCheckBox;
    CheckBoxPointlessFile1: TCheckBox;
    CheckBoxPointlessFile2: TCheckBox;
    CheckBoxPointlessFile3: TCheckBox;
    CheckBoxPointlessFile4: TCheckBox;
    LabelPointlessFile: TLabel;
    GroupBoxGBABIOS: TGroupBox;
    LabelGBABIOS: TLabel;
    GroupBoxBIOS: TGroupBox;
    TimerLazyLoad: TTimer;
    PanelBootLogoDoubleBufferer: TPanel;
    ImageBootLogo: TImage;
    LabelCRC: TLabel;
    LabelCRCStatus: TLabel;
    LabelCRCInfo: TLabel;
    ButtonCRCFix: TButton;
    ButtonCRCRefresh: TButton;
    LabelBootLogo: TLabel;
    ButtonBootLogoSave: TButton;
    ButtonBootLogoReplace: TButton;
    ButtonBootLogoRefresh: TButton;
    GroupBoxROMFixes: TGroupBox;
    ButtonFixMDThumbs: TButton;
    LabelFixMDThumbs: TLabel;
    ButtonFixGlazedThumb: TButton;
    LabelFixGlazedThumb: TLabel;
    SaveDialogBootLogo: TSaveDialog;
    OpenDialogBootLogo: TOpenDialog;
    LabelBootLogo1: TLabel;
    LabelScreen: TLabel;
    ComboBoxScreen: TComboBox;
    CheckBoxGBABIOS0: TCheckBox;
    LabelGBABIOS1: TLabel;
    CheckBoxGBABIOS1: TCheckBox;
    CheckBoxGBABIOS2: TCheckBox;
    CheckBoxGBABIOS3: TCheckBox;
    CheckBoxGBABIOS4: TCheckBox;
    CheckBoxGBABIOS5: TCheckBox;
    CheckBoxGBABIOS6: TCheckBox;
    CheckBoxGBABIOS7: TCheckBox;
    GroupBoxReset: TGroupBox;
    LabelReset: TLabel;
    ButtonClearFavorites: TButton;
    ButtonClearHistory: TButton;
    ButtonClearKeyMap: TButton;
    LabelScreen2: TLabel;
    CheckBoxVT03: TCheckBox;
    LabelSearchResultSelColor: TLabel;
    ColorBoxSearchResultSelColor: TColorBox;
    LabelSearchResultSelColor2: TLabel;
    ButtonAlwaysUseFCEUmm: TButton;
    Label1: TLabel;
    CheckBoxPatchVT03LUT: TCheckBox;
    Label2: TLabel;
    CheckBoxVT03SizeHack: TCheckBox;
    Label3: TLabel;
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ButtonCRCRefreshClick(Sender: TObject);
    procedure ButtonBootLogoRefreshClick(Sender: TObject);
    procedure ButtonCRCFixClick(Sender: TObject);
    procedure ButtonBootLogoReplaceClick(Sender: TObject);
    procedure ButtonBootLogoSaveClick(Sender: TObject);
    procedure ButtonFixMDThumbsClick(Sender: TObject);
    procedure ComboBoxScreenSelect(Sender: TObject);
    procedure CheckBoxPatchBootloaderClick(Sender: TObject);
    procedure CheckBoxPointlessFileClick(Sender: TObject);
    procedure ButtonFixGlazedThumbClick(Sender: TObject);
    procedure ButtonClearFavoritesClick(Sender: TObject);
    procedure ButtonClearHistoryClick(Sender: TObject);
    procedure ButtonClearKeyMapClick(Sender: TObject);
    procedure CheckBoxGBABIOSClick(Sender: TObject);
    procedure CheckBoxVT03Click(Sender: TObject);
    procedure ColorBoxSearchResultSelColorChange(Sender: TObject);
    procedure ButtonAlwaysUseFCEUmmClick(Sender: TObject);
    procedure CheckBoxPatchVT03LUTClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoCRCCheckReset();
    procedure DoCRCCheck(BIOS: TBIOS);
    procedure DoUpdateBootLogo(BIOS: TBIOS);
    procedure DoReplaceBootLogo(FileName: string);
    function GetPointlessFileName(i: Integer): string;
    function GetGBABIOSFileName(i: Integer): string;
    procedure UpdateGBABIOSStatus();
    procedure DoDelete(FileName: string);
    procedure DropBootlogo(Sender: TObject);
    var
      FirmwareFileName: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  PngImage, UITypes, UnitMain;

{$R *.dfm}

{ TFrameBIOS }

procedure TFrameBIOS.ButtonAlwaysUseFCEUmmClick(Sender: TObject);
var
  sl: TStringList;
  Candidate: string;
  ROM: TROMFile;
  ROMROM: TMemoryStream;
  Line: string;
  i: Integer;
  b: Byte;
  NL: TNameList;
begin
  // this is not the function you can expect from the name of the function but generates some testing output of iNES files in ROMS
  sl := TStringList.Create();
  try
    NL := TNameList.Create();
    NL.LoadFromFile(FileNamesFilenames[7]);
    for Candidate in {TDirectory.GetFiles(Path + 'FC', '*.zfc')} NL do
    begin
      ROM := TROMFile.Create();
      try
        ROM.LoadFromFile(7, ExtractFileName(Candidate));
        ROMROM := ROM.ROM;
        try
          Line := ROM.ROMFileName;
          Line := ExtractFileName(Candidate) + ';' + ChangeFileExt(Line, '') + ';' + ExtractFileExt(Line);
          for i := 0 to 15 do
          begin
            ROMROM.ReadData(b);
            Line := Line + ';="' + IntToHex(b, 2) + '"';
          end;
          sl.Add(Line);
        finally
          ROMROM.Free();
        end;
      finally
        ROM.Free();
      end;
    end;
  finally
    sl.SaveToFile('ines.csv');
    sl.Free();
  end;
end;

procedure TFrameBIOS.ButtonBootLogoRefreshClick(Sender: TObject);
var
  BIOS: TBIOS;
begin
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    DoUpdateBootLogo(BIOS);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.ButtonBootLogoReplaceClick(Sender: TObject);
begin
  DoCRCCheckReset();
  if OpenDialogBootLogo.Execute() then
  DoReplaceBootLogo(OpenDialogBootLogo.FileName);
end;

procedure TFrameBIOS.ButtonBootLogoSaveClick(Sender: TObject);
var
  BIOS: TBIOS;
  FS: TFileStream;
begin
  if SaveDialogBootLogo.Execute() then
  begin
    BIOS := TBIOS.Create();
    try
      BIOS.LoadFromFile(TBIOS.Path);
      FS := TFileStream.Create(SaveDialogBootLogo.FileName, fmCreate);
      try
        BIOS.SaveBootLogoToStream(FS);
      finally
        FS.Free();
      end;
    finally
      BIOS.Free();
    end;
  end;
end;

procedure TFrameBIOS.ButtonClearFavoritesClick(Sender: TObject);
begin
  DoDelete('Favorites.bin');
  Favorites.Clear();
end;

procedure TFrameBIOS.ButtonClearHistoryClick(Sender: TObject);
begin
  DoDelete('History.bin');
  History.Clear();
end;

procedure TFrameBIOS.ButtonClearKeyMapClick(Sender: TObject);
begin
  DoDelete('KeyMapInfo.kmp');
end;

procedure TFrameBIOS.ButtonCRCFixClick(Sender: TObject);
var
  BIOS: TBIOS;
begin
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.StoredCRC := BIOS.CalculatedCRC;
    BIOS.SaveToFile(TBIOS.Path);
    ButtonCRCRefreshClick(nil);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.ButtonCRCRefreshClick(Sender: TObject);
var
  BIOS: TBIOS;
begin
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    DoCRCCheck(BIOS);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.ButtonFixGlazedThumbClick(Sender: TObject);
var
  FileName: string;
  PNG: TPngImage;
  MS, MS2: TMemoryStream;
  Header: Cardinal;
begin
  FileName := IncludeTrailingPathDelimiter(Path + 'GBA') + 'Pokemon - Glazed Version (CN).zgb';
  MS := TMemoryStream.Create(); // Using a FileStream here will probably not get me an handle on the file for writing
  try
    MS.LoadFromFile(FileName);
    MS.Position := 346 * 500 * 2;
    MS.ReadData(Header);
    if Header <> $03575157 then
    raise Exception.Create('Patch is not applicable (file is unsupported or already patched)');

    PNG := GetPNG(2002);
    try
      MS2 := TMemoryStream.Create();
      try
        WriteGraphicToStream(PNG, MS2, idfRGB565, 144, 208, False);
        MS.Position := 346 * 500 * 2;
        MS2.CopyFrom2(MS, MS.Size - MS.Position);
        MS2.SaveToFile(FileName);
      finally
        MS2.Free();
      end;
    finally
      PNG.Free();
    end;
  finally
    MS.Free();
  end;
end;

procedure TFrameBIOS.ButtonFixMDThumbsClick(Sender: TObject);
var
  Candidate: string;
  Image: TGraphic;
  Header: Cardinal;
  FS: TFileStream;
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    for Candidate in TDirectory.GetFiles(Path + 'MD') do
    begin
      FS := TFileStream.Create(Candidate, fmOpenRead);
      try
        FS.Position := 2 * $EA00;
        FS.ReadData(Header);
        if Header <> $03575157 then // not a double-the-normal-size thumbnail
        Continue;

        FS.Position := 0;
        Image := GetDIBImageFromStream(FS, idfBGRA8888, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y);
        try
          MS.Clear();
          WriteGraphicToStream(Image, MS, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y, False);
        finally
          Image.Free();
        end;
        MS.CopyFrom(FS, FS.Size - FS.Position);
      finally
        FS.Free();
      end;
      MS.SaveToFile(Candidate);
    end;
  finally
    MS.Free();
  end;
end;

procedure TFrameBIOS.CheckBoxGBABIOSClick(Sender: TObject);
var
  cb: TCheckBox;
  fn: string;
begin
  cb := Sender as TCheckBox;
  fn := GetGBABIOSFileName(cb.Tag);
  try
    if cb.Checked then
    begin
      ForceDirectories(ExtractFilePath(fn)); // required for CopyFile to work
      CopyFile(PChar(IncludeTrailingPathDelimiter(Path + 'bios') + 'gba_bios.bin'), PChar(fn), True);
    end
    else
    begin
      DeleteFile(fn);
      RemoveDir(ExtractFilePath(fn));
      RemoveDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(fn))));
      RemoveDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(fn))))));
    end;
  finally
    UpdateGBABIOSStatus();
  end;
end;

procedure TFrameBIOS.CheckBoxPatchBootloaderClick(Sender: TObject);
var
  RS: TResourceStream;
begin
  try
    if CheckBoxPatchBootloader.Checked then
    begin
      ForceDirectories(ExtractFilePath(FirmwareFileName));
      RS := TResourceStream.CreateFromID(HInstance, 42, RT_RCDATA);
      try
        RS.SaveToFile(FirmwareFileName);
      finally
        RS.Free();
      end;
    end
    else
    begin
      DeleteFile(FirmwareFileName);
      RemoveDir(ExtractFilePath(FirmwareFileName)); // only works if empty
    end;
  except
    CheckBoxPatchBootloader.Checked := not CheckBoxPatchBootloader.Checked; // undo
    raise;
  end;
end;

procedure TFrameBIOS.CheckBoxPatchVT03LUTClick(Sender: TObject);
var
  BIOS: TBIOS;
begin
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.VT03LUT565 := CheckBoxPatchVT03LUT.Checked;
    BIOS.StoredCRC := BIOS.CalculatedCRC;
    BIOS.SaveToFile(TBIOS.Path);
    ButtonCRCRefreshClick(nil);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.CheckBoxPointlessFileClick(Sender: TObject);
var
  FS: TFileStream;
begin
  if (Sender as TCheckBox).Checked then
  begin
    FS := TFileStream.Create(GetPointlessFileName((Sender as TCheckBox).Tag), fmCreate);
    FS.Free();
  end
  else
  DeleteFile(GetPointlessFileName((Sender as TCheckBox).Tag));
end;

procedure TFrameBIOS.CheckBoxVT03Click(Sender: TObject);
var
  BIOS: TBIOS;
begin
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.VT03 := CheckBoxVT03.Checked;
    BIOS.StoredCRC := BIOS.CalculatedCRC;
    BIOS.SaveToFile(TBIOS.Path);
    ButtonCRCRefreshClick(nil);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.ColorBoxSearchResultSelColorChange(Sender: TObject);
var
  BIOS: TBIOS;
begin
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.SearchResultSelColor := ColorBoxSearchResultSelColor.Selected;
    BIOS.StoredCRC := BIOS.CalculatedCRC;
    BIOS.SaveToFile(TBIOS.Path);
    ButtonCRCRefreshClick(nil);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.ComboBoxScreenSelect(Sender: TObject);
procedure Patch(Resource: Word);
var
  RS: TResourceStream;
  BIOS: TBIOS;
begin
  RS := TResourceStream.CreateFromID(HInstance, Resource, RT_RCDATA);
  try
    BIOS := TBIOS.Create();
    try
      BIOS.LoadFromFile(TBIOS.Path);
      BIOS.Position := TBIOS.DisplayInitOffset;
      BIOS.CopyFrom(RS);
      BIOS.StoredCRC := BIOS.CalculatedCRC;
      BIOS.SaveToFile(TBIOS.Path);
      ButtonCRCRefreshClick(nil);
    finally
      BIOS.Free();
    end;
  finally
    RS.Free();
  end;
  ButtonCRCRefreshClick(nil);
end;
begin
  case ComboBoxScreen.ItemIndex of
    0:
      if MessageDlg('Do you want to change the display init code back to the original one?', mtWarning, mbYesNo, 0) = mrYes then
      Patch(300)
      else
      TimerLazyLoadTimer(TimerLazyLoad);
    1:
      if MessageDlg('If you''ve opened your GB300 and swapped in the SF2000''s screen, you''ll notice that your screen is now upside-down and inverted.'#13#10'This feature will install a patch created by bnister (osaka) and Dteyn to fix this.'#13#10#13#10'Do you want to continue?', mtWarning, mbYesNo, 0) = mrYes then
      Patch(2000)
      else
      TimerLazyLoadTimer(TimerLazyLoad);
  end;
end;

constructor TFrameBIOS.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  FirmwareFileName := IncludeTrailingPathDelimiter(Path + 'UpdateFirmware') + 'Firmware.upk';
  CheckBoxPatchBootloader.CheckedNoClick := FileExists(FirmwareFileName);
  for i := 1 to 4 do
  (FindComponent('CheckboxPointlessFile' + IntToStr(i)) as TCheckBox).CheckedNoClick := FileExists(GetPointlessFileName(i));
  for i := 0 to 7 do
  (FindComponent('CheckboxGBABIOS' + IntToStr(i)) as TCheckBox).Caption := StringReplace(Foldername.Folders[i], '&', '&&', [rfReplaceAll]);
  UpdateGBABIOSStatus();
  Form1.DragIn.OnDrop := DropBootlogo;
  Form1.DragIn.Enabled := True;
end;

procedure TFrameBIOS.DoCRCCheck(BIOS: TBIOS);
begin
  if BIOS.IsCRCValid then
  begin
    LabelCRCStatus.Caption := 'VALID';
    LabelCRCStatus.Font.Color := clGreen;
  end
  else
  begin
    LabelCRCStatus.Caption := 'INVALID';
    LabelCRCStatus.Font.Color := clMaroon;
  end;
end;

procedure TFrameBIOS.DoCRCCheckReset;
begin
  LabelCRCStatus.Caption := '...';
  LabelCRCStatus.Font.Color := Font.Color;
end;

procedure TFrameBIOS.DoDelete(FileName: string);
begin
  if MessageDlg('Do you really want to delete ''' + FileName + '''?', mtWarning, mbYesNo, 0) = mrYes then
  DeleteFile(IncludeTrailingPathDelimiter(Path + 'Resources') + FileName)
  else
  Abort;
end;

procedure TFrameBIOS.DoReplaceBootLogo(FileName: string);
var
  BIOS: TBIOS;
  Image: TPicture;
begin
  Image := TPicture.Create();
  try
    Image.LoadFromFile(FileName);
    BIOS := TBIOS.Create();
    try
      BIOS.LoadFromFile(TBIOS.Path);
      BIOS.BootLogo := Image.Graphic;
      BIOS.StoredCRC := BIOS.CalculatedCRC;
      BIOS.SaveToFile(TBIOS.Path);
      ButtonCRCRefreshClick(nil);
      ButtonBootLogoRefreshClick(nil);
    finally
      BIOS.Free();
    end;
  finally
    Image.Free();
  end;
end;

procedure TFrameBIOS.DoUpdateBootLogo(BIOS: TBIOS);
var
  Logo: TGraphic;
begin
  Logo := BIOS.BootLogo;
  try
    ImageBootLogo.Picture.Assign(Logo);
  finally
    Logo.Free();
  end;
end;

procedure TFrameBIOS.DropBootlogo(Sender: TObject);
begin
  if Form1.DragIn.FileList.Count <> 1 then
  raise Exception.Create('Can only use exactly one file for the boot logo');
  DoReplaceBootLogo(Form1.DragIn.FileList[0]);
end;

function TFrameBIOS.GetGBABIOSFileName(i: Integer): string;
begin
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + Foldername.Folders[i]) + 'mnt') + 'sda1') + 'bios') + 'gba_bios.bin';
end;

function TFrameBIOS.GetPointlessFileName(i: Integer): string;
begin
  // not using Format strings instead of this method in case people have % in their directory (people do strange things, you know...)
  Result := IncludeTrailingPathDelimiter(Path + 'BIOS') + 'temp' + IntToStr(i) + '.txt';
end;

procedure TFrameBIOS.TimerLazyLoadTimer(Sender: TObject);
var
  BIOS: TBIOS;
begin
  TimerLazyLoad.Enabled := False;
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    if BIOS.Size <> 7299832 then
    if GroupBoxBIOS.Visible then
    begin
      MessageDlg('Your BIOS has a different size than expected.'#13#10#13#10'Please contact numma_cway on Discord to have GB300 Tool updated to support it.'#13#10#13#10'The BIOS settings will now disappear to prevent GB300 Tool from breaking anything.', mtWarning, [mbOk], 0);
      GroupBoxBIOS.Hide();
      Exit;
    end;
    DoCRCCheck(BIOS);
    DoUpdateBootLogo(BIOS);
    VTxxEnabled := BIOS.VT03;
    CheckBoxVT03.CheckedNoClick := VTxxEnabled;
    CheckBoxPatchVT03LUT.CheckedNoClick := BIOS.VT03LUT565;
    ColorBoxSearchResultSelColor.Selected := BIOS.SearchResultSelColor;
    ComboBoxScreen.ItemIndex := Ord(BIOS.GetScreenIndex);
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.UpdateGBABIOSStatus();
var
  i: Byte;
begin
  for i := 0 to 7 do
  (FindComponent('CheckboxGBABIOS' + IntToStr(i)) as TCheckBox).CheckedNoClick := FileExists(GetGBABIOSFileName(i));
end;

end.
