unit GUIHelpers;

interface

uses
  SysUtils, StdCtrls, Classes, ComCtrls, IniFiles, Windows, Graphics, PngImage,
  Controls, ImgList;

type
  TCheckBoxHelper = class helper for TCheckbox
  private
    procedure SetStateNoClick(Value: TCheckboxState);
    procedure SetCheckedNoClick(const Value: Boolean);
  public
    property StateNoClick: TCheckBoxState write SetStateNoClick;
    property CheckedNoClick: Boolean write SetCheckedNoClick;
  end;

  TListViewHelper = class helper for TListView
    procedure SelectAgain();
    procedure DoAutoSize(); reintroduce;
  end;

  TComboBoxHelper = class helper for TComboBox
  private
    function GetObjectIndexInt: NativeInt;
    procedure SetObjectIndexInt(const Value: NativeInt);
  public
    property ObjectIndexInt: NativeInt read GetObjectIndexInt write SetObjectIndexInt;
  end;

function GetPNG(ID: Integer): TPngImage;
function PNGToBMP(PNG: TPngImage): TBitmap;
procedure LoadPNGTo(ID: Integer; Target: TPersistent);
procedure LoadPNGToList(ID: Integer; Target: TImageList);
procedure HandleDnDScrollTimer(Sender: TWinControl);

implementation

uses
  Math, Messages;

function GetPNG(ID: Integer): TPngImage;
var
  RS: TResourceStream;
begin
  RS := TResourceStream.CreateFromID(HInstance, ID, 'PNG');
  try
    Result := TPngImage.Create();
    try
      Result.LoadFromStream(RS);
    except
      try
        Result.Free();
      except
      end;
      raise;
    end;
  finally
    RS.Free();
  end;
end;

function PNGToBMP(PNG: TPngImage): TBitmap;
var
  x, y: Integer;
  ScanlineSrc, ScanlineTrg: pByteArray;
begin
  // Fixes a bug that causes BMP transparency to look very dark und ugly for
  // areas after conversion to BMP
  Result := TBitmap.Create();
  Result.Assign(PNG);
  if PNG.Header.ColorType = COLOR_RGBALPHA then
  for y := 0 to PNG.Height - 1 do
  begin
    ScanlineSrc := PNG.Scanline[y];
    ScanlineTrg := Result.Scanline[y];
    for x := 0 to PNG.Width - 1 do
    begin
      ScanlineTrg^[x*4] := ScanlineSrc^[x*3];
      ScanlineTrg^[x*4+1] := ScanlineSrc^[x*3+1];
      ScanlineTrg^[x*4+2] := ScanlineSrc^[x*3+2];
    end;
  end;
end;

procedure LoadPNGTo(ID: Integer; Target: TPersistent);
var
  PNG: TPngImage;
begin
  PNG := GetPNG(ID);
  try
    Target.Assign(PNG);
  finally
    PNG.Free();
  end;
end;

procedure LoadPNGToList(ID: Integer; Target: TImageList);
var
  PNG: TPngImage;
  BMP: TBitmap;
begin
  PNG := GetPNG(ID);
  try
    BMP := PNGToBMP(PNG);
    try
      Target.AddMasked(BMP, clNone);
    finally
      BMP.Free();
    end;
  finally
    PNG.Free();
  end;
end;

procedure HandleDnDScrollTimer(Sender: TWinControl);
begin
  with Sender.ScreenToClient(Mouse.CursorPos) do
  if InRange(x, 0, Sender.Width) then
  if InRange(y, 0, 31) then
  SendMessage(Sender.Handle, WM_VSCROLL, SB_LINEUP, 0)
  else
  if InRange(y, Sender.Height - 32, Sender.Height - 1) then
  SendMessage(Sender.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

{ TCheckBoxHelper }

procedure TCheckBoxHelper.SetCheckedNoClick(const Value: Boolean);
var
  Event: TNotifyEvent;
begin
  Event := OnClick;
  OnClick := nil;
  Checked := Value;
  OnClick := Event;
end;

procedure TCheckBoxHelper.SetStateNoClick(Value: TCheckboxState);
var
  Event: TNotifyEvent;
begin
  Event := OnClick;
  OnClick := nil;
  State := Value;
  OnClick := Event;
end;

{ TJanniListView }

procedure TListViewHelper.DoAutoSize();
// Copied from the official source code
var
  I, Count, WorkWidth, TmpWidth, Remain: Integer;
  List: TList;
  Column: TListColumn;
begin
  { Try to fit all sections within client width }
  List := TList.Create;
  try
    WorkWidth := Self.ClientWidth;
    for I := 0 to Self.Columns.Count - 1 do
    begin
      Column := Self.Columns[I];
      if Column.AutoSize then
        List.Add(Column)
      else
        Dec(WorkWidth, Column.Width);
    end;
    if List.Count > 0 then
    begin
      Self.Columns.BeginUpdate;
      try
        repeat
          Count := List.Count;
          Remain := WorkWidth mod Count;
          { Try to redistribute sizes to those sections which can take it }
          TmpWidth := WorkWidth div Count;
          for I := Count - 1 downto 0 do
          begin
            Column := TListColumn(List[I]);
            if I = 0 then
              Inc(TmpWidth, Remain);
            Column.Width := TmpWidth;
          end;

          { Verify new sizes don't conflict with min/max section widths and
            adjust if necessary. }
          TmpWidth := WorkWidth div Count;
          for I := Count - 1 downto 0 do
          begin
            Column := TListColumn(List[I]);
            if I = 0 then
              Inc(TmpWidth, Remain);
            if Column.Width <> TmpWidth then
            begin
              List.Delete(I);
              Dec(WorkWidth, Column.Width);
            end;
          end;
        until (List.Count = 0) or (List.Count = Count);
      finally
        Self.Columns.EndUpdate;
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TListViewHelper.SelectAgain();
begin
  if Assigned(OnSelectItem) then
  if Assigned(Selected) then
  OnSelectItem(Self, Selected, True)
  else
  OnSelectItem(Self, nil, False);
end;

{ TComboBoxHelper }

function TComboBoxHelper.GetObjectIndexInt: NativeInt;
begin
  Result := NativeInt(Items.Objects[ItemIndex]);
end;

procedure TComboBoxHelper.SetObjectIndexInt(const Value: NativeInt);
begin
  ItemIndex := Items.IndexOfObject(TObject(Value));
end;

end.
