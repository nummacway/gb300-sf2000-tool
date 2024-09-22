unit MulticoreUtils;

interface

uses
  Classes, Types, Generics.Collections, ComCtrls;

type
  TBIOSCheckResult = record
    FileName: string;
    Required: Boolean;
    Exists: Boolean;
    CRCValid: Boolean;
  end;

  TBIOSCheckResults = array of TBIOSCheckResult;

  TCardinalArray = array of Cardinal;

  TBIOSChecker = class
    protected
      class function CheckBIOSFile(const FileName: string; Required: Boolean; ExpectedCRC: array of Cardinal): TBIOSCheckResult;
      class function CheckBIOSFileAbs(const FileName: string; Required: Boolean; ExpectedCRC: array of Cardinal): TBIOSCheckResult;
      class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; overload; virtual; abstract;
      class var
        BIOSLastRequiredCheckedResult: TBIOSCheckResults;
        BIOSLastRequiredCheckedAllOK: Boolean;
        BIOSLastRequiredChecked: TDateTime;
    public
      class function CheckBIOS(OnlyRequired: Boolean; out AllOK: Boolean): TBIOSCheckResults; virtual;
  end;

  TBIOSCheckerNone = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerAtari5200 = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerColecoVision = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerChannelF = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoy = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyColor = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyGambatte = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyGambatteGB = class(TBIOSCheckerGameBoyGambatte)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyGambatteGBB = class(TBIOSCheckerGameBoyGambatte)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyColorGambatte = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyColorGambatteGB = class(TBIOSCheckerGameBoyGambatte)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyColorGambatteGBB = class(TBIOSCheckerGameBoyGambatte)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyAdvance = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerGameBoyAdvanceStock = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerIntelliVision = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerLynx = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerMSXColecoVision = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerMSXSegaSG1000 = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerFamicomDiskSystem = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerFamicomDiskSystemStock = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerVTxx = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerPCEngineCD = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  //TBIOSCheckerSinclair = class(TBIOSChecker) // confusing AF, probably not required for most computers
  //  class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  //end;

  TBIOSCheckerPC88 = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerMegaCD = class(TBIOSChecker)
    class function DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults; override;
  end;

  TBIOSCheckerClass = class of TBIOSChecker;

  TCoreOption = record
    Name: string;
    Default: string;
    Value: string;
    Values: string;
  end;

  TCoreOptions = array of TCoreOption;

  TCoreConsole = record
    Core: string;
    Console: string;
    NoIntro: Word; // currently unused
    Extensions: string;
    BIOSChecker: TBIOSCheckerClass;
    class procedure BIOSCheckToListItems(const Source: TBIOSCheckResults; Target: TListItems; Group: Integer = 0); static;
  end;

  TCoreConsoles = array of TCoreConsole;

  TCore = record
    Core: string;
    Name: string;
    Config: string; // without ".opt"
    Description: string;
    function GetNameAndDescription(): string;
    function GetConfig(const ROMFileNameNoPathButExt: string = ''): TCoreOptions;
    function GetConfigPath(const ROMFileNameNoPathButExt: string = ''): string;
    procedure SetConfig(Value: TCoreOptions; const ROMFileNameNoPathButExt: string = '');
    class function GetCores(): TList<string>; static;
    function GetConsoles(): TCoreConsoles; overload;
    class function GetConsoles(const Core: string): TCoreConsoles; overload; static;
    class function GetConsolesByExtension(Ext: string): TCoreConsoles; static;
    function GetExtensionList(): TStringList; overload;
    class function GetExtensionList(const Core: string): TStringList; overload; static;
  end;

const
  //Beetle = 'My emulator doesn''t need a frickin'' excellent name – ';
  Beetle = 'Mednafen ';

var
  CoreConsoles: array[0..76] of TCoreConsole =
    ((Core: 'Stock';      Console: 'Nintendo - Nintendo Entertainment System (Famicom) [FCEUmm]';                        NoIntro:  45; Extensions: 'nes|unf'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Nintendo - Famicom Disk System [FCEUmm]';                                            NoIntro:  31; Extensions: 'fds'; BIOSChecker: TBIOSCheckerFamicomDiskSystemStock),
     (Core: 'Stock';      Console: 'V.R. Technology - VTxx (incl. NES/Famicom) - mapper 12 only [wiseemu]';              NoIntro:  45; Extensions: 'nfc'; BIOSChecker: TBIOSCheckerVTxx),
     (Core: 'Stock';      Console: 'NEC - PC Engine (Turbografx-16) [Mednafen PCE Fast v0.9.38.7]';                      NoIntro:  12; Extensions: 'pce'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Nintendo - Super Nintendo Entertainment System (Super Famicom) [Snes9x 2005 v1.36]'; NoIntro:  49; Extensions: 'smc|fig|sfc|gd3|gd7|dx2|bsx|swc'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Sega - Mega Drive (Genesis) [PicoDrive 1.91]';                                       NoIntro:  32; Extensions: 'md|smd|bin|gen'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Sega - Kids Computer Pico [PicoDrive 1.91]';                                         NoIntro:  18; Extensions: 'md|smd|bin|gen'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Sega - Master System [PicoDrive 1.91]';                                              NoIntro:  26; Extensions: 'sms'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Nintendo - Dot Matrix Game ("Game Boy") [TGB Dual v0.8.3]';                          NoIntro:  46; Extensions: 'gb'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Nintendo - Game Boy Color [TGB Dual v0.8.3]';                                        NoIntro:  47; Extensions: 'gbc|sgb'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'Stock';      Console: 'Nintendo - Game Boy Advance [gpSP v0.91]';                                           NoIntro:  23; Extensions: 'gba|agb|zgb'; BIOSChecker: TBIOSCheckerGameBoyAdvanceStock),
     (Core: 'Stock';      Console: 'Compressed and/or thumbnailed ("Wise" Wang QunWei obfuscated) file';                 NoIntro:   0; Extensions: 'bkp|zip|zfc|zsf|zpc|zmd|zgb|zfb'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'a26';        Console: 'Atari - 2600';                                                                       NoIntro:  88; Extensions: 'a26|bin|zip'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'a5200';      Console: 'Atari - 5200';                                                                       NoIntro:   1; Extensions: 'a52|bin|zip'; BIOSChecker: TBIOSCheckerAtari5200),
     (Core: 'a78';        Console: 'Atari - 7800';                                                                       NoIntro:  74; Extensions: 'a78|bin'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'amstrad';    Console: 'Amstrad - CPC';                                                                      NoIntro: 250; Extensions: 'dsk|sna|kcr'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'amstradb';   Console: 'Amstrad - CPC';                                                                      NoIntro: 250; Extensions: 'dsk|sna|tap|cdt|voc|m3u|cpr|zip'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'cdg';        Console: 'Game - Pocket CDG';                                                                  NoIntro:   0; Extensions: 'cdg'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'chip8';      Console: 'Fantasy Console - XO-CHIP/S-CHIP/CHIP-8';                                            NoIntro:   0; Extensions: 'ch8|sc8|xo8'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'col';        Console: 'Coleco - ColecoVision';                                                              NoIntro:   3; Extensions: 'col|cv|bin|rom'; BIOSChecker: TBIOSCheckerColecoVision),
     (Core: 'dblcherrygb';Console: 'Nintendo - Dot Matrix Game ("Game Boy")';                                            NoIntro:  46; Extensions: 'gb|dmg|sgb'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'dblcherrygb';Console: 'Nintendo - Game Boy Color';                                                          NoIntro:  47; Extensions: 'gbc|cgb|sgb'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'fake08';     Console: 'Fantasy Console - PICO-8';                                                           NoIntro:   0; Extensions: 'p8|png'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'fcf';        Console: 'Fairchild - Channel F';                                                              NoIntro:   6; Extensions: 'bin|rom|chf'; BIOSChecker: TBIOSCheckerChannelF),
     (Core: 'gb';         Console: 'Nintendo - Dot Matrix Game ("Game Boy")';                                            NoIntro:  46; Extensions: 'gb|sgb'; BIOSChecker: TBIOSCheckerGameBoyGambatteGB),
     (Core: 'gb';         Console: 'Nintendo - Game Boy Color';                                                          NoIntro:  47; Extensions: 'gbc|sgb'; BIOSChecker: TBIOSCheckerGameBoyColorGambatteGB),
     (Core: 'gba';        Console: 'Nintendo - Game Boy Advance';                                                        NoIntro:  23; Extensions: 'gba|bin'; BIOSChecker: TBIOSCheckerGameBoyAdvance),
     (Core: 'gbav';       Console: 'Nintendo - Game Boy Advance';                                                        NoIntro:  23; Extensions: 'gba'; BIOSChecker: TBIOSCheckerGameBoyAdvance),
     (Core: 'gbb';        Console: 'Nintendo - Dot Matrix Game ("Game Boy")';                                            NoIntro:  46; Extensions: 'gb|dmg'; BIOSChecker: TBIOSCheckerGameBoyGambatteGBB),
     (Core: 'gbb';        Console: 'Nintendo - Game Boy Color';                                                          NoIntro:  47; Extensions: 'gbc'; BIOSChecker: TBIOSCheckerGameBoyColorGambatteGBB),
     (Core: 'gbgb';       Console: 'Nintendo - Dot Matrix Game ("Game Boy")';                                            NoIntro:  46; Extensions: 'gb|dmg|sgb'; BIOSChecker: TBIOSCheckerGameBoy),
     (Core: 'gbgb';       Console: 'Nintendo - Game Boy Color';                                                          NoIntro:  47; Extensions: 'gbc|sgb'; BIOSChecker: TBIOSCheckerGameBoyColor),
     (Core: 'geolith';    Console: 'SNK - Neo Geo MVS/AES';                                                              NoIntro:   0; Extensions: 'neo'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'gg';         Console: 'Sega - SG-1000';                                                                     NoIntro:  19; Extensions: 'sg|bin|rom'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'gg';         Console: 'Sega - Game Gear';                                                                   NoIntro:  25; Extensions: 'gg|sms|bin'; BIOSChecker: TBIOSCheckerNone), // optional BIOS Checker needed
     (Core: 'gg';         Console: 'Sega - Master System';                                                               NoIntro:  26; Extensions: 'sms|bin'; BIOSChecker: TBIOSCheckerNone), // optional BIOS Checker needed
     (Core: 'gme';        Console: 'Media - Game Music Emu';                                                             NoIntro:   0; Extensions: 'ay|gbs|gym|hes|kss|nsf|nsfe|sap|spc|vgm|vgz'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'gw';         Console: 'Nintendo - Game & Watch';                                                            NoIntro: 226; Extensions: 'mgw'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'int';        Console: 'Mattel - Intellivision';                                                             NoIntro: 105; Extensions: 'int|rom|bin'; BIOSChecker: TBIOSCheckerIntelliVision),
     (Core: 'lnx';        Console: 'Atari - Lynx';                                                                       NoIntro:  30; Extensions: 'lnx'; BIOSChecker: TBIOSCheckerLynx),
     //(Core: 'lnxb';       Console: 'Atari - Lynx';                                                                       NoIntro:  30; Extensions: 'lnx|o'; BIOSChecker: TBIOSCheckerLynx),
     (Core: 'm2k';        Console: 'Arcade';                                                                             NoIntro:   0; Extensions: 'zip'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'msx';        Console: 'Sega - SG-1000';                                                                     NoIntro:  19; Extensions: 'sg|sc|ri'; BIOSChecker: TBIOSCheckerMSXSegaSG1000),
     (Core: 'msx';        Console: 'Coleco - ColecoVision';                                                              NoIntro:   3; Extensions: 'col'; BIOSChecker: TBIOSCheckerMSXColecoVision),
     (Core: 'nes';        Console: 'Nintendo - Nintendo Entertainment System';                                           NoIntro:  45; Extensions: 'nes|unif|unf'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'nes';        Console: 'Nintendo - Family Computer Disk System [not working]';                               NoIntro:  31; Extensions: 'fds|nes'; BIOSChecker: TBIOSCheckerFamicomDiskSystem),
     (Core: 'nesq';       Console: 'Nintendo - Nintendo Entertainment System';                                           NoIntro:  45; Extensions: 'nes'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'nest';       Console: 'Nintendo - Family Computer Disk System [not working?]';                              NoIntro:  31; Extensions: 'fds|nes'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'nest';       Console: 'Nintendo - Nintendo Entertainment System';                                           NoIntro:  45; Extensions: 'nes|unif|unf'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'ngpc';       Console: 'SNK - NeoGeo Pocket Color';                                                          NoIntro:  36; Extensions: 'ngc'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'ngpc';       Console: 'SNK - NeoGeo Pocket';                                                                NoIntro:  35; Extensions: 'ngp'; BIOSChecker: TBIOSCheckerNone),
     //(Core: 'o2em';       Console: 'Philips - Videopac G7000 ("Magnavox Odyssey2")';                                     NoIntro:  9; Extensions: 'bin'; BIOSChecker: TBIOSCheckerMagnavoxOdyssey2), // this thing is waaay too confusing
     //(Core: 'o2em';       Console: 'Philips - Videopac+ G7400 ("Odyssey3 Command Center")';                              NoIntro:  16; Extensions: 'bin'; BIOSChecker: TBIOSCheckerVideopacPlus),
     (Core: 'pc8800';     Console: 'NEC - PC-88';                                                                        NoIntro: 242; Extensions: 'd88|u88|m3u'; BIOSChecker: TBIOSCheckerPC88),
     (Core: 'pce';        Console: 'NEC - PC Engine';                                                                    NoIntro:  12; Extensions: 'pce'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'pce';        Console: 'NEC - PC Engine CD';                                                                 NoIntro: 159; Extensions: 'cue|ccd|iso|img|bin|chd'; BIOSChecker: TBIOSCheckerPCEngineCD),
     (Core: 'pcesgx';     Console: 'NEC - PC Engine';                                                                    NoIntro:  12; Extensions: 'pce'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'pcesgx';     Console: 'NEC - PC Engine Supergrafx';                                                         NoIntro:  13; Extensions: 'sgx'; BIOSChecker: TBIOSCheckerNone), // optional BIOS Checker needed
     (Core: 'pcesgx';     Console: 'NEC - PC Engine CD';                                                                 NoIntro: 159; Extensions: 'cue|ccd|chd'; BIOSChecker: TBIOSCheckerPCEngineCD),
     //(Core: 'pcfx';       Console: 'NEC - PC-FX';                                                                        NoIntro:   0; Extensions: 'cue|ccd|toc|chd'; BIOSChecker: TBIOSCheckerPCFX),
     (Core: 'pokem';      Console: 'Nintendo - Pokémon Mini';                                                            NoIntro:  14; Extensions: 'min'; BIOSChecker: TBIOSCheckerNone), // optional BIOS Checker
     //(Core: 'retro8';     Console: 'Fantasy Console - PICO-8';                                                           NoIntro:   0; Extensions: 'p8|png'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - SG-1000 [unofficial]';                                                        NoIntro:  19; Extensions: 'sg'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - Game Gear [unofficial]';                                                      NoIntro:  25; Extensions: 'gg'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - Master System';                                                               NoIntro:  26; Extensions: 'sms|68k|bin'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - Mega Drive';                                                                  NoIntro:  32; Extensions: 'md|smd|gen|bin'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - Kids Computer Pico';                                                          NoIntro:  18; Extensions: 'md|smd|gen|bin'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - 32X';                                                                         NoIntro:  17; Extensions: '32x|bin'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'sega';       Console: 'Sega - Mega-CD';                                                                     NoIntro: 166; Extensions: 'iso|chd|bin|cue'; BIOSChecker: TBIOSCheckerMegaCD),
     (Core: 'snes';       Console: 'Nintendo - Super Nintendo Entertainment System';                                     NoIntro:  49; Extensions: 'smc|fig|sfc|gd3|gd7|dx2|bsx|wsc'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'snes';       Console: 'Bandai - SuFami Turbo [not working]';                                                NoIntro:  78; Extensions: 'st'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'snes02';     Console: 'Nintendo - Super Nintendo Entertainment System';                                     NoIntro:  49; Extensions: 'smc|fig|sfc|gd3|gd7|dx2|bsx|wsc'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'snes02';     Console: 'Bandai - SuFami Turbo [not working]';                                                NoIntro:  78; Extensions: 'st'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'spec';       Console: 'Sinclair - ZX Spectrum';                                                             NoIntro:  73; Extensions: 'tzx|tap|z80|rzx|scl|trd'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'thom';       Console: 'Thomson - MO, TO';                                                                   NoIntro:   0; Extensions: 'fd|sap|k7|rom|m7|m5'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'vapor';      Console: 'Fantasy Console - VaporSpec';                                                        NoIntro:   0; Extensions: 'vaporbin'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'vec';        Console: 'GCE - Vectrex';                                                                      NoIntro:   7; Extensions: 'bin|vec'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'wsv';        Console: 'Watara - SuperVision';                                                               NoIntro:  22; Extensions: 'bin|sv'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'wswan';      Console: 'Bandai - WonderSwan';                                                                NoIntro:  50; Extensions: 'ws'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'wswan';      Console: 'Bandai - WonderSwan Color';                                                          NoIntro:  51; Extensions: 'wsc'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'wswan';      Console: 'Benesse - Pocket Challenge v2';                                                      NoIntro:  87; Extensions: 'pc2'; BIOSChecker: TBIOSCheckerNone),
     (Core: 'zx81';       Console: 'Sinclair - ZX 81';                                                                   NoIntro:   0; Extensions: 'p|tzx|t81'; BIOSChecker: TBIOSCheckerNone));

  Cores: array[0..94] of TCore =
    ((Core: 'multicore';  Name: 'multicore General Options';   Config: 'multicore';               Description: 'configuration only'),
     (Core: 'Stock';      Name: 'GB300 Stock Emulators';       Config: '';                        Description: 'NES, VTxx, PCE, SNES, MD, SMS, GB, GBC, GBA'),
     (Core: 'arduboy';    Name: 'Arduous';                     Config: 'arduous';                 Description: 'Arduboy'),
     (Core: 'a5200';      Name: 'Atari800';                    Config: 'a5200';                   Description: 'Atari 5200, Atari 8-Bit/800'),
     (Core: 'a800';       Name: 'libatari800';                 Config: 'Atari 800 (libatari800)'; Description: 'Atari 5200, Atari 8-Bit/800'),
     (Core: 'lnxb';       Name: Beetle+'Lynx';                 Config: 'Beetle Lynx';             Description: 'Atari Lynx'),
     (Core: 'pce';        Name: Beetle+'PCE Fast';             Config: 'Beetle PCE Fast';         Description: 'PC Engine, PC Engine-CD'),
     (Core: 'pcfx';       Name: Beetle+'PC-FX';                Config: 'Beetle PC-FX';            Description: 'NEC PC-FX'),
     (Core: 'pcesgx';     Name: Beetle+'SGX';                  Config: 'Beetle SuperGrafx';       Description: 'NEC PC Engine, PC Engine CD, SuperGrafx'),
     (Core: 'vb';         Name: Beetle+'VB';                   Config: 'Beetle VB';               Description: 'Nintendo Virtual Boy'),
     (Core: 'wswan';      Name: Beetle+'Cygne';                Config: 'Beetle WonderSwan';       Description: 'Bandai WonderSwan Classic, Color'),
     (Core: 'msx';        Name: 'blueMSX';                     Config: 'blueMSX';                 Description: 'Microsoft MSX, MSX2, Coleco ColecoVision, Sega SG-1000'),
     (Core: 'outrun';     Name: 'Cannonball';                  Config: 'Cannonball';              Description: 'OutRun Game Engine'),
     (Core: 'amstradb';   Name: 'Caprice32';                   Config: 'cap32';                   Description: 'Amstrad CPC'),
     (Core: 'amstrad';    Name: 'CrocoDS';                     Config: 'crocods';                 Description: 'Amstrad CPC'),
     (Core: 'dblcherrygb';Name: 'DoubleCherryGB';              Config: 'DoubleCherryGB';          Description: 'Game Boy Classic, Color'),
     (Core: 'wolf3d';     Name: 'ECWolf';                      Config: 'ecwolf';                  Description: 'Wolfenstein 3D Game Engine'),
     (Core: 'zx81';       Name: 'EightyOne';                   Config: 'EightyOne';               Description: 'Sinclair ZX 81'),
     (Core: 'fake08';     Name: 'FAKE-08';                     Config: 'fake-08';                 Description: 'PICO-08 Fantasy Console'),
     (Core: 'nes';        Name: 'FCEUmm';                      Config: 'FCEUmm';                  Description: 'Nintendo Entertainment System/Famicom'),
     (Core: 'fcf';        Name: 'FreeChaF';                    Config: 'FreeChaF';                Description: 'Fairchild Channel F'),
     (Core: 'int';        Name: 'FreeIntV';                    Config: 'FreeInv';                 Description: 'Mattel Intellivision'),
     (Core: 'c64f';       Name: 'Frodo';                       Config: 'Frodo';                   Description: 'Commodore 64'),
     (Core: 'c64fc';      Name: 'FrodoSC';                     Config: 'Frodo';                   Description: 'Commodore 64'),
     (Core: 'spec';       Name: 'Fuse';                        Config: 'fuse';                    Description: 'Sinclair ZX Spectrum'),
     (Core: 'gw';         Name: 'GW';                          Config: 'Game & Watch';            Description: 'Nintendo Game & Watch'),
     (Core: 'gme';        Name: 'Game Music Emu';              Config: 'Game Music Emulator';     Description: 'Music Player'),
     (Core: 'gbgb';       Name: 'Gearboy';                     Config: 'Gearboy';                 Description: 'Game Boy Classic/Color'),
     (Core: 'col';        Name: 'GearColeco';                  Config: 'Gearcoleco';              Description: 'Coleco ColecoVision'),
     (Core: 'gg';         Name: 'Gearsystem';                  Config: 'Gearsystem';              Description: 'Sega SG-1000, Master System, Game Gear'),
     (Core: 'gpgx';       Name: 'Genesis Plus GX';             Config: 'Genesis Plus GX';         Description: 'Sega SG-1000, Master System, Game Gear, Mega Drive, PICO, Mega-CD'),
     (Core: 'geolith';    Name: 'Geolith';                     Config: 'Geolith';                 Description: 'Neo Geo AES/MVS'),
     (Core: 'gong';       Name: 'Gong';                        Config: 'gong';                    Description: 'Pong Game'),
     (Core: 'gba';        Name: 'gpSP';                        Config: 'gpSP';                    Description: 'Game Boy Advance'),
     (Core: 'lnx';        Name: 'Handy';                       Config: 'Handy';                   Description: 'Atari Lynx'),
     (Core: 'chip8';      Name: 'JAXE';                        Config: 'JAXE';                    Description: 'Fantasy Consoles XO-CHIP, S-CHIP CHIP-8'),
     (Core: 'jnb';        Name: 'Jump ''n Bump';               Config: 'Jump ''n Bump';           Description: 'Game Engine'),
     (Core: 'lowres-nx';  Name: 'LowRes NX';                   Config: 'LowRes NX';               Description: 'LowRes NX Fantasy Console'),
     (Core: 'm2k';        Name: 'MAME 2000';                   Config: 'MAME 2000';               Description: 'Arcade'),
     (Core: 'mgba';       Name: 'mGBA';                        Config: 'mGBA';                    Description: 'Game Boy Classic, Color, Advance'),
     (Core: 'nest';       Name: 'Nestopia UE';                 Config: 'Nestopia';                Description: 'Nintendo Entertainment System/Famicom'),
     (Core: 'cavestory';  Name: 'NXEngine';                    Config: 'NXEngine';                Description: 'Cave Story Game Engine'),
     (Core: 'o2em';       Name: 'O2EM';                        Config: 'O2EM';                    Description: 'Magnavox Odyssey, Philips VideoPac+'),
     (Core: 'sega';       Name: 'PicoDrive';                   Config: 'PicoDrive';               Description: 'Sega Master System, Game Gear, Mega Drive, PICO, Mega-CD, 32x'),
     (Core: 'cdg';        Name: 'Pocket CDG';                  Config: 'pocketcdg';               Description: 'Karaoke'),
     (Core: 'pokem';      Name: 'PokeMini';                    Config: 'PokeMini';                Description: 'Pokémon Mini'),
     (Core: 'wsv';        Name: 'Potator';                     Config: 'Potator';                 Description: 'Watara SuperVision'),
     (Core: 'prboom';     Name: 'PrBoom';                      Config: 'PrBoom';                  Description: 'Doom Game Engine'),
     (Core: 'a78';        Name: 'ProSystem';                   Config: 'ProSystem';               Description: 'Atari 7800'),
     (Core: 'pc8800';     Name: 'QUASI88';                     Config: 'QUASI88';                 Description: 'PC8800'),
     (Core: 'nesq';       Name: 'QuickNES';                    Config: 'QuickNES';                Description: 'Nintendo Entertainment System/Famicom'),
     (Core: 'ngpc';       Name: 'RACE';                        Config: 'RACE';                    Description: 'NeoGeo Pocket Classic, Color'),
     (Core: 'flashback';  Name: 'REminiscence';                Config: 'REminiscence';            Description: 'Flashback Game Engine'),
     (Core: 'retro8';     Name: 'Retro8';                      Config: 'retro-8 (alpha)';         Description: 'PICO-8 Fantasy Console'),
     (Core: 'snes02';     Name: 'Snes9x 2002';                 Config: 'Snes9x 2002';             Description: 'Super Nintendo Entertainment System/Super Famicom'),
     (Core: 'snes';       Name: 'Snes9x 2005';                 Config: 'Snes9x 2005';             Description: 'Super Nintendo Entertainment System/Super Famicom'),
     (Core: 'a26';        Name: 'Stella';                      Config: 'Stella 2014';             Description: 'Atari 2600'),
     (Core: 'gb';         Name: 'TGB Dual';                    Config: 'TGB Dual';                Description: 'Game Boy Classic, Color'), // adjust TForm1.ButtonOnboardingStartClick if you swap gb and gbb by default!
     (Core: 'gbb';        Name: 'Gambatte';                    Config: 'Gambatte';                Description: 'Game Boy Classic, Color'),
     (Core: 'thom';       Name: 'Theodore';                    Config: 'theodore';                Description: 'Thomson MO/TO Series'),
     (Core: 'quake';      Name: 'TyrQuake';                    Config: 'TyrQuake';                Description: 'Quake Game Engine'),
     (Core: 'vapor';      Name: 'VaporSpec';                   Config: 'Vaporspec';               Description: 'VaporSpec Fantasy Console'),
     (Core: 'gbav';       Name: 'VBA Next';                    Config: 'VBA Next';                Description: 'Game Boy Advance'),
     (Core: 'vec';        Name: 'vecx';                        Config: 'VecX';                    Description: 'GCE Vectrex'),
     (Core: 'c64';        Name: 'VICE x64';                    Config: 'VICE x64';                Description: 'Commodore 64'),
     (Core: 'c64sc';      Name: 'VICE x64sc';                  Config: 'VICE x64sc';              Description: 'Commodore 64'),
     (Core: 'vic20';      Name: 'VICE';                        Config: 'VICE xvic';               Description: 'Commodore VIC-20'),
     (Core: 'xrick';      Name: 'XRick';                       Config: 'xrick';                   Description: 'Rick Dangerous Game Engine'),
     (Core: 'psx';        Name: 'Beetle PSX';                  Config: '';                        Description: 'PlayStation'),
     (Core: 'snesc';      Name: 'ChimeraSNES';                 Config: '';                        Description: 'Super Nintendo Entertainment System/Super Famicom'),
     (Core: 'dossvn';     Name: 'DOSBox-SVN';                  Config: '';                        Description: 'Disk Operating System'),
     (Core: 'neogeo';     Name: 'FB Alpha';                    Config: '';                        Description: 'Arcade'),
     (Core: 'cps1';       Name: 'Final Burn Alpha 2012 CPS-1'; Config: '';                        Description: 'Arcade'),
     (Core: 'cps2';       Name: 'Final Burn Alpha 2012 CPS-2'; Config: '';                        Description: 'Arcade'),
     (Core: 'cps3';       Name: 'Final Burn Alpha 2012 CPS-3'; Config: '';                        Description: 'Arcade'),
     (Core: 'fmsx';       Name: 'fMSX';                        Config: '';                        Description: 'Microsoft MSX, MSX2'),
     (Core: 'glxy';       Name: 'Galaxy';                      Config: '';                        Description: 'Galaksija'),
     (Core: 'img';        Name: 'image-viewer-legacy';         Config: '';                        Description: 'Image Viewer'),
     (Core: 'testadv';    Name: 'libretro_test_advanced';      Config: '';                        Description: 'Test'),
     (Core: 'uw8';        Name: 'MicroW8';                     Config: '';                        Description: 'Microw8 Fantasy Console'),
     (Core: 'mac';        Name: 'minivmac';                    Config: '';                        Description: 'Mac II'),
     (Core: 'zork';       Name: 'mojozork';                    Config: '';                        Description: 'Z-Machine'),
     (Core: 'nogg';       Name: 'nogg';                        Config: '';                        Description: 'eggnogg Game'),
     (Core: 'numero';     Name: 'Numero';                      Config: '';                        Description: 'Texas Instruments TI-83'),
     (Core: 'risc';       Name: 'Oberon';                      Config: '';                        Description: 'Oberon RISC Machine'),
     (Core: '3do';        Name: 'Opera';                       Config: '';                        Description: 'Panasonic 3DO'),
     (Core: 'x68k';       Name: 'PX68k';                       Config: '';                        Description: 'Sharp X86000'),
     (Core: 'gbs';        Name: 'SameBoy';                     Config: '';                        Description: 'Game Boy Classic, Color'),
     (Core: 'snesn';      Name: 'Snes9x';                      Config: '';                        Description: 'Super Nintendo Entertainment System/Super Famicom'),
     (Core: 'sbw';        Name: 'Super Bros War';              Config: '';                        Description: 'Super Bros. War Game'),
     (Core: 'uzem';       Name: 'Uzem';                        Config: '';                        Description: 'Uzebox'),
     (Core: 'gbam';       Name: 'VBA-M';                       Config: '';                        Description: 'Game Boy Classic, Color, Advance'),
     (Core: 'jag';        Name: 'Virtual Jaguar';              Config: '';                        Description: 'Atari Jaguar'),
     (Core: 'quake2';     Name: 'vitaQuake 2';                 Config: '';                        Description: 'Quake2 Game Engine'),
     (Core: 'xmil';       Name: 'X Millennium';                Config: '';                        Description: 'Sharp X1'));

var
  CoresDict: TDictionary<string, TCore>;
  SwapGBAndGBB: Boolean;

procedure TidyUpFileList(List: TStrings); // TOpenDialog.Files and TDragFileTrg.FileList are both TStringList which would actually be helpful here because only TStringList has binary search, but well...

implementation

uses
  SysUtils, StrUtils, GB300Utils, DateUtils, pngimage;

procedure TidyUpFileList(List: TStrings);
var
  Temp: TStringList;
  Playlist: TStringList;
  Item, PlaylistItem: string;
  Ext: string;
  Replace: TDictionary<string, string>; // replace contains files and their sister files if any exist
  i: Integer;
procedure Remove(Item: string; OriginalItem: string);
var
  i: Integer;
begin
  if OriginalItem <> '' then
  if Replace.ContainsKey(OriginalItem) then
  Replace[OriginalItem] := Replace[OriginalItem] + '|' + Item
  else
  Replace.Add(OriginalItem, OriginalItem + '|' + Item);

  Temp.Find(Item, i);
  if i >= 0 then
  Temp.Delete(i);
end;
begin
  // This method removes all items referenced by M3U, CUE and CDG files
  // Only supports flat paths, because items in other directories unlikely be in the user's selection.
  Temp := TStringList.Create();
  Replace := TDictionary<string, string>.Create();
  try
    Temp.Assign(List);
    Temp.Sort();

    for Item in List do
    begin
      if not FileExists(Item) then
      begin
        Remove(Item, '');
        Continue;
      end;

      Ext := Lowercase(ExtractFileExt(Item));
      if Ext = '.m3u' then
      begin
        Playlist := TStringList.Create();
        try
          Playlist.LoadFromFile(Item);
          for PlaylistItem in Playlist do
          if PlaylistItem <> '' then
          if PlaylistItem[1] <> '#' then
          Remove(ExtractFilePath(Item) + PlaylistItem, Item);
        finally
          Playlist.Free();
        end;
      end;

      if Ext = '.cue' then
      begin
        Playlist := TStringList.Create();
        try
          Playlist.LoadFromFile(Item);
          for PlaylistItem in Playlist do
          if PlaylistItem <> '' then
          if StartsStr('FILE "', PlaylistItem) then
          if EndsStr('" BINARY', PlaylistItem) then
          Remove(ExtractFilePath(Item) + Copy(PlaylistItem, 7, Length(PlaylistItem) - 14), Item);
        finally
          Playlist.Free();
        end;
      end;

      if Ext = '.cdg' then
      begin
        Remove(ChangeFileExt(Item, '.mp3'), Item);
        Remove(ChangeFileExt(Item, '.MP3'), '');
      end;
    end;

    List.Clear();
    for i := 0 to Temp.Count - 1 do
    if Replace.ContainsKey(Temp[i]) then
    List.Add(Replace[Temp[i]])
    else
    List.Add(Temp[i]);

  finally
    Temp.Free();
    Replace.Free;
  end;
end;

{ TBIOSChecker }

class function TBIOSChecker.CheckBIOSFile(const FileName: string; Required: Boolean; ExpectedCRC: array of Cardinal): TBIOSCheckResult;
begin
  Result := CheckBIOSFileAbs(IncludeTrailingPathDelimiter(Path + 'bios') + FileName, Required, ExpectedCRC);
end;

class function TBIOSChecker.CheckBIOSFileAbs(const FileName: string;
  Required: Boolean; ExpectedCRC: array of Cardinal): TBIOSCheckResult;
var
  MS: TMemoryStream;
  CRC: Cardinal;
  ExpCRC: Cardinal;
begin
  Result.FileName := FileName;
  Delete(Result.FileName, 1, Length(Path));
  Result.Required := Required;
  Result.Exists := FileExists(FileName);
  Result.CRCValid := False;
  if Result.Exists then
  begin
    MS := TMemoryStream.Create();
    try
      MS.LoadFromFile(FileName);
      CRC := $ffffffff xor update_crc($ffffffff, MS.Memory, MS.Size);
      for ExpCRC in ExpectedCRC do
      if ExpCRC = CRC then
      begin
        Result.CRCValid := True;
        Exit;
      end;
    finally
      MS.Free();
    end;
  end;

end;

class function TBIOSChecker.CheckBIOS(OnlyRequired: Boolean; out AllOK: Boolean): TBIOSCheckResults;
var
  Item: TBIOSCheckResult;
begin
  if OnlyRequired then // Optional roms are only used by the GUI, so we need no caching there
  if Length(BIOSLastRequiredCheckedResult) > 0 then
  try
    if SecondsBetween(Now, BIOSLastRequiredChecked) < 10 then // less than the time the user will need to fix BIOS
    begin
      Result := BIOSLastRequiredCheckedResult;
      AllOK := BIOSLastRequiredCheckedAllOK;
    end;
  except // in case of any odd data in BIOSLastRequired causing SecondsBetween to fail
  end;

  if Length(Result) = 0 then
  Result := DoCheckBIOS(OnlyRequired);

  AllOK := True;
  for Item in Result do
  if Item.Required and not Item.CRCValid then
  begin
    AllOK := False;
    Break;
  end;

  BIOSLastRequiredCheckedResult := Result;
  BIOSLastRequiredCheckedAllOK := AllOK;
  BIOSLastRequiredChecked := Now();
end;

{ TCore }

function TCore.GetConfig(const ROMFileNameNoPathButExt: string): TCoreOptions;
var
  i: Integer;
  OptFile: TStringList;
  Row: string;
  Values: TDictionary<string, string>;
  TempFN: string;
  Temp: TCoreOption;
  TempName: string;
  TempValue: string;
  ParseState: (psInit, psName, psFirstColon, psDefault, psSecondColon, psValues);
  TempData: string;
begin
  OptFile := TStringList.Create();
  Values := TDictionary<string, string>.Create();
  try
    TempFN := GetConfigPath(ROMFileNameNoPathButExt);
    if ROMFileNameNoPathButExt <> '' then
    if FileExists(TempFN) then
    OptFile.LoadFromFile(TempFN)
    else
    begin
      TempFN := GetConfigPath();
      OptFile.LoadFromFile(TempFN);

      // load default multicore settings if per-game config does not exist
      if ROMFileNameNoPathButExt <> '' then
      begin
        TempFN := CoresDict['multicore'].GetConfigPath;
        if FileExists(TempFN) then
        begin
          TempData := OptFile.Text;
          OptFile.LoadFromFile(TempFN);
          OptFile.Text := TempData + #13#10 + OptFile.Text; // Add() stores multiline text in a single row
        end;
      end;
    end
    else
    OptFile.LoadFromFile(GetConfigPath());


    for Row in OptFile do
    begin
      if Row = '' then
      Continue;
      if StartsStr('###', Row) then // definition
      begin
        // this is essentially an automaton
        Temp.Name := '';
        Temp.Default := '';
        Temp.Values := '';
        ParseState := psInit;
        for i := 4 to Length(Row) do
        case ParseState of
          psInit:
            if Row[i] = '[' then
            ParseState := psName;
          psName:
            if Row[i] = ']' then
            ParseState := psFirstColon
            else
            Temp.Name := Temp.Name + Row[i];
          psFirstColon:
            if Row[i] = '[' then
            ParseState := psDefault;
          psDefault:
            if Row[i] = ']' then
            ParseState := psSecondColon
            else
            Temp.Default := Temp.Default + Row[i];
          psSecondColon:
            if Row[i] = '[' then
            ParseState := psValues;
          psValues:
            if Row[i] = ']' then
            begin
              SetLength(Result, Length(Result) + 1);
              Result[High(Result)] := Temp;
              Break;
            end
            else
            Temp.Values := Temp.Values + Row[i];
        end;
      end
      else
      if not StartsStr('#', Row) then // not a comment
      begin
        TempName := '';
        TempValue := '';
        ParseState := psName;
        for i := 1 to Length(Row) do
        case ParseState of
          psName:
            if (Row[i] = ' ') or (Row[i] = '=') then
            ParseState := psFirstColon
            else
            TempName := TempName + Row[i];
          psFirstColon:
            if Row[i] = '"' then
            ParseState := psDefault;
          psDefault:
            if Row[i] = '"' then
            begin
              Values.AddOrSetValue(TempName, TempValue);
              Break;
            end
            else
            TempValue := TempValue + Row[i];
        end;
      end;
    end;

    if Values.Count <> Length(Result) then
    raise Exception.CreateFmt('Cannot parse %s options (%s.opt) because the number of set options (%d) and available options (%d) do not match. This is a multicore issue.', [Core, Config, Values.Count, Length(Result)]);

    for i := Low(Result) to High(Result) do
    if not Values.ContainsKey(Result[i].Name) then
    raise Exception.CreateFmt('Cannot parse %s options (%s.opt) because the set options and available options do not match (e.g. no value set for %s). This is a multicore issue.', [Core, Config, Result[i].Name]);

    for i := Low(Result) to High(Result) do
    Result[i].Value := Values[Result[i].Name];
  finally
    OptFile.Free();
    Values.Free();
  end;
end;

function TCore.GetConsoles: TCoreConsoles;
begin
  Result := GetConsoles(Core);
end;

function TCore.GetConfigPath(const ROMFileNameNoPathButExt: string): string;
begin
  if ROMFileNameNoPathButExt = '' then
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'cores') + 'config') + Config + '.opt'
  else
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'cores') + 'config') + Config) + ChangeFileExt(ROMFileNameNoPathButExt, '') + '.opt';
end;

class function TCore.GetConsoles(const Core: string): TCoreConsoles;
var
  Console: TCoreConsole;
begin
  for Console in CoreConsoles do
  if Console.Core = Core then
  begin
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := Console;
  end;
end;

class function TCore.GetConsolesByExtension(Ext: string): TCoreConsoles;
var
  Console: TCoreConsole;
begin
  Ext := '|' + Ext + '|';
  for Console in CoreConsoles do
  if Pos(Ext, '|' + Console.Extensions + '|') > 0 then
  begin
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := Console;
  end;
end;

class function TCore.GetCores: TList<string>;
var
  Path: string;
  SearchRec: TSearchRec;
begin
  Path := IncludeTrailingPathDelimiter(GB300Utils.Path + 'cores') + '*';
  Result := TList<string>.Create();
  try
    if FindFirst(Path, faDirectory, SearchRec) <> 0 then
    Exit;
    repeat
      if (ExtractFileName(SearchRec.Name) <> 'config') and (ExtractFileName(SearchRec.Name) <> '.') and (ExtractFileName(SearchRec.Name) <> '..') then
      Result.Add(SearchRec.Name);
    until (FindNext(SearchRec) <> 0);
    Result.Sort();
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
end;

class function TCore.GetExtensionList(const Core: string): TStringList;
var
  Temp: TStringList;
  s: string;
  Console: TCoreConsole;
begin
  Result := TStringList.Create();
  try
    Result.Duplicates := dupIgnore;
    Result.Sorted := True;
    Temp := TStringList.Create();
    try
      for Console in CoreConsoles do
      if Console.Core = Core then
      begin
        Temp.Text := StringReplace(Console.Extensions, '|', #13#10, [rfReplaceAll]);
        for s in Temp do
        Result.Add(s);
      end;
    finally
      Temp.Free();
    end;
  except
    Result.Free();
    raise;
  end;
end;

function TCore.GetNameAndDescription: string;
begin
  if Description = '' then
  Result := Name
  else
  Result := Name + ' – ' + Description;
end;

function TCore.GetExtensionList: TStringList;
begin
  Result := GetExtensionList(Core);
end;

procedure TCore.SetConfig(Value: TCoreOptions; const ROMFileNameNoPathButExt: string);
var
  sl: TStringList;
  Option: TCoreOption;
begin
  sl := TStringList.Create();
  try
    for Option in Value do
    sl.Add('### [' + Option.Name + ']:[' + Option.Default + ']:[' + Option.Values + ']'); // TODO: Make output pretty
    for Option in Value do
    sl.Add(Option.Name + ' = "' + Option.Value + '"');
    ForceDirectories(ExtractFilePath(GetConfigPath(ROMFileNameNoPathButExt)));
    sl.SaveToFile(GetConfigPath(ROMFileNameNoPathButExt));
  finally
    sl.Free();
  end;
end;

{ TBIOSCheckerNone }

class function TBIOSCheckerNone.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 0);
end;

{ TBIOSCheckerAtari5200 }

class function TBIOSCheckerAtari5200.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 1);
  Result[0] := CheckBIOSFile('5200.rom', True, [$4248D3E3]);
end;

{ TBIOSCheckerColecoVision }

class function TBIOSCheckerColecoVision.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 1);
  Result[0] := CheckBIOSFile('colecovision.rom', True, [$3AA93EF3]);
end;

{ TBIOSCheckerChannelF }

class function TBIOSCheckerChannelF.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 2);
  Result[0] := CheckBIOSFile('sl31253.bin', True, [$04694ED9]);
  Result[1] := CheckBIOSFile('sl31254.bin', True, [$9C047BA3]);
  if not OnlyRequired then
  begin
    SetLength(Result, 3);
    Result[2] := CheckBIOSFile('sl90025.bin', False, [$015C1E38]);
  end;
end;

{ TBIOSCheckerGameBoy }

class function TBIOSCheckerGameBoy.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if OnlyRequired then
  SetLength(Result, 0)
  else
  begin
    SetLength(Result, 1);
    Result[0] := CheckBIOSFile('dmg_boot.bin', False, [$59C8598E]);
  end;
end;

{ TBIOSCheckerGameBoyColor }

class function TBIOSCheckerGameBoyColor.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if OnlyRequired then
  SetLength(Result, 0)
  else
  begin
    SetLength(Result, 1);
    Result[0] := CheckBIOSFile('cgb_boot.bin', False, [$41884E46]);
  end;
end;

{ TBIOSCheckerGameBoyAdvance }

class function TBIOSCheckerGameBoyAdvance.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if OnlyRequired then
  SetLength(Result, 0)
  else
  begin
    SetLength(Result, 1);
    Result[0] := CheckBIOSFile('gba_bios.bin', False, [$81977335]);
  end;
end;

{ TBIOSCheckerGameBoyAdvanceStock }

class function TBIOSCheckerGameBoyAdvanceStock.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if OnlyRequired then
  SetLength(Result, 0)
  else
  begin
    SetLength(Result, 2);
    Result[0] := CheckBIOSFileAbs(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'GBA') + 'mnt') + 'sda1') + 'bios') +'gba_bios.bin', False, [$81977335]);
    Result[1] := CheckBIOSFileAbs(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Foldername.AbsoluteFolder[7] + 'mnt') + 'sda1') + 'bios') +'gba_bios.bin', False, [$81977335]);
  end;
end;

{ TBIOSCheckerGameBoyGambatte }

class function TBIOSCheckerGameBoyGambatte.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if OnlyRequired then
  SetLength(Result, 0)
  else
  begin
    SetLength(Result, 1);
    Result[0] := CheckBIOSFile('gb_bios.bin', False, [$59C8598E]);
  end;
end;

{ TBIOSCheckerGameBoyColorGambatte }

class function TBIOSCheckerGameBoyColorGambatte.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if OnlyRequired then
  SetLength(Result, 0)
  else
  begin
    SetLength(Result, 1);
    Result[0] := CheckBIOSFile('gbc_bios.bin', False, [$41884E46]);
  end;
end;

{ TBIOSCheckerIntelliVision }

class function TBIOSCheckerIntelliVision.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 2);
  Result[0] := CheckBIOSFile('exec.bin', True, [$CBCE86F7]);
  Result[1] := CheckBIOSFile('grom.bin', True, [$683A4158]);
end;

{ TBIOSCheckerLynx }

class function TBIOSCheckerLynx.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 1);
  Result[0] := CheckBIOSFile('lynxboot.img', True, [$0D973C9D]);
end;

{ TBIOSCheckerMSXColecoVision }

class function TBIOSCheckerMSXColecoVision.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 5);
  Result[0] := CheckBIOSFile('Machines\COL - ColecoVision\coleco.rom', True, [$3AA93EF3]);
  Result[1] := CheckBIOSFile('Machines\COL - Bit Corporation Dina\czz50-1.rom', True, [$696C101A]);
  Result[2] := CheckBIOSFile('Machines\COL - Bit Corporation Dina\czz50-2.rom', True, [$6538DD32]);
  Result[3] := CheckBIOSFile('Machines\COL - ColecoVision with Opcode Memory Extension\coleco.rom', True, [$3AA93EF3]); // same as the first one
  Result[4] := CheckBIOSFile('Machines\COL - Spectravideo SVI-603 Coleco\SVI603.ROM', True, [$19E91B82]);
end;

{ TBIOSCheckerMSXSegaSG1000 }

class function TBIOSCheckerMSXSegaSG1000.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 1);
  Result[0] := CheckBIOSFile('Machines\SEGA - SF-7000\sf7000.rom', True, [$D76810B8]);
end;

{ TBIOSCheckerFamicomDiskSystem }

class function TBIOSCheckerFamicomDiskSystem.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 1);
  Result[0] := CheckBIOSFile('disksys.rom', True, [$5E607DCF]);
  // I didn't find the GG bios mentioned at libretro
end;

{ TBIOSCheckerFamicomDiskSystemStock }

class function TBIOSCheckerFamicomDiskSystemStock.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
//var
//  BIOS: TBIOS;
begin
  SetLength(Result, 2);
  Result[1] := CheckBIOSFileAbs(IncludeTrailingPathDelimiter(Path + 'ROMS') + 'disksys.rom', True, [$5E607DCF]);
  Result[0].FileName := 'Binary patch (not yet available)';
  Result[0].Required := True;
  Result[0].CRCValid := False;
  Result[0].Exists := False;

  {Result[0].FileName := 'FDS enabled in BIOS tab';
  Result[0].Required := True;
  if FileExists(TBIOS.Path) then
  begin
    BIOS := TBIOS.Create();
    try
      BIOS.LoadFromFile(TBIOS.Path);
      Result[0].CRCValid := BIOS.FDS;
    finally
      BIOS.Free();
    end;
  end
  else
  Result[0].CRCValid := False;
  Result[0].Exists := Result[0].CRCValid;       }
end;

{ TBIOSCheckerPCEngineCD }

class function TBIOSCheckerPCEngineCD.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 1);
  Result[0] := CheckBIOSFile('syscard3.pce', True, [$6D9A73EF, $64F78E3C]);
  // this is all very odd, because there are more common other BIOSes that still work, and for the three optional BIOSes, no hash is given
end;

{ TBIOSCheckerPC88 }

class function TBIOSCheckerPC88.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 8);
  Result[0] := CheckBIOSFile('n88.rom', True, [$A0FC0473, $73573432]);
  Result[1] := CheckBIOSFile('n88n.rom', True, [$27E1857D, $8A2A1E17]);
  Result[2] := CheckBIOSFile('disk.rom', True, [$2158D307, $F2CBE4EE]);
  Result[3] := CheckBIOSFile('n88knj1.rom', True, [$6178BD43]); // I have the same hash only here and stuff works
  Result[4] := CheckBIOSFile('n88_0.rom', True, [$710A63EC, $A72697D7]);
  Result[5] := CheckBIOSFile('n88_1.rom', True, [$C0BD2AA6, $7AD5D943]);
  Result[6] := CheckBIOSFile('n88_2.rom', True, [$AF2B6EFA, $6AEE9A4E]);
  Result[7] := CheckBIOSFile('n88_3.rom', True, [$7713C519, $692CBCD8]);
end;

{ TBIOSCheckerMegaCD }

class function TBIOSCheckerMegaCD.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  SetLength(Result, 3);
  Result[0] := CheckBIOSFile('bios_CD_E.bin', True, [$529AC15A]);
  Result[1] := CheckBIOSFile('bios_CD_J.bin', True, [$9D2DA8F2]);
  Result[2] := CheckBIOSFile('bios_CD_U.bin', True, [$C6D10268]);
end;

{ TCoreExtensions }

class procedure TCoreConsole.BIOSCheckToListItems(const Source: TBIOSCheckResults; Target: TListItems; Group: Integer = 0);
function YesNo(b: Boolean): string;
begin
  if b then
  Result := 'Yes'
  else
  Result := 'No';
end;
var
  Item: TListItem;
  Check: TBIOSCheckResult;
begin
  if Length(Source) = 0 then
  begin
    Item := Target.Add;
    Item.Caption := 'none required';
    Item.GroupID := Group;
    Item.ImageIndex := -1;
  end
  else
  for Check in Source do
  begin
    Item := Target.Add;
    Item.Caption := Check.FileName;
    Item.SubItems.Add(YesNo(Check.Required));
    Item.SubItems.Add(YesNo(Check.Exists));
    Item.SubItems.Add(YesNo(Check.CRCValid));
    if Check.CRCValid then
    Item.ImageIndex := 0
    else
    if Check.Exists and not Check.CRCValid then
    Item.ImageIndex := 3
    else
    if Check.Required and not Check.Exists then
    Item.ImageIndex := 1
    else
    //if not Check.Required then
    Item.ImageIndex := 2;

    Item.GroupID := Group;
  end;
end;

{ TBIOSCheckerGameBoyGambatteGB }

class function TBIOSCheckerGameBoyGambatteGB.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if CoresDict['gb'].Config = 'Gambatte' then
  Result := inherited
  else
  SetLength(Result, 0);
end;

{ TBIOSCheckerGameBoyGambatteGBB }

class function TBIOSCheckerGameBoyGambatteGBB.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if CoresDict['gbb'].Config = 'Gambatte' then
  Result := inherited
  else
  SetLength(Result, 0);
end;

{ TBIOSCheckerGameBoyColorGambatteGB }

class function TBIOSCheckerGameBoyColorGambatteGB.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if CoresDict['gb'].Config = 'Gambatte' then
  Result := inherited
  else
  SetLength(Result, 0);
end;

{ TBIOSCheckerGameBoyColorGambatteGBB }

class function TBIOSCheckerGameBoyColorGambatteGBB.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
begin
  if CoresDict['gbb'].Config = 'Gambatte' then
  Result := inherited
  else
  SetLength(Result, 0);
end;

{ TBIOSCheckerVTxx }

class function TBIOSCheckerVTxx.DoCheckBIOS(OnlyRequired: Boolean): TBIOSCheckResults;
//var
//  BIOS: TBIOS;
begin
  SetLength(Result, 1);
  Result[0].FileName := 'Binary patch (not yet available)';
  Result[0].Required := True;
  Result[0].CRCValid := False;
  Result[0].Exists := False;
  {SetLength(Result, 2);
  Result[0].FileName := 'VT02/03 enabled in BIOS tab';
  Result[0].Required := True;
  Result[1].FileName := 'VT03 LUT patched in BIOS tab';
  Result[1].Required := False;
  if FileExists(TBIOS.Path) then
  begin
    BIOS := TBIOS.Create();
    try
      BIOS.LoadFromFile(TBIOS.Path);
      Result[0].CRCValid := BIOS.VT03;
      Result[1].CRCValid := BIOS.VT03LUT565;
    finally
      BIOS.Free();
    end;
  end
  else
  begin
    Result[0].CRCValid := False;
    Result[1].CRCValid := False;
  end;
  Result[0].Exists := Result[0].CRCValid;      }
end;

end.
