unit UnitMulticore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Generics.Collections, UnitCoreOptions, MulticoreUtils;

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
    LabelBIOSInfo: TLabel;
    PanelConfigActions: TPanel;
    ButtonSaveConfig: TButton;
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
    Frame: TFrameCoreOptions;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  UnitMain, GUIHelpers, GB300Utils;

{$R *.dfm}

procedure TFrameMulticore.ButtonSaveConfigClick(Sender: TObject);
begin
  Frame.Save();
end;

constructor TFrameMulticore.Create(AOwner: TComponent);
begin
  inherited;
  Frame := TFrameCoreOptions.Create(Self);
  Frame.Parent := PanelCoreInfo;
  PanelInstalled.Visible := HasMulticore;
  PanelNotInstalled.Visible := not HasMulticore;
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
  Exts: TStringList;
  Ext: string;
  Console: TCoreConsole;
  Dummy: Boolean;
begin
  if Selected then
  try
    Core.Core := Item.Caption;
    Core.Name := Item.Caption;
    Core.Config := '';
    if CoresDict.ContainsKey(Item.Caption) then
    begin
      Core := CoresDict[Item.Caption];
      LabelEmuName.Caption := StringReplace(Core.GetNameAndDescription(), '&', '&&', [rfReplaceAll]);
      ButtonSaveConfig.Visible := Frame.LoadCore(Core, '');
    end
    else
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
          Checked := INI.ReadString('Default', Ext, '') = Core.Core;
        end;
        with ListViewAlways.Items.Add do
        begin
          Caption := Ext;
          Checked := INI.ReadString('Always', Ext, '') = Core.Core;
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
      for Console in TCore.GetConsoles(Core.Core) do
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
