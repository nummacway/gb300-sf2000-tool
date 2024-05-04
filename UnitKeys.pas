unit UnitKeys;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GUIHelpers, Vcl.Menus;

type
  TFrameKeys = class(TFrame)
    ImageFC: TImage;
    Label1: TLabel;
    ImagePCE: TImage;
    Label2: TLabel;
    ImageSFC: TImage;
    Label3: TLabel;
    ImageMD: TImage;
    Label4: TLabel;
    ImageGB: TImage;
    Label5: TLabel;
    ImageGBA: TImage;
    Label6: TLabel;
    LabelPlayer1: TLabel;
    ShapePlayer1: TShape;
    Image1A: TImage;
    Image1B: TImage;
    Image1X: TImage;
    Image1Y: TImage;
    Image1L: TImage;
    Image1R: TImage;
    Shape1: TShape;
    LabelPlayer2: TLabel;
    Image2A: TImage;
    Image2B: TImage;
    Image2X: TImage;
    Image2Y: TImage;
    Image2L: TImage;
    Image2R: TImage;
    Label7: TLabel;
    ComboBoxFC1A: TComboBox;
    CheckBoxFC1A: TCheckBox;
    ComboBoxFC1B: TComboBox;
    CheckBoxFC1B: TCheckBox;
    ComboBoxFC1X: TComboBox;
    CheckBoxFC1X: TCheckBox;
    ComboBoxFC1Y: TComboBox;
    CheckBoxFC1Y: TCheckBox;
    ComboBoxFC1L: TComboBox;
    CheckBoxFC1L: TCheckBox;
    ComboBoxFC1R: TComboBox;
    CheckBoxFC1R: TCheckBox;
    ComboBoxFC2A: TComboBox;
    CheckBoxFC2A: TCheckBox;
    ComboBoxFC2B: TComboBox;
    CheckBoxFC2B: TCheckBox;
    ComboBoxFC2X: TComboBox;
    CheckBoxFC2X: TCheckBox;
    ComboBoxFC2Y: TComboBox;
    CheckBoxFC2Y: TCheckBox;
    ComboBoxFC2L: TComboBox;
    CheckBoxFC2L: TCheckBox;
    ComboBoxFC2R: TComboBox;
    CheckBoxFC2R: TCheckBox;
    ButtonFCDefaults: TButton;
    TimerLazyLoad: TTimer;
    ComboBoxPCE1A: TComboBox;
    CheckBoxPCE1A: TCheckBox;
    ComboBoxPCE1B: TComboBox;
    CheckBoxPCE1B: TCheckBox;
    ComboBoxPCE1X: TComboBox;
    CheckBoxPCE1X: TCheckBox;
    ComboBoxPCE1Y: TComboBox;
    CheckBoxPCE1Y: TCheckBox;
    ComboBoxPCE1L: TComboBox;
    CheckBoxPCE1L: TCheckBox;
    ComboBoxPCE1R: TComboBox;
    CheckBoxPCE1R: TCheckBox;
    ComboBoxPCE2A: TComboBox;
    CheckBoxPCE2A: TCheckBox;
    ComboBoxPCE2B: TComboBox;
    CheckBoxPCE2B: TCheckBox;
    ComboBoxPCE2X: TComboBox;
    CheckBoxPCE2X: TCheckBox;
    ComboBoxPCE2Y: TComboBox;
    CheckBoxPCE2Y: TCheckBox;
    ComboBoxPCE2L: TComboBox;
    CheckBoxPCE2L: TCheckBox;
    ComboBoxPCE2R: TComboBox;
    CheckBoxPCE2R: TCheckBox;
    ButtonPCEDefaults: TButton;
    ComboBoxSFC1A: TComboBox;
    CheckBoxSFC1A: TCheckBox;
    ComboBoxSFC1B: TComboBox;
    CheckBoxSFC1B: TCheckBox;
    ComboBoxSFC1X: TComboBox;
    CheckBoxSFC1X: TCheckBox;
    ComboBoxSFC1Y: TComboBox;
    CheckBoxSFC1Y: TCheckBox;
    ComboBoxSFC1L: TComboBox;
    CheckBoxSFC1L: TCheckBox;
    ComboBoxSFC1R: TComboBox;
    CheckBoxSFC1R: TCheckBox;
    ComboBoxSFC2A: TComboBox;
    CheckBoxSFC2A: TCheckBox;
    ComboBoxSFC2B: TComboBox;
    CheckBoxSFC2B: TCheckBox;
    ComboBoxSFC2X: TComboBox;
    CheckBoxSFC2X: TCheckBox;
    ComboBoxSFC2Y: TComboBox;
    CheckBoxSFC2Y: TCheckBox;
    ComboBoxSFC2L: TComboBox;
    CheckBoxSFC2L: TCheckBox;
    ComboBoxSFC2R: TComboBox;
    CheckBoxSFC2R: TCheckBox;
    ButtonSFCDefaults: TButton;
    ComboBoxMD1A: TComboBox;
    CheckBoxMD1A: TCheckBox;
    ComboBoxMD1B: TComboBox;
    CheckBoxMD1B: TCheckBox;
    ComboBoxMD1X: TComboBox;
    CheckBoxMD1X: TCheckBox;
    ComboBoxMD1Y: TComboBox;
    CheckBoxMD1Y: TCheckBox;
    ComboBoxMD1L: TComboBox;
    CheckBoxMD1L: TCheckBox;
    ComboBoxMD1R: TComboBox;
    CheckBoxMD1R: TCheckBox;
    ComboBoxMD2A: TComboBox;
    CheckBoxMD2A: TCheckBox;
    ComboBoxMD2B: TComboBox;
    CheckBoxMD2B: TCheckBox;
    ComboBoxMD2X: TComboBox;
    CheckBoxMD2X: TCheckBox;
    ComboBoxMD2Y: TComboBox;
    CheckBoxMD2Y: TCheckBox;
    ComboBoxMD2L: TComboBox;
    CheckBoxMD2L: TCheckBox;
    ComboBoxMD2R: TComboBox;
    CheckBoxMD2R: TCheckBox;
    ButtonMDDefaults: TButton;
    ComboBoxGB1A: TComboBox;
    CheckBoxGB1A: TCheckBox;
    ComboBoxGB1B: TComboBox;
    CheckBoxGB1B: TCheckBox;
    ComboBoxGB1X: TComboBox;
    CheckBoxGB1X: TCheckBox;
    ComboBoxGB1Y: TComboBox;
    CheckBoxGB1Y: TCheckBox;
    ComboBoxGB1L: TComboBox;
    CheckBoxGB1L: TCheckBox;
    ComboBoxGB1R: TComboBox;
    CheckBoxGB1R: TCheckBox;
    ComboBoxGB2A: TComboBox;
    CheckBoxGB2A: TCheckBox;
    ComboBoxGB2B: TComboBox;
    CheckBoxGB2B: TCheckBox;
    ComboBoxGB2X: TComboBox;
    CheckBoxGB2X: TCheckBox;
    ComboBoxGB2Y: TComboBox;
    CheckBoxGB2Y: TCheckBox;
    ComboBoxGB2L: TComboBox;
    CheckBoxGB2L: TCheckBox;
    ComboBoxGB2R: TComboBox;
    CheckBoxGB2R: TCheckBox;
    ButtonGBDefaults: TButton;
    ComboBoxGBA1A: TComboBox;
    CheckBoxGBA1A: TCheckBox;
    ComboBoxGBA1B: TComboBox;
    CheckBoxGBA1B: TCheckBox;
    ComboBoxGBA1X: TComboBox;
    CheckBoxGBA1X: TCheckBox;
    ComboBoxGBA1Y: TComboBox;
    CheckBoxGBA1Y: TCheckBox;
    ComboBoxGBA1L: TComboBox;
    CheckBoxGBA1L: TCheckBox;
    ComboBoxGBA1R: TComboBox;
    CheckBoxGBA1R: TCheckBox;
    ComboBoxGBA2A: TComboBox;
    CheckBoxGBA2A: TCheckBox;
    ComboBoxGBA2B: TComboBox;
    CheckBoxGBA2B: TCheckBox;
    ComboBoxGBA2X: TComboBox;
    CheckBoxGBA2X: TCheckBox;
    ComboBoxGBA2Y: TComboBox;
    CheckBoxGBA2Y: TCheckBox;
    ComboBoxGBA2L: TComboBox;
    CheckBoxGBA2L: TCheckBox;
    ComboBoxGBA2R: TComboBox;
    CheckBoxGBA2R: TCheckBox;
    ButtonGBADefaults: TButton;
    ButtonSave: TButton;
    PopupMenuFile: TPopupMenu;
    OpenDialogKMP: TOpenDialog;
    SaveDialogKMP: TSaveDialog;
    MenuItemImport: TMenuItem;
    MenuItemExport: TMenuItem;
    N1: TMenuItem;
    MenuItemsUndo: TMenuItem;
    MenuItemDefaults: TMenuItem;
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ButtonDefaultsClick(Sender: TObject);
    procedure MenuItemImportClick(Sender: TObject);
    procedure MenuItemExportClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure MenuItemsUndoClick(Sender: TObject);
    procedure MenuItemDefaultsClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitData();
    function GetFileName(): string;
    const
      // for accessing controls
      ConsoleNames: array[0..5] of string = ('FC', 'PCE', 'SFC', 'MD', 'GB', 'GBA');
      ButtonNames: array[0..11] of string = ('1X', '1Y', '1L', '1A', '1B', '1R', '2X', '2Y', '2L', '2A', '2B', '2R');
      // for populating controls
      KeyNamesFC:   array[0..1] of string = ('A',   'B'); // also used by GB
      KeyValuesFC:  array[0..1] of Word   = ($0008, $0000); // also used by GB
      KeyNamesPCE:  array[0..5] of string = ('I',   'II', 'invalid', 'invalid', 'invalid', 'invalid');
      KeyNamesSFC:  array[0..5] of string = ('A',   'B',   'X',   'Y',   'L',   'R');
      KeyValuesSFC: array[0..5] of Word   = ($0008, $0000, $000a, $000b, $0009, $0001);
      KeyNamesMD:   array[0..5] of string = ('A',   'B / SMS 1', 'C / SMS 2', 'X',   'Y',   'Z');
      KeyValuesMD:  array[0..5] of Word   = ($0008, $0000,       $0001,       $000a, $000b, $0009); // also used by PCE
      KeyNamesGBA:  array[0..5] of string = ('A',   'B',   'invalid', 'invalid', 'L', 'R');
      KeyValuesGBA: array[0..5] of Word   = ($0008, $0000, $0001,     $0009,     $000a,    $000b);
    var
      ComboBoxes: array[0..71] of TComboBox;
      CheckBoxes: array[0..71] of TCheckBox;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure LoadFromStream(Stream: TStream);
    procedure LoadConsoleFromStream(Console: Byte; Stream: TStream);
    procedure LoadFromFile(); overload;
    procedure SaveToFile(); overload;
    procedure LoadFromFile(FileName: string); overload;
    procedure SaveToFile(FileName: string); overload;
    procedure LoadDefaults();
  end;

implementation

uses
  Generics.Collections, GB300Utils;

{$R *.dfm}

{ TFrameKeys }

procedure TFrameKeys.ButtonDefaultsClick(Sender: TObject);
var
  RS: TResourceStream;
begin
  RS := TResourceStream.CreateFromID(HInstance, 1, RT_RCDATA);
  try
    RS.Position := (Sender as TButton).Tag * Length(ButtonNames) * SizeOf(Word) * 2;
    LoadConsoleFromStream((Sender as TButton).Tag, RS);
  finally
    RS.Free();
  end;
end;

procedure TFrameKeys.ButtonSaveClick(Sender: TObject);
begin
  SaveToFile();
end;

constructor TFrameKeys.Create(AOwner: TComponent);
begin
  inherited;
  LoadPNGTo(1001, ImageFC.Picture);
  LoadPNGTo(1002, ImagePCE.Picture);
  LoadPNGTo(1003, ImageSFC.Picture);
  LoadPNGTo(1004, ImageMD.Picture);
  LoadPNGTo(1006, ImageGB.Picture);
  LoadPNGTo(1007, ImageGBA.Picture);
  LoadPNGTo(1101, Image1A.Picture);
  LoadPNGTo(1102, Image1B.Picture);
  LoadPNGTo(1103, Image1X.Picture);
  LoadPNGTo(1104, Image1Y.Picture);
  LoadPNGTo(1105, Image1L.Picture);
  LoadPNGTo(1106, Image1R.Picture);
  LoadPNGTo(1101, Image2A.Picture);
  LoadPNGTo(1102, Image2B.Picture);
  LoadPNGTo(1103, Image2X.Picture);
  LoadPNGTo(1104, Image2Y.Picture);
  LoadPNGTo(1105, Image2L.Picture);
  LoadPNGTo(1106, Image2R.Picture);
end;

function TFrameKeys.GetFileName: string;
begin
  Result := IncludeTrailingPathDelimiter(Path + 'Resources') + 'KeyMapInfo.kmp';
end;

procedure TFrameKeys.InitData;
procedure InitConsole(Console: Byte; const KeyNames: array of string; const KeyValues: array of Word);
var
  i, j: Byte;
begin
  for i := Console*12+Low(ButtonNames) to Console*12+High(ButtonNames) do
  begin
    CheckBoxes[i] := FindComponent('CheckBox' + ConsoleNames[Console] + ButtonNames[i mod 12]) as TCheckBox;
    ComboBoxes[i] := FindComponent('ComboBox' + ConsoleNames[Console] + ButtonNames[i mod 12]) as TComboBox;
    CheckBoxes[i].Caption := 'Autofire';
    ComboBoxes[i].Style := csDropDownList;
    with ComboBoxes[i] do
    begin
      if i mod 12 = 0 then
      begin
        Items.BeginUpdate();
        for j := Low(KeyNames) to High(KeyNames) do
        Items.AddObject(KeyNames[j], TObject(KeyValues[j]));
        Items.EndUpdate();
      end
      else
      Items := ComboBoxes[Console * 12].Items;
    end;
  end;
end;
begin
  InitConsole(0, KeyNamesFC, KeyValuesFC);
  InitConsole(1, KeyNamesPCE, KeyValuesMD);
  InitConsole(2, KeyNamesSFC, KeyValuesSFC);
  InitConsole(3, KeyNamesMD, KeyValuesMD);
  InitConsole(4, KeyNamesFC, KeyValuesFC);
  InitConsole(5, KeyNamesGBA, KeyValuesGBA);
end;

procedure TFrameKeys.LoadConsoleFromStream(Console: Byte; Stream: TStream);
var
  i: Byte;
  w: Word;
  w2: Word;
begin
  for i := Console*12 to Console*12+11 do
  begin
    Stream.Read(w, 2);
    Stream.Read(w2, 2);
    ComboBoxes[i].ObjectIndexInt := w;
    CheckBoxes[i].Checked := (w2 and 1) = 1; // this how the GB300 does that: odd is autofire, even isn't (tested -1 (which is odd), 0 to 3)
  end;
end;

procedure TFrameKeys.LoadDefaults;
var
  RS: TResourceStream;
begin
  RS := TResourceStream.CreateFromID(HInstance, 1, RT_RCDATA);
  try
    LoadFromStream(RS);
  finally
    RS.Free();
  end;
end;

procedure TFrameKeys.LoadFromFile;
begin
  try
    if FileExists(GetFileName()) then
    LoadFromFile(GetFileName());
  except
    LoadDefaults();
    raise;
  end;
end;

procedure TFrameKeys.LoadFromFile(FileName: string);
var
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(FileName);
    LoadFromStream(MS);
  finally
    MS.Free();
  end;
end;

procedure TFrameKeys.LoadFromStream(Stream: TStream);
var
  Console: Byte;
begin
  for Console := Low(ConsoleNames) to High(ConsoleNames) do
  LoadConsoleFromStream(Console, Stream);
end;

procedure TFrameKeys.MenuItemDefaultsClick(Sender: TObject);
begin
  LoadDefaults();
end;

procedure TFrameKeys.MenuItemExportClick(Sender: TObject);
begin
  if SaveDialogKMP.Execute() then
  begin
    SaveToFile(SaveDialogKMP.FileName);
  end;
end;

procedure TFrameKeys.MenuItemImportClick(Sender: TObject);
begin
  if OpenDialogKMP.Execute() then
  begin
    LoadFromFile(OpenDialogKMP.FileName);
  end;
end;

procedure TFrameKeys.MenuItemsUndoClick(Sender: TObject);
begin
  LoadFromFile();
end;

procedure TFrameKeys.SaveToFile(FileName: string);
var
  i: Integer;
  MS: TMemoryStream;
  RS: TResourceStream;
begin
  MS := TMemoryStream.Create;
  try
    for i := Low(ComboBoxes) to High(ComboBoxes) do
    begin
      MS.WriteData(Word(ComboBoxes[i].ObjectIndexInt));
      MS.WriteData(Word(CheckBoxes[i].Checked));
    end;
    // Copy 7th console (whyever that one exists...)
    RS := TResourceStream.CreateFromID(HInstance, 1, RT_RCDATA);
    try
      RS.Position := MS.Position;
      MS.CopyFrom(RS, RS.Size - RS.Position);
    finally
      RS.Free();
    end;
    MS.SaveToFile(FileName);
  finally
    MS.Free();
  end;
end;

procedure TFrameKeys.SaveToFile;
begin
  SaveToFile(GetFileName());
end;

procedure TFrameKeys.TimerLazyLoadTimer(Sender: TObject);
begin
  TimerLazyLoad.Enabled := False;
  InitData(); // running this after creation of the form takes half as long as calling in the Create() method because Delphi essentially creates the form twice otherwise
  LoadFromFile();
  Show();
end;

end.
