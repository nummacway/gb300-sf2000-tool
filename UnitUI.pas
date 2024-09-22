unit UnitUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  GB300Utils, Vcl.StdCtrls, GUIHelpers, pngimage, GB300UIConst, Vcl.Menus;

type
  TFrameUI = class(TFrame)
    ListViewFiles: TListView;
    PanelSpacer: TPanel;
    PanelRight: TPanel;
    ScrollBoxPreview: TScrollBox;
    PanelTop: TPanel;
    ButtonSave: TButton;
    ButtonReplace: TButton;
    ComboBoxDisplayMode: TComboBox;
    ImagePreview: TImage;
    TimerLazyLoad: TTimer;
    SaveDialogImage: TSaveDialog;
    OpenDialogImageRGB565: TOpenDialog;
    OpenDialogImageBGRA8888: TOpenDialog;
    LabelFormat: TLabel;
    Label1: TLabel;
    ComboBoxImageList: TComboBox;
    ImagePreview2: TImage;
    PanelRightFoldername: TPanel;
    EditFoldernameHeader: TEdit;
    Label2: TLabel;
    EditFoldernameLanguages: TEdit;
    Label3: TLabel;
    ColorBoxFoldernameDefaultColor: TColorBox;
    Label4: TLabel;
    ColorBoxFoldernameSelectedColor0: TColorBox;
    EditFoldernameFolder0: TEdit;
    Label5: TLabel;
    ColorBoxFoldernameSelectedColor1: TColorBox;
    EditFoldernameFolder1: TEdit;
    Label6: TLabel;
    ColorBoxFoldernameSelectedColor2: TColorBox;
    EditFoldernameFolder2: TEdit;
    Label7: TLabel;
    ColorBoxFoldernameSelectedColor3: TColorBox;
    EditFoldernameFolder3: TEdit;
    Label8: TLabel;
    ColorBoxFoldernameSelectedColor4: TColorBox;
    EditFoldernameFolder4: TEdit;
    Label9: TLabel;
    ColorBoxFoldernameSelectedColor5: TColorBox;
    EditFoldernameFolder5: TEdit;
    Label10: TLabel;
    ColorBoxFoldernameSelectedColor6: TColorBox;
    EditFoldernameFolder6: TEdit;
    Label11: TLabel;
    ColorBoxFoldernameSelectedColor7: TColorBox;
    EditFoldernameFolder7: TEdit;
    Label12: TLabel;
    ColorBoxFoldernameSelectedColor8: TColorBox;
    EditFoldernameFolder8: TEdit;
    Label13: TLabel;
    ColorBoxFoldernameSelectedColor9: TColorBox;
    EditFoldernameFolder9: TEdit;
    Label14: TLabel;
    EditFoldernameTabCount: TEdit;
    Label15: TLabel;
    ComboBoxFoldernameInitialLeftTab: TComboBox;
    Label16: TLabel;
    ComboBoxFoldernameInitialSelectedTab: TComboBox;
    Label17: TLabel;
    EditFoldernameThumbnailPositionX: TEdit;
    EditFoldernameThumbnailPositionY: TEdit;
    Label23: TLabel;
    EditFoldernameThumbnailSizeWidth: TEdit;
    EditFoldernameThumbnailSizeHeight: TEdit;
    Label24: TLabel;
    EditFoldernameSelectionSizeWidth: TEdit;
    EditFoldernameSelectionSizeHeight: TEdit;
    Label25: TLabel;
    ButtonFoldernameReload: TButton;
    ButtonFoldernameUndo: TButton;
    ButtonFoldernameDefaults: TButton;
    ButtonFoldernameSave: TButton;
    PopupMenuSave: TPopupMenu;
    MenuItemCopy: TMenuItem;
    N1: TMenuItem;
    MenuItemReloadXML: TMenuItem;
    N2: TMenuItem;
    ExportAllImagestoDirectory1: TMenuItem;
    MenuItemCopySmall: TMenuItem;
    PanelRightStrings: TPanel;
    Memo1: TMemo;
    MemoStrings: TMemo;
    Panel1: TPanel;
    ButtonStringsSave: TButton;
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ListViewFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ImagePreviewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonReplaceClick(Sender: TObject);
    procedure ComboBoxDisplayModeSelect(Sender: TObject);
    procedure ComboBoxImageListSelect(Sender: TObject);
    procedure ColorBoxGetColors(Sender: TCustomColorBox; Items: TStrings);
    procedure ButtonFoldernameReloadClick(Sender: TObject);
    procedure ButtonFoldernameDefaultsClick(Sender: TObject);
    procedure ButtonFoldernameUndoClick(Sender: TObject);
    procedure ButtonFoldernameSaveClick(Sender: TObject);
    procedure EditFoldernameFolderChange(Sender: TObject);
    procedure MenuItemCopyClick(Sender: TObject);
    procedure MenuItemReloadXMLClick(Sender: TObject);
    procedure ExportAllImagestoDirectory1Click(Sender: TObject);
    procedure MenuItemCopySmallClick(Sender: TObject);
    procedure PopupMenuSavePopup(Sender: TObject);
    procedure ButtonStringsSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowFile(const NewFile: TUIFile);
    procedure UpdateSlices(const Slices: array of TUIFileSlice);
    procedure DoReplace(const FileName: string);
    procedure DropNewImage(Sender: TObject);
    var
      CurrentFile: TUIFile;
  public
    { Public declarations }
  end;

implementation

uses
  Clipbrd, UnitMain, FileCtrl, UITypes;

{$R *.dfm}

procedure TFrameUI.ButtonFoldernameDefaultsClick(Sender: TObject);
begin
  if CurrentDevice = cdGB300 then
  Foldername := DefaultFoldernameGB300;
  if CurrentDevice = cdSF2000 then
  Foldername := DefaultFoldernameSF2000;
  ButtonFoldernameUndoClick(ButtonFoldernameUndo);
end;

procedure TFrameUI.ButtonFoldernameReloadClick(Sender: TObject);
begin
  Foldername.LoadFromFile();
  ButtonFoldernameUndoClick(ButtonFoldernameUndo);
end;

procedure TFrameUI.ButtonFoldernameSaveClick(Sender: TObject);
var
  i: Integer;
  TempFoldername: TFoldername;
begin
  TempFoldername := Foldername;

  TempFoldername.DefaultColor := ColorBoxFoldernameDefaultColor.Selected;
  for i := 0 to 9 do
  begin
    TempFoldername.SelectedColors[i] := (FindComponent('ColorBoxFoldernameSelectedColor' + IntToStr(i)) as TColorBox).Selected;
    TempFoldername.Folders[i] := (FindComponent('EditFoldernameFolder' + IntToStr(i)) as TEdit).Text;
  end;
  TempFoldername.InitialLeftTab := ComboBoxFoldernameInitialLeftTab.ItemIndex;
  TempFoldername.UserSettingsTab := ComboBoxFoldernameInitialSelectedTab.ItemIndex;

  TempFoldername.ThumbnailPosition.X := StrToInt(EditFoldernameThumbnailPositionX.Text);
  TempFoldername.ThumbnailPosition.Y := StrToInt(EditFoldernameThumbnailPositionY.Text);
  TempFoldername.ThumbnailSize.X := StrToInt(EditFoldernameThumbnailSizeWidth.Text);
  TempFoldername.ThumbnailSize.Y := StrToInt(EditFoldernameThumbnailSizeHeight.Text);
  TempFoldername.SelectionSize.X := StrToInt(EditFoldernameSelectionSizeWidth.Text);
  TempFoldername.SelectionSize.Y := StrToInt(EditFoldernameSelectionSizeHeight.Text);

  TempFoldername.SaveToFile();
  Foldername := TempFoldername;
  Form1.UpdateLabels();
  Foldername.ForceAllDirectories();
end;

procedure TFrameUI.ButtonFoldernameUndoClick(Sender: TObject);
var
  i: Integer;
begin
  EditFoldernameHeader.Text := Foldername.Header;
  EditFoldernameLanguages.Text := IntToStr(Foldername.Languages);
  ColorBoxFoldernameDefaultColor.Selected := Foldername.DefaultColor;
  for i := 0 to 9 do
  begin
    (FindComponent('ColorBoxFoldernameSelectedColor' + IntToStr(i)) as TColorBox).Selected := Foldername.SelectedColors[i];
    (FindComponent('EditFoldernameFolder' + IntToStr(i)) as TEdit).Text := Foldername.Folders[i];
  end;
  EditFoldernameTabCount.Text := IntToStr(Foldername.TabCount);
  ComboBoxFoldernameInitialLeftTab.ItemIndex := Foldername.InitialLeftTab;
  ComboBoxFoldernameInitialSelectedTab.ItemIndex := Foldername.UserSettingsTab;

  EditFoldernameThumbnailPositionX.Text := IntToStr(Foldername.ThumbnailPosition.X);
  EditFoldernameThumbnailPositionY.Text := IntToStr(Foldername.ThumbnailPosition.Y);
  EditFoldernameThumbnailSizeWidth.Text := IntToStr(Foldername.ThumbnailSize.X);
  EditFoldernameThumbnailSizeHeight.Text := IntToStr(Foldername.ThumbnailSize.Y);

  EditFoldernameSelectionSizeWidth.Text := IntToStr(Foldername.SelectionSize.X);
  EditFoldernameSelectionSizeHeight.Text := IntToStr(Foldername.SelectionSize.Y);
end;

procedure TFrameUI.ButtonReplaceClick(Sender: TObject);
begin
  case CurrentFile.Format of
    idfRGB565:
      if OpenDialogImageRGB565.Execute() then
      DoReplace(OpenDialogImageRGB565.FileName);
    idfBGRA8888:
      if OpenDialogImageBGRA8888.Execute() then
      DoReplace(OpenDialogImageBGRA8888.FileName);
  end;
end;

procedure TFrameUI.ButtonSaveClick(Sender: TObject);
var
  PNG: TPngImage;
begin
  SaveDialogImage.FileName := CurrentFile.Filename + '.png';
  if SaveDialogImage.Execute() then
  begin
    PNG := CurrentFile.GetPNGImage();
    try
      PNG.SaveToFile(SaveDialogImage.FileName);
    finally
      PNG.Free();
    end;
  end;
end;

procedure TFrameUI.ButtonStringsSaveClick(Sender: TObject);
begin
  MemoStrings.Lines.WriteBOM := False;
  MemoStrings.Lines.SaveToFile(IncludeTrailingPathDelimiter(Path + 'Resources') + CurrentFile.Filename, TEncoding.UTF8);
end;

procedure TFrameUI.ColorBoxGetColors(Sender: TCustomColorBox; Items: TStrings);
begin
  Items.AddObject('Orange', Pointer($80ff));
end;

procedure TFrameUI.ComboBoxDisplayModeSelect(Sender: TObject);
var
  i: Integer;
begin
  case ComboBoxDisplayMode.ItemIndex of
    0: CurrentFile.GetSlices(UpdateSlices);
    1:
      begin
        ComboBoxImageList.Items.BeginUpdate();
        try
          ComboBoxImageList.Items.Clear();
          for i := Low(UIPreviews) to High(UIPreviews) do
          if UIPreviews[i].IsApplicable() then
          if UIPreviews[i].ContainsImage(CurrentFile.Filename) then
          ComboBoxImageList.Items.AddObject(UIPreviews[i].Name, Pointer(i));
        finally
          ComboBoxImageList.Items.EndUpdate();
        end;
        if ComboBoxImageList.Items.Count > 0 then
        begin
          ComboBoxImageList.ItemIndex := 0;
          ComboBoxImageListSelect(ComboBoxImageList);
          ComboBoxImageList.Enabled := True;
        end
        else
        begin // no previews, fall back to single images
          ComboBoxDisplayMode.ItemIndex := 0;
          ComboBoxDisplayModeSelect(ComboBoxDisplayMode);
        end;
      end;
  end;
  ImagePreview2.Visible := ComboBoxDisplayMode.ItemIndex = 1;
end;

procedure TFrameUI.ComboBoxImageListSelect(Sender: TObject);
var
  Img: TPngImage;
  Img2: TPngImage;
begin
  case ComboBoxDisplayMode.ItemIndex of
    0:
      begin
        case ComboBoxImageList.ItemIndex of
          0: Img := CurrentFile.GetPNGImage;
          else Img := CurrentFile.GetSliceImage(ComboBoxImageList.ItemIndex - 1);
        end;
        try
          ImagePreview.Picture.Assign(Img);
        finally
          Img.Free();
        end;
      end;
    1:
      begin
        Img := UIPreviews[Integer(ComboBoxImageList.Items.Objects[ComboBoxImageList.ItemIndex])].GetPNG();
        try
          ImagePreview.Picture.Assign(Img);
          Img2 := TPngImage.CreateBlank(COLOR_RGB, 8, 320, 240); // we create the scaled image instead of using Delphi's feature to improve compatibility with screen scaling
          try
            Img.Canvas.CopyRect(Rect(1,1,640,480), Img.Canvas, Rect(0,0,639,479)); // Windows shows the bottom right pixel of a 2x2 block when scaled down by 50%, whereas the GB300 displays the top left (CopyRect is strange if both rectangles have different dimensions)
            img.Draw(Img2.Canvas, Rect(0, 0, 320, 240));
            ImagePreview2.Picture.Assign(Img2);
          finally
            Img2.Free();
          end;
        finally
          Img.Free();
        end;
      end;
  end;
end;

procedure TFrameUI.DoReplace(const FileName: string);
var
  Image: TPicture;
begin
  if PanelRightFoldername.Visible then
  Exit;
  Image := TPicture.Create();
  try
    Image.LoadFromFile(FileName);
    CurrentFile.WriteImage(Image.Graphic);
  finally
    Image.Free();
  end;
  ComboBoxImageListSelect(ComboBoxImageList);
end;

procedure TFrameUI.DropNewImage(Sender: TObject);
begin
  if Form1.DragIn.FileList.Count <> 1 then
  raise Exception.Create('Can only use exactly one file to replace the image');
  DoReplace(Form1.DragIn.FileList[0]);
end;

procedure TFrameUI.EditFoldernameFolderChange(Sender: TObject);
var
  i: Integer;
  OldIndex: Integer;
begin
  OldIndex := ComboBoxFoldernameInitialLeftTab.ItemIndex;
  ComboBoxFoldernameInitialLeftTab.Items.BeginUpdate();
  try
    ComboBoxFoldernameInitialLeftTab.Items.Clear();
    for i := 0 to 8 do
    ComboBoxFoldernameInitialLeftTab.Items.Add(Foldername.GetTabName(i));
  finally
    ComboBoxFoldernameInitialLeftTab.Items.EndUpdate();
  end;
  ComboBoxFoldernameInitialLeftTab.ItemIndex := OldIndex;
end;

procedure TFrameUI.ExportAllImagestoDirectory1Click(Sender: TObject);
var
  Dir: string;
  UIFile: TUIFile;
begin
  if SelectDirectory('Export files to:'#13#10'(overwrites existing files there)', '', Dir) then
  begin
    Dir := IncludeTrailingPathDelimiter(Dir);
    for UIFile in UIFiles do
    if UIFile.IsApplicable() then
    CopyFile(PChar(UIFile.GetPath()), PChar(Dir + UIFile.Filename), False);
    //if MessageDlg('Copy ''Foldername.ini''?', mtWarning, mbYesNo, 0) = mrYes then
    //CopyFile(PChar(IncludeTrailingPathDelimiter(Path + 'Resources') + 'Foldername.ini'), PChar(Dir + 'Foldername.ini'), False);
  end;
end;

procedure TFrameUI.ImagePreviewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Use mouse down event so the user does not have to wait until DblClick is not longer fired instead
  ScrollBoxPreview.Color := Random(16777216);
end;

procedure TFrameUI.ListViewFilesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  if Item.Caption = 'Foldername.ini' then
  begin
    PanelRight.Hide();
    PanelRightStrings.Hide();
    ButtonFoldernameUndoClick(ButtonFoldernameUndo);
    PanelRightFoldername.Show();
    Form1.DragIn.Enabled := False;
  end
  else
  if Item.GroupID = 8 then
  begin
    PanelRight.Hide();
    PanelRightFoldername.Hide();
    CurrentFile := UIFiles[Integer(Item.Data)];
    MemoStrings.Lines.LoadFromFile(IncludeTrailingPathDelimiter(Path + 'Resources') + CurrentFile.Filename, TEncoding.UTF8);
    PanelRightStrings.Show();
    Form1.DragIn.Enabled := False;
  end
  else
  begin
    PanelRightFoldername.Hide();
    PanelRightStrings.Hide();
    ShowFile(UIFiles[Integer(Item.Data)]);
    PanelRight.Show();
    Form1.DragIn.Enabled := True;
  end;
end;

procedure TFrameUI.MenuItemCopyClick(Sender: TObject);
begin
  Clipboard.Assign(ImagePreview.Picture.Graphic);
end;

procedure TFrameUI.MenuItemCopySmallClick(Sender: TObject);
begin
  Clipboard.Assign(ImagePreview2.Picture.Graphic);
end;

procedure TFrameUI.MenuItemReloadXMLClick(Sender: TObject);
var
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(ExtractFilePath(paramstr(0)) + 'previews.xml');
    LoadUIPreviews(MS);
    if ComboBoxDisplayMode.ItemIndex = 1 then
    ComboBoxImageListSelect(ComboBoxImageList);
  finally
    MS.Free();
  end;
end;

procedure TFrameUI.PopupMenuSavePopup(Sender: TObject);
begin
  MenuItemCopySmall.Enabled := ImagePreview2.Visible;
end;

procedure TFrameUI.ShowFile(const NewFile: TUIFile);
begin
  case NewFile.Format of
    idfRGB565:
      LabelFormat.Caption := Format('RGB565, %d×%d', [NewFile.Width, NewFile.Height]);
    idfBGRA8888:
      LabelFormat.Caption := Format('BGRA8888, %d×%d', [NewFile.Width, NewFile.Height]);
  end;
  CurrentFile := NewFile;
  ComboBoxDisplayModeSelect(ComboBoxDisplayMode);

  PanelRight.Show();
end;

procedure TFrameUI.TimerLazyLoadTimer(Sender: TObject);
var
  ListItem: TListItem;
  i: Integer;
begin
  Form1.DragIn.OnDrop := DropNewImage;
  TimerLazyLoad.Enabled := False;
  // Populate list view
  ListViewFiles.Items.BeginUpdate();
  try
    for i := Low(UIFiles) to High(UIFiles) do
    if UIFiles[i].IsApplicable() then
    begin
      ListItem := ListViewFiles.Items.Add;
      ListItem.GroupID := UIFiles[i].Group;
      ListItem.Caption := UIFiles[i].Filename;
      ListItem.Data := Pointer(i);
      ListItem.SubItems.Add(UIFiles[i].Description);
    end;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.DoAutoSize();
  end;

  //MenuItemReloadXML.Visible := ParamStr(1) = '-dev';
end;

procedure TFrameUI.UpdateSlices(const Slices: array of TUIFileSlice);
var
  Slice: TUIFileSlice;
begin
  ComboBoxImageList.Items.BeginUpdate();
  try
    ComboBoxImageList.Items.Clear();
    ComboBoxImageList.Items.Add('(full image)');
    for Slice in Slices do
    ComboBoxImageList.Items.Add(Slice.Description);
  finally
    ComboBoxImageList.Items.EndUpdate();
  end;
  ComboBoxImageList.ItemIndex := 0;
  ComboBoxImageList.Enabled := Length(Slices) > 0;
  ComboBoxImageList.OnSelect(ComboBoxImageList);
end;

end.

