program GB300Tool;

{$R 'Data.res' 'Data.rc'}

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  UnitBIOS in 'UnitBIOS.pas' {FrameBIOS: TFrame},
  GB300Utils in 'GB300Utils.pas',
  GUIHelpers in 'GUIHelpers.pas',
  UnitUI in 'UnitUI.pas' {FrameUI: TFrame},
  UnitStockROMs in 'UnitStockROMs.pas' {FrameStockROMs: TFrame},
  UnitROMDetails in 'UnitROMDetails.pas' {FrameROMDetails: TFrame},
  GB300UIConst in 'GB300UIConst.pas',
  RedeemerXML in 'RedeemerXML.pas',
  RedeemerEntities in 'RedeemerEntities.pas',
  UnitKeys in 'UnitKeys.pas' {FrameKeys: TFrame},
  UnitUserROMs in 'UnitUserROMs.pas' {FrameUserROMs: TFrame},
  UnitFavorites in 'UnitFavorites.pas' {FrameFavorites: TFrame},
  uDragFilesTrg in 'uDragFilesTrg.pas',
  MulticoreUtils in 'MulticoreUtils.pas',
  UnitMulticore in 'UnitMulticore.pas' {FrameMulticore: TFrame},
  UnitMulticoreSelection in 'UnitMulticoreSelection.pas' {FormMulticoreSelection},
  UnitCoreOption in 'UnitCoreOption.pas' {FrameCoreOption: TFrame},
  GambatteColors in 'GambatteColors.pas',
  UnitCoreOptions in 'UnitCoreOptions.pas' {FrameCoreOptions: TFrame},
  UnitGambatteColorPicker in 'UnitGambatteColorPicker.pas' {FrameGambatteColorPicker: TFrame},
  UnitPerGameCoreConfig in 'UnitPerGameCoreConfig.pas' {FormPerGameCoreConfig},
  UnitMulticoreLog in 'UnitMulticoreLog.pas' {FrameMulticoreLog: TFrame},
  PaletteColors in 'PaletteColors.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
