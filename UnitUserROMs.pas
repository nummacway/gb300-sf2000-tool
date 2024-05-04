unit UnitUserROMs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, UnitROMDetails, IOUtils,
  Generics.Collections;

type
  TFrameUserROMs = class(TFrame)
    PanelLeft: TPanel;
    PanelListActions: TPanel;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    ListViewFiles: TListView;
    PanelSpacer: TPanel;
    TimerLazyLoad: TTimer;
    OpenDialogROMs: TOpenDialog;
    procedure ListViewFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ListViewFilesCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ButtonAddClick(Sender: TObject);
    procedure ListViewFilesEdited(Sender: TObject; Item: TListItem;
      var S: string);
    procedure ListViewFilesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure DropFiles(Sender: TObject);
    procedure ROMDuplicate(var Item: TListItem; const NewName: string);
    procedure ROMRename(var Item: TListItem; const NewName: string);
    private
      ROMDetailsFrame: TFrameROMDetails;
  public
    { Public declarations }
    procedure DoAdd(Files: TStrings);
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  GB300Utils, GUIHelpers, UITypes, UnitMain, MultiCoreUtils,
  UnitMulticoreSelection;

{$R *.dfm}

{ TFrameUserROMs }

procedure TFrameUserROMs.ButtonAddClick(Sender: TObject);
begin
  OpenDialogROMs.Filter := 'Stock supported files (' + StringReplace(Extensions, ';', ', ', [rfReplaceAll]) + ')|' + Extensions + '|All files (*.*)|*.*';
  if HasMulticore then
  OpenDialogROMs.FilterIndex := 2;
  if OpenDialogROMs.Execute() then
  DoAdd(OpenDialogROMs.Files);
end;

procedure TFrameUserROMs.ButtonDeleteClick(Sender: TObject);
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
        if DeleteFile(Foldername.AbsoluteFolder[7] + ListViewFiles.Items[i].Caption) then
        ListViewFiles.Items[i].Delete();
      end;
    finally
      ListViewFiles.Items.EndUpdate();
    end;
  end;
end;

constructor TFrameUserROMs.Create(AOwner: TComponent);
begin
  inherited;
  ROMDetailsFrame := TFrameROMDetails.Create(Self);
  ROMDetailsFrame.Parent := Self;
  ROMDetailsFrame.OnRename := ROMRename;
  ROMDetailsFrame.OnDuplicate := ROMDuplicate;
  ROMDetailsFrame.ImageFavorite.Hide();
  Form1.DragIn.OnDrop := DropFiles;
  Form1.DragIn.Enabled := True;
end;

procedure TFrameUserROMs.DoAdd(Files: TStrings);
var
  FN: string;
  NewFN: string;
  Overwrite: Boolean;
  All: Boolean;
  Item: TListItem;
  FileExisted: Boolean;
begin
  // this method has not been moved in the general GB300 Utils because the handling of the list items to be created is different
  All := False;
  Overwrite := True;

  ListViewFiles.Items.BeginUpdate();
  try
    if HasMulticore then
    begin
      TidyUpFileList(Files);
      for FN in Files do
      begin
        NewFN := FN;
        if TFormMulticoreSelection.HandleMulticore(7, NewFN) then
        if NewFN <> '' then
        begin
          Item := ListViewFiles.Items.Add;
          Item.Caption := ExtractFileName(NewFN);
          Item.ImageIndex := TROMFile.FileNameToImageIndex(NewFN);
        end;
      end;
    end
    else
    for FN in Files do
    begin
        NewFN := Foldername.AbsoluteFolder[7] + ExtractFileName(FN);

        if NewFN = FN then
        Continue;

        FileExisted := FileExists(NewFN);

        if not All then
        if FileExists(NewFN) then
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
        begin
          Item := ListViewFiles.Items.Add;
          Item.Caption := ExtractFileName(FN);
          Item.ImageIndex := TROMFile.FileNameToImageIndex(FN);
          //if Item.ImageIndex = -1 then
          //Item.Delete();
        end;
    end;
  finally
    ListViewFiles.AlphaSort();
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.DoAutoSize();
  end;
end;

procedure TFrameUserROMs.DropFiles(Sender: TObject);
begin
  DoAdd(Form1.DragIn.FileList);
end;

procedure TFrameUserROMs.ListViewFilesCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  Compare := CompareStr(Item1.Caption, Item2.Caption); // default collation of TListView.AlphaSort is CI (=CompareText), but GB300 is CS (pure binary)
end;

procedure TFrameUserROMs.ListViewFilesEdited(Sender: TObject; Item: TListItem; var S: string);
begin
  if RenameFile(Foldername.AbsoluteFolder[7] + Item.Caption,
                Foldername.AbsoluteFolder[7] + S) then
  begin
    Item.Caption := S;
    ROMDetailsFrame.ShowFile(7, Item);
  end
  else
  S := Item.Caption;
end;

procedure TFrameUserROMs.ListViewFilesKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrameUserROMs.ListViewFilesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  ButtonDelete.Enabled := ListViewFiles.SelCount > 0;
  if Selected then
  ROMDetailsFrame.ShowFile(7, Item);
end;

procedure TFrameUserROMs.ROMDuplicate(var Item: TListItem; const NewName: string);
begin
  Item := ListViewFiles.Items.Add;
  Item.Caption := NewName;
  Item.ImageIndex := TROMFile.FileNameToImageIndex(NewName);
  ListViewFiles.AlphaSort();
  ListViewFiles.DoAutoSize();
end;

procedure TFrameUserROMs.ROMRename(var Item: TListItem; const NewName: string);
begin
  Item.Caption := NewName;
  Item.ImageIndex := TROMFile.FileNameToImageIndex(NewName);
  ListViewFiles.AlphaSort();
end;

procedure TFrameUserROMs.TimerLazyLoadTimer(Sender: TObject);
var
  Files: TList<string>;
  FN: string;
  Item: TListItem;
begin
  TimerLazyLoad.Enabled := False;
  ROMDetailsFrame.Parent := Self;
  ListViewFiles.Items.BeginUpdate();
  try
    Files := TROMFile.GetROMsIn(7);
    try
      for FN in Files do
      begin
        Item := ListViewFiles.Items.Add;
        Item.Caption := FN;
        Item.ImageIndex := TROMFile.FileNameToImageIndex(FN);
      end;
    finally
      Files.Free();
    end;
  finally
    ListViewFiles.AlphaSort();
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.DoAutoSize();
  end;
end;

end.
