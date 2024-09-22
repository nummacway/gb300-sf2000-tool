unit UnitNeoGeoFaker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uDragFilesTrg,
  Generics.Collections, GB300Utils, Vcl.ExtCtrls, NeoGeoFaker;

type
  TFormNeoGeoFaker = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBoxP: TGroupBox;
    ListViewP: TListView;
    GroupBoxM: TGroupBox;
    ListViewM: TListView;
    GroupBoxS: TGroupBox;
    ListViewS: TListView;
    GroupBoxV: TGroupBox;
    ListViewV: TListView;
    GroupBoxC: TGroupBox;
    ListViewC: TListView;
    Label6: TLabel;
    ComboBoxCharacterMode: TComboBox;
    Label7: TLabel;
    ButtonExport: TButton;
    ButtonClear: TButton;
    SaveDialog: TSaveDialog;
    Label5: TLabel;
    Label8: TLabel;
    ComboBoxProgramMode: TComboBox;
    Label9: TLabel;
    OpenDialogXML: TOpenDialog;
    ButtonParseDAT: TButton;
    GroupBoxZIP: TGroupBox;
    ListViewZIP: TListView;
    ComboBoxOutputType: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    ButtonOpen: TButton;
    OpenDialog: TOpenDialog;
    Label12: TLabel;
    Panel1: TPanel;
    ComboBoxCompressionLevel: TComboBox;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListViewStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ButtonExportClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonParseDATClick(Sender: TObject);
    procedure ComboBoxOutputTypeSelect(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateSum(ListView: TListView); overload;
    procedure UpdateSum(); overload;
    //procedure WriteFile(Stream: TMemoryStream; FileName: string); // alternative output method that was initially used; however, the Windows folder picker was too confusing when used more than once, so ZIP support was added
    procedure WriteToZIP(Stream: TMemoryStream; FileName: string);
    var
      IsDragging: Boolean;
      DragSource: TListView;
      //OutputDir: string;
      OutputZIP: TStream;
      OutputZIPDirectory: TList<TZipCentralDirectory>;
      InputZIP: TFileStream;
      InputZIPDirectory: TList<TZipLocalHeader>; // at the point where we reach the Central Dir, we have already read all local headers and have the information we need (7-Zip too only cares for the local headers and the EoCD's comment)
      InputZIPOffsets: TList<Integer>;
      Sizes: TNeoGeoFakeTargetSize;
      DifOld, DifDif: TArray<Cardinal>;
    var
      OutputType: TNeoGeoFakeTargetClass;
  public
    { Public declarations }
    procedure LoadFromZIPFile(FileName: string; ShowWarnings: Boolean = True);
    procedure SaveToZIPFile(FileName: string);
  end;

var
  FormNeoGeoFaker: TFormNeoGeoFaker;

implementation

uses
  StrUtils, pngimage, Math, zlib, RedeemerXML, UITypes;

{$R *.dfm}

procedure TFormNeoGeoFaker.ButtonParseDATClick(Sender: TObject);
var
  Game: string;
function GetROMType(FN: string): string;
begin
  if (FN.Contains('.c') or FN.Contains('-c')) and not (FN.Contains('.v') or FN.Contains('-v')) and not (FN.Contains('.p') or FN.Contains('-p')) and not (FN.Contains('.m') or FN.Contains('-m')) and not (FN.Contains('.s') or FN.Contains('-s')) then
  Exit('c');
  if (FN.Contains('.v') or FN.Contains('-v')) and not (FN.Contains('.c') or FN.Contains('-c')) and not (FN.Contains('.p') or FN.Contains('-p')) and not (FN.Contains('.m') or FN.Contains('-m')) and not (FN.Contains('.s') or FN.Contains('-s')) then
  Exit('v');
  if (FN.Contains('.m') or FN.Contains('-m')) and not (FN.Contains('.v') or FN.Contains('-v')) and not (FN.Contains('.p') or FN.Contains('-p')) and not (FN.Contains('.c') or FN.Contains('-c')) and not (FN.Contains('.s') or FN.Contains('-s')) then
  Exit('m');
  if (FN.Contains('.p') or FN.Contains('-p')) and not (FN.Contains('.v') or FN.Contains('-v')) and not (FN.Contains('.c') or FN.Contains('-c')) and not (FN.Contains('.m') or FN.Contains('-m')) and not (FN.Contains('.s') or FN.Contains('-s')) then
  Exit('p');
  if (FN.Contains('.s') or FN.Contains('-s')) and not (FN.Contains('.v') or FN.Contains('-v')) and not (FN.Contains('.p') or FN.Contains('-p')) and not (FN.Contains('.m') or FN.Contains('-m')) and not (FN.Contains('.c') or FN.Contains('-c')) then
  Exit('s');

  Result := '';
  if not InputQuery(Game, FN, Result) then
  Abort;
end;
var
  sl: TStringList;
  s, v: string;
  XML: TRedeemerXML;
begin
  if OpenDialogXML.Execute() then
  begin
    sl := TStringList.Create();
    try
      sl.LoadFromFile(OpenDialogXML.FileName);
      XML := TRedeemerXML.Create(sl.Text);
      try
        sl.Clear();
        while XML.GoToAndGetNextTag() do
        begin
          if XML.CurrentTag = 'game' then
          begin
            Game := XML.GetAttribute('name');
            s := '<fake name="' + Game + '"';
            if XML.GetAttribute('status', v) then
            s := s + ' status="' + v + '"';
            if XML.GetAttribute('error', v) then
            s := s + ' error="' + v + '"';
            if XML.GetAttribute('p', v) then // Program ROM mode
            s := s + ' p="' + v + '"';
            if XML.GetAttribute('c', v) then // Character ROM mode
            s := s + ' c="' + v + '"';
            sl.Add(s + '>');
          end
          else
          if XML.CurrentTag = 'description' then
          sl.Add('<title>' + XML.GetInnerTextAndSkip + '</title>')
          else
          if XML.CurrentTag = 'rom' then
          begin
            sl.Add('<' + GetROMType(XML.GetAttribute('name')) + ' crc="' + XML.GetAttribute('crc') + '"/>');
          end
          else
          if (XML.CurrentTag = 'p') or (XML.CurrentTag = 'c') or (XML.CurrentTag = 's') or (XML.CurrentTag = 'm') or (XML.CurrentTag = 'v') then
          begin
            sl.Add('<' + XML.CurrentTag + ' crc="' + XML.GetAttribute('crc') + '"/>');
          end
          else
          if XML.CurrentTag = '/game' then
          sl.Add('</fake>');
        end;
      finally
        XML.Free();
      end;
    finally
      sl.SaveToFile(ChangeFileExt(OpenDialogXML.FileName, '.fake.dat'));
      sl.Free();
    end;
  end;
end;

procedure TFormNeoGeoFaker.ButtonClearClick(Sender: TObject);
var
  LV: TListView;
begin
  for LV in [ListViewP, ListViewM, ListViewS, ListViewV, ListViewC] do
  begin
    LV.Items.Clear();
    UpdateSum(LV);
  end;
end;

procedure TFormNeoGeoFaker.ButtonExportClick(Sender: TObject);
begin
  {if not FileOpenDialog.Execute() then // The difference between TOpenDialog and TFileOpenDialog is that TOpenDialog can only open files and TFileOpenDialog can open folders...
  Exit;
  OutputDir := IncludeTrailingPathDelimiter(FileOpenDialog.FileName);}
  SaveDialog.Filter := OutputType.GetName() + '|' + OutputType.ClassName + '.zip';
  SaveDialog.FileName := OutputType.ClassName + '.zip';
  if SaveDialog.Execute() then
  SaveToZIPFile(SaveDialog.FileName);
end;

procedure TFormNeoGeoFaker.ButtonOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute() then
  LoadFromZIPFile(OpenDialog.FileName);
end;

procedure TFormNeoGeoFaker.ComboBoxOutputTypeSelect(Sender: TObject);
begin
  case ComboBoxOutputType.ItemIndex of
     0: OutputType := garoup;
     1: OutputType := kof98n;
     2: OutputType := mslugx;
     3: OutputType := garou;
     4: OutputType := jockeygp;
     5: OutputType := kof99;
     6: OutputType := kof2003;
     7: OutputType := matrim;
     8: OutputType := pnyaa;
     9: OutputType := rotd;
    10: OutputType := samsh5sp;
    11: OutputType := samsho5;
    12: OutputType := ct2k3sa;
    13: OutputType := ct2k3sp;
    14: OutputType := cthd2003;
    15: OutputType := kf10thep;
    16: OutputType := kf2k3bl;
    17: OutputType := kf2k3bla;
    18: OutputType := kf2k3pl;
    19: OutputType := kf2k5uni;
    20: OutputType := kof2000;
    21: OutputType := kof2001;
    22: OutputType := kof2002;
    23: OutputType := ms5plus;
    24: OutputType := mslug3;
    25: OutputType := mslug3b6;
    26: OutputType := mslug3h;
    27: OutputType := mslug3hd;
    28: OutputType := mslug4;
    29: OutputType := mslug5;
    30: OutputType := sengoku3;
    31: OutputType := svcboot;
  end;
  Sizes := OutputType.GetSizes();
  UpdateSum();
end;

procedure TFormNeoGeoFaker.FormCreate(Sender: TObject);
begin
  InputZIPDirectory := TList<TZipLocalHeader>.Create();
  InputZIPOffsets := TList<Integer>.Create();
  ComboBoxOutputTypeSelect(nil);
  TNeoGeoFakeSource.EnsureXMLLoaded();
end;

procedure TFormNeoGeoFaker.FormDestroy(Sender: TObject);
begin
  InputZIPDirectory.Free();
  InputZIPOffsets.Free();
  InputZIP.Free();
end;

procedure TFormNeoGeoFaker.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    (Sender as TListView).DeleteSelected();
    UpdateSum((Sender as TListView));
  end;
end;

procedure TFormNeoGeoFaker.ListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Target: TListItem;
  Selection: TObjectList<TListItem>;
  Item: TListItem;
  i: Integer;
begin
  if IsDragging then
  begin
    IsDragging := False;
    Target := (Sender as TListView).GetItemAt(X, Y);
    if Assigned(Target) then
    i := Target.Index
    else
    if Sender <> DragSource then
    i := 0
    else
    Exit;

    Selection := TObjectList<TListItem>.Create(DragSource <> ListViewZIP);
    (Sender as TListView).Items.BeginUpdate();
    try
      for Item in (DragSource as TListView).Items do
      if Item.Selected then
      Selection.Add(Item);

      if Sender = DragSource then
      if (Sender as TListView).ItemFocused.Index < i then
      Inc(i);

      if Sender <> ListViewZIP then
      for Item in Selection do
      begin
        (Sender as TListView).Items.Insert(i).Assign(Item);
        Inc(i);
      end;
    finally
      Selection.Free();
      (Sender as TListView).Items.EndUpdate();
      if Sender <> ListViewZIP then
      UpdateSum(Sender as TListView);
      if DragSource <> ListViewZIP then
      UpdateSum(DragSource);
    end;
  end;
end;

procedure TFormNeoGeoFaker.ListViewDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := IsDragging;
end;

procedure TFormNeoGeoFaker.ListViewStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  IsDragging := True;
  DragSource := Sender as TListView;
end;

procedure TFormNeoGeoFaker.LoadFromZIPFile(FileName: string; ShowWarnings: Boolean);
procedure FindByCRC(CRC: Cardinal; Target: TListView);
var
  LocalHeader: TZipLocalHeader;
  ZIPItem: TListItem;
  Name: string;
begin
  for LocalHeader in InputZIPDirectory do
  if LocalHeader.CRC32 = CRC then
  begin
    Name := LocalHeader.FileName;

    // Testing: Report ROMs that are probably encrypted.
    {if Target.Items.Count = 0 then
    if LocalHeader.CompressedSize > LocalHeader.UncompressedSize * 0.8 then
    if Target = ListViewC then
    ShowMessage(ExtractFileName(InputZIP.FileName) + #13#10'Very bad C-ROM compression ratio. Encrypted?');}

    Break;
  end;

  if Name = '' then
  raise Exception.Create('Cannot find ROM with CRC 0x' + IntToHex(CRC, 8) + '. Make sure to use Non-Merged FBNeo sets only.');

  for ZIPItem in ListViewZIP.Items do
  if ZIPItem.Caption = Name then
  begin
    with Target.Items.Add() do
    Assign(ZIPItem);
    UpdateSum(Target);
    //ZIPItem.Free();
    Exit;
  end;
end;
var
  LocalHeader: TZipLocalHeader;
  RomSet: string;
  Arrangement: TNeoGeoFakeSource;
  CRC: Cardinal;
  i: Integer;
begin
  // Clear
  ButtonExport.Enabled := False;
  FreeAndNil(InputZIP);
  ButtonClearClick(nil);
  InputZIPDirectory.Clear();
  InputZIPOffsets.Clear();
  ListViewZIP.Items.Clear();
  SetLength(DifOld, 0);
  SetLength(DifDif, 0);
  // Parse
  InputZIP := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  while LocalHeader.LoadFromStream(InputZIP) do
  begin
    InputZIPDirectory.Add(LocalHeader);
    InputZIPOffsets.Add(InputZIP.Position);
    InputZIP.Position := InputZIP.Position + LocalHeader.CompressedSize;
    with ListViewZIP.Items.Add() do
    begin
      Caption := LocalHeader.FileName;
      Data := Pointer(LocalHeader.UncompressedSize);
      SubItems.Add(IntToStr(LocalHeader.UncompressedSize div 1024) + ' KiB');
      SubItems.Add(LocalHeader.FileName);
    end;
  end;
  ButtonExport.Enabled := True;
  // Get arrangement preset
  RomSet := ChangeFileExt(ExtractFileName(FileName), '');
  GroupBoxZIP.Caption := 'Available ROMs in ZIP File (' + RomSet + ')';
  if FakeSources.ContainsKey(RomSet) then
  begin
    Arrangement := FakeSources[RomSet];
    if Arrangement.Status = 'error' then
    raise Exception.Create('ROM set ''' + Romset + ''' is not supported:'#13#10 + Arrangement.Msg);
    if (Arrangement.Status = 'warning') and ShowWarnings then
    MessageDlg('ROM set ''' + Romset + ''' is only partially supported and might have some lesser issues:'#13#10 + Arrangement.Msg, mtWarning, [mbOk], 0);

    DifOld := Arrangement.DifOld;
    DifDif := Arrangement.DifDif;

    for CRC in Arrangement.C do
    FindByCRC(CRC, ListViewC);
    for CRC in Arrangement.M do
    FindByCRC(CRC, ListViewM);
    for CRC in Arrangement.P do
    FindByCRC(CRC, ListViewP);
    for CRC in Arrangement.S do
    FindByCRC(CRC, ListViewS);
    for CRC in Arrangement.V do
    FindByCRC(CRC, ListViewV);

    ComboBoxCharacterMode.ItemIndex := Arrangement.CMode;
    ComboBoxProgramMode.ItemIndex := Arrangement.PMode;

    for i := 0 to ComboBoxOutputType.Items.Count - 1 do
    if StartsStr(Arrangement.Target + ' ', ComboBoxOutputType.Items[i] + ' ') then
    begin
      ComboBoxOutputType.ItemIndex := i;
      ComboBoxOutputTypeSelect(nil);
      Exit;
    end;

    Exit;
  end;
  if ShowWarnings then
  MessageDlg('GB300+SF2000 Tool does not have an arragement preset for ROM set ''' + RomSet + '''. Either this set is quite new, not a Neo Geo set, or it''s perfectly supported natively by stock.'#13#10'Arrange ROMs yourself. If the set is not supported by stock, contact GB300+SF2000 Tool''s author to have this set added.', mtInformation, [mbOk], 0)
  else
  Abort; // where this method is called with ShowWarnings = False, this is handled before this form is created
end;

procedure TFormNeoGeoFaker.SaveToZIPFile(FileName: string);
var
  GroupCount: Integer;
{procedure AddFileToStream(FileName: string; Target: TStream);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    Target.CopyFrom(FS);
  finally
    FS.Free();
  end;
end;}
procedure AddFileToStream(FileName: string; Target: TBytesStream);
var
  i, j: Integer;
  Zlib: TZDecompressionStream;
  Position: Integer;
  Diff: TBytesStream;
  CRC: Cardinal;
begin
  Position := Target.Position;
  CRC := 0;
  for i := 0 to InputZIPDirectory.Count - 1 do
  begin
    if InputZIPDirectory[i].FileName = FileName then
    begin
      InputZIP.Position := InputZIPOffsets[i];
      CRC := InputZIPDirectory[i].CRC32;

      case InputZIPDirectory[i].CompressionMethod of
        0:
          begin
            Target.CopyFrom2(InputZIP, InputZIPDirectory[i].UncompressedSize);
            Break;
          end;
        8:
          begin
            Zlib := TDecompressionStream.Create(InputZIP, -15);
            try
              Target.CopyFrom2(Zlib, InputZIPDirectory[i].UncompressedSize);
            finally
              Zlib.Free();
            end;
            Break;
          end;
        else raise EInvalidImage.CreateFmt('Unsupported ZIP compression method %d', [InputZIPDirectory[i].CompressionMethod]);
      end;
    end;
  end;
  // fetch .dif from ZIP
  for j := Low(DifOld) to High(DifOld) do
  if DifOld[j] = CRC then
  begin
    Diff := TBytesStream.Create();
    try
      for i := 0 to InputZIPDirectory.Count - 1 do
      begin
        if InputZIPDirectory[i].CRC32 = DifDif[j] then
        begin
          InputZIP.Position := InputZIPOffsets[i];
          case InputZIPDirectory[i].CompressionMethod of
            0:
              begin
                Diff.CopyFrom2(InputZIP, InputZIPDirectory[i].UncompressedSize);
                Break;
              end;
            8:
              begin
                Zlib := TDecompressionStream.Create(InputZIP, -15);
                try
                  Diff.CopyFrom2(Zlib, InputZIPDirectory[i].UncompressedSize);
                finally
                  Zlib.Free();
                end;
                Break;
              end;
            else raise EInvalidImage.CreateFmt('Unsupported ZIP compression method %d', [InputZIPDirectory[i].CompressionMethod]);
          end;
        end;
      end;
      if Diff.Size > 0 then
      //if Diff.Size = Target.Position - Position then // kof98ae's diff only has the first 128 KiB of a 256 KiB Strings file
      for i := 0 to Diff.Size - 1 do
      Target.Bytes[Position+i] := Target.Bytes[Position+i] xor Diff.Bytes[i];
    finally
      Diff.Free();
    end;
  end;
end;
procedure HandleC();
procedure Verify(); // verify that the files have the correct size
var
  i, j: Integer;
  Size: NativeInt;
begin
  if GroupCount = 1 then // this method does nothing even if this is not checked
  Exit;
  if ListViewC.Items.Count mod GroupCount > 0 then
  raise Exception.CreateFmt('The number of character ROMs provided for the selected type of interleaving must be devisable by %d', [GroupCount]);
  i := 0;
  while i < ListViewC.Items.Count do
  begin
    Size := NativeInt(ListViewC.Items[i].Data);
    for j := i+1 to i+GroupCount - 1 do
    if Size <> NativeInt(ListViewC.Items[j].Data) then
    raise Exception.Create('All files inside an interleaving group must have the same file size');
    Inc(i, GroupCount);
  end;
end;
var
  MS: array[0..1] of TBytesStream;
  Source: array[0..3] of TBytesStream; // much faster for byte-wise reading and writing than other TFileStream (at least when I last tried back in 2012)
  i, j: Integer;
begin
  case ComboBoxCharacterMode.ItemIndex of
    1, 3: GroupCount := 2;
    2: GroupCount := 4;
    else GroupCount := 1;
  end;
  Verify();

  if ComboBoxCharacterMode.ItemIndex = 3 then
  GroupCount := 1; // odd workaround for 3bouta being really strange

  MS[0] := TBytesStream.Create();
  MS[1] := TBytesStream.Create();
  i := 0;
  try
    Panel1.Show();
    Refresh();
    while i < ListViewC.Items.Count do
    begin
      case ComboBoxCharacterMode.ItemIndex of
        0:
          begin
            Source[0] := TBytesStream.Create();
            try
              AddFileToStream(ListViewC.Items[i].SubItems[1], Source[0]);
              Source[0].Position := 0;
              for j := 0 to Source[0].Size - 1 do
              MS[j mod 2].CopyFrom(Source[0], 1);
            finally
              Source[0].Free();
            end;
          end;
        1:
          begin
            AddFileToStream(ListViewC.Items[i+0].SubItems[1], MS[0]);
            AddFileToStream(ListViewC.Items[i+1].SubItems[1], MS[1]);
          end;
        2:
          begin
            Source[0] := TBytesStream.Create();
            Source[1] := TBytesStream.Create();
            Source[2] := TBytesStream.Create();
            Source[3] := TBytesStream.Create();
            try
              AddFileToStream(ListViewC.Items[i+0].SubItems[1], Source[0]);
              AddFileToStream(ListViewC.Items[i+1].SubItems[1], Source[1]);
              AddFileToStream(ListViewC.Items[i+2].SubItems[1], Source[2]);
              AddFileToStream(ListViewC.Items[i+3].SubItems[1], Source[3]);
              Source[0].Position := 0;
              Source[1].Position := 0;
              Source[2].Position := 0;
              Source[3].Position := 0;
              for j := 0 to Source[0].Size - 1 do
              begin
                // This is completely weird, as the file numbering makes no sense at all:
                // Offset | File | Plane
                // -------+------+------
                // 0      |    3 |     1
                // 1      |    1 |     0
                // 2      |    4 |     3
                // 3      |    2 |     2
                MS[0].CopyFrom(Source[0], 1);
                MS[0].CopyFrom(Source[2], 1);
                MS[1].CopyFrom(Source[1], 1);
                MS[1].CopyFrom(Source[3], 1);
              end;
            finally
              Source[0].Free();
              Source[1].Free();
              Source[2].Free();
              Source[3].Free();
            end;
          end;
        3:
          begin
            // this thing actually runs twice
            Source[0] := TBytesStream.Create();
            Source[1] := TBytesStream.Create();
            try
              AddFileToStream(ListViewC.Items[i * 2 mod ListViewC.Items.Count + 0].SubItems[1], Source[0]);
              AddFileToStream(ListViewC.Items[i * 2 mod ListViewC.Items.Count + 1].SubItems[1], Source[1]);
              Source[0].Position := (i * 2 div ListViewC.Items.Count) * Source[0].Size div 2;
              Source[1].Position := (i * 2 div ListViewC.Items.Count) * Source[1].Size div 2;
              MS[0].CopyFrom(Source[0], Source[0].Size div 2);
              MS[1].CopyFrom(Source[1], Source[1].Size div 2);
            finally
              Source[0].Free();
              Source[1].Free();
            end;
          end;
      end;
      Inc(i, GroupCount);
    end;
    MS[0].Position := 0;
    MS[1].Position := 0;
    OutputType.C0(MS[0]);
    OutputType.C1(MS[1]);
  finally
    MS[0].Free();
    MS[1].Free();
    Panel1.Hide();
  end;
end;
procedure HandleOther(ListView: TListView; Method: TStreamMethod);
var
  Item: TListItem;
  MS: TBytesStream;
  Temp, Temp2: TBytesStream;
  Offset: Integer;
  i, j: Integer;
begin
  MS := TBytesStream.Create();
  try
    // even-odd load
    if (ListView = ListViewP) and (ComboBoxProgramMode.ItemIndex = 2) then
    begin
      if ListViewP.Items.Count mod 2 = 1 then
      raise Exception.Create('Cannot use even-odd interleaving because the Program ROM file number is not even');

      for i := 0 to ListViewP.Items.Count div 2 - 1 do
      begin
        Temp := TBytesStream.Create();
        Temp2 := TBytesStream.Create();
        try
          AddFileToStream(ListViewP.Items[i*2  ].SubItems[1], Temp);
          AddFileToStream(ListViewP.Items[i*2+1].SubItems[1], Temp2);
          if ListViewP.Items.Count mod 2 = 1 then
          raise Exception.Create('Cannot use even-odd interleaving because the Program ROM file pairs do not share size');

          Temp.Position := 0;
          Temp2.Position := 0;
          for j := 0 to Temp.Size - 1 do
          begin
            MS.CopyFrom(Temp, 1);
            MS.CopyFrom(Temp2, 1);
          end;
        finally
          Temp.Free();
          Temp2.Free();
        end;
      end;
    end
    else
    // normal load
    for Item in ListView.Items do
    AddFileToStream(Item.SubItems[1], MS);

    // move first 1 MiB to the front
    if ListView = ListViewP then
    if ComboBoxProgramMode.ItemIndex = 1 then
    begin
      if MS.Position <= 1024*1024 then
      raise Exception.Create('Cannot write last 1 MiB first if the Program ROM is not larger than 1 MiB');

      Temp := TBytesStream.Create();
      try
        MS.Position := MS.Position - 1024*1024;
        Offset := MS.Position;
        Temp.CopyFrom(MS, 1024*1024);
        MS.Position := 0;
        Temp.CopyFrom2(MS, Offset);
        FreeAndNil(MS);
        MS := Temp;
        Temp := nil;
      finally
        Temp.Free();
      end;
    end;

    MS.Position := 0;
    Method(MS);
  finally
    MS.Free();
  end;
end;
var
  Dir: TZipCentralDirectory;
  EoCD: TZipEndOfCentralDirectory;
begin
  OutputZIP := TFileStream.Create(FileName, fmCreate);
  OutputZIPDirectory := TList<TZipCentralDirectory>.Create();
  try
    TNeoGeoFakeTarget.OutputWriter := WriteToZIP;
    HandleC();
    HandleOther(ListViewM, OutputType.M);
    HandleOther(ListViewP, OutputType.P);
    HandleOther(ListViewS, OutputType.S);
    HandleOther(ListViewV, OutputType.V);

    EoCD.Init();
    EoCD.OffsetOfStartOfTheCentralDirectoryWithRespectToTheStartingDiskNumber := OutputZIP.Position;
    for Dir in OutputZIPDirectory do
    Dir.SaveToStream(OutputZIP);

    EoCD.TotalNumberOfEntriesInTheCentralDirectoryOnThisDisk := OutputZIPDirectory.Count;
    EoCD.TotalNumberOfEntriesInTheCentralDirectory := OutputZIPDirectory.Count;
    EoCD.SizeOfTheCentralDirectory := OutputZIP.Position - EoCD.OffsetOfStartOfTheCentralDirectoryWithRespectToTheStartingDiskNumber;
    EoCD.SaveToStream(OutputZIP);
  finally
    OutputZIPDirectory.Free();
    OutputZIP.Free();
  end;
end;

procedure TFormNeoGeoFaker.UpdateSum();
begin
  UpdateSum(ListViewC);
  UpdateSum(ListViewM);
  UpdateSum(ListViewP);
  UpdateSum(ListViewS);
  UpdateSum(ListViewV);
end;

procedure TFormNeoGeoFaker.UpdateSum(ListView: TListView);
const
  // Array index is ListView.Tag
  Names: array[0..4] of string = ('Character', 'Music', 'Program', 'Strings', 'Voice');
var
  Sum: Integer;
  Item: TListItem;
begin
  Sum := 0;
  for Item in ListView.Items do
  Sum := Sum + NativeInt(Item.Data);

  (FindComponent('GroupBox' + RightStr(ListView.Name, 1)) as TGroupBox).Caption := Names[ListView.Tag] + ' (' + IntToStr(Sum div 1024) + ' / ' + IntToStr(Sizes[ListView.Tag]) + ' KiB)';
end;

{procedure TFormNeoGeoFaker.WriteFile(Stream: TMemoryStream; FileName: string);
begin
  Stream.SaveToFile(OutputDir + FileName);
end;  }

procedure TFormNeoGeoFaker.WriteToZIP(Stream: TMemoryStream; FileName: string);
var
  Header: TZipLocalHeader;
  CentralDir: TZipCentralDirectory;
  Start: Integer;
  ZLibStart: Integer;
  ZLib: TZCompressionStream;
begin
  Start := OutputZip.Position;

  // Write header (first pass)
  Header.Init();
  Header.FileName := FileName;
  Header.LastModFileDateTime.AsDateTime := Now();
  Header.UncompressedSize := Stream.Size;
  Header.CRC32 := not update_crc($ffffffff, Stream.Memory, Stream.Size);
  Header.SaveToStream(OutputZIP);
  ZlibStart := OutputZIP.Position;

  // Write Deflate
  Stream.Position := 0;
  ZLib := TZCompressionStream.Create(OutputZIP, TZCompressionLevel(ComboBoxCompressionLevel.ItemIndex+1), -15);
  try
    ZLib.CopyFrom(Stream);
  finally
    ZLib.Free();
  end;

  // Write header (second pass)
  Header.CompressedSize := OutputZIP.Position - ZLibStart;
  OutputZip.Position := Start;
  Header.SaveToStream(OutputZIP);
  OutputZIP.Position := OutputZIP.Size;

  // Prepare Central Dictionary
  CentralDir.Assign(Header);
  CentralDir.RelativeOffsetOfLocalHeader := Start;
  OutputZIPDirectory.Add(CentralDir);
end;

end.
