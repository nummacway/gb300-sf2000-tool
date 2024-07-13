unit UnitStockROMs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GB300Utils, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, UnitROMDetails, Vcl.Menus;

type
  TFrameStockROMs = class(TFrame)
    PanelLeft: TPanel;
    PanelListActions: TPanel;
    ListViewFiles: TListView;
    ButtonCheckAll: TButton;
    ButtonUncheckAll: TButton;
    ButtonAdd: TButton;
    ButtonAlphaSort: TButton;
    ButtonDelete: TButton;
    PanelSpacer: TPanel;
    TimerSave: TTimer;
    OpenDialogROMs: TOpenDialog;
    TimerDnDScroll: TTimer;
    PopupMenu: TPopupMenu;
    MenuItemImportAllImages: TMenuItem;
    procedure ListViewFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TimerSaveTimer(Sender: TObject);
    procedure ListViewFilesItemChecked(Sender: TObject; Item: TListItem);
    procedure ListViewFilesEdited(Sender: TObject; Item: TListItem;
      var S: string);
    procedure ButtonAddClick(Sender: TObject);
    procedure TimerDnDScrollTimer(Sender: TObject);
    procedure ListViewFilesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonAlphaSortClick(Sender: TObject);
    procedure ButtonUncheckAllClick(Sender: TObject);
    procedure ButtonCheckAllClick(Sender: TObject);
    procedure ListViewFilesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListViewFilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListViewFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListViewFilesKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewFilesDblClick(Sender: TObject);
    procedure MenuItemImportAllImagesClick(Sender: TObject);
  private
    { Private declarations }
    procedure DropFiles(Sender: TObject);
    procedure DoCheck(NewState: Boolean);
    procedure DoCheckSelection(NewState: Boolean);
    function DoAddUnlisted(FN: string; Checked: Boolean): TListItem;
    procedure ROMDuplicate(var Item: TListItem; const NewName: string);
    procedure ROMRename(var Item: TListItem; const NewName: string);
    var
      FolderIndex: Word;
      Names: TNameLists;
      ROMDetailsFrame: TFrameROMDetails;
      IsDragging: Boolean;
      MustSaveReferenceLists: Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure LoadFromFiles(FolderIndex: Word);
    procedure ApplyAndSave();
    procedure DoAdd(Files: TStrings);
  end;

implementation

uses
  GUIHelpers, Generics.Collections, UnitMain, UITypes, MulticoreUtils,
  UnitMulticoreSelection;

{$R *.dfm}

{ TFrame1 }

procedure TFrameStockROMs.ApplyAndSave;
{var
  Item: TListItem;
  CheckCount: Integer;
  Shift: Integer;
begin
  // old code, discarded because it was too complicated and unflexible
  CheckCount := 0;
  Shift := 0;
  for Item in ListViewFiles.Items do
  begin
    if Item.Checked then
    begin
      if Item.Data = NotListed then
      Names.Insert(CheckCount, Item.Caption, Item.SubItems[0], Item.SubItems[1]);
      Item.Data := Pointer(CheckCount);
      Inc(CheckCount);
    end
    else
    if Item.Data <> NotListed then
    begin
      Names.Delete(CheckCount);
      Item.Data := NotListed;
    end;
  end;
  Names.SaveToFiles(FolderIndex);

  // processing favorites and history needs to stay  }
var
  Item: TListItem;
  NewNames: TNameLists;
  TempNames: TNameLists;
  MustSaveFavorites: Boolean;
  MustSaveHistory: Boolean;
begin
  TimerSave.Enabled := False;
  NewNames := TNameLists.Create();
  try
    for Item in ListViewFiles.Items do
    if Item.Checked then
    NewNames.Add(Item.Caption, Item.SubItems[0], Item.SubItems[1]);
  except
    NewNames.Free();
    raise;
  end;
  TempNames := Names;
  Names := NewNames;
  TempNames.Free();
  NewNames.SaveToFiles(FolderIndex);

  MustSaveFavorites := Favorites.Apply(Names.FileNames, FolderIndex);
  MustSaveHistory := History.Apply(Names.FileNames, FolderIndex);
  if MustSaveFavorites or MustSaveReferenceLists then
  Favorites.SaveToFile(rfFavorites);
  if MustSaveHistory or MustSaveReferenceLists then
  History.SaveToFile(rfHistory);
  MustSaveReferenceLists := False;

  ROMDetailsFrame.RefreshFavoriteStatus();
end;

procedure TFrameStockROMs.ButtonAddClick(Sender: TObject);
begin
  OpenDialogROMs.Filter := 'Stock supported files (' + StringReplace(Extensions, ';', ', ', [rfReplaceAll]) + ')|' + Extensions + '|All files (*.*)|*.*';
  if HasMulticore then
  OpenDialogROMs.FilterIndex := 2;
  if OpenDialogROMs.Execute() then
  DoAdd(OpenDialogROMs.Files);
end;

procedure TFrameStockROMs.ButtonAlphaSortClick(Sender: TObject);
begin
  ListViewFiles.AlphaSort();
  ApplyAndSave();
end;

procedure TFrameStockROMs.ButtonCheckAllClick(Sender: TObject);
begin
  DoCheck(True);
end;

procedure TFrameStockROMs.ButtonDeleteClick(Sender: TObject);
var
  Msg: string;
  i: Integer;
begin
  if ListViewFiles.SelCount = 0 then
  Exit;

  if ListViewFiles.SelCount = 1 then
  Msg := Format('Do you want to delete ''%s''?', [ListViewFiles.Selected.Caption])
  else
  Msg := Format('Do you want to delete %d items?', [ListViewFiles.SelCount]);

  if MessageDlg(Msg, mtWarning, mbYesNo, 0) = mrYes then
  begin
    ListViewFiles.Items.BeginUpdate();
    try
      for i := ListViewFiles.Items.Count - 1 downto 0 do
      if ListViewFiles.Items[i].Selected then
      begin
        if TROMFile.GetIsMultiCore(ListViewFiles.Items[i].Caption) then
        DeleteFile(TROMFile.GetMCName(ListViewFiles.Items[i].Caption).AbsoluteFileName);
        if DeleteFile(Foldername.AbsoluteFolder[FolderIndex] + ListViewFiles.Items[i].Caption) then
        ListViewFiles.Items[i].Delete();
      end;
    finally
      ListViewFiles.Items.EndUpdate();
      ApplyAndSave();
      ROMDetailsFrame.Hide();
    end;
  end;
end;

procedure TFrameStockROMs.ButtonUncheckAllClick(Sender: TObject);
begin
  if MessageDlg('Do you really want to uncheck all these files?'#13#10'This will remove them from the favorites.'#13#10#13#10'All files not checked when leaving this tab will lose their Chinese and Pinyin Names.', mtWarning, mbYesNo, 0) = mrYes then
  DoCheck(False);
end;

constructor TFrameStockROMs.Create(AOwner: TComponent);
begin
  inherited;
  Names := TNameLists.Create();
  ROMDetailsFrame := TFrameROMDetails.Create(Self);
  ROMDetailsFrame.Parent := Self;
  ROMDetailsFrame.OnRename := ROMRename;
  ROMDetailsFrame.OnDuplicate := ROMDuplicate;
  if ShowChineseNames then
  begin
    ListViewFiles.Columns.Add.Width := 90;
    ListViewFiles.Columns.Add.Width := 90;
  end;
  Form1.DragIn.OnDrop := DropFiles;
  Form1.DragIn.Enabled := True;
end;

destructor TFrameStockROMs.Destroy;
begin
  Names.Free();
  // ROMDetailsFrame has an owner and therefore doesn't need to be freed
  inherited;
end;

procedure TFrameStockROMs.DoAdd(Files: TStrings);
var
  FN: string;
  NewFN: string;
  Overwrite: Boolean;
  All: Boolean;
  FileExisted: Boolean;
begin
  // this method has not been moved in the general GB300 Utils because the handling of the list items to be created is different
  All := False;
  Overwrite := True;
  ListViewFiles.OnItemChecked := nil;
  ListViewFiles.Items.BeginUpdate();
  try
    if HasMulticore then
    begin
      TidyUpFileList(Files);
      for FN in Files do
      begin
        NewFN := FN;
        if TFormMulticoreSelection.HandleMulticore(FolderIndex, NewFN) then
        if NewFN <> '' then
        DoAddUnlisted(ExtractFileName(NewFN), True);
      end;
    end
    else
    for FN in Files do
    begin
      NewFN := Foldername.AbsoluteFolder[FolderIndex] + ExtractFileName(FN);

      if NewFN = FN then
      Continue;

      FileExisted := FileExists(NewFN);
      if not All then
      if FileExisted then
      case MessageDlg(Format('%s already exists. Overwrite?', [ExtractFileName(FN)]), mtWarning, [mbYes, mbNo, mbYesToAll, mbNoToAll, mbAbort], 0) of
        mrYes:;
        mrNo:
          Continue;
        mrYesToAll:
          All := True;
        mrNoToAll:
          begin
            All := True;
            Overwrite := False;
          end
        else Exit;
      end;

      if CopyFile(PChar(FN), PChar(NewFN), not Overwrite) then
      if not FileExisted then
      DoAddUnlisted(ExtractFileName(FN), True);
    end;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.OnItemChecked := ListViewFilesItemChecked;
    ListViewFiles.DoAutoSize();
    ApplyAndSave();
  end;
end;

function TFrameStockROMs.DoAddUnlisted(FN: string; Checked: Boolean): TListItem;
var
  FN2: string;
begin
  Result := ListViewFiles.Items.Add();
  Result.Caption := FN;
  Result.Checked := Checked;
  //if ShowChineseNames then
  //begin
  if TROMFile.GetIsMultiCore(FN) then
  FN := TROMFile.GetMCName(FN).Name;
  FN2 := ChangeFileExt(FN, '');
  Result.SubItems.Add(FN2);
  Result.SubItems.Add(FN2);
  Result.ImageIndex := TROMFile.FileNameToImageIndex(FN);
  //end;
end;

procedure TFrameStockROMs.DoCheck(NewState: Boolean);
var
  Item: TListItem;
begin
  ListViewFiles.Items.BeginUpdate();
  try
    ListViewFiles.OnItemChecked := nil;
    for Item in ListViewFiles.Items do
    if NewState then
    Item.Checked := FileExists(Foldername.AbsoluteFolder[FolderIndex] + Item.Caption)
    else
    Item.Checked := NewState;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.OnItemChecked := ListViewFilesItemChecked;
    ApplyAndSave();
  end;
end;

procedure TFrameStockROMs.DoCheckSelection(NewState: Boolean);
var
  Item: TListItem;
begin
  ListViewFiles.Items.BeginUpdate();
  try
    ListViewFiles.OnItemChecked := nil;
    for Item in ListViewFiles.Items do
    if Item.Selected then
    Item.Checked := NewState;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.OnItemChecked := ListViewFilesItemChecked;
    ApplyAndSave();
  end;
end;

procedure TFrameStockROMs.DropFiles(Sender: TObject);
begin
  DoAdd(Form1.DragIn.FileList);
end;

procedure TFrameStockROMs.ListViewFilesDblClick(Sender: TObject);
var
  Names: array[0..1] of string;
begin
  if ListViewFiles.SelCount = 1 then
  if ShowChineseNames then
  begin
    Names[0] := ListViewFiles.Selected.SubItems[0];
    Names[1] := ListViewFiles.Selected.SubItems[1];
    if InputQuery('Edit Chinese Names', ['Chinese:', 'Pinyin:'], Names) then
    begin
      ListViewFiles.Selected.SubItems[0] := Names[0];
      ListViewFiles.Selected.SubItems[1] := Names[1];
    end;
    ApplyAndSave();
  end;
end;

procedure TFrameStockROMs.ListViewFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Target: TListItem;
  Selection: TObjectList<TListItem>;
  Item: TListItem;
  i: Integer;
begin
  TimerDnDScroll.Enabled := False;
  if IsDragging then
  begin
    IsDragging := False;
    Target := ListViewFiles.GetItemAt(X, Y);
    if Target = nil then
    Exit;
    //if Target.Selected then
    //Exit;

    Selection := TObjectList<TListItem>.Create(True);
    ListViewFiles.Items.BeginUpdate();
    try
      for Item in ListViewFiles.Items do
      if Item.Selected then
      Selection.Add(Item);

      i := Target.Index;
      if ListViewFiles.ItemFocused.Index < Target.Index then
      Inc(i);

      for Item in Selection do
      begin
        ListViewFiles.Items.Insert(i).Assign(Item);
        Inc(i);
      end;
    finally
      Selection.Free();
      ListViewFiles.Items.EndUpdate();
      ApplyAndSave();
    end;
  end;
end;

procedure TFrameStockROMs.ListViewFilesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := IsDragging;
end;

procedure TFrameStockROMs.ListViewFilesEdited(Sender: TObject; Item: TListItem; var S: string);
begin
  if RenameFile(Foldername.AbsoluteFolder[FolderIndex] + Item.Caption,
                Foldername.AbsoluteFolder[FolderIndex] + S) then
  begin
    if Favorites.Rename(FolderIndex, Item.Caption, S) then
    MustSaveReferenceLists := True;
    if History.Rename(FolderIndex, Item.Caption, S) then
    MustSaveReferenceLists := True;
    if not TROMFile.RenameRelated(FolderIndex, Item.Caption, S) then
    MessageDlg('Could not rename all existing related files, likely because there is some conflict or corruption', mtWarning, [mbOk], 0);
    Item.Caption := S;
    ROMDetailsFrame.ShowFile(FolderIndex, Item);
    ApplyAndSave();
  end
  else
  S := Item.Caption;
end;

procedure TFrameStockROMs.ListViewFilesItemChecked(Sender: TObject;
  Item: TListItem);
begin
  TimerSave.Enabled := False;
  TimerSave.Enabled := True;
end;

procedure TFrameStockROMs.ListViewFilesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not ListViewFiles.IsEditing then
  if ListViewFiles.SelCount > 0 then
  begin
    if Key = VK_DELETE then
    ButtonDeleteClick(nil);
    if Key = VK_F2 then
    ListViewFiles.Selected.EditCaption();
  end;
end;

procedure TFrameStockROMs.ListViewFilesKeyPress(Sender: TObject; var Key: Char);
begin
  if not ListViewFiles.IsEditing then
  if ListViewFiles.SelCount > 0 then
  begin
    if Key = '+' then
    begin
      Key := #0;
      DoCheckSelection(True);
    end;
    if Key = '-' then // is this you, Ed Sheeran?
    begin
      Key := #0;
      DoCheckSelection(False);
    end;
  end;
end;

procedure TFrameStockROMs.ListViewFilesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  ROMDetailsFrame.ShowFile(FolderIndex, Item);
end;

procedure TFrameStockROMs.ListViewFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  IsDragging := True;
  TimerDnDScroll.Enabled := True;
end;

procedure TFrameStockROMs.LoadFromFiles(FolderIndex: Word);
var
  i: Integer;
  Item: TListItem;
  KnownFiles: TDictionary<string, Integer>; // the second argument is not needed
  AllFiles: TList<string>;
  FN: string;
begin
  Self.FolderIndex := FolderIndex;
  Names.LoadFromFiles(FolderIndex);
  ListViewFiles.Items.BeginUpdate();
  KnownFiles := TDictionary<string, Integer>.Create();
  try
    ListViewFiles.OnItemChecked := nil; // Items.Add always fires this if Checkboxes is true
    ListViewFiles.Items.Clear();
    for i := 0 to Names.FileNames.Count - 1 do
    begin
      Item := ListViewFiles.Items.Add();
      Item.Caption := Names.FileNames[i];
      KnownFiles.Add(AnsiLowercase(Names.FileNames[i]), 0);
      Item.Checked := True;
      Item.ImageIndex := TROMFile.FileNameToImageIndex(Names.FileNames[i]);
      Item.SubItems.Add(Names.ChineseNames[i]);
      Item.SubItems.Add(Names.PinyinNames[i]);
    end;
    AllFiles := TROMFile.GetROMsIn(FolderIndex);
    try
      AllFiles.Sort();
      for FN in AllFiles do
      if not KnownFiles.ContainsKey(AnsiLowercase(FN)) then
      DoAddUnlisted(FN, False);
    finally
      AllFiles.Free();
    end;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.OnItemChecked := ListViewFilesItemChecked;
    ListViewFiles.DoAutoSize();
    KnownFiles.Free();
  end;
end;

procedure TFrameStockROMs.MenuItemImportAllImagesClick(Sender: TObject);
var
  AbsFolder: string;
  Caption: string;
  Del: Boolean;
function DoProcess(Item: TListItem; const CandidateImage: string): Boolean;
var
  ROM: TROMFile;
  Picture: TPicture;
  HadImage: Boolean;
  Filename: string;
begin
  Result := False;
  if FileExists(CandidateImage) then
  begin
    ROM := TROMFile.Create();
    try
      ROM.LoadFromFile(FolderIndex, Caption);

      Picture := TPicture.Create();
      try
        Picture.LoadFromFile(CandidateImage);

        AutoScaleThumbnail(Picture);

        HadImage := ROM.HasImage;
        FileName := Caption;
        if not HadImage then
        begin
          FileName := ChangeFileExt(Caption, TROMFile.FileTypeToThumbExt(TROMFile.FileNameToType(ROM.ROMFileName)));
          if FileExists(Foldername.AbsoluteFolder[FolderIndex] + FileName) then
          Exit();
        end;
        ROM.Thumbnail := Picture.Graphic;
        ROM.SaveToFile(FolderIndex, Caption, True);
        if Caption <> FileName then
        begin
          if not RenameFile(Foldername.AbsoluteFolder[FolderIndex] + Caption,
                            Foldername.AbsoluteFolder[FolderIndex] + FileName) then
          raise Exception.CreateFmt('Could not rename file ''%s'' to ''%s''', [Caption, FileName]);

          if not TROMFile.RenameRelated(FolderIndex, Caption, Filename) then
          MessageDlg(Format('Could not rename all existing related files after renaming ''%s'' to ''%s'', likely because there is some conflict or corruption', [Caption, FileName]), mtWarning, [mbOk], 0);
          Item.Caption := Filename;
          Item.ImageIndex := TROMFile.FileNameToImageIndex(Filename);
          if ROMDetailsFrame.Item = Item then         
          ROMDetailsFrame.ShowFile(FolderIndex, Item, True);
        end;
      finally
        Picture.Free();
      end;
      Result := True;

      if Del then
      DeleteFile(CandidateImage);
    finally
      ROM.Free();
    end;
  end;
end;
var
  Item: TListItem;
begin
  case MessageDlg('This checks this folder for ROMs that have images where .png and .jpg have added to the extension or replaced it. ' +
                  'For multicore stubs, it also checks the actual ROMs'' location using the same pattern. Those images are then used as thumbnail.'#13#10#13#10 +
                  'Do you want to delete images that were successfully imported in this process?', mtWarning, mbYesNoCancel, 0, mbNo) of
    mrYes: Del := True;
    mrNo: Del := False;
    else Exit;
  end;

  AbsFolder := Foldername.AbsoluteFolder[FolderIndex];
  try
    try
      for Item in ListViewFiles.Items do
      begin
        Caption := Item.Caption;
        if DoProcess(Item, AbsFolder + Caption + '.png') then Continue;
        if DoProcess(Item, AbsFolder + Caption + '.jpg') then Continue;
        if DoProcess(Item, AbsFolder + ChangeFileExt(Caption, '.png')) then Continue;
        if DoProcess(Item, AbsFolder + ChangeFileExt(Caption, '.jpg')) then Continue;
        if TROMFile.GetIsMultiCore(Caption) then
        with TROMFile.GetMCName(Caption) do
        begin
          if DoProcess(Item, AbsFolder + AbsoluteFileName + '.png') then Continue;
          if DoProcess(Item, AbsFolder + AbsoluteFileName + '.jpg') then Continue;
          if DoProcess(Item, AbsFolder + ChangeFileExt(AbsoluteFileName, '.png')) then Continue;
          if DoProcess(Item, AbsFolder + ChangeFileExt(AbsoluteFileName, '.jpg')) then Continue;
        end;
      end;         
    finally
      MustSaveReferenceLists := True;
      ApplyAndSave();
    end;
  except    
    LoadFromFiles(FolderIndex);
    raise;
  end;
end;

procedure TFrameStockROMs.ROMDuplicate(var Item: TListItem; const NewName: string);
begin
  try
    ListViewFiles.OnItemChecked := nil;
    Item := DoAddUnlisted(NewName, ROMDetailsFrame.Item.Checked);
  finally
    ListViewFiles.OnItemChecked := ListViewFilesItemChecked;
    ListViewFiles.DoAutoSize();
    ApplyAndSave();
  end;
end;

procedure TFrameStockROMs.ROMRename(var Item: TListItem; const NewName: string);
begin
  if Favorites.Rename(FolderIndex, Item.Caption, NewName) then
  MustSaveReferenceLists := True;
  if History.Rename(FolderIndex, Item.Caption, NewName) then
  MustSaveReferenceLists := True;
  if not TROMFile.RenameRelated(FolderIndex, Item.Caption, NewName) then
  MessageDlg('Could not rename all existing related files, likely because there is some conflict or corruption', mtWarning, [mbOk], 0);
  Item.Caption := NewName;
  Item.ImageIndex := TROMFile.FileNameToImageIndex(NewName);
  ApplyAndSave();
end;

procedure TFrameStockROMs.TimerDnDScrollTimer(Sender: TObject);
begin
  HandleDnDScrollTimer(ListViewFiles);
end;

procedure TFrameStockROMs.TimerSaveTimer(Sender: TObject);
begin
  TimerSave.Enabled := False;
  ApplyAndSave;
end;

end.
