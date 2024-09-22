unit GB300UIConst;

interface

uses
  SysUtils, Classes, Graphics, GB300Utils, PngImage;

type
  TApplicableDevice = (adBoth, adGB300v2, adSF2000);

  TUIFileSlice = record
    X: Word;
    Y: Word;
    Width: Word;
    Height: Word;
    private
      FDescription: string;
      function GetDescription(): string;
    public
      property Description: string read GetDescription;
  end;

  TSliceHandler = procedure(const Slices: array of TUIFileSlice) of object;

  TUIFileSlices = (usNone = 0,
                   usPlatformLogos,
                   usGameCountDigits,
                   usLanguage152x1224,
                   usGameLabels,
                   usTVSystems,
                   usUserSettings,
                   usMessageBox,
                   usMessageBoxBorders,
                   usKeyboard,
                   usPhysicalButtons,
                   usMappingPlatforms,
                   usButtonLabels,
                   usButtonPopup,
                   usSaveStates,
                   usBatteryStates,
                   usBottomTabsLegacy);

  TUIFile = record
    Filename: string;
    Format: TImageDataFormat;
    strict private
      FWidth: Word;
      FHeight: Word;
      procedure GetSliceFromSlices(const Slices: array of TUIFileSlice);
      function GetHeight: Word;
      function GetWidth: Word;
      var // should be threadvar, but records don't support threadvar
        SliceIndex: Byte;
        Slice: TUIFileSlice;
    public
      property Width: Word read GetWidth;
      property Height: Word read GetHeight;
    public
      Group: Byte;
      Description: string;
      Slices: TUIFileSlices;
      AppliesTo: TApplicableDevice;
      function GetPath(): string;
      procedure GetDIBStream(Output: TStream);
      function GetDIBImage(): TWICImage;
      function GetPNGImage(): TPngImage;
      procedure WriteImage(Input: TGraphic);
      procedure GetSlices(Callback: TSliceHandler);
      procedure GetSlice(SliceIndex: ShortInt);
      function GetSliceImage(SliceIndex: ShortInt): TPngImage;
      function SlicePNG(Temp: TPngImage): TPngImage;
      function IsApplicable(): Boolean;
  end;

const
  SlicesPlatformLogos: array[0..8] of TUIFIleSlice =
    ((X:    0; Y:    0; Width: 576; Height: 168; FDescription: '#0'),
     (X:    0; Y:  168; Width: 576; Height: 168; FDescription: '#1'),
     (X:    0; Y:  336; Width: 576; Height: 168; FDescription: '#2'),
     (X:    0; Y:  504; Width: 576; Height: 168; FDescription: '#3'),
     (X:    0; Y:  672; Width: 576; Height: 168; FDescription: '#4'),
     (X:    0; Y:  840; Width: 576; Height: 168; FDescription: '#5'),
     (X:    0; Y: 1008; Width: 576; Height: 168; FDescription: '#6'),
     (X:    0; Y: 1176; Width: 576; Height: 168; FDescription: '#7'),
     (X:    0; Y: 1344; Width: 576; Height: 168; FDescription: '#8'));

  SlicesGameCountDigits: array[0..9] of TUIFIleSlice =
    ((X:    0; Y:    0; Width:  16; Height:  24; FDescription: '0'),
     (X:    0; Y:   24; Width:  16; Height:  24; FDescription: '1'),
     (X:    0; Y:   48; Width:  16; Height:  24; FDescription: '2'),
     (X:    0; Y:   72; Width:  16; Height:  24; FDescription: '3'),
     (X:    0; Y:   96; Width:  16; Height:  24; FDescription: '4'),
     (X:    0; Y:  120; Width:  16; Height:  24; FDescription: '5'),
     (X:    0; Y:  144; Width:  16; Height:  24; FDescription: '6'),
     (X:    0; Y:  168; Width:  16; Height:  24; FDescription: '7'),
     (X:    0; Y:  192; Width:  16; Height:  24; FDescription: '8'),
     (X:    0; Y:  216; Width:  16; Height:  24; FDescription: '9'));

  SlicesLanguage152x1224: array[0..16] of TUIFIleSlice =
    ((X:    0; Y:    0; Width: 152; Height:  72; FDescription: 'English'),
     (X:    0; Y:   72; Width: 152; Height:  72; FDescription: 'Chinese'),
     (X:    0; Y:  144; Width: 152; Height:  72; FDescription: 'Spanish'),
     (X:    0; Y:  216; Width: 152; Height:  72; FDescription: 'Portuguese'),
     (X:    0; Y:  288; Width: 152; Height:  72; FDescription: 'Russian'),
     (X:    0; Y:  360; Width: 152; Height:  72; FDescription: 'Korean'),
     (X:    0; Y:  432; Width: 152; Height:  72; FDescription: 'French'),
     (X:    0; Y:  504; Width: 152; Height:  72; FDescription: 'German'),
     (X:    0; Y:  576; Width: 152; Height:  72; FDescription: 'Italian'),
     (X:    0; Y:  648; Width: 152; Height:  72; FDescription: 'Polish'),
     (X:    0; Y:  720; Width: 152; Height:  72; FDescription: 'Dutch'),
     (X:    0; Y:  792; Width: 152; Height:  72; FDescription: 'Japanese'),
     (X:    0; Y:  864; Width: 152; Height:  72; FDescription: 'Turkish'),
     (X:    0; Y:  936; Width: 152; Height:  72; FDescription: 'Thai'),
     (X:    0; Y: 1008; Width: 152; Height:  72; FDescription: 'Malay'),
     (X:    0; Y: 1080; Width: 152; Height:  72; FDescription: 'Hebrew'),
     (X:    0; Y: 1152; Width: 152; Height:  72; FDescription: 'Arabic'));

  SlicesGameLabels: array[0..7] of TUIFIleSlice =
    ((X:    0; Y:   32; Width: 576; Height:  32; FDescription: '#1'),
     (X:    0; Y:   64; Width: 576; Height:  32; FDescription: '#2'),
     (X:    0; Y:   96; Width: 576; Height:  32; FDescription: '#3'),
     (X:    0; Y:  128; Width: 576; Height:  32; FDescription: '#4'),
     (X:    0; Y:  160; Width: 576; Height:  32; FDescription: '#5'),
     (X:    0; Y:  192; Width: 576; Height:  32; FDescription: '#6'),
     (X:    0; Y:  224; Width: 576; Height:  32; FDescription: '#7'),
     (X:    0; Y:  256; Width: 576; Height:  32; FDescription: '#8'));

  SlicesTVSystems: array[0..1] of TUIFIleSlice =
    ((X:    0; Y:    0; Width: 120; Height: 120; FDescription: 'Never The Same Color'),
     (X:  120; Y:  120; Width: 120; Height: 120; FDescription: 'Pay Additional Luxury'));

  SlicesUserSettings: array[0..6] of TUIFIleSlice =
    ((X:    0; Y:    0; Width: 144; Height: 164; FDescription: 'Game List'),
     (X:  144; Y:    0; Width: 144; Height: 164; FDescription: 'Favorites'),
     (X:  288; Y:    0; Width: 144; Height: 164; FDescription: 'History'),
     (X:  432; Y:    0; Width: 144; Height: 164; FDescription: 'Search'),
     (X:  576; Y:    0; Width: 144; Height: 164; FDescription: 'Key Mapping'),
     (X:  720; Y:    0; Width: 144; Height: 164; FDescription: 'Language'),
     (X:  864; Y:    0; Width: 144; Height: 164; FDescription: 'TV System'));

  SlicesMessageBox: array[0..3] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 400; Height:  72; FDescription: 'Base'), // this is the only case where there are different image sizes in a file
     (X:    0; Y:   72; Width: 400; Height:  40; FDescription: 'Ok'),
     (X:    0; Y:  112; Width: 400; Height:  40; FDescription: 'No'),
     (X:    0; Y:  152; Width: 400; Height:  40; FDescription: 'Yes'));

  SlicesMessageBoxBorders: array[0..1] of TUIFileSlice =
    ((X:    0; Y:    0; Width:   8; Height: 112; FDescription: 'Left'),
     (X:    0; Y:  112; Width:   8; Height: 112; FDescription: 'Right'));

  SlicesKeyboardGB300: array[0..37] of TUIFileSlice =
    ((X:   17; Y:  173; Width:  54; Height:  54; FDescription: '1'),
     (X:   72; Y:  173; Width:  54; Height:  54; FDescription: '2'),
     (X:  127; Y:  173; Width:  54; Height:  54; FDescription: '3'),
     (X:  182; Y:  173; Width:  54; Height:  54; FDescription: '4'),
     (X:  237; Y:  173; Width:  54; Height:  54; FDescription: '5'),
     (X:  292; Y:  173; Width:  54; Height:  54; FDescription: '6'),
     (X:  347; Y:  173; Width:  54; Height:  54; FDescription: '7'),
     (X:  402; Y:  173; Width:  54; Height:  54; FDescription: '8'),
     (X:  457; Y:  173; Width:  54; Height:  54; FDescription: '9'),
     (X:  512; Y:  173; Width:  54; Height:  54; FDescription: '0'),
     (X:  567; Y:  173; Width:  54; Height:  54; FDescription: 'Bksp'),
     (X:   45; Y:  235; Width:  54; Height:  54; FDescription: 'Q'),
     (X:  100; Y:  235; Width:  54; Height:  54; FDescription: 'W'),
     (X:  155; Y:  235; Width:  54; Height:  54; FDescription: 'E'),
     (X:  210; Y:  235; Width:  54; Height:  54; FDescription: 'R'),
     (X:  265; Y:  235; Width:  54; Height:  54; FDescription: 'T'),
     (X:  320; Y:  235; Width:  54; Height:  54; FDescription: 'Y'),
     (X:  375; Y:  235; Width:  54; Height:  54; FDescription: 'U'),
     (X:  430; Y:  235; Width:  54; Height:  54; FDescription: 'I'),
     (X:  485; Y:  235; Width:  54; Height:  54; FDescription: 'O'),
     (X:  540; Y:  235; Width:  54; Height:  54; FDescription: 'P'),
     (X:   72; Y:  297; Width:  54; Height:  54; FDescription: 'A'),
     (X:  127; Y:  297; Width:  54; Height:  54; FDescription: 'S'),
     (X:  182; Y:  297; Width:  54; Height:  54; FDescription: 'D'),
     (X:  237; Y:  297; Width:  54; Height:  54; FDescription: 'F'),
     (X:  292; Y:  297; Width:  54; Height:  54; FDescription: 'G'),
     (X:  347; Y:  297; Width:  54; Height:  54; FDescription: 'H'),
     (X:  402; Y:  297; Width:  54; Height:  54; FDescription: 'J'),
     (X:  457; Y:  297; Width:  54; Height:  54; FDescription: 'K'),
     (X:  512; Y:  297; Width:  54; Height:  54; FDescription: 'L'),
     (X:  100; Y:  358; Width:  54; Height:  54; FDescription: 'Z'),
     (X:  155; Y:  358; Width:  54; Height:  54; FDescription: 'X'),
     (X:  210; Y:  358; Width:  54; Height:  54; FDescription: 'C'),
     (X:  265; Y:  358; Width:  54; Height:  54; FDescription: 'V'),
     (X:  320; Y:  358; Width:  54; Height:  54; FDescription: 'B'),
     (X:  375; Y:  358; Width:  54; Height:  54; FDescription: 'N'),
     (X:  430; Y:  358; Width:  54; Height:  54; FDescription: 'M'),
     (X:  485; Y:  358; Width:  54; Height:  54; FDescription: 'Return'));

  SlicesKeyboardSF2000: array[0..35] of TUIFileSlice =
    ((X:   32; Y:  168; Width:  56; Height:  56; FDescription: '1'),
     (X:   96; Y:  168; Width:  56; Height:  56; FDescription: '2'),
     (X:  160; Y:  168; Width:  56; Height:  56; FDescription: '3'),
     (X:  224; Y:  168; Width:  56; Height:  56; FDescription: '4'),
     (X:  288; Y:  168; Width:  56; Height:  56; FDescription: '5'),
     (X:  352; Y:  168; Width:  56; Height:  56; FDescription: '6'),
     (X:  416; Y:  168; Width:  56; Height:  56; FDescription: '7'),
     (X:  480; Y:  168; Width:  56; Height:  56; FDescription: '8'),
     (X:  544; Y:  168; Width:  56; Height:  56; FDescription: '9'),
     (X:   32; Y:  240; Width:  56; Height:  56; FDescription: '0'),
     (X:   96; Y:  240; Width:  56; Height:  56; FDescription: 'A'),
     (X:  160; Y:  240; Width:  56; Height:  56; FDescription: 'B'),
     (X:  224; Y:  240; Width:  56; Height:  56; FDescription: 'C'),
     (X:  288; Y:  240; Width:  56; Height:  56; FDescription: 'D'),
     (X:  352; Y:  240; Width:  56; Height:  56; FDescription: 'E'),
     (X:  416; Y:  240; Width:  56; Height:  56; FDescription: 'F'),
     (X:  480; Y:  240; Width:  56; Height:  56; FDescription: 'G'),
     (X:  544; Y:  240; Width:  56; Height:  56; FDescription: 'H'),
     (X:   32; Y:  312; Width:  56; Height:  56; FDescription: 'I'),
     (X:   96; Y:  312; Width:  56; Height:  56; FDescription: 'J'),
     (X:  160; Y:  312; Width:  56; Height:  56; FDescription: 'K'),
     (X:  224; Y:  312; Width:  56; Height:  56; FDescription: 'L'),
     (X:  288; Y:  312; Width:  56; Height:  56; FDescription: 'M'),
     (X:  352; Y:  312; Width:  56; Height:  56; FDescription: 'N'),
     (X:  416; Y:  312; Width:  56; Height:  56; FDescription: 'O'),
     (X:  480; Y:  312; Width:  56; Height:  56; FDescription: 'P'),
     (X:  544; Y:  312; Width:  56; Height:  56; FDescription: 'Q'),
     (X:   32; Y:  384; Width:  56; Height:  56; FDescription: 'R'),
     (X:   96; Y:  384; Width:  56; Height:  56; FDescription: 'S'),
     (X:  160; Y:  384; Width:  56; Height:  56; FDescription: 'T'),
     (X:  224; Y:  384; Width:  56; Height:  56; FDescription: 'U'),
     (X:  288; Y:  384; Width:  56; Height:  56; FDescription: 'V'),
     (X:  352; Y:  384; Width:  56; Height:  56; FDescription: 'W'),
     (X:  416; Y:  384; Width:  56; Height:  56; FDescription: 'X'),
     (X:  480; Y:  384; Width:  56; Height:  56; FDescription: 'Y'),
     (X:  544; Y:  384; Width:  56; Height:  56; FDescription: 'Z'));

  SlicesGB300Buttons: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 640; Height: 240; FDescription: 'X'),
     (X:    0; Y:  240; Width: 640; Height: 240; FDescription: 'Y'),
     (X:    0; Y:  480; Width: 640; Height: 240; FDescription: 'L'),
     (X:    0; Y:  720; Width: 640; Height: 240; FDescription: 'A'),
     (X:    0; Y:  960; Width: 640; Height: 240; FDescription: 'B'),
     (X:    0; Y: 1200; Width: 640; Height: 240; FDescription: 'R'));

  SlicesSF2000Buttons: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 640; Height: 240; FDescription: 'X'),
     (X:    0; Y:  240; Width: 640; Height: 240; FDescription: 'Y'),
     (X:    0; Y:  480; Width: 640; Height: 240; FDescription: 'R'),
     (X:    0; Y:  720; Width: 640; Height: 240; FDescription: 'A'),
     (X:    0; Y:  960; Width: 640; Height: 240; FDescription: 'B'),
     (X:    0; Y: 1200; Width: 640; Height: 240; FDescription: 'L'));

  SlicesMappingPlatformsGB300: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 640; Height: 136; FDescription: 'FC'),
     (X:    0; Y:  136; Width: 640; Height: 136; FDescription: 'SFC'),
     (X:    0; Y:  272; Width: 640; Height: 136; FDescription: 'MD'),
     (X:    0; Y:  408; Width: 640; Height: 136; FDescription: 'PCE'),
     (X:    0; Y:  544; Width: 640; Height: 136; FDescription: 'GBA'),
     (X:    0; Y:  680; Width: 640; Height: 136; FDescription: 'MAME'));

  SlicesMappingPlatformsSF2000: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 640; Height: 136; FDescription: 'FC'),
     (X:    0; Y:  136; Width: 640; Height: 136; FDescription: 'SFC'),
     (X:    0; Y:  272; Width: 640; Height: 136; FDescription: 'MD'),
     (X:    0; Y:  408; Width: 640; Height: 136; FDescription: 'GB/GBC'),
     (X:    0; Y:  544; Width: 640; Height: 136; FDescription: 'GBA'),
     (X:    0; Y:  680; Width: 640; Height: 136; FDescription: 'MAME'));

  SlicesButtonLabels: array[0..23] of TUIFileSlice =
    ((X:    0; Y:    0; Width:  26; Height:  16; FDescription:  'B'),
     (X:   26; Y:    0; Width:  26; Height:  16; FDescription: 'TB'),
     (X:    0; Y:   16; Width:  26; Height:  16; FDescription:  'C'),
     (X:   26; Y:   16; Width:  26; Height:  16; FDescription: 'TC'),
     (X:    0; Y:   32; Width:  26; Height:  16; FDescription: 'ST'), // no need to try, ST(ART) and S(E)L(ECT) don't work (tested on GB and GBA)
     (X:   26; Y:   32; Width:  26; Height:  16; FDescription: 'ST'),
     (X:    0; Y:   48; Width:  26; Height:  16; FDescription: 'SL'),
     (X:   26; Y:   48; Width:  26; Height:  16; FDescription: 'SL'),
     (X:    0; Y:   64; Width:  26; Height:  16; FDescription:  'U'),
     (X:   26; Y:   64; Width:  26; Height:  16; FDescription:  'U'),
     (X:    0; Y:   80; Width:  26; Height:  16; FDescription:  'D'),
     (X:   26; Y:   80; Width:  26; Height:  16; FDescription:  'D'),
     (X:    0; Y:   96; Width:  26; Height:  16; FDescription:  'L'),
     (X:   26; Y:   96; Width:  26; Height:  16; FDescription: 'TL'),
     (X:    0; Y:  112; Width:  26; Height:  16; FDescription:  'R'),
     (X:   26; Y:  112; Width:  26; Height:  16; FDescription: 'TR'),
     (X:    0; Y:  128; Width:  26; Height:  16; FDescription:  'A'),
     (X:   26; Y:  128; Width:  26; Height:  16; FDescription: 'TA'),
     (X:    0; Y:  144; Width:  26; Height:  16; FDescription:  'Z'),
     (X:   26; Y:  144; Width:  26; Height:  16; FDescription: 'TZ'),
     (X:    0; Y:  160; Width:  26; Height:  16; FDescription:  'X'),
     (X:   26; Y:  160; Width:  26; Height:  16; FDescription: 'TX'),
     (X:    0; Y:  176; Width:  26; Height:  16; FDescription:  'Y'),
     (X:   26; Y:  176; Width:  26; Height:  16; FDescription: 'TY'));

  SlicesButtonPopup: array[0..31] of TUIFileSlice =
    ((X:    0; Y:    0; Width:  32; Height:  20; FDescription:  'A'),
     (X:   32; Y:    0; Width:  32; Height:  20; FDescription: 'TA'),
     (X:    0; Y:   20; Width:  32; Height:  20; FDescription:  'B'),
     (X:   32; Y:   20; Width:  32; Height:  20; FDescription: 'TB'),
     (X:    0; Y:   40; Width:  32; Height:  20; FDescription:  'X'),
     (X:   32; Y:   40; Width:  32; Height:  20; FDescription: 'TX'),
     (X:    0; Y:   60; Width:  32; Height:  20; FDescription:  'Y'),
     (X:   32; Y:   60; Width:  32; Height:  20; FDescription: 'TY'),
     (X:    0; Y:   80; Width:  32; Height:  20; FDescription:  'C'),
     (X:   32; Y:   80; Width:  32; Height:  20; FDescription: 'TC'),
     (X:    0; Y:  100; Width:  32; Height:  20; FDescription:  'Z'),
     (X:   32; Y:  100; Width:  32; Height:  20; FDescription: 'TZ'),
     (X:    0; Y:  120; Width:  32; Height:  20; FDescription:  'L'),
     (X:   32; Y:  120; Width:  32; Height:  20; FDescription: 'TL'),
     (X:    0; Y:  140; Width:  32; Height:  20; FDescription:  'R'),
     (X:   32; Y:  140; Width:  32; Height:  20; FDescription: 'TR'),
     (X:    0; Y:  160; Width:  32; Height:  20; FDescription:  'A (focussed)'),
     (X:   32; Y:  160; Width:  32; Height:  20; FDescription: 'TA (focussed)'),
     (X:    0; Y:  180; Width:  32; Height:  20; FDescription:  'B (focussed)'),
     (X:   32; Y:  180; Width:  32; Height:  20; FDescription: 'TB (focussed)'),
     (X:    0; Y:  200; Width:  32; Height:  20; FDescription:  'X (focussed)'),
     (X:   32; Y:  200; Width:  32; Height:  20; FDescription: 'TX (focussed)'),
     (X:    0; Y:  220; Width:  32; Height:  20; FDescription:  'Y (focussed)'),
     (X:   32; Y:  220; Width:  32; Height:  20; FDescription: 'TY (focussed)'),
     (X:    0; Y:  240; Width:  32; Height:  20; FDescription:  'C (focussed)'),
     (X:   32; Y:  240; Width:  32; Height:  20; FDescription: 'TC (focussed)'),
     (X:    0; Y:  260; Width:  32; Height:  20; FDescription:  'Z (focussed)'),
     (X:   32; Y:  260; Width:  32; Height:  20; FDescription: 'TZ (focussed)'),
     (X:    0; Y:  280; Width:  32; Height:  20; FDescription:  'L (focussed)'),
     (X:   32; Y:  280; Width:  32; Height:  20; FDescription: 'TL (focussed)'),
     (X:    0; Y:  300; Width:  32; Height:  20; FDescription:  'R (focussed)'),
     (X:   32; Y:  300; Width:  32; Height:  20; FDescription: 'TR (focussed)'));

  SlicesSaveStates: array[0..3] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 640; Height:  80; FDescription: 'State 1'),
     (X:    0; Y:   80; Width: 640; Height:  80; FDescription: 'State 2'),
     (X:    0; Y:  160; Width: 640; Height:  80; FDescription: 'State 3'),
     (X:    0; Y:  240; Width: 640; Height:  80; FDescription: 'State 4'));

  SlicesBatteryStates: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width:  60; Height:  24; FDescription: '1/5'),
     (X:    0; Y:   24; Width:  60; Height:  24; FDescription: '2/5'),
     (X:    0; Y:   48; Width:  60; Height:  24; FDescription: '3/5'),
     (X:    0; Y:   72; Width:  60; Height:  24; FDescription: '4/5'),
     (X:    0; Y:   96; Width:  60; Height:  24; FDescription: '5/5'),
     (X:    0; Y:  120; Width:  60; Height:  24; FDescription: 'Charging'));

  SlicesBottomTabsLegacy: array[0..10] of TUIFileSlice = // used by unused images only, but I still had this ready from GB300 Tool v1
    ((X:    0; Y:    0; Width: 100; Height: 120; FDescription: 'FC'),
     (X:  100; Y:    0; Width: 100; Height: 120; FDescription: 'SFC'),
     (X:  200; Y:    0; Width: 100; Height: 120; FDescription: 'MD'),
     (X:  300; Y:    0; Width: 100; Height: 120; FDescription: 'GB'),
     (X:  400; Y:    0; Width: 100; Height: 120; FDescription: 'GBC'),
     (X:  500; Y:    0; Width: 100; Height: 120; FDescription: 'GBA'),
     (X:  600; Y:    0; Width: 100; Height: 120; FDescription: 'CPS1'),
     (X:  700; Y:    0; Width: 100; Height: 120; FDescription: 'CPS2'),
     (X:  800; Y:    0; Width: 100; Height: 120; FDescription: 'NEOGEO'),
     (X:  900; Y:    0; Width: 100; Height: 120; FDescription: 'IGS'),
     (X: 1000; Y:    0; Width: 100; Height: 120; FDescription: 'FOLDER'));


  UIFiles: array[0..138] of TUIFile =
    ((Filename: 'fixas.ctp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - FC'; Slices: usNone),
     (Filename: 'drivr.ers';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - SFC'; Slices: usNone),
     (Filename: 'icuin.cpl';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - MD'; Slices: usNone),
     (Filename: 'xajkg.hsp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - GB'; Slices: usNone),
     (Filename: 'qwave.bke';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - GBC'; Slices: usNone),
     (Filename: 'irftp.ctp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - GBA'; Slices: usNone),
     (Filename: 'hctml.ers';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - Arcade'; Slices: usNone),
     (Filename: 'knczwaq.phd'; Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background and quick select - PCE'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'dsuei.cpl';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  0; Description: 'Menu background - User Settings'; Slices: usNone),
     (Filename: 'sfcdr.cpl';   Format: idfBGRA8888; FWidth:  576; FHeight: 1512; Group:  1; Description: 'Platform logos'; Slices: usPlatformLogos; AppliesTo: adGB300v2),
     (Filename: 'sfcdr.cpl';   Format: idfBGRA8888; FWidth:  576; FHeight: 1344; Group:  1; Description: 'Platform logos'; Slices: usPlatformLogos; AppliesTo: adSF2000),
     (Filename: 'nvinf.hsp';   Format: idfBGRA8888; FWidth:  16;  FHeight:  240; Group:  1; Description: 'Game count digits'; Slices: usGameCountDigits),
     (Filename: 'exaxz.hsp';   Format: idfBGRA8888; FWidth:  152; FHeight: 1224; Group:  1; Description: '"Games Exist, Start Open"'; Slices: usLanguage152x1224),
     (Filename: 'gkavc.ers';   Format: idfBGRA8888; FWidth:  576; FHeight:  288; Group:  1; Description: 'Menu and game labels - Chinese'; Slices: usGameLabels; AppliesTo: adGB300v2),
     (Filename: 'gakne.ctp';   Format: idfBGRA8888; FWidth:  576; FHeight:  288; Group:  1; Description: 'Menu and game labels - English'; Slices: usGameLabels; AppliesTo: adGB300v2),
     (Filename: 'gkavc.ers';   Format: idfBGRA8888; FWidth:  576; FHeight:  256; Group:  1; Description: 'Menu and game labels - Chinese'; Slices: usGameLabels; AppliesTo: adSF2000),
     (Filename: 'gakne.ctp';   Format: idfBGRA8888; FWidth:  576; FHeight:  256; Group:  1; Description: 'Menu and game labels - English'; Slices: usGameLabels; AppliesTo: adSF2000),
     (Filename: 'ectte.bke';   Format: idfBGRA8888; FWidth:  161; FHeight:  126; Group:  1; Description: 'Quick select selection'; Slices: usNone),
     (Filename: 'sdclt.occ';   Format: idfRGB565;   FWidth:  120; FHeight:  240; Group:  1; Description: 'TV standards'; Slices: usTVSystems),
     (Filename: 'ucby4.aax';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Arabic'; Slices: usUserSettings),
     (Filename: 'itiss.ers';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Chinese'; Slices: usUserSettings),
     (Filename: 'irmon.tax';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Dutch'; Slices: usUserSettings),
     (Filename: 'dxkgi.ctp';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - English'; Slices: usUserSettings),
     (Filename: 'sensc.bvs';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - French'; Slices: usUserSettings),
     (Filename: 'rmapi.tax';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - German'; Slices: usUserSettings),
     (Filename: 'vidca.bvs';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Hebrew'; Slices: usUserSettings),
     (Filename: 'pcadm.nec';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Italian'; Slices: usUserSettings),
     (Filename: 'mssvp.nec';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Japanese'; Slices: usUserSettings),
     (Filename: 'aepic.nec';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Korean'; Slices: usUserSettings),
     (Filename: 'vssvc.nec';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Malay'; Slices: usUserSettings),
     (Filename: 'ntdll.bvs';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Polish'; Slices: usUserSettings),
     (Filename: 'pmuta.bvs';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Portuguese'; Slices: usUserSettings; AppliesTo: adGB300v2),
     (Filename: 'ke89a.bvs';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Portuguese'; Slices: usUserSettings; AppliesTo: adSF2000),
     (Filename: 'subst.tax';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Russian'; Slices: usUserSettings),
     (Filename: 'cpwge.nec';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Spanish'; Slices: usUserSettings; AppliesTo: adGB300v2),
     (Filename: 'djoin.nec';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Spanish'; Slices: usUserSettings; AppliesTo: adSF2000),
     (Filename: 'awusa.tax';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Thai'; Slices: usUserSettings),
     (Filename: 'esent.bvs';   Format: idfBGRA8888; FWidth: 1008; FHeight:  164; Group:  1; Description: 'User Settings icons and labels - Turkish'; Slices: usUserSettings),
     (Filename: 'urlkp.bvs';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - FC'; Slices: usNone),
     (Filename: 'c1eac.pal';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - SFC'; Slices: usNone),
     (Filename: 'ihdsf.bke';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - MD'; Slices: usNone),
     (Filename: 'fltmc.sta';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - GB'; Slices: usNone),
     (Filename: 'cero.phl';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - GBC '; Slices: usNone),
     (Filename: 'efsui.stc';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - GBA'; Slices: usNone),
     (Filename: 'apisa.dlk';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - Arcade'; Slices: usNone),
     (Filename: 'xzaiw.mop';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - PCE'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'qasf.bel';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - User ROMs'; Slices: usNone),
     (Filename: 'uyhbc.dck';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - Favorites'; Slices: usNone),
     (Filename: 'lkvax.aef';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - History'; Slices: usNone),
     (Filename: 'lfsvc.dll';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  2; Description: 'Game list background - Search results'; Slices: usNone),
     (Filename: 'okcg2.old';   Format: idfBGRA8888; FWidth:   32; FHeight:   32; Group:  3; Description: 'Favorite star'; Slices: usNone),
     (Filename: 'appvc.ikb';   Format: idfBGRA8888; FWidth:  150; FHeight:  214; Group:  3; Description: 'Thumbnail background'; Slices: usNone),
     (Filename: 'certlm.msa';  Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - FC'; Slices: usNone),
     (Filename: 'djctq.rsd';   Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - SFC'; Slices: usNone),
     (Filename: 'dxdiag.bin';  Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - MD'; Slices: usNone),
     (Filename: 'fvecpl.ai';   Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - GB'; Slices: usNone),
     (Filename: 'htui.kcc';    Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - GBC'; Slices: usNone),
     (Filename: 'icm32.dll';   Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - GBA'; Slices: usNone),
     (Filename: 'msgsm.dll';   Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - Arcade'; Slices: usNone),
     (Filename: 'pgdcea.cpd';  Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - PCE'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'normidna.bin';Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group:  3; Description: 'Selection icon - Other lists'; Slices: usNone),
     (Filename: 'mhg4s.ihg';   Format: idfRGB565;   FWidth:  400; FHeight:  192; Group:  3; Description: 'Message box background and buttons'; Slices: usMessageBox),
     (Filename: 'zaqrc.olc';   Format: idfBGRA8888; FWidth:    8; FHeight:  224; Group:  3; Description: 'Message box background left/right edges'; Slices: usMessageBoxBorders),
     (Filename: 'mksh.rcv';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  4; Description: 'Search - Keyboard, default state'; Slices: usKeyboard),
     (Filename: 'hlink.bvs';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  4; Description: 'Search - Keyboard, selected state'; Slices: usKeyboard),
     (Filename: 'dxva2.nec';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  4; Description: 'Search - Keyboard, pressed state'; Slices: usKeyboard),
     (Filename: 'kmbcj.acp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  4; Description: 'Key Mapping - Background'; Slices: usNone),
     (Filename: 'mkhbc.rcv';   Format: idfRGB565;   FWidth:  640; FHeight: 1440; Group:  4; Description: 'Key Mapping - Device with buttons highlighted'; Slices: usPhysicalButtons),
     (Filename: 'cketp.bvs';   Format: idfRGB565;   FWidth:  640; FHeight:  816; Group:  4; Description: 'Key Mapping - Platform tab bar'; Slices: usMappingPlatforms),
     (Filename: 'lk7tc.bvs';   Format: idfBGRA8888; FWidth:   52; FHeight:  192; Group:  4; Description: 'Key Mapping - Button labels'; Slices: usButtonLabels),
     (Filename: 'ztrba.nec';   Format: idfRGB565;   FWidth:   64; FHeight:  320; Group:  4; Description: 'Button/key selection popup menu'; Slices: usButtonPopup),
     (Filename: 'dism.cef';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  5; Description: 'Pause screen background - 1st item selected'; Slices: usNone),
     (Filename: 'd2d1.hgp';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  5; Description: 'Pause screen background - 2nd item selected'; Slices: usNone),
     (Filename: 'bisrv.nec';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  5; Description: 'Pause screen background - 3rd item selected'; Slices: usNone),
     (Filename: 'pwsso.occ';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  5; Description: 'Pause screen background - 4th item selected'; Slices: usNone),
     (Filename: 'dpskc.ctp';   Format: idfRGB565;   FWidth:  640; FHeight:  320; Group:  6; Description: 'Pause screen - Save state slots'; Slices: usSaveStates),
     (Filename: 'wshrm.nec';   Format: idfBGRA8888; FWidth:  217; FHeight:   37; Group:  6; Description: 'Overwrite confirmation window - Yes selected'; Slices: usNone),
     (Filename: 'igc64.dll';   Format: idfBGRA8888; FWidth:  217; FHeight:   37; Group:  6; Description: 'Overwrite confirmation window - No selected'; Slices: usNone),
     (Filename: 'bttlve.kbp';  Format: idfBGRA8888; FWidth:   60; FHeight:  144; Group:  7; Description: 'Battery states'; Slices: usBatteryStates),
     (Filename: 'jccatm.kbp';  Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  7; Description: 'Empty battery screen'; Slices: usNone),
     (Filename: 'seltMap.key'; Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  9; Description: 'Unknown - Key map (greyscale)'; Slices: usNone),
     (Filename: 'dectMap.key'; Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  9; Description: 'Unknown - Key map (color)'; Slices: usNone),
     (Filename: 'gpapi.bvs';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group:  9; Description: 'Pause screen background - fifth item and keys'; Slices: usNone),
     (Filename: 'nvinfohsp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - MD (4th selected)'; Slices: usNone),
     (Filename: 'aeinv.bke';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - MD (5th selected)'; Slices: usNone),
     (Filename: 'plasy.ers';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - "GBX" (2nd selected)'; Slices: usNone),
     (Filename: 'mswbv.cpl';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - "GBX" (3rd selected)'; Slices: usNone),
     (Filename: 'kdill.hsp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - "GBX" (4th selected)'; Slices: usNone),
     (Filename: 'msdtc.bke';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - "GBX" (5th selected)'; Slices: usNone),
     (Filename: 'nsibm.ctp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - Arcade (1st selected)'; Slices: usNone),
     (Filename: 'mfpmp.ers';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - Arcade (2nd selected)'; Slices: usNone),
     (Filename: 'tsmcf.cpl';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - Arcade (3rd selected)'; Slices: usNone),
     (Filename: 'djoin.hsp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - Arcade (4th selected)'; Slices: usNone),
     (Filename: 'subst.bke';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - Arcade (5th selected)'; Slices: usNone),
     (Filename: 'fcont.ctp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - User ROMs (1st selected)'; Slices: usNone),
     (Filename: 'aepic.ers';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - User ROMs (2nd selected)'; Slices: usNone),
     (Filename: 'rmapi.cpl';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - User ROMs (3rd selected)'; Slices: usNone),
     (Filename: 'pcadm.hsp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 10; Description: 'Alternate background - User ROMs (4th selected)'; Slices: usNone),
     (Filename: 'desk.cpl';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Unknown - Chinese eight-games quick select'; Slices: usNone),
     (Filename: 'wshom.ocx';   Format: idfBGRA8888; FWidth: 1100; FHeight:  120; Group: 11; Description: 'GB300-v1-style bottom tabs - normal'; Slices: usBottomTabsLegacy),
     (Filename: 'fdbil.ph';    Format: idfBGRA8888; FWidth: 1100; FHeight:  120; Group: 11; Description: 'GB300-v1-style bottom tabs - selected'; Slices: usBottomTabsLegacy),
     (Filename: 'spmpm.gdp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - FC (lighter, preview)'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'ihds.bke';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - MD (lighter, preview)'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'url.bvs';     Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - CPS1 (lighter, preview)'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'c1e.pal';     Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - CPS2 (lighter, preview)'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'x86e.hgp';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - NeoGeo (lighter, preview)'; Slices: usNone; AppliesTo: adGB300v2),
     (Filename: 'spmpm.gdp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - FC (baked-in preview)'; Slices: usNone; AppliesTo: adSF2000), // these aren't lighter than the other ones on the SF2000, so they got split
     (Filename: 'ihds.bke';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - MD (baked-in preview)'; Slices: usNone; AppliesTo: adSF2000),
     (Filename: 'url.bvs';     Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - CPS1 (baked-in preview)'; Slices: usNone; AppliesTo: adSF2000),
     (Filename: 'c1e.pal';     Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - CPS2 (baked-in preview)'; Slices: usNone; AppliesTo: adSF2000),
     (Filename: 'x86e.hgp';    Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Game list background - NeoGeo (baked-in preview)'; Slices: usNone; AppliesTo: adSF2000),
     (Filename: 'mrtac.klo';   Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group: 11; Description: 'Alternative arcade selection icon'; Slices: usNone),
     (Filename: 'nettrace.dll';Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group: 11; Description: 'Alternative arcade selection icon'; Slices: usNone),
     (Filename: 'logilda.be';  Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group: 11; Description: 'Selection icon - CPS1'; Slices: usNone),
     (Filename: 'mfc64.emc';   Format: idfBGRA8888; FWidth:   40; FHeight:   24; Group: 11; Description: 'Selection icon - CPS2'; Slices: usNone),
     (Filename: 'cca.bvs';     Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 11; Description: 'Pause screen - 6 Chinese items, 1st selected'; Slices: usNone),
     (Filename: 'werui.ioc';   Format: idfRGB565;   FWidth:  320; FHeight:  240; Group: 11; Description: '"NODATA" background for save state thumbnail'; Slices: usNone),
     (Filename: 'msdmo.gdb';   Format: idfRGB565;   FWidth:  392; FHeight:   80; Group: 11; Description: 'Save state slot background - 1st selected'; Slices: usNone),
     (Filename: 'hgcpl.cke';   Format: idfRGB565;   FWidth:  392; FHeight:   80; Group: 11; Description: 'Save state slot background - 2nd selected'; Slices: usNone),
     (Filename: 'gpsvc.bvs';   Format: idfRGB565;   FWidth:  392; FHeight:   80; Group: 11; Description: 'Save state slot background - 3rd selected'; Slices: usNone),
     (Filename: 'ksxbar.ax';   Format: idfRGB565;   FWidth:  392; FHeight:   80; Group: 11; Description: 'Save state slot background - 4th selected'; Slices: usNone),
     (Filename: 'Foldername.ini';                                                Group:  8; Description: 'General configuration file'; Slices: usNone),
     (Filename: 'vdaz5.bjk';                                                     Group:  8; Description: 'UI strings - Arabic'; Slices: usNone),
     (Filename: 't2act.sgf';                                                     Group:  8; Description: 'UI strings - Chinese'; Slices: usNone),
     (Filename: 'jsnno.uby';                                                     Group:  8; Description: 'UI strings - Dutch'; Slices: usNone),
     (Filename: 'fhshl.skb';                                                     Group:  8; Description: 'UI strings - English'; Slices: usNone),
     (Filename: 'sgotd.cwt';                                                     Group:  8; Description: 'UI strings - French'; Slices: usNone),
     (Filename: 'snbqj.uby';                                                     Group:  8; Description: 'UI strings - German'; Slices: usNone),
     (Filename: 'xjebd.clq';                                                     Group:  8; Description: 'UI strings - Hebrew'; Slices: usNone),
     (Filename: 'qdbec.ofd';                                                     Group:  8; Description: 'UI strings - Italian'; Slices: usNone),
     (Filename: 'ntrcq.oba';                                                     Group:  8; Description: 'UI strings - Japanese'; Slices: usNone),
     (Filename: 'bfrjd.odb';                                                     Group:  8; Description: 'UI strings - Korean'; Slices: usNone),
     (Filename: 'wtrxj.lbd';                                                     Group:  8; Description: 'UI strings - Malay'; Slices: usNone),
     (Filename: 'ouenj.dut';                                                     Group:  8; Description: 'UI strings - Polish'; Slices: usNone),
     (Filename: 'lf9lb.cut';                                                     Group:  8; Description: 'UI strings - Portuguese'; Slices: usNone),
     (Filename: 'tvctu.uby';                                                     Group:  8; Description: 'UI strings - Russian'; Slices: usNone),
     (Filename: 'eknjo.ofd';                                                     Group:  8; Description: 'UI strings - Spanish'; Slices: usNone),
     (Filename: 'bxvtb.sby';                                                     Group:  8; Description: 'UI strings - Thai'; Slices: usNone),
     (Filename: 'dufdr.cwr';                                                     Group:  8; Description: 'UI strings - Turkish'; Slices: usNone)
     );

type
  TUIObjectType = (uoImage, uoText, uoStatic);

  TUIObject = record
    public
      T: TUIObjectType;
      D: string;
    private
      FX: Integer;
      FY: Integer;
    public
      S: Integer; // Slice / Size
    private
      FC: Integer;
    function GetC: TColor;
    function GetX: Integer;
    function GetY: Integer; // Color
    public
      property X: Integer read GetX;
      property Y: Integer read GetY;
      property C: TColor read GetC;
  end;

  TUIPreview = record
    private
      FName: string;
      D: TApplicableDevice;
      function GetName(): string;
    public
      Data: array of TUIObject;
      property Name: string read GetName;
      function GetPNG(): TPngImage;
      function ContainsImage(const FileName: string): Boolean;
      function IsApplicable(): Boolean;
  end;

var
  UIPreviews: array of TUIPreview;

procedure LoadUIPreviews(Stream: TStream);

implementation

uses
  RedeemerXML, Types, Windows, GUIHelpers;

function GetFontResourceInfo(lpszFilename: PWideChar; var Cardinal: DWORD; lpBuffer: PWideChar; dwQueryType: Cardinal): LongBool; stdcall; external 'gdi32.dll' name 'GetFontResourceInfoW';

procedure LoadUIPreviews(Stream: TStream);
var
  XML: TRedeemerXML;
procedure DoAdd();
var
  Obj: TUIObject;
begin
  if XML.CurrentTag = 'image' then
  Obj.T := uoImage
  else
  if XML.CurrentTag = 'text' then
  Obj.T := uoText
  else
  if XML.CurrentTag = 'static' then
  Obj.T := uoStatic
  else
  Exit;

  if Obj.T = uoStatic then
  XML.GetAttribute('d', Obj.D)
  else
  if not XML.GetAttribute('d', Obj.D) then
  Exit;
  Obj.FX := StrToIntDef(XML.GetAttribute('x'), 0);
  Obj.FY := StrToIntDef(XML.GetAttribute('y'), 0);
  Obj.S  := StrToIntDef(XML.GetAttribute('s'), 0);
  Obj.FC := StrToIntDef(XML.GetAttribute('c'), -1);

  SetLength(UIPreviews[High(UIPreviews)].Data, Length(UIPreviews[High(UIPreviews)].Data) + 1);
  UIPreviews[High(UIPreviews)].Data[High(UIPreviews[High(UIPreviews)].Data)] := Obj;
end;
var
  SS: TStringStream;
begin
  SetLength(UIPreviews, 0);
  SS := TStringStream.Create('', TEncoding.UTF8, False);
  try
    SS.CopyFrom(Stream);
    XML := TRedeemerXML.Create(SS.DataString);
    try
      while XML.GoToAndGetNextTag() do
      begin
        if XML.CurrentTag = 'preview' then
        begin
          SetLength(UIPreviews, Length(UIPreviews) + 1);
          UIPreviews[High(UIPreviews)].FName := XML.GetAttribute('name');
          UIPreviews[High(UIPreviews)].D := TApplicableDevice(StrToInt(XML.GetAttributeDef('d', '0')));
        end
        else
        DoAdd();
      end;
    finally
      XML.Free();
    end;
  finally
    SS.Free();
  end;
end;

{ TUIFile }

function TUIFile.GetDIBImage: TWICImage;
var
  MS: TMemoryStream; // could use TFileStream, but we don't need to save memory, do we?
begin
  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(GetPath());
    Result := GetDIBImageFromStream(MS, Format, Width, Height);
  finally
    MS.Free();
  end;
end;

procedure TUIFile.GetDIBStream(Output: TStream);
var
  MS: TMemoryStream; // could use TFileStream, but we don't need to save memory, do we?
begin
  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(GetPath());
    GetDIBStreamFromStream(MS, Output, Format, Width, Height);
  finally
    MS.Free();
  end;
end;

function TUIFile.GetHeight: Word;
begin
  if Filename = 'appvc.ikb' then
  Result := Foldername.ThumbnailSize.Y + 6
  else
  if (Filename = 'certlm.msa') or
     (Filename = 'djctq.rsd') or
     (Filename = 'dxdiag.bin') or
     (Filename = 'fvecpl.ai') or
     (Filename = 'htui.kcc') or
     (Filename = 'icm32.dll') or
     (Filename = 'msgsm.dll') or
     (Filename = 'pgdcea.cpd') or
     (Filename = 'normidna.bin') then
  Result := Foldername.SelectionSize.Y
  else
  Result := FHeight;
end;

function TUIFile.GetPath: string;
begin
  Result := IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + Filename;
end;

function TUIFile.GetPNGImage: TPngImage;
var
  MS: TMemoryStream; // TFileStream is too slow for the single reads GetPNGImageFromStream does
begin
  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(GetPath());
    Result := GetPNGImageFromStream(MS, Format, Width, Height);
  finally
    MS.Free();
  end;
end;

function TUIFile.GetSliceImage(SliceIndex: ShortInt): TPngImage;
var
  Temp: TPngImage;
begin
  if Slices = usNone then
  Exit(GetPNGImage());

  GetSlice(SliceIndex);
  Temp := GetPNGImage();
  try
    Result := SlicePNG(Temp);
  finally
    Temp.Free();
  end;
end;

procedure TUIFile.GetSlice(SliceIndex: ShortInt);
begin
  Self.SliceIndex := SliceIndex;

  GetSlices(GetSliceFromSlices);
end;

procedure TUIFile.GetSliceFromSlices(const Slices: array of TUIFileSlice);
begin
  Slice := Slices[SliceIndex];
end;

procedure TUIFile.GetSlices(Callback: TSliceHandler);
procedure CheckPCE(Slices: array of TUIFileSlice);
var
  Slices2: array of TUIFileSlice;
    i: Integer;
begin
  if CurrentDevice = cdGB300 then
  Callback(Slices)
  else
  begin
    SetLength(Slices2, Length(Slices) - 1);
    for i := Low(Slices2) to High(Slices2) do
    Slices2[i] := Slices[i];
    Callback(Slices2);
  end;
end;
begin
  case Slices of
    usNone:
      Callback([]);
    usPlatformLogos:
      CheckPCE(SlicesPlatformLogos);
    usGameCountDigits:
      Callback(SlicesGameCountDigits);
    usLanguage152x1224:
      Callback(SlicesLanguage152x1224);
    usGameLabels:
      CheckPCE(SlicesGameLabels);
    usTVSystems:
      Callback(SlicesTVSystems);
    usUserSettings:
      Callback(SlicesUserSettings);
    usMessageBox:
      Callback(SlicesMessageBox);
    usMessageBoxBorders:
      Callback(SlicesMessageBoxBorders);
    usKeyboard:
      if CurrentDevice = cdSF2000 then
      Callback(SlicesKeyboardSF2000)
      else
      Callback(SlicesKeyboardGB300);
    usPhysicalButtons:
      if CurrentDevice = cdSF2000 then
      Callback(SlicesSF2000Buttons)
      else
      Callback(SlicesGB300Buttons);
    usMappingPlatforms:
      if CurrentDevice = cdSF2000 then
      Callback(SlicesMappingPlatformsSF2000)
      else
      Callback(SlicesMappingPlatformsGB300);
    usButtonLabels:
      Callback(SlicesButtonLabels);
    usButtonPopup:
      Callback(SlicesButtonPopup);
    usSaveStates:
      Callback(SlicesSaveStates);
    usBatteryStates:
      Callback(SlicesBatteryStates);
    usBottomTabsLegacy:
      Callback(SlicesBottomTabsLegacy);
  end;
end;

function TUIFile.GetWidth: Word;
begin
  if Filename = 'appvc.ikb' then
  Result := Foldername.ThumbnailSize.X + 6
  else
  if (Filename = 'certlm.msa') or
     (Filename = 'djctq.rsd') or
     (Filename = 'dxdiag.bin') or
     (Filename = 'fvecpl.ai') or
     (Filename = 'htui.kcc') or
     (Filename = 'icm32.dll') or
     (Filename = 'msgsm.dll') or
     (Filename = 'pgdcea.cpd') or
     (Filename = 'normidna.bin') then
  Result := Foldername.SelectionSize.X
  else
  Result := FWidth;
end;

function TUIFile.IsApplicable(): Boolean;
begin
  if (CurrentDevice = cdGB300) and (AppliesTo = adSF2000) then
  Exit(False);
  if (CurrentDevice = cdSF2000) and (AppliesTo = adGB300v2) then
  Exit(False);
  Result := True;
end;

function TUIFile.SlicePNG(Temp: TPngImage): TPngImage;
var
  x, y: Integer;
  SrcAlphaScanline: pByteArray;
  DstAlphaScanline: pByteArray;
begin
  Result := TPngImage.CreateBlank(Temp.Header.ColorType, Temp.Header.BitDepth, Slice.Width, Slice.Height);
  try
    Result.Canvas.CopyRect(Rect(0, 0, Slice.Width, Slice.Height),
                           Temp.Canvas,
                           Rect(Slice.X, Slice.Y, Slice.X + Slice.Width, Slice.Y + Slice.Height));

    if Temp.TransparencyMode = ptmPartial then
    for y := 0 to Slice.Height - 1 do
    begin
      SrcAlphaScanline := Temp.AlphaScanline[y+Slice.Y];
      DstAlphaScanline := Result.AlphaScanline[y];
      for x := 0 to Slice.Width - 1 do
      DstAlphaScanline^[x] := SrcAlphaScanline^[x+Slice.X];
    end;
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
end;

procedure TUIFile.WriteImage(Input: TGraphic);
var
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create();
  try
    WriteGraphicToStream(Input, MS, Format, Width, Height, True);
    MS.SaveToFile(GetPath);
  finally
    MS.Free();
  end;
end;

{ TUIPreview }

function TUIPreview.ContainsImage(const FileName: string): Boolean;
var
  Obj: TUIObject;
begin
  Result := False;
  for Obj in Data do
  if Obj.T = uoImage then
  if Obj.D = FileName then
  Exit(True);
end;

function TUIPreview.GetName: string;
var
  Index: Integer;
begin
  if Copy(FName, 1, 1) = '#' then
  begin
    Index := StrToIntDef(Copy(FName, 2, 1337), 9);
    if (Index <= 8) and (Index >= 0) then
    Exit(Foldername.Folders[Index]);
  end;
  Result := FName;
end;

function TUIPreview.GetPNG: TPngImage;
var
  Obj: TUIObject;
  i: Integer;
  UIF: TUIFile;
  Img, Img2: TPngImage;
  r: TRect;
  LogFont: array of TLogFontW;
  lfsz: Cardinal;
  AddFontRes: Integer;
  OwnsFontResource: Boolean;
  s: string;
procedure LoadFont();
begin
  // Loading a custom font file whose display name is not known using the completely undocumented GetFontResourceInfo function...
  AddFontRes := AddFontResourceExW(PWideChar(IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + 'Arial_en.ttf'), FR_PRIVATE, nil);
  OwnsFontResource := True;
  if AddFontRes > 0 then
  begin
    SetLength(LogFont, AddFontRes);
    lfsz := AddFontRes * SizeOf(TLogFontW);
    if not GetFontResourceInfo(PWideChar(IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + 'Arial_en.ttf'), lfsz, @LogFont[0], 2) then
      raise Exception.Create('GetFontResourceInfoW failed.');

    if lfsz div SizeOf(TLogFont) > 0 then
    begin
      Result.Canvas.Font.Name := LogFont[0].lfFaceName;
      Exit;
    end;
  end;
end;
begin
  OwnsFontResource:= False;
  Result := TPngImage.CreateBlank(COLOR_RGB, 8, 640, 480);
  Img := nil;
  try
    try
      for Obj in Data do
      case Obj.T of
        uoImage:
          begin
            // Implement some sort of caching for images used multiple times
            if UIF.Filename <> Obj.D then
            for i := Low(UIFiles) to High(UIFiles) do
            if UIFiles[i].IsApplicable() then
            if UIFiles[i].Filename = Obj.D then
            begin
              UIF := UIFiles[i];
              Img.Free();
              Img := UIF.GetPNGImage;
            end;

            if UIF.Slices = usNone then
            begin
              r.Left := Obj.X;
              r.Top := Obj.Y;
              r.Width := Img.Width;
              r.Height := Img.Height;
              Img.Draw(Result.Canvas, r);
            end
            else
            begin
              UIF.GetSlice(Obj.S);
              Img2 := UIF.SlicePNG(Img);
              try
                r.Left := Obj.X;
                r.Top := Obj.Y;
                r.Width := Img2.Width;
                r.Height := Img2.Height;
                Img2.Draw(Result.Canvas, r);
              finally
                Img2.Free();
              end;
            end;
          end;
        uoText:
          begin
            LoadFont();
            //SetTextCharacterExtra(Result.Canvas.Handle, 1);
            Result.Canvas.Font.Height := Obj.S;
            Result.Canvas.Font.Color := Obj.C;
            Result.Canvas.Font.Quality := TFontQuality.fqAntialiased; // disable ClearType but use monochromatic Antialiasing
            Result.Canvas.Brush.Style := bsClear; // disable image background
            r.Left := Obj.X;
            r.Top := Obj.Y;
            r.Width := 640;
            r.Height := 480;
            s := Obj.D;
            //DrawText(Result.Canvas.Handle, s, Length(s), r, DT_EXTERNALLEADING); // does not help with decenders and has bugged " " spacing from the second space in a string
            Result.Canvas.TextRect(r, Obj.X, Obj.Y, s);
            //Result.Canvas.TextOut(Obj.X, Obj.Y, Obj.D + #13#10 + 'bla');
          end;
        uoStatic:
          begin
            Img.Free();
            Img := GUIHelpers.GetPNG(Obj.S);
            if Obj.D = 'thumb' then
            begin
              r.Left := Foldername.ThumbnailPosition.X;
              r.Top := Foldername.ThumbnailPosition.Y;
            end
            else
            begin
              r.Left := Obj.X;
              r.Top := Obj.Y;
            end;
            r.Width := Img.Width;
            r.Height := Img.Height;
            Img.Draw(Result.Canvas, r);
          end;
      end;
    except
      try
        Result.Free();
      except
      end;
      raise;
    end;
  finally
    Img.Free();
    if OwnsFontResource then
    RemoveFontResourceW(PWideChar(IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + 'Arial_en.ttf'));
  end;
end;

function TUIPreview.IsApplicable: Boolean;
begin
  if (CurrentDevice = cdGB300) and (D = adSF2000) then
  Exit(False);
  if (CurrentDevice = cdSF2000) and (D = adGB300v2) then
  Exit(False);
  Result := True;
end;

{ TUIObject }

function TUIObject.GetC: TColor;
begin
  if FC >= Low(Foldername.SelectedColors) then
  if FC <= High(Foldername.SelectedColors) then
  Exit(Foldername.SelectedColors[FC]);
  if FC = -2 then
  Exit(clWhite)
  else
  if FC = -3 then
  Exit(clRed)
  else
  if FC = -4 then // favorites, history and search results have a fixed selection color
  Exit($80ff)
  else
  Result := Foldername.DefaultColor;
end;

function TUIObject.GetX: Integer;
begin
  Result := FX;
  if T = uoImage then
  if D = 'appvc.ikb' then
  Result := Foldername.ThumbnailPosition.X - 3;
end;

function TUIObject.GetY: Integer;
begin
  Result := FY;
  if T = uoImage then
  if D = 'appvc.ikb' then
  Result := Foldername.ThumbnailPosition.Y - 3;
end;

{ TUIFileSlice }

function TUIFileSlice.GetDescription: string;
var
  Index: Integer;
begin
  if Copy(FDescription, 1, 1) = '#' then
  begin
    Index := StrToIntDef(Copy(FDescription, 2, 1337), 9);
    if (Index <= 8) and (Index >= 0) then
    Exit(Foldername.Folders[Index]);
  end;
  Result := FDescription;
end;

end.
