unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, IniFiles, ImageList, ImgList,
  uDragFilesTrg, System.Actions, Vcl.ActnList, Vcl.ExtActns;

type
  TFrameClass = class of TFrame;

  TForm1 = class(TForm)
    ShapeFrame1: TShape;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Image1: TImage;
    Image2: TImage;
    Label2: TLabel;
    Image3: TImage;
    Label3: TLabel;
    Image4: TImage;
    Label4: TLabel;
    Image5: TImage;
    Label5: TLabel;
    Image6: TImage;
    Label6: TLabel;
    Image7: TImage;
    Label7: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Image10: TImage;
    Image11: TImage;
    Label11: TLabel;
    Image12: TImage;
    Label12: TLabel;
    Shape8: TShape;
    Label8: TLabel;
    Image8: TImage;
    PanelFrame: TPanel;
    Image9: TImage;
    Label10: TLabel;
    Label9: TLabel;
    Shape9: TShape;
    PanelOnboarding: TPanel;
    ImageOnboardingDevice: TImage;
    LabelOnboardingName: TLabel;
    LabelOnboardingWelcome: TLabel;
    LabelOnboardingWorkingDir: TLabel;
    EditOnboardingWorkingDir: TEdit;
    ImageOnboardingClyde: TImage;
    ImageOnboardingOctocat: TImage;
    LabelOnboardingGithubRepository: TLabel;
    ButtonOnboardingStart: TButton;
    LabelUnboardingDiscordHandle: TLabel;
    ShapeOnboarding: TShape;
    PanelTop: TPanel;
    CheckBoxOnboardingChinese: TCheckBox;
    ImageListFileTypes: TImageList;
    ShapeFrame3: TShape;
    ShapeFrame2: TShape;
    TimerLazyLoad: TTimer;
    ActionList: TActionList;
    BrowseURL: TBrowseURL;
    Shape13: TShape;
    Image13: TImage;
    Label13: TLabel;
    ImageListCheckResults: TImageList;
    LabelOnboardingChinese: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure EditOnboardingWorkingDirChange(Sender: TObject);
    procedure ButtonOnboardingStartClick(Sender: TObject);
    procedure ShapeMouseEnter(Sender: TObject);
    procedure ShapeMouseLeave(Sender: TObject);
    procedure ShapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBoxOnboardingChineseClick(Sender: TObject);
  private
    { Private declarations }
    var
      Frame: TCustomFrame;
    procedure ShowFrame(FrameClass: TFrameClass);
    procedure LazyCreate();
    procedure HandleHover(NewTag: Byte);
    procedure HandleDown(NewTag: Byte);
  public
    { Public declarations }
    procedure UpdateLabels();
    procedure OpenURL(URL: string);
    var
      DragIn: TDragFilesTrg;
  end;

var
  Form1: TForm1;

implementation

uses
  GB300Utils, GB300UIConst, DateUtils, GUIHelpers, Generics.Collections,
  UnitBIOS, UnitUI, UnitStockROMs, UnitKeys, UnitUserROMs, UnitFavorites,
  UnitMulticore, MulticoreUtils, System.UITypes;

{$R *.dfm}

{ TForm1 }

procedure TForm1.ButtonOnboardingStartClick(Sender: TObject);
var
  FileNames: TObjectList<TNameList>;
  i: Integer;
  Core, CoreTGBDual, CoreGambatte, CoreGB, CoreGBB: TCore;
function IsCoreGambatte(Core: string; Default: Boolean): Boolean;
begin
  Core := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'cores') + Core) + 'core_87000000';
  if FileExists(Core) then
  Result := GetFileSize(Core) > 668206 // average of the two
  else
  Result := Default;
end;
begin
  Path := EditOnboardingWorkingDir.Text;
  if Length(Path) = 1 then
  Path := Path + ':';
  Path := IncludeTrailingPathDelimiter(Path);

  Foldername.LoadFromFile();
  Foldername.ForceAllDirectories();
  UpdateLabels();

  INI.WriteString('Onboarding', 'WorkingDir', Path);
  INI.WriteBool('Onboarding', 'Chinese', CheckBoxOnboardingChinese.Checked);
  HasMulticore := DirectoryExists(Path + 'cores');
  ShowChineseNames := CheckBoxOnboardingChinese.Checked;
  FileNames := TReferenceList.GetFileNames();
  try
    Favorites := TReferenceList.Create();
    Favorites.LoadFromFile('Favorites.bin', FileNames);
    History := TReferenceList.Create();
    History.LoadFromFile('History.bin', FileNames);
  finally
    FileNames.Free();
  end;
  PanelOnboarding.Hide();
  PanelTop.Show();
  Caption := Caption + ' – ' + Path;
  HandleHover(10);
  HandleDown(10);

  if HasMulticore then
  begin
    // Ever asked yourself how to cause the a lot of unnecessary work for tool developers? Just randomly swap important files around between versions!
    for i := Low(Cores) to High(Cores) do
    if Cores[i].Core = 'gb' then
    CoreTGBDual := Cores[i]
    else
    if Cores[i].Core = 'gbb' then
    CoreGambatte := Cores[i];

    if IsCoreGambatte('gb', False) then
    CoreGB := CoreGambatte
    else
    CoreGB := CoreTGBDual;

    if IsCoreGambatte('gbb', False) then
    CoreGBB := CoreGambatte
    else
    CoreGBB := CoreTGBDual;

    CoreGB.Core := 'gb';
    CoreGBB.Core := 'gbb';

    for i := Low(Cores) to High(Cores) do
    if Cores[i].Core = 'gb' then
    Cores[i] := CoreGB
    else
    if Cores[i].Core = 'gbb' then
    Cores[i] := CoreGBB;
  end;

  for Core in Cores do
  CoresDict.Add(Core.Core, Core);
end;

procedure TForm1.CheckBoxOnboardingChineseClick(Sender: TObject);
begin
  LabelOnboardingChinese.Visible := CheckBoxOnboardingChinese.Checked;
end;

procedure TForm1.EditOnboardingWorkingDirChange(Sender: TObject);
begin
  ButtonOnboardingStart.Enabled := Length(EditOnboardingWorkingDir.Text) > 0;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DragIn.Free(); // separate call prevents really odd bug in drag and drop component causing access violations when you exit (they are invisible, delay closing the form by some seconds)
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  INIPath: string;
begin
  if (Screen.Width < 1200) or (Screen.Height < 864) then
  MessageDlg('Your screen resolution seems to be lower than that of the OLPC XO-1, better known as the world’s cheapest laptop, released in 2007. GB300 Tool does not support such a low resolution.', mtWarning, [mbOk], 0);

  Randomize(); // used for the random background colors of the UI editor
  Application.Title := Caption;
  Foldername := DefaultFoldername;
  //ShowFrame(TFrameBIOS);
  INIPath := ExtractFilePath(ParamStr(0)) + 'GB300Tool.ini';
  if FileExists(INIPath) then
  INI := TIniFile.Create(INIPath)
  else
  begin
    INIPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(GetEnvironmentVariable('APPDATA')) + 'GB300 Tool');
    ForceDirectories(INIPath);
    INI := TIniFile.Create(INIPath + 'GB300Tool.ini');
  end;
  EditOnboardingWorkingDir.Text := INI.ReadString('Onboarding', 'WorkingDir', '');
  CheckBoxOnboardingChinese.Checked := INI.ReadBool('Onboarding', 'Chinese', False);
  LoadPNGTo(42, ImageOnboardingDevice.Picture);
  LoadPNGTo(1, ImageOnboardingOctocat.Picture);
  LoadPNGTo(2, ImageOnboardingClyde.Picture);
  DragIn := TDragFilesTrg.Create(Self);
  DragIn.Target := Self; // any other value does not work
  TPicture.RegisterFileFormat('DIB', 'Device Independent Bitmap', TWICImage); // why isn't this the default?
  CoresDict := TDictionary<string, TCore>.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  NoIntro.Free();
  INI.Free();
  CoresDict.Free();
end;

procedure TForm1.HandleDown(NewTag: Byte);
var
  i: Byte;
begin
  case NewTag of
    1..7:
      begin
        ShowFrame(TFrameStockROMs);
        (Frame as TFrameStockROMs).ListViewFiles.SmallImages := ImageListFileTypes;
        (Frame as TFrameStockROMs).LoadFromFiles(NewTag-1);
      end;
    8:
      begin
        ShowFrame(TFrameUserROMs);
        (Frame as TFrameUserROMs).ListViewFiles.SmallImages := ImageListFileTypes;
      end;
    9:
      begin
        ShowFrame(TFrameFavorites);
        (Frame as TFrameFavorites).ListViewFiles.SmallImages := ImageListFileTypes;
      end;
    10:
      ShowFrame(TFrameBIOS);
    11:
      ShowFrame(TFrameKeys);
    12:
      ShowFrame(TFrameUI);
    13:
      ShowFrame(TFrameMulticore);
  end;
  for i := 1 to 13 do
  with FindComponent('Shape' + IntToStr(i)) as TShape do
  if i = NewTag then
  begin
    Brush.Color := $e0e0e0;
    //Brush.Style := bsSolid;
    Enabled := False;
    SendToBack();
  end
  else
  begin
    Brush.Style := bsClear; // also changes Brush.Color to clWhite
    Enabled := True;
    BringToFront();
  end;
end;

procedure TForm1.HandleHover(NewTag: Byte);
var
  i: Byte;
begin
  for i := 1 to 13 do
  with FindComponent('Shape' + IntToStr(i)) as TShape do
  if (i = NewTag) or not Enabled then
  begin
    Pen.Style := psSolid;
  end
  else
  begin
    Pen.Style := psClear;
  end;
end;

procedure TForm1.LazyCreate;
const
  NoIntroPlatforms: array[0..27] of Word = (//12, 23, 25, 26, 32, 45, 46, 47, 49
    12,
    46,
    23,
    47,
    45,
    49,
    25,
    26,
    32,
    88,
    1,
    74,
    30,
    50,
    51,
    87,
    3,
    6,
    7,
    105,
    14,
    17,
    18,
    19,
    73,
    35,
    36,
    22);
var
  RS: TResourceStream;
  NoIntroPlatform: Word;
  Temp: TNoIntro;
begin
  // low-priority
  RS := TResourceStream.CreateFromID(HInstance, 1, 'XML');
  try
    LoadUIPreviews(RS);
  finally
    RS.Free();
  end;
  LoadPNGToList(1000, ImageListFileTypes);
  LoadPNGToList(997, ImageListCheckResults);
  LoadPNGTo(1001, Image1.Picture);
  LoadPNGTo(1002, Image2.Picture);
  LoadPNGTo(1003, Image3.Picture);
  LoadPNGTo(1004, Image4.Picture);
  LoadPNGTo(1005, Image5.Picture);
  LoadPNGTo(1006, Image6.Picture);
  LoadPNGTo(1007, Image7.Picture);
  LoadPNGTo(42, Image8.Picture);
  LoadPNGTo(1008, Image9.Picture);
  LoadPNGTo(1009, Image10.Picture);
  LoadPNGTo(1010, Image11.Picture);
  LoadPNGTo(1011, Image12.Picture);
  LoadPNGTo(1012, Image13.Picture);

  NoIntro := TDictionary<Cardinal, TNoIntro>.Create;
  //ZeroMemory(@Temp, SizeOf(TNoIntro));
  //Temp.Name := 'EMPTY FILE (MULTICORE STUB, NOT YET SUPPORTED)';
  //NoIntro.Add(0, Temp);
  for NoIntroPlatform in NoIntroPlatforms do
  begin
    RS := TResourceStream.CreateFromID(HInstance, NoIntroPlatform, 'DAT');
    try
      while RS.Position < RS.Size do
      begin
        Temp.LoadFromStream(RS);
        NoIntro.Add(Temp.CRC32, Temp);
      end;
    finally
      RS.Free();
    end;
  end;
end;

procedure TForm1.OpenURL(URL: string);
begin
  BrowseURL.URL := URL;
  BrowseURL.Execute();
end;

procedure TForm1.ShapeMouseEnter(Sender: TObject);
begin
  HandleHover((Sender as TComponent).Tag);
end;

procedure TForm1.ShapeMouseLeave(Sender: TObject);
begin
  HandleHover(255);
end;

procedure TForm1.ShapeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  HandleDown((Sender as TComponent).Tag);
end;

procedure TForm1.ShowFrame(FrameClass: TFrameClass);
begin
  DragIn.Enabled := False;
  FreeAndNil(Frame);
  Frame := FrameClass.Create(Self);
  Frame.Parent := PanelFrame;
end;

procedure TForm1.TimerLazyLoadTimer(Sender: TObject);
begin
  TimerLazyLoad.Enabled := False;
  LazyCreate();
end;

procedure TForm1.UpdateLabels;
var
  i: Byte;
begin
  for i := 1 to 8 do
  with FindComponent('Label' + IntToStr(i)) as TLabel do
  Caption := StringReplace(Foldername.Folders[i-1], '&', '&&', [rfReplaceAll]);
end;

end.
