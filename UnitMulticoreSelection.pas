unit UnitMulticoreSelection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,   Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls, Generics.Collections, Vcl.ExtCtrls;

type
  TFormMulticoreSelection = class(TForm)
    LabelFile: TLabel;
    LabelFileName: TLabel;
    LabelRecommendedCore: TLabel;
    CheckBoxAlwaysUseThisCore: TCheckBox;
    ListViewBIOS: TListView;
    LabelBIOS: TLabel;
    ButtonOK: TButton;
    ButtonSkip: TButton;
    LabelAnyCore: TLabel;
    ComboBoxAnyCore: TComboBox;
    Label1: TLabel;
    ButtonCopyOnly: TButton;
    ButtonAbort: TButton;
    TimerLazyPrepare: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxAnyCoreSelect(Sender: TObject);
    procedure TimerLazyPrepareTimer(Sender: TObject);
  private
    { Private declarations }
    procedure LazyPrepare();
    var
      Ext: string;
      Cores: TList<string>;
  public
    { Public declarations }
    procedure Prepare(const FileNames, MainFileExt: string);
    procedure WriteINI();
    function GetCore(): string;
    class function HandleMulticore(const FolderIndex: Byte; var FileNames: string): Boolean; // Return value is whether a new file has been created and its path written to FileNames
  end;

var
  FormMulticoreSelection: TFormMulticoreSelection;

implementation

uses
  GB300Utils, MulticoreUtils, UITypes;

{$R *.dfm}

{ TFormMulticoreSelection }

procedure TFormMulticoreSelection.ComboBoxAnyCoreSelect(Sender: TObject);
var
  Console: TCoreConsole;
  Dummy: Boolean;
begin
  if ComboBoxAnyCore.ItemIndex > -1 then
  begin
    try
      // Handle BIOS
      ListViewBIOS.Items.BeginUpdate();
      ListViewBIOS.Groups.BeginUpdate();
      try
        ListViewBIOS.Items.Clear();
        ListViewBIOS.Groups.Clear();
        for Console in TCore.GetConsoles(GetCore()) do
        if Pos('|' + Ext + '|', '|' + Console.Extensions + '|') > 0 then
        begin
          ListViewBIOS.Groups.Add.Header := Console.Console;

          TCoreConsole.BIOSCheckToListItems(Console.BIOSChecker.CheckBIOS(False, Dummy), ListViewBIOS.Items, ListViewBIOS.Groups.Count - 1);
        end;
      finally
        ListViewBIOS.Groups.EndUpdate();
        ListViewBIOS.Items.EndUpdate();
      end;
    except
    end;

    ButtonOK.Enabled := True;
    ButtonCopyOnly.Enabled := True;
  end;
end;

procedure TFormMulticoreSelection.FormCreate(Sender: TObject);
begin
  Cores := TList<string>.Create();
end;

procedure TFormMulticoreSelection.FormDestroy(Sender: TObject);
begin
  Cores.Free();
end;

function TFormMulticoreSelection.GetCore: string;
begin
  Result := Cores[ComboBoxAnyCore.ItemIndex];
end;

class function TFormMulticoreSelection.HandleMulticore(const FolderIndex: Byte; var FileNames: string): Boolean;
var
  FileNameList: TStringList;
  MainFile: string;
  Ext: string;
  Core: string;
  Existed: Boolean;
function HandleCopy(const Core: string; var OutputFile: string; MakeStub: Boolean): Boolean;
var
  NewFileNameList: TStringList;
  FileName: string;
  i: Integer;
  MS: TMemoryStream;
  ROM: TROMFile;
begin
  if Core = '' then
  Exit(False);

  if Core <> 'Stock' then
  if not DirectoryExists(IncludeTrailingPathDelimiter(Path + 'cores') + Core) then
  Exit(False);

  NewFileNameList := TStringList.Create();
  try
    for FileName in FileNameList do
    begin
      if Core = 'Stock' then
      NewFileNameList.Add(Foldername.AbsoluteFolder[FolderIndex] + ExtractFileName(FileName))
      else
      NewFileNameList.Add(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + Core) + ExtractFileName(FileName));
      if FileExists(NewFileNameList[NewFileNameList.Count-1]) then
      if MessageDlg(Format('Target file ''%s'' already exists in core %s''s ROMs. Do you want to overwrite it?'#13#10'Click ''No'' to select another core.', [ExtractFileName(FileName), Core]), mtWarning, mbYesNo, 0) <> mrYes then
      Exit(False);
    end;
    ForceDirectories(ExtractFilePath(NewFileNameList[0]));
    Existed := FileExists(NewFileNameList[0]);
    for i := 0 to FileNameList.Count - 1 do
    if not CopyFile(PChar(FileNameList[i]), PChar(NewFileNameList[i]), False) then
    raise Exception.CreateFmt('Could not copy ''%s'' to ''%s''.', [FileNameList[i], NewFileNameList[i]]);

    Result := True;

    if Core = 'Stock' then
    OutputFile := NewFileNameList[0]
    else
    if not MakeStub then
    OutputFile := ''
    else
    if UseZFBForMulticore then
    begin
      ROM := TROMFile.CreateFinalBurn(Core + ';' + ExtractFileName(FileNameList[0]) + '.gba');
      try
        OutputFile := ChangeFileExt(ExtractFileName(FileNameList[0]), '') + '.zfb';
        Existed := FileExists(Foldername.AbsoluteFolder[FolderIndex] + OutputFile);
        ROM.SaveToFile(FolderIndex, OutputFile, True);
        OutputFile := Foldername.AbsoluteFolder[FolderIndex] + OutputFile;
      finally
        ROM.Free();
      end;
    end
    else
    begin
      MS := TMemoryStream.Create();
      try
        OutputFile := Foldername.AbsoluteFolder[FolderIndex] + Core + ';' + ExtractFileName(FileNameList[0]) + '.gba';
        Existed := FileExists(OutputFile);
        MS.SaveToFile(OutputFile);
      finally
        MS.Free();
      end;
    end;
  finally
    NewFileNameList.Free();
  end;
end;
begin
  Existed := False;
  FileNameList := TStringList.Create();
  try
    FileNameList.Text := StringReplace(FileNames, '|', #13#10, [rfReplaceAll]);

    MainFile := FileNameList[0];
    Ext := Lowercase(Copy(ExtractFileExt(MainFile), 2, 1337));

    Core := INI.ReadString('Always', Ext, '');
    if HandleCopy(Core, MainFile, True) then
    Exit(True);

    repeat
      Application.CreateForm(TFormMulticoreSelection, FormMulticoreSelection);
      try
        FormMulticoreSelection.Prepare(MainFile, Ext);
        case FormMulticoreSelection.ShowModal() of
          mrOk:
            begin
              FormMulticoreSelection.WriteINI();
              if HandleCopy(FormMulticoreSelection.GetCore(), MainFile, True) then
              Exit(True);
            end;
          mrNo:
            begin
              FormMulticoreSelection.WriteINI();
              if HandleCopy(FormMulticoreSelection.GetCore(), MainFile, False) then
              Exit(False);
            end;
          mrIgnore:
            Exit(False);
          //mrAbort:
          else
            Abort;
        end;
      finally
        FormMulticoreSelection.Free();
      end;
    until False;
  finally
    if Existed then
    FileNames := ''
    else
    FileNames := MainFile;
    FileNameList.Free();
  end;
end;

procedure TFormMulticoreSelection.LazyPrepare;
var
  DefaultCore: string;
  RecommendedCores: TCoreConsoles;
  Console: TCoreConsole;
  Core: TCore;
  RecommendedCoresDict: TDictionary<string, Integer>; // does not use the value
begin
  DefaultCore := INI.ReadString('Default', Ext, '');
  RecommendedCores := TCore.GetConsolesByExtension(Ext);
  RecommendedCoresDict := TDictionary<string, Integer>.Create();
  ComboBoxAnyCore.Items.BeginUpdate();
  try
    for Console in RecommendedCores do
    if not RecommendedCoresDict.ContainsKey(Console.Core) then
    if DirectoryExists(IncludeTrailingPathDelimiter(Path + 'cores') + Console.Core) or (Console.Core = 'Stock') then
    begin
      RecommendedCoresDict.Add(Console.Core, 0);
      Cores.Add(Console.Core);
      ComboBoxAnyCore.Items.Add('[+] ' + Console.Core + ' (' + CoresDict[Console.Core].GetNameAndDescription() + ')');
    end;

    for Core in MulticoreUtils.Cores do
    if not RecommendedCoresDict.ContainsKey(Core.Core) then
    if DirectoryExists(IncludeTrailingPathDelimiter(Path + 'cores') + Core.Core) or (Console.Core = 'Stock') then
    begin
      RecommendedCoresDict.Add(Core.Core, 0);
      Cores.Add(Core.Core);
      ComboBoxAnyCore.Items.Add(Core.Core + ' (' + Core.GetNameAndDescription() + ')');
    end;

    ComboBoxAnyCore.ItemIndex := Cores.IndexOf(DefaultCore);
    ComboBoxAnyCoreSelect(ComboBoxAnyCore);
  finally
    RecommendedCoresDict.Free();
    ComboBoxAnyCore.Items.EndUpdate();
  end;
end;

procedure TFormMulticoreSelection.Prepare(const FileNames, MainFileExt: string);
begin
  Ext := MainFileExt;
  LabelFileName.Caption := FileNames;
  TimerLazyPrepare.Enabled := True;
end;

procedure TFormMulticoreSelection.TimerLazyPrepareTimer(Sender: TObject);
begin
  TimerLazyPrepare.Enabled := False;
  LazyPrepare();
end;

procedure TFormMulticoreSelection.WriteINI;
begin
  INI.WriteString('Default', Ext, GetCore());
  if CheckBoxAlwaysUseThisCore.Checked then
  INI.WriteString('Always', Ext, GetCore());
end;

end.
