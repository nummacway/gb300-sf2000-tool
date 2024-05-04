unit UnitFavorites;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, UnitROMDetails;

type
  TFrameFavorites = class(TFrame)
    PanelLeft: TPanel;
    PanelListActions: TPanel;
    ListViewFiles: TListView;
    PanelSpacer: TPanel;
    ButtonAlphaSort: TButton;
    ButtonDelete: TButton;
    TimerLazyLoad: TTimer;
    TimerDnDScroll: TTimer;
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ListViewFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewFilesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListViewFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListViewFilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TimerDnDScrollTimer(Sender: TObject);
    procedure ListViewFilesDeletion(Sender: TObject; Item: TListItem);
    procedure ButtonAlphaSortClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ListViewFilesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    var
      ROMDetailsFrame: TFrameROMDetails;
      IsDragging: Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure ApplyAndSave();
  end;

implementation

uses
  GB300Utils, GUIHelpers, Generics.Collections;

{$R *.dfm}

{ TFrameFavorites }

procedure TFrameFavorites.ApplyAndSave;
procedure Renumber;
var
  i: Integer;
begin
  for i := 0 to ListViewFiles.Items.Count - 1 do
  ListViewFiles.Items[i].Data := Pointer(i);
end;
var
  i: Integer;
  Temp: TReferenceList;
begin
  Temp := TReferenceList.Create();
  try
    for i := 0 to ListViewFiles.Items.Count - 1 do
    Temp.Add(Favorites[Integer(ListViewFiles.Items[i].Data)]);
    Favorites.Clear();
    Favorites.AddRange(Temp);
    Renumber();
    Favorites.SaveToFile('Favorites.bin');
  finally
    Temp.Free();
  end;
end;

procedure TFrameFavorites.ButtonAlphaSortClick(Sender: TObject);
begin
  ListViewFiles.AlphaSort();
  ApplyAndSave();
end;

procedure TFrameFavorites.ButtonDeleteClick(Sender: TObject);
begin
  ListViewFiles.DeleteSelected();
  ApplyAndSave();
end;

constructor TFrameFavorites.Create(AOwner: TComponent);
begin
  inherited;
  ROMDetailsFrame := TFrameROMDetails.Create(Self);
  ROMDetailsFrame.Parent := Self;
  ROMDetailsFrame.ImageFavorite.Hide();
end;

destructor TFrameFavorites.Destroy;
begin
  // ROMDetailsFrame has an owner and therefore doesn't need to be freed
  inherited;
end;

procedure TFrameFavorites.ListViewFilesDeletion(Sender: TObject;
  Item: TListItem);
begin
  if Item = ROMDetailsFrame.Item then
  ROMDetailsFrame.Hide();
end;

procedure TFrameFavorites.ListViewFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
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
      ApplyAndSave();
      ListViewFiles.Items.EndUpdate();
    end;
  end;
end;

procedure TFrameFavorites.ListViewFilesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := IsDragging;
end;

procedure TFrameFavorites.ListViewFilesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not ListViewFiles.IsEditing then
  if Key = VK_DELETE then
  ButtonDeleteClick(nil);
end;

procedure TFrameFavorites.ListViewFilesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  ROMDetailsFrame.ShowFile(Favorites[Integer(ListViewFiles.Selected.Data)].FolderIndex, ListViewFiles.Selected);
end;

procedure TFrameFavorites.ListViewFilesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  IsDragging := True;
  TimerDnDScroll.Enabled := True;
end;

procedure TFrameFavorites.TimerDnDScrollTimer(Sender: TObject);
begin
  HandleDnDScrollTimer(ListViewFiles);
end;

procedure TFrameFavorites.TimerLazyLoadTimer(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
  Ref: TReference;
begin
  TimerLazyLoad.Enabled := False;
  ListViewFiles.Items.BeginUpdate();
  try
    for i := 0 to Favorites.Count - 1 do
    begin
      Ref := Favorites[i];
      Item := ListViewFiles.Items.Add;
      Item.Caption := Ref.FileName;
      Item.ImageIndex := TROMFile.FileNameToImageIndex(Ref.FileName);
      Item.Data := Pointer(i);
    end;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.DoAutoSize();
  end;
end;

end.
