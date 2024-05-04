unit UnitMulticore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Generics.Collections, UnitCoreOption, MulticoreUtils;

type
  TFrameMulticore = class(TFrame)
    PanelNotInstalled: TPanel;
    LabelNotInstalled1: TLabel;
    LabelNotInstalled2: TLabel;
    LabelNotInstalled4: TLabel;
    PanelInstalled: TPanel;
    ShapeNotInstalled: TShape;
    LabelNotInstalled3: TLabel;
    ListViewFiles: TListView;
    TimerLazyLoad: TTimer;
    PanelSpacer: TPanel;
    PanelCoreInfo: TPanel;
    PanelCorePreferences: TPanel;
    LabelEmuName: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ListViewDefault: TListView;
    Label3: TLabel;
    ListViewAlways: TListView;
    ListViewBIOS: TListView;
    Label4: TLabel;
    ScrollBox: TScrollBox;
    LabelBIOSInfo: TLabel;
    ButtonSaveConfig: TButton;
    LabelError: TLabel;
    procedure PanelNotInstalledClick(Sender: TObject);
    procedure TimerLazyLoadTimer(Sender: TObject);
    procedure ListViewFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonSaveConfigClick(Sender: TObject);
    procedure ListViewDefaultItemChecked(Sender: TObject; Item: TListItem);
    procedure ListViewAlwaysItemChecked(Sender: TObject; Item: TListItem);
  private
    { Private declarations }
    Core: TCore;
    ConfigComps: TObjectList<TFrameCoreOption>;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation

uses
  UnitMain, GUIHelpers, GB300Utils;

{$R *.dfm}

procedure TFrameMulticore.ButtonSaveConfigClick(Sender: TObject);
var
  Options: TCoreOptions;
  i: Integer;
begin
  SetLength(Options, ConfigComps.Count);
  for i := 0 to ConfigComps.Count - 1 do
  Options[i] := ConfigComps[i].Option;
  Core.SetConfig(Options);
end;

constructor TFrameMulticore.Create(AOwner: TComponent);
begin
  inherited;
  PanelInstalled.Visible := HasMulticore;
  PanelNotInstalled.Visible := not HasMulticore;
  ConfigComps := TObjectList<TFrameCoreOption>.Create(True);
end;

destructor TFrameMulticore.Destroy;
begin
  ConfigComps.Free();
  inherited;
end;

procedure TFrameMulticore.ListViewAlwaysItemChecked(Sender: TObject; Item: TListItem);
begin
  if Item.Checked then
  INI.WriteString('Always', Item.Caption, Core.Core)
  else
  INI.DeleteKey('Always', Item.Caption);
end;

procedure TFrameMulticore.ListViewDefaultItemChecked(Sender: TObject; Item: TListItem);
begin
  if Item.Checked then
  INI.WriteString('Default', Item.Caption, Core.Core)
  else
  INI.DeleteKey('Default', Item.Caption);
end;

procedure TFrameMulticore.ListViewFilesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  FoundCore: Boolean;
  Core: TCore; // name collission with self is no issue because this is a loop variable and the compiler will complain about situation when the two a different
  Option: TCoreOption;
  Top: Integer;
  Exts: TStringList;
  Ext: string;
  Console: TCoreConsole;
  Dummy: Boolean;
begin
  if Selected then
  try
    ConfigComps.Clear();
    ScrollBox.VertScrollBar.Position := 0; // does funny things if you don't do that and the user has scrolled down in the previous core
    FoundCore := False;
    LabelError.Hide();
    Self.Core.Core := Item.Caption;
    Self.Core.Name := Item.Caption;
    Self.Core.Config := '';
    for Core in Cores do
    if Core.Core = Item.Caption then
    begin
      Self.Core := Core;
      LabelEmuName.Caption := StringReplace(Core.GetNameAndDescription(), '&', '&&', [rfReplaceAll]);
      Top := 0;
      try
        if Core.Config = '' then
        raise Exception.Create('GB300 Tool does not know the configuration file''s name for this core (probably this core cannot be configured)');
        for Option in Core.GetConfig do
        begin
          ConfigComps.Add(TFrameCoreOption.Create(Self));
          ConfigComps.Last.Parent := ScrollBox;
          ConfigComps.Last.Name := '';
          ConfigComps.Last.Option := Option;
          ConfigComps.Last.Top := Top;
          Inc(Top, ConfigComps.Last.Height);
        end;
      except
        on E: Exception do
        begin
          LabelError.Caption := E.Message;
          LabelError.Top := Top;
          LabelError.Show();
        end;
      end;
      if ConfigComps.Count = 0 then
      ButtonSaveConfig.Hide()
      else
      begin
        ButtonSaveConfig.Top := Top;
        ButtonSaveConfig.Show();
      end;
      FoundCore := True;
      Break;
    end;
    if not FoundCore then
    begin
      LabelEmuName.Caption := Item.Caption;
      ButtonSaveConfig.Hide();
    end;

    // Handle Extensions
    Exts := TCore.GetExtensionList(Item.Caption);
    ListViewDefault.Items.BeginUpdate();
    ListViewAlways.Items.BeginUpdate();
    try
      ListViewDefault.OnItemChecked := nil; // would be called by Add, no matter the Checked status
      ListViewAlways.OnItemChecked := nil;
      ListViewDefault.Items.Clear();
      ListViewAlways.Items.Clear();
      for Ext in Exts do
      begin
        with ListViewDefault.Items.Add do
        begin
          Caption := Ext;
          Checked := INI.ReadString('Default', Ext, '') = Self.Core.Core;
        end;
        with ListViewAlways.Items.Add do
        begin
          Caption := Ext;
          Checked := INI.ReadString('Always', Ext, '') = Self.Core.Core;
        end;
      end;
    finally
      ListViewDefault.OnItemChecked := ListViewDefaultItemChecked;
      ListViewAlways.OnItemChecked := ListViewAlwaysItemChecked;
      ListViewDefault.Items.EndUpdate();
      ListViewAlways.Items.EndUpdate();
      ListViewDefault.DoAutoSize();
      ListViewAlways.DoAutoSize();
      Exts.Free();
    end;

    // Handle BIOS
    ListViewBIOS.Items.BeginUpdate();
    ListViewBIOS.Groups.BeginUpdate();
    try
      ListViewBIOS.Items.Clear();
      ListViewBIOS.Groups.Clear();
      for Console in TCore.GetConsoles(Self.Core.Core) do
      begin
        ListViewBIOS.Groups.Add.Header := Console.Console;

        TCoreConsole.BIOSCheckToListItems(Console.BIOSChecker.CheckBIOS(False, Dummy), ListViewBIOS.Items, ListViewBIOS.Groups.Count - 1);
      end;
    finally
      ListViewBIOS.Groups.EndUpdate();
      ListViewBIOS.Items.EndUpdate();
    end;

    PanelCoreInfo.Show();
  except
    PanelCoreInfo.Hide();
  end;
end;

procedure TFrameMulticore.PanelNotInstalledClick(Sender: TObject);
begin
  Form1.OpenURL('https://github.com/tzubertowski/gb300_multicore/releases');
end;

procedure TFrameMulticore.TimerLazyLoadTimer(Sender: TObject);
var
  Core: string;
  Cores: TList<string>;
begin
  TimerLazyLoad.Enabled := False;
  Cores := TCore.GetCores();
  ListViewFiles.Items.BeginUpdate();
  try
    ListViewFiles.Items.Clear();
    with ListViewFiles.Items.Add do
    begin
      Caption := 'multicore';
      GroupID := 0;
    end;
    with ListViewFiles.Items.Add do
    begin
      Caption := 'Stock';
      GroupID := 0;
    end;
    for Core in Cores do
    with ListViewFiles.Items.Add do
    begin
      Caption := Core;
      GroupID := 1;
    end;
  finally
    ListViewFiles.Items.EndUpdate();
    ListViewFiles.DoAutoSize();
    Cores.Free();
  end;
end;

end.
