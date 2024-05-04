unit UnitROMDetails;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, pngimage, GB300Utils;

type
  TRenameEvent = procedure (var Item: TListItem; const NewName: string) of object;

  TFrameROMDetails = class(TFrame)
    GroupBox1: TGroupBox;
    ImageThumbnailBackground: TImage;
    ButtonExportROM: TButton;
    ButtonImportROM: TButton;
    ButtonExportThumb: TButton;
    ButtonImportThumb: TButton;
    ButtonPatchROM: TButton;
    ButtonRename: TButton;
    ImageThumbnail: TImage;
    LabelROMName: TLabel;
    LabelRename: TLabel;
    LabelExportROM: TLabel;
    LabelImportROM: TLabel;
    LabelPatchROM: TLabel;
    LabelExportThumb: TLabel;
    LabelImportThumb: TLabel;
    PopupMenuRename: TPopupMenu;
    MenuItemDuplicate: TMenuItem;
    MenuItemCompress: TMenuItem;
    MenuItemDecompress: TMenuItem;
    ImageListStates: TImageList;
    PanelTop: TPanel;
    ListViewStates: TListView;
    SaveDialogROM: TSaveDialog;
    OpenDialogROM: TOpenDialog;
    OpenDialogPatch: TOpenDialog;
    PopupMenuState: TPopupMenu;
    MenuItemStateSaveDIB: TMenuItem;
    SaveDialogImage: TSaveDialog;
    LabelCRC: TLabel;
    N1: TMenuItem;
    MenuItemConvertDAT: TMenuItem;
    OpenDialogDAT: TOpenDialog;
    LabelNoIntro: TLabel;
    OpenDialogImageRGB565: TOpenDialog;
    ImageFavorite: TImage;
    N2: TMenuItem;
    MenuItemMakeMulticore: TMenuItem;
    procedure ButtonExportROMClick(Sender: TObject);
    procedure ButtonPatchROMClick(Sender: TObject);
    procedure MenuItemStateSaveDIBClick(Sender: TObject);
    procedure SaveDialogImageTypeChange(Sender: TObject);
    procedure LabelCRCClick(Sender: TObject);
    procedure MenuItemConvertDATClick(Sender: TObject);
    procedure LabelNoIntroClick(Sender: TObject);
    procedure MenuItemCompressClick(Sender: TObject);
    procedure ButtonImportROMClick(Sender: TObject);
    procedure ButtonImportThumbClick(Sender: TObject);
    procedure MenuItemDecompressClick(Sender: TObject);
    procedure PopupMenuStatePopup(Sender: TObject);
    procedure ImageFavoriteClick(Sender: TObject);
    procedure MenuItemDuplicateClick(Sender: TObject);
    procedure PopupMenuRenamePopup(Sender: TObject);
    procedure ButtonRenameClick(Sender: TObject);
    procedure ListViewStatesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuItemMakeMulticoreClick(Sender: TObject);
  private
    { Private declarations }
    procedure InputQueryHook(Sender: TObject);
    procedure InputQueryShow(Sender: TObject);
    var
      ROM: TROMFile;
      CRC: Cardinal;
      NoIntroData: TNoIntro;
      FFolderIndex: Byte;
      FFileName: string;
      FItem: TListItem;
      FOnRename: TRenameEvent;
      FOnDuplicate: TRenameEvent;
  public
    { Public declarations }
    procedure ShowFile(FolderIndex: Byte; Item: TListItem; Force: Boolean = False);
    procedure RefreshFavoriteStatus();
    constructor Create(AOwner: TComponent); override;
    property Item: TListItem read FItem;
    property OnRename: TRenameEvent read FOnRename write FOnRename;
    property OnDuplicate: TRenameEvent read FOnDuplicate write FOnDuplicate;
  end;

implementation

uses
  GB300UIConst, Clipbrd, RedeemerXML, StrUtils, GUIHelpers, UITypes,
  UnitStockROMs, UnitUserROMs;

{$R *.dfm}

{ TFrameROMDetails }

procedure TFrameROMDetails.ButtonExportROMClick(Sender: TObject);
var
  FN: string;
  MS: TMemoryStream;
begin
  FN := ROM.ROMFileName;
  SaveDialogROM.FileName := FN;
  SaveDialogROM.DefaultExt := ExtractFileExt(FN);
  SaveDialogROM.Filter := TROMFile.FileTypeToFilter(TROMFile.FileNameToType(FN), False);
  if SaveDialogROM.Execute() then
  begin
    MS := ROM.ROM;
    try
      MS.SaveToFile(SaveDialogROM.FileName);
    finally
      MS.Free();
    end;
  end;
end;

procedure TFrameROMDetails.ButtonImportROMClick(Sender: TObject);
var
  Stream: TFileStream;
begin
  OpenDialogROM.Filter := TROMFile.FileTypeToFilter(TROMFile.FileNameToType(ROM.ROMFileName), False) + '|ROMs (' + StringReplace(ExtensionsROMs, ';', ', ', [rfReplaceAll]) + ')|' + ExtensionsROMs + '|All files (*.*)|*.*';
  if OpenDialogROM.Execute() then
  begin
    Stream := TFileStream.Create(OpenDialogROM.FileName, fmOpenRead);
    try
      ROM.SetROM(Stream, ExtractFileName(OpenDialogROM.FileName)); // does not support zipped files, so we don't have them in the above filters (but only ROMs)
    finally
      Stream.Free();
    end;
    ROM.SaveToFile(FFolderIndex, FFileName);
    ShowFile(FFolderIndex, FItem, True);
  end;
end;

procedure TFrameROMDetails.ButtonImportThumbClick(Sender: TObject);
var
  Picture: TPicture;
  HadImage: Boolean;
  FileName: string;
  Thumb: TGraphic;
  IsMulticore: Boolean;
begin
  if OpenDialogImageRGB565.Execute() then
  begin
    Picture := TPicture.Create();
    try
      Picture.LoadFromFile(OpenDialogImageRGB565.FileName);
      HadImage := ROM.HasImage;
      FileName := FFileName;
      if not HadImage then
      begin
        IsMultiCore := ROM.IsMultiCore;
        if IsMultiCore then
        //FileName := ChangeFileExt(FFileName, '.zfb')
        raise Exception.Create('The GB300''s firmware does not support thumbnailed link files (ZFB) and other thumbnailed files (ZFC, ZPC, ZSF, ZMD, ZGB) will inevitably run a stock emulator')
        else
        FileName := ChangeFileExt(FFileName, TROMFile.FileTypeToThumbExt(TROMFile.FileNameToType(ROM.ROMFileName)));
        if FileExists(Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
        raise Exception.Create('There is already a thumbnailed file of this ROM''s name');
        ROM.Thumbnail := Picture.Graphic;
        if IsMultiCore then
        ROM.MakeFinalBurn();
      end
      else
      ROM.Thumbnail := Picture.Graphic;
      ROM.SaveToFile(FFolderIndex, FFileName);
      if FFileName <> FileName then
      begin
        if not RenameFile(Foldername.AbsoluteFolder[FFolderIndex] + FFileName,
                          Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
        raise Exception.Create('Could not rename the file');
        FFileName := FileName;
        try
          if Assigned(FOnRename) then
          FOnRename(FItem, FFileName);
        finally
          Thumb := ROM.Thumbnail;
          try
            ImageThumbnail.Picture.Assign(Thumb);
            ImageThumbnail.Show();
          finally
            Thumb.Free();
          end;
        end;
      end;
    finally
      Picture.Free();
    end;
  end;
end;

procedure TFrameROMDetails.ButtonPatchROMClick(Sender: TObject);
var
  MS: TMemoryStream;
  FileName: string;
  Exists: Boolean;
begin
  FileName := FFileName;
  {SaveDialogPatchedFile.FileName := FileName;
  SaveDialogPatchedFile.InitialDir := Foldername.AbsoluteFolder[FFolderIndex];
  SaveDialogPatchedFile.DefaultExt := ExtractFileExt(FileName);
  SaveDialogPatchedFile.Filter := TROMFile.FileTypeToFilter(TROMFile.FileNameToType(FileName), False);       }
  if OpenDialogPatch.Execute() then
  try
    Application.OnModalBegin := InputQueryHook;
    if InputQuery(Application.Title, 'New file name:'#13#10'(leave unchanged to overwrite current file)', FileName) then
    begin
      MS := ROM.ROM;
      try
        TROMFile.Patch(MS, OpenDialogPatch.FileName);
        MS.Position := 0;
        ROM.SetROM(MS, ROM.ROMFileName);
        Exists := FileExists(Foldername.AbsoluteFolder[FFolderIndex] + FileName);

        ROM.SaveToFile(FFolderIndex, FileName);

        if Exists then
        if FileName <> FFileName then // FItem is now invalid so we cannot continue
        begin
          FItem.Selected := False;
          FItem := nil;
          Hide();
          Exit;
        end;

        FFileName := FileName;

        try
          FItem.Selected := False;
          if not Exists then
          if Assigned(FOnDuplicate) then
          begin
            FOnDuplicate(FItem, FileName);
            FItem.ListView.ClearSelection();
            FItem.ListView.Selected := FItem;
            if not Assigned(FItem) then
            begin
              Hide();
              Exit;
            end;
          end;
        finally
          if Visible then
          ShowFile(FFolderIndex, FItem, True);
        end;
      finally
        MS.Free();
      end;
    end;
  finally
    Application.OnModalBegin := nil;
  end;
end;

procedure TFrameROMDetails.ButtonRenameClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := FFileName;
  try
    Application.OnModalBegin := InputQueryHook;
    if InputQuery(Application.Title, 'New file name:', FileName) then
    begin
      if TROMFile.GetIsMultiCore(FileName) xor TROMFile.GetIsMultiCore(FileName) then
      raise Exception.Create('Cannot switch between multicore and stock by renaming a file');

      if FileExists(Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
      raise Exception.Create('File already exists');

      if TROMFile.GetIsMultiCore(FileName) then
      if FileExists(TROMFile.GetMCName(FFileName).AbsoluteFileName) then
      raise Exception.Create('MC File already exists');

      RenameFile(Foldername.AbsoluteFolder[FFolderIndex] + FFileName, Foldername.AbsoluteFolder[FFolderIndex] + FileName);
      try
        if Assigned(FOnRename) then
        FOnRename(FItem, FileName);
      finally
        if Visible then
        ShowFile(FFolderIndex, FItem, True);
      end;
    end;
  finally
    Application.OnModalBegin := nil;
  end;
end;

constructor TFrameROMDetails.Create(AOwner: TComponent);
var
  UIFile: TUIFIle;
  PNG: TPngImage;
begin
  inherited;
  for UIFile in UIFiles do
  if UIFile.Filename = 'appvc.ikb' then
  begin
    PNG := UIFile.GetPNGImage;
    try
      ImageThumbnailBackground.Picture.Assign(PNG);
    finally
      PNG.Free();
    end;
  end;
  LabelImportThumb.Caption := Format(LabelImportThumb.Caption, [Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y]);
  LoadPNGTo(999, ImageFavorite.Picture);
  MenuItemConvertDAT.Visible := ParamStr(1) = '-dev';
end;

procedure TFrameROMDetails.ImageFavoriteClick(Sender: TObject);
begin
  if ImageFavorite.Center then
  Favorites.RemoveFile(FFolderIndex, FFileName)
  else
  Favorites.AddFile(FFolderIndex, FFileName);
  ImageFavorite.Center := Favorites.ContainsFile(FFolderIndex, FFileName);
  Favorites.SaveToFile(rfFavorites);
end;

procedure TFrameROMDetails.InputQueryHook(Sender: TObject);
begin
  // I want to change an Edit's SelLength, but you can only change it after the form is completely shown (OnShow does not work here)
  with TTimer.Create(Screen.CustomForms[Screen.CustomFormCount-1]) do
  begin
    Interval := 1;
    OnTimer := InputQueryShow;
  end;
end;

procedure TFrameROMDetails.InputQueryShow(Sender: TObject);
begin
  (Sender as TTimer).Enabled := False;
  if ((Sender as TTimer).Owner as TForm).Components[1] is TEdit then
  with ((Sender as TTimer).Owner as TForm).Components[1] as TEdit do
  SelLength := SelLength - Length(ExtractFileExt(Text));
end;

procedure TFrameROMDetails.LabelCRCClick(Sender: TObject);
begin
  Clipboard.AsText := LabelCRC.Caption;
end;

procedure TFrameROMDetails.LabelNoIntroClick(Sender: TObject);
begin
  Clipboard.AsText := string(NoIntroData.Name) + #9 + IntToStr(NoIntroData.GameID) + #9 + IntToHex(CRC, 8);
end;

procedure TFrameROMDetails.ListViewStatesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ListViewStates.SelCount = 1 then
  if Key = VK_DELETE then
  if MessageDlg(Format('Do you really want to delete ''%s''?', [ListViewStates.Selected.Caption]), mtWarning, mbYesNo, 0, mbNo) = mrYes then
  begin
    if DeleteFile(ListViewStates.Selected.SubItems[0]) then
    ListViewStates.DeleteSelected();
  end;
end;

procedure TFrameROMDetails.MenuItemMakeMulticoreClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Add(Foldername.AbsoluteFolder[FFolderIndex] + FFileName);
    if Owner is TFrameUserROMs then
    (Owner as TFrameUserROMs).DoAdd(sl);
    if Owner is TFrameStockROMs then
    (Owner as TFrameStockROMs).DoAdd(sl);
  finally
    sl.Free();
  end;
end;

procedure TFrameROMDetails.MenuItemCompressClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := ChangeFileExt(ROM.ROMFileName, '.zip');
  if FileExists(Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
  raise Exception.Create('There is already a ZIP file of this ROM''s name');
  ROM.Compress(0);
  ROM.SaveToFile(FFolderIndex, FFileName); // assuming that overwriting is more prone to errors than renaming now that the non-existance of the target file has been checked
  if not RenameFile(Foldername.AbsoluteFolder[FFolderIndex] + FFileName,
                    Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
  raise Exception.Create('Could not rename the file to .zip');
  FFileName := FileName;
  if Assigned(FOnRename) then
  FOnRename(FItem, FFileName);
end;

procedure TFrameROMDetails.MenuItemConvertDATClick(Sender: TObject);
var
  SS: TStringStream;
  XML: TRedeemerXML;
  GameID: SmallInt;
  Game: AnsiString;
  MS: TMemoryStream;
  ID: Integer;
  FN: string;
begin
  if OpenDialogDAT.Execute() then
  for FN in OpenDialogDAT.Files do
  begin
    SS := TStringStream.Create(); // ASCII anyway
    MS := TMemoryStream.Create();
    try
      SS.LoadFromFile(FN);
      XML := TRedeemerXML.Create(SS.DataString);
      GameID := 0;
      ID := 0;
      try
        while XML.GoToAndGetNextTag() do
        begin
          if XML.CurrentTag = 'id' then
          ID := StrToInt(XML.GetInnerTextAndSkip);
          if XML.CurrentTag = 'game' then
          begin
            Game := AnsiString(XML.GetAttribute('name'));
            GameID := StrToInt(XML.GetAttribute('id'));
          end
          else
          if XML.CurrentTag = 'rom' then
          begin
            if Game = 'Phantasy Star Fukkokuban (Japan)' then // this MD game is a duplicate by CRC of the identical(!) SMS game and therefore causes issues with TDictionary used to store the data for fast tree search; the MD module had a SMS-to-MD converter, but the ROM is exactly the same
            Continue;
            Assert(Length(Game) < 255);
            MS.WriteData(Cardinal(StrToInt64('0x' + XML.GetAttribute('crc'))));
            if XML.GetAttribute('status') = 'verified' then
            MS.WriteData(GameID)
            else
            MS.WriteData(SmallInt(-GameID));
            MS.WriteData(ShortInt(Length(Game)));
            MS.Write(Game[1], Length(Game));
          end;
        end;
      finally
        XML.Free();
      end;
      MS.SaveToFile(ExtractFilePath(FN) + IntToStr(ID) + '.bin');
    finally
      SS.Free();
      MS.Free();
    end;
  end;
end;

procedure TFrameROMDetails.MenuItemDecompressClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := ROM.ROMFileName;
  if FileExists(Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
  raise Exception.Create('There is already a file of the contained ROM''s name');
  ROM.Decompress();
  ROM.SaveToFile(FFolderIndex, FFileName); // assuming that overwriting is more prone to errors than renaming now that the non-existance of the target file has been checked
  if not RenameFile(Foldername.AbsoluteFolder[FFolderIndex] + FFileName,
                    Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
  raise Exception.Create('Could not rename the file to the uncompressed ROM name');
  FFileName := FileName;
  if Assigned(FOnRename) then
  FOnRename(FItem, FFileName);
  ImageThumbnail.Hide();
end;

procedure TFrameROMDetails.MenuItemDuplicateClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := FFileName;
  try
    Application.OnModalBegin := InputQueryHook;
    if InputQuery(Application.Title, 'New file name:', FileName) then
    begin
      if FileExists(Foldername.AbsoluteFolder[FFolderIndex] + FileName) then
      raise Exception.Create('File already exists');

      ROM.SaveToFile(FFolderIndex, FileName);
      try
        FItem.Selected := False;
        if Assigned(FOnDuplicate) then
        begin
          FOnDuplicate(FItem, FileName);
          FItem.ListView.ClearSelection();
          FItem.ListView.Selected := FItem;
          if not Assigned(FItem) then
          begin
            Hide();
            Exit;
          end;
        end;
      finally
        if Visible then
        ShowFile(FFolderIndex, FItem, True);
      end;
    end;
  finally
    Application.OnModalBegin := nil;
  end;
end;

procedure TFrameROMDetails.MenuItemStateSaveDIBClick(Sender: TObject);
var
  State: TState;
  Dimensions: TPoint;
  MS: TMemoryStream;
  MS2: TMemoryStream;
  PNG: TPNGImage;
begin
  if ListViewStates.SelCount = 1 then
  if SaveDialogImage.Execute() then
  begin
    State := TState.Create();
    try
      State.LoadFromFile(ListViewStates.Selected.SubItems[0]);
      MS := State.GetScreenshotData(Dimensions);
      try
        MS.Position := 0;
        case SaveDialogImage.FilterIndex of
          1:
            begin
              PNG := GetPNGImageFromStream(MS, idfRGB565, Dimensions.X, Dimensions.Y);
              try
                PNG.SaveToFile(SaveDialogImage.FileName);
              finally
                PNG.Free();
              end;
            end;
          2:
            begin
              MS2 := GetDIBStreamFromStream(MS, idfRGB565, Dimensions.X, Dimensions.Y);
              try
                MS2.SaveToFile(SaveDialogImage.FileName);
              finally
                MS2.Free();
              end;
            end;
        end;
      finally
        MS.Free();
      end;
    finally
      State.Free();
    end;
  end;
end;

procedure TFrameROMDetails.PopupMenuRenamePopup(Sender: TObject);
begin
  MenuItemCompress.Enabled := not ROM.IsCompressed and not ROM.IsMultiCore;
  MenuItemDecompress.Enabled := ROM.IsCompressed and not ROM.IsMultiCore;
  MenuItemMakeMulticore.Enabled := not ROM.IsMultiCore;
end;

procedure TFrameROMDetails.PopupMenuStatePopup(Sender: TObject);
begin
  MenuItemStateSaveDIB.Enabled := ListViewStates.SelCount > 0;
end;

procedure TFrameROMDetails.RefreshFavoriteStatus;
begin
  if ImageFavorite.Visible then
  begin
    ImageFavorite.Center := Favorites.ContainsFile(FFolderIndex, FFileName);
    ImageFavorite.Left := LabelROMName.Left + LabelROMName.Width;
  end;
end;

procedure TFrameROMDetails.SaveDialogImageTypeChange(Sender: TObject);
begin
  case SaveDialogImage.FilterIndex of
    1: SaveDialogImage.DefaultExt := '.png';
    2: SaveDialogImage.DefaultExt := '.dib';
  end;
end;

procedure TFrameROMDetails.ShowFile(FolderIndex: Byte; Item: TListItem; Force: Boolean);
var
  Thumb: TGraphic;
  i: Byte;
  Candidate: string;
  State: TState;
  PNG: TPngImage;
  Bitmap: TBitmap;
  NewItem: TListItem;
begin
  if (FolderIndex <> FFolderIndex) or (Item.Caption <> FFileName) or Force then
  try
    FreeAndNil(ROM);
    ROM := TROMFile.Create();
    ROM.LoadFromFile(FolderIndex, Item.Caption);
    //LabelROMName.Caption := ChangeFileExt(Item.Caption, '');
    LabelROMName.Caption := StringReplace(ROM.ROMFileName, '&', '&&', [rfReplaceAll]) + ' ';
    if ROM.HasImage then
    begin
      Thumb := ROM.Thumbnail;
      try
        ImageThumbnail.Picture.Assign(Thumb);
        ImageThumbnail.Show();
      finally
        Thumb.Free();
      end;
    end
    else
    ImageThumbnail.Hide();
    CRC := ROM.GetCRC();
    LabelCRC.Caption := IntToHex(CRC, 8);
    if NoIntro.ContainsKey(CRC) then
    begin
      NoIntroData := NoIntro[CRC];
      LabelNoIntro.Caption := 'No-Intro: #' + RightStr('000' + IntToStr(NoIntroData.GameID), 4) + ' � ' + string(NoIntroData.Name) + IfThen(NoIntroData.IsVerified, ' [verified]');
    end
    else
    LabelNoIntro.Caption := 'No-Intro: unmatched';

    // States
    ListViewStates.Items.BeginUpdate();
    ImageListStates.BeginUpdate();
    try
      ListViewStates.Items.Clear();
      ImageListStates.Clear();
      for i := 0 to 3 do
      begin
        Candidate := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + Foldername.Folders[FolderIndex]) + 'save') + Item.Caption + '.sa' + IntToStr(i);
        if FileExists(Candidate) then
        begin
          State := TState.Create();
          try
            State.LoadFromFile(Candidate);
            PNG := State.GetScreenshot();
            try
              // Handle dimensions of screenshot
              if ListViewStates.Items.Count = 0 then
              begin
                ImageListStates.Width := PNG.Width;
                ImageListStates.Height := PNG.Height;
              end;

              // Add new screenshot
              Bitmap := TBitmap.Create();
              try
                if (ImageListStates.Width <> PNG.Width) or (ImageListStates.Height <> PNG.Height) then
                begin
                  // can only have same-sized images in an ImageList and under normal circumstances, this is the case
                  // (repeatedly entering the pause menu eventually allows you to create a 640x480 screenshot of the GB300's interface and some PCE games can change the resolution)
                  NewItem := ListViewStates.Items.Add();
                  NewItem.ImageIndex := -1;
                end
                else
                begin
                  Bitmap.Assign(PNG);
                  ImageListStates.AddMasked(Bitmap, clNone);
                  NewItem := ListViewStates.Items.Add();
                  NewItem.ImageIndex := ImageListStates.Count - 1;
                end;
                NewItem.Caption := ExtractFileName(Candidate);
                NewItem.SubItems.Add(Candidate);
              finally
                Bitmap.Free();
              end;
            finally
              PNG.Free();
            end;
          finally
            State.Free();
          end;
        end;
      end;
    finally
      ImageListStates.EndUpdate();
      ListViewStates.Items.EndUpdate();
    end;
    FFolderIndex := FolderIndex;
    FFileName := Item.Caption;
  except
    Hide();
    raise;
  end;
  FItem := Item;
  ButtonRename.Enabled := Assigned(FOnRename);
  ButtonImportThumb.Enabled := Assigned(FOnRename) or ROM.HasImage;
  RefreshFavoriteStatus();
  Show();
end;

end.
