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
    GroupBoxBIOSGB300: TGroupBox;
    TimerLazyLoad: TTimer;
    PanelBootLogoDoubleBufferer: TPanel;
    ImageBootLogoGB300: TImage;
    LabelCRC: TLabel;
    LabelCRCStatusGB300: TLabel;
    LabelCRCInfo: TLabel;
    ButtonCRCFixGB300: TButton;
    ButtonCRCRefreshGB300: TButton;
    LabelBootLogo: TLabel;
    ButtonBootLogoSaveGB300: TButton;
    ButtonBootLogoReplaceGB300: TButton;
    ButtonBootLogoRefreshGB300: TButton;
    GroupBoxROMFixes: TGroupBox;
    ButtonFixMDThumbs: TButton;
    LabelFixMDThumbs: TLabel;
    ButtonFixGlazedThumb: TButton;
    LabelFixGlazedThumb: TLabel;
    SaveDialogBootLogo: TSaveDialog;
    OpenDialogBootLogo: TOpenDialog;
    LabelBootLogo1: TLabel;
    LabelScreen: TLabel;
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
    ButtonAlwaysUseFCEUmm: TButton;
    Label1: TLabel;
    CheckBoxPatchVT03LUT: TCheckBox;
    Label3: TLabel;
    CheckBoxFDS: TCheckBox;
    CheckBoxGBABIOS8: TCheckBox;
    GroupBoxBIOSSF2000: TGroupBox;
    Label2: TLabel;
    LabelCRCStatusSF2000: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    ImageBootLogoSF2000: TImage;
    ButtonCRCFixSF2000: TButton;
    ButtonCRCRefreshSF2000: TButton;
    ButtonBootLogoSaveSF2000: TButton;
    ButtonBootLogoReplaceSF2000: TButton;
    ButtonBootLogoRefreshSF2000: TButton;
    Label4: TLabel;
    CheckBoxGaroupSF2000: TCheckBox;
    CheckBoxGaroupGB300: TCheckBox;
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ButtonCRCRefreshClick(Sender: TObject);
    procedure ButtonBootLogoRefreshClick(Sender: TObject);
    procedure ButtonCRCFixClick(Sender: TObject);
    procedure ButtonBootLogoReplaceClick(Sender: TObject);
    procedure ButtonBootLogoSaveClick(Sender: TObject);
    procedure ButtonFixMDThumbsClick(Sender: TObject);
    procedure CheckBoxPatchBootloaderClick(Sender: TObject);
    procedure CheckBoxPointlessFileClick(Sender: TObject);
    procedure ButtonFixGlazedThumbClick(Sender: TObject);
    procedure ButtonClearFavoritesClick(Sender: TObject);
    procedure ButtonClearHistoryClick(Sender: TObject);
    procedure ButtonClearKeyMapClick(Sender: TObject);
    procedure CheckBoxGBABIOSClick(Sender: TObject);
    procedure CheckBoxVT03Click(Sender: TObject);
    procedure ButtonAlwaysUseFCEUmmClick(Sender: TObject);
    procedure CheckBoxPatchVT03LUTClick(Sender: TObject);
    procedure CheckBoxFDSClick(Sender: TObject);
    procedure CheckBoxGaroupClick(Sender: TObject);
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
(*var
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
    NL.LoadFromFile(FileNamesFilenames[UserROMsFolderIndex]);
    for Candidate in {TDirectory.GetFiles(Path + 'FC', '*.zfc')} NL do
    begin
      ROM := TROMFile.Create();
      try
        ROM.LoadFromFile(UserROMsFolderIndex, ExtractFileName(Candidate));
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
  end;  *)
var
  Candidate: string;
  ROM: TROMFile;
begin
  if CurrentDevice = cdSF2000 then
  raise Exception.Create('This feature would not affect the SF2000');

  for Candidate in TDirectory.GetFiles(Path + 'FC') do
  begin
    ROM := TROMFile.Create;
    try
      ROM.LoadFromFile(FCFolderIndex, ExtractFileName(Candidate));

      if ROM.ChangeExt('.nfc', '.nes') then
      ROM.SaveToFile(FCFolderIndex, ExtractFileName(Candidate), False);
    finally
      ROM.Free();
    end;
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

procedure TFrameBIOS.CheckBoxFDSClick(Sender: TObject);
//var
//  BIOS: TBIOS;
begin
{  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.FDS := CheckBoxFDS.Checked;
    BIOS.StoredCRC := BIOS.CalculatedCRC;
    BIOS.SaveToFile(TBIOS.Path);
    ButtonCRCRefreshClick(nil);
  finally
    BIOS.Free();
  end;  }
end;

procedure TFrameBIOS.CheckBoxGaroupClick(Sender: TObject);
var
  BIOS: TBIOS;
begin
  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    try
      if (Sender as TCheckBox).Checked then
      BIOS.GaroupP2Size := 8 * 1024 * 1024
      else
      BIOS.GaroupP2Size := 4 * 1024 * 1024;
      BIOS.StoredCRC := BIOS.CalculatedCRC;
      BIOS.SaveToFile(TBIOS.Path);
    finally
      CheckBoxGaroupGB300.CheckedNoClick := (Sender as TCheckBox).Checked;
      CheckBoxGaroupSF2000.CheckedNoClick := (Sender as TCheckBox).Checked;
      ButtonCRCRefreshClick(nil);
    end;
  finally
    BIOS.Free();
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
//var
//  BIOS: TBIOS;
begin
{  DoCRCCheckReset();
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.VT03LUT565 := CheckBoxPatchVT03LUT.Checked;
    BIOS.StoredCRC := BIOS.CalculatedCRC;
    BIOS.SaveToFile(TBIOS.Path);
    ButtonCRCRefreshClick(nil);
  finally
    BIOS.Free();
  end;      }
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
begin
{  DoCRCCheckReset();
  try
    TBIOS.Patch(3190+Byte(CheckBoxVT03.Checked), TBIOS.VT03Offset);
  except
    CheckBoxVT03.CheckedNoClick := not CheckBoxVT03.Checked;
    raise;
  end;
  ButtonCRCRefreshClick(nil);     }
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
  if CurrentDevice = cdSF2000 then
  CheckBoxGBABIOS8.Hide();
  GroupBoxBIOSGB300.Visible := CurrentDevice = cdGB300;
  GroupBoxBIOSSF2000.Visible := CurrentDevice = cdSF2000;
  for i := 0 to 8 do
  (FindComponent('CheckboxGBABIOS' + IntToStr(i)) as TCheckBox).Caption := StringReplace(Foldername.Folders[i], '&', '&&', [rfReplaceAll]);
  UpdateGBABIOSStatus();
  Form1.DragIn.OnDrop := DropBootlogo;
  Form1.DragIn.Enabled := True;
end;

procedure TFrameBIOS.DoCRCCheck(BIOS: TBIOS);
begin
  if BIOS.IsCRCValid then
  begin
    LabelCRCStatusGB300.Caption := 'VALID';
    LabelCRCStatusGB300.Font.Color := clGreen;
  end
  else
  begin
    LabelCRCStatusGB300.Caption := 'INVALID';
    LabelCRCStatusGB300.Font.Color := clMaroon;
  end;
  LabelCRCStatusSF2000.Caption := LabelCRCStatusGB300.Caption;
  LabelCRCStatusSF2000.Font.Color := LabelCRCStatusGB300.Font.Color;
end;

procedure TFrameBIOS.DoCRCCheckReset;
begin
  LabelCRCStatusGB300.Caption := '...';
  LabelCRCStatusGB300.Font.Color := Font.Color;
  LabelCRCStatusSF2000.Caption := '...';
  LabelCRCStatusSF2000.Font.Color := Font.Color;
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
    if CurrentDevice = cdGB300 then
    ImageBootLogoGB300.Picture.Assign(Logo);
    if CurrentDevice = cdSF2000 then
    ImageBootLogoSF2000.Picture.Assign(Logo);
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
    try
      BIOS.SizeSupported;
    except
      if GroupBoxBIOSGB300.Visible or GroupBoxBIOSSF2000.Visible then
      begin
        // cannot occur anymore as BIOS is checked before entering, unless people swap the card
        MessageDlg('Your BIOS has a different size than expected.'#13#10#13#10'Please contact numma_cway on Discord to have GB300+SF2000 Tool updated to support it.'#13#10#13#10'The BIOS settings will now disappear to prevent the tool from breaking anything.', mtWarning, [mbOk], 0);
        GroupBoxBIOSGB300.Hide();
        GroupBoxBIOSSF2000.Hide();
        Exit;
      end;
    end;
    DoCRCCheck(BIOS);
    DoUpdateBootLogo(BIOS);
    case BIOS.GaroupP2Size of
      8*1024*1024: HasGaroupPatch := True;
      4*1024*1024: HasGaroupPatch := False;
      else MessageDlg('garoup''s current P2 ROM size is neither 4 nor 8 MiB. This is unexpected for supported BIOS versions. You might want to submit your BIOS to the developer.', mtWarning, [mbOk], 0);
    end;
    CheckBoxGaroupSF2000.CheckedNoClick := HasGaroupPatch;
    CheckBoxGaroupGB300.CheckedNoClick := HasGaroupPatch;

    //CheckBoxFDS.CheckedNoClick := BIOS.FDS;
    //CheckBoxVT03.CheckedNoClick := BIOS.VT03;
    //CheckBoxPatchVT03LUT.CheckedNoClick := BIOS.VT03LUT565;
    //ColorBoxSearchResultSelColor.Selected := BIOS.SearchResultSelColor;
  finally
    BIOS.Free();
  end;
end;

procedure TFrameBIOS.UpdateGBABIOSStatus();
var
  i: Byte;
begin
  for i := 0 to 8 do
  (FindComponent('CheckboxGBABIOS' + IntToStr(i)) as TCheckBox).CheckedNoClick := FileExists(GetGBABIOSFileName(i));
end;

end.
