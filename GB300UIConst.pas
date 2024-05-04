unit GB300UIConst;

interface

uses
  SysUtils, Classes, Graphics, GB300Utils, PngImage;

type
  TUIFileSlice = record
    X: Word;
    Y: Word;
    Width: Word;
    Height: Word;
    Description: string;
  end;

  TSliceHandler = procedure(const Slices: array of TUIFileSlice) of object;

  TUIFileSlices = (usNone = 0,
                   usKeyboard,
                   usBottomTabs,
                   usTopLeftLogos,
                   usMessageBox,
                   usMessageBoxBorders,
                   usLanguage328x224,
                   usLanguage448x224,
                   usLanguage240x168,
                   usLanguage192x224,
                   usLanguage288x448,
                   usDeviceLogos,
                   usSaveStates,
                   usGB300Buttons,
                   usButtonLabels,
                   usButtonPopup,
                   usPauseMenuLabels,
                   usBatteryStates);

  TUIFile = record
    Filename: string;
    Format: TImageDataFormat;
    strict private
      FWidth: Word;
      FHeight: Word;
      procedure GetSliceFromSlices(const Slices: array of TUIFileSlice);
      function GetHeight: Word;
      function GetWidth: Word;
      var // should be threadvar, but records thing doesn't support threadvar
        SliceIndex: Byte;
        Slice: TUIFileSlice;
    public
      property Width: Word read GetWidth;   // TODO: Read from Foldername.ini instead
      property Height: Word read GetHeight;
    public
      Group: Byte;
      Description: string;
      IsLanguage: Boolean;
      Slices: TUIFileSlices;
      function GetPath(): string;
      procedure GetDIBStream(Output: TStream);
      function GetDIBImage(): TWICImage;
      function GetPNGImage(): TPngImage;
      procedure WriteImage(Input: TGraphic);
      procedure GetSlices(Callback: TSliceHandler);
      procedure GetSlice(SliceIndex: ShortInt);
      function GetSliceImage(SliceIndex: ShortInt): TPngImage;
      function SlicePNG(Temp: TPngImage): TPngImage;
  end;

const
  SlicesKeyboard: array[0..37] of TUIFileSlice =
    ((X:   17; Y:   45; Width:  54; Height:  54; Description: '1'),
     (X:   72; Y:   45; Width:  54; Height:  54; Description: '2'),
     (X:  127; Y:   45; Width:  54; Height:  54; Description: '3'),
     (X:  182; Y:   45; Width:  54; Height:  54; Description: '4'),
     (X:  237; Y:   45; Width:  54; Height:  54; Description: '5'),
     (X:  292; Y:   45; Width:  54; Height:  54; Description: '6'),
     (X:  347; Y:   45; Width:  54; Height:  54; Description: '7'),
     (X:  402; Y:   45; Width:  54; Height:  54; Description: '8'),
     (X:  457; Y:   45; Width:  54; Height:  54; Description: '9'),
     (X:  512; Y:   45; Width:  54; Height:  54; Description: '0'),
     (X:  567; Y:   45; Width:  54; Height:  54; Description: 'Bksp'),
     (X:   45; Y:  107; Width:  54; Height:  54; Description: 'Q'),
     (X:  100; Y:  107; Width:  54; Height:  54; Description: 'W'),
     (X:  155; Y:  107; Width:  54; Height:  54; Description: 'E'),
     (X:  210; Y:  107; Width:  54; Height:  54; Description: 'R'),
     (X:  265; Y:  107; Width:  54; Height:  54; Description: 'T'),
     (X:  320; Y:  107; Width:  54; Height:  54; Description: 'Y'),
     (X:  375; Y:  107; Width:  54; Height:  54; Description: 'U'),
     (X:  430; Y:  107; Width:  54; Height:  54; Description: 'I'),
     (X:  485; Y:  107; Width:  54; Height:  54; Description: 'O'),
     (X:  540; Y:  107; Width:  54; Height:  54; Description: 'P'),
     (X:   72; Y:  169; Width:  54; Height:  54; Description: 'A'),
     (X:  127; Y:  169; Width:  54; Height:  54; Description: 'S'),
     (X:  182; Y:  169; Width:  54; Height:  54; Description: 'D'),
     (X:  237; Y:  169; Width:  54; Height:  54; Description: 'F'),
     (X:  292; Y:  169; Width:  54; Height:  54; Description: 'G'),
     (X:  347; Y:  169; Width:  54; Height:  54; Description: 'H'),
     (X:  402; Y:  169; Width:  54; Height:  54; Description: 'J'),
     (X:  457; Y:  169; Width:  54; Height:  54; Description: 'K'),
     (X:  512; Y:  169; Width:  54; Height:  54; Description: 'L'),
     (X:  100; Y:  230; Width:  54; Height:  54; Description: 'Z'),
     (X:  155; Y:  230; Width:  54; Height:  54; Description: 'X'),
     (X:  210; Y:  230; Width:  54; Height:  54; Description: 'C'),
     (X:  265; Y:  230; Width:  54; Height:  54; Description: 'V'),
     (X:  320; Y:  230; Width:  54; Height:  54; Description: 'B'),
     (X:  375; Y:  230; Width:  54; Height:  54; Description: 'N'),
     (X:  430; Y:  230; Width:  54; Height:  54; Description: 'M'),
     (X:  485; Y:  230; Width:  54; Height:  54; Description: 'Return'));

  SlicesBottomTabs: array[0..11] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 100; Height: 120; Description: '#0'),
     (X:  100; Y:    0; Width: 100; Height: 120; Description: '#1'),
     (X:  200; Y:    0; Width: 100; Height: 120; Description: '#2'),
     (X:  300; Y:    0; Width: 100; Height: 120; Description: '#3'),
     (X:  400; Y:    0; Width: 100; Height: 120; Description: '#4'),
     (X:  500; Y:    0; Width: 100; Height: 120; Description: '#5'),
     (X:  600; Y:    0; Width: 100; Height: 120; Description: '#6'),
     (X:  700; Y:    0; Width: 100; Height: 120; Description: '#7'),
     (X:  800; Y:    0; Width: 100; Height: 120; Description: '#8'),
     (X:  900; Y:    0; Width: 100; Height: 120; Description: '#9'),
     (X: 1000; Y:    0; Width: 100; Height: 120; Description: '#10'),
     (X: 1100; Y:    0; Width: 100; Height: 120; Description: '#11'));

  SlicesTopLeftLogos: array[0..11] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 448; Height:  64; Description: '#0'),
     (X:    0; Y:   64; Width: 448; Height:  64; Description: '#1'),
     (X:    0; Y:  128; Width: 448; Height:  64; Description: '#2'),
     (X:    0; Y:  192; Width: 448; Height:  64; Description: '#3'),
     (X:    0; Y:  256; Width: 448; Height:  64; Description: '#4'),
     (X:    0; Y:  320; Width: 448; Height:  64; Description: '#5'),
     (X:    0; Y:  384; Width: 448; Height:  64; Description: '#6'),
     (X:    0; Y:  448; Width: 448; Height:  64; Description: '#7'),
     (X:    0; Y:  512; Width: 448; Height:  64; Description: '#8'),
     (X:    0; Y:  576; Width: 448; Height:  64; Description: '#9'),
     (X:    0; Y:  640; Width: 448; Height:  64; Description: '#10'),
     (X:    0; Y:  704; Width: 448; Height:  64; Description: '#11'));

  SlicesMessageBox: array[0..3] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 400; Height:  72; Description: 'Base'), // this is the only case where there are different image sizes in a file
     (X:    0; Y:   72; Width: 400; Height:  40; Description: 'Ok'),
     (X:    0; Y:  112; Width: 400; Height:  40; Description: 'No'),
     (X:    0; Y:  152; Width: 400; Height:  40; Description: 'Yes'));

  SlicesMessageBoxBorders: array[0..1] of TUIFileSlice =
    ((X:    0; Y:    0; Width:   8; Height: 112; Description: 'Left'),
     (X:    0; Y:  112; Width:   8; Height: 112; Description: 'Right'));

  SlicesLanguage328x224: array[0..6] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 328; Height:  32; Description: 'English'),
     (X:    0; Y:   32; Width: 328; Height:  32; Description: 'Chinese'),
     (X:    0; Y:   64; Width: 328; Height:  32; Description: 'Arabic'),
     (X:    0; Y:   96; Width: 328; Height:  32; Description: 'Russian'),
     (X:    0; Y:  128; Width: 328; Height:  32; Description: 'Spanish'),
     (X:    0; Y:  160; Width: 328; Height:  32; Description: 'Portuguese'),
     (X:    0; Y:  192; Width: 328; Height:  32; Description: 'Korean'));

  SlicesLanguage448x224: array[0..6] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 448; Height:  32; Description: 'English'),
     (X:    0; Y:   32; Width: 448; Height:  32; Description: 'Chinese'),
     (X:    0; Y:   64; Width: 448; Height:  32; Description: 'Arabic'),
     (X:    0; Y:   96; Width: 448; Height:  32; Description: 'Russian'),
     (X:    0; Y:  128; Width: 448; Height:  32; Description: 'Spanish'),
     (X:    0; Y:  160; Width: 448; Height:  32; Description: 'Portuguese'),
     (X:    0; Y:  192; Width: 448; Height:  32; Description: 'Korean'));

  SlicesLanguage240x168: array[0..6] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 240; Height:  24; Description: 'English'),
     (X:    0; Y:   24; Width: 240; Height:  24; Description: 'Chinese'),
     (X:    0; Y:   48; Width: 240; Height:  24; Description: 'Arabic'),
     (X:    0; Y:   72; Width: 240; Height:  24; Description: 'Russian'),
     (X:    0; Y:   96; Width: 240; Height:  24; Description: 'Spanish'),
     (X:    0; Y:  120; Width: 240; Height:  24; Description: 'Portuguese'),
     (X:    0; Y:  144; Width: 240; Height:  24; Description: 'Korean'));

  SlicesLanguage192x224: array[0..6] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 192; Height:  32; Description: 'English'),
     (X:    0; Y:   32; Width: 192; Height:  32; Description: 'Chinese'),
     (X:    0; Y:   64; Width: 192; Height:  32; Description: 'Arabic'),
     (X:    0; Y:   96; Width: 192; Height:  32; Description: 'Russian'),
     (X:    0; Y:  128; Width: 192; Height:  32; Description: 'Spanish'),
     (X:    0; Y:  160; Width: 192; Height:  32; Description: 'Portuguese'),
     (X:    0; Y:  192; Width: 192; Height:  32; Description: 'Korean'));

  SlicesLanguage288x448: array[0..6] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 288; Height:  64; Description: 'English'),
     (X:    0; Y:   64; Width: 288; Height:  64; Description: 'Chinese'),
     (X:    0; Y:  128; Width: 288; Height:  64; Description: 'Arabic'),
     (X:    0; Y:  192; Width: 288; Height:  64; Description: 'Russian'),
     (X:    0; Y:  256; Width: 288; Height:  64; Description: 'Spanish'),
     (X:    0; Y:  320; Width: 288; Height:  64; Description: 'Portuguese'),
     (X:    0; Y:  384; Width: 288; Height:  64; Description: 'Korean'));

  SlicesDeviceLogos: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 640; Height:  56; Description: 'Family Computer'),
     (X:    0; Y:   56; Width: 640; Height:  56; Description: 'PC-Engine'),
     (X:    0; Y:  112; Width: 640; Height:  56; Description: 'Super Famicom'),
     (X:    0; Y:  168; Width: 640; Height:  56; Description: 'Mega Drive'),
     (X:    0; Y:  224; Width: 640; Height:  56; Description: 'Game Boy (Color)'),
     (X:    0; Y:  280; Width: 640; Height:  56; Description: 'Game Boy Advance'));

  SlicesSaveStates: array[0..3] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 384; Height:  80; Description: 'State 1'),
     (X:    0; Y:   80; Width: 384; Height:  80; Description: 'State 2'),
     (X:    0; Y:  160; Width: 384; Height:  80; Description: 'State 3'),
     (X:    0; Y:  240; Width: 384; Height:  80; Description: 'State 4'));

  SlicesGB300Buttons: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 320; Height: 376; Description: 'X'),
     (X:    0; Y:  376; Width: 320; Height: 376; Description: 'Y'),
     (X:    0; Y:  752; Width: 320; Height: 376; Description: 'L'),
     (X:    0; Y: 1128; Width: 320; Height: 376; Description: 'A'),
     (X:    0; Y: 1504; Width: 320; Height: 376; Description: 'B'),
     (X:    0; Y: 1880; Width: 320; Height: 376; Description: 'R'));

  SlicesButtonLabels: array[0..23] of TUIFileSlice =
    ((X:    0; Y:    0; Width:  26; Height:  16; Description:  'B'),
     (X:   26; Y:    0; Width:  26; Height:  16; Description: 'TB'),
     (X:    0; Y:   16; Width:  26; Height:  16; Description:  'C'),
     (X:   26; Y:   16; Width:  26; Height:  16; Description: 'TC'),
     (X:    0; Y:   32; Width:  26; Height:  16; Description: 'ST'), // no need to try, ST(ART) and S(E)L(ECT) don't work (tested on GB and GBA)
     (X:   26; Y:   32; Width:  26; Height:  16; Description: 'ST'),
     (X:    0; Y:   48; Width:  26; Height:  16; Description: 'SL'),
     (X:   26; Y:   48; Width:  26; Height:  16; Description: 'SL'),
     (X:    0; Y:   64; Width:  26; Height:  16; Description:  'U'),
     (X:   26; Y:   64; Width:  26; Height:  16; Description:  'U'),
     (X:    0; Y:   80; Width:  26; Height:  16; Description:  'D'),
     (X:   26; Y:   80; Width:  26; Height:  16; Description:  'D'),
     (X:    0; Y:   96; Width:  26; Height:  16; Description:  'L'),
     (X:   26; Y:   96; Width:  26; Height:  16; Description: 'TL'),
     (X:    0; Y:  112; Width:  26; Height:  16; Description:  'R'),
     (X:   26; Y:  112; Width:  26; Height:  16; Description: 'TR'),
     (X:    0; Y:  128; Width:  26; Height:  16; Description : 'A'),
     (X:   26; Y:  128; Width:  26; Height:  16; Description: 'TA'),
     (X:    0; Y:  144; Width:  26; Height:  16; Description:  'Z'),
     (X:   26; Y:  144; Width:  26; Height:  16; Description: 'TZ'),
     (X:    0; Y:  160; Width:  26; Height:  16; Description:  'X'),
     (X:   26; Y:  160; Width:  26; Height:  16; Description: 'TX'),
     (X:    0; Y:  176; Width:  26; Height:  16; Description:  'Y'),
     (X:   26; Y:  176; Width:  26; Height:  16; Description: 'TY'));

  SlicesButtonPopup: array[0..31] of TUIFileSlice =
    ((X:    0; Y:    0; Width:  32; Height:  20; Description:  'A'),
     (X:   32; Y:    0; Width:  32; Height:  20; Description: 'TA'),
     (X:    0; Y:   20; Width:  32; Height:  20; Description:  'B'),
     (X:   32; Y:   20; Width:  32; Height:  20; Description: 'TB'),
     (X:    0; Y:   40; Width:  32; Height:  20; Description:  'X'),
     (X:   32; Y:   40; Width:  32; Height:  20; Description: 'TX'),
     (X:    0; Y:   60; Width:  32; Height:  20; Description:  'Y'),
     (X:   32; Y:   60; Width:  32; Height:  20; Description: 'TY'),
     (X:    0; Y:   80; Width:  32; Height:  20; Description:  'C'),
     (X:   32; Y:   80; Width:  32; Height:  20; Description: 'TC'),
     (X:    0; Y:  100; Width:  32; Height:  20; Description:  'Z'),
     (X:   32; Y:  100; Width:  32; Height:  20; Description: 'TZ'),
     (X:    0; Y:  120; Width:  32; Height:  20; Description:  'L'),
     (X:   32; Y:  120; Width:  32; Height:  20; Description: 'TL'),
     (X:    0; Y:  140; Width:  32; Height:  20; Description:  'R'),
     (X:   32; Y:  140; Width:  32; Height:  20; Description: 'TR'),
     (X:    0; Y:  160; Width:  32; Height:  20; Description:  'A (focussed)'),
     (X:   32; Y:  160; Width:  32; Height:  20; Description: 'TA (focussed)'),
     (X:    0; Y:  180; Width:  32; Height:  20; Description:  'B (focussed)'),
     (X:   32; Y:  180; Width:  32; Height:  20; Description: 'TB (focussed)'),
     (X:    0; Y:  200; Width:  32; Height:  20; Description:  'X (focussed)'),
     (X:   32; Y:  200; Width:  32; Height:  20; Description: 'TX (focussed)'),
     (X:    0; Y:  220; Width:  32; Height:  20; Description:  'Y (focussed)'),
     (X:   32; Y:  220; Width:  32; Height:  20; Description: 'TY (focussed)'),
     (X:    0; Y:  240; Width:  32; Height:  20; Description:  'C (focussed)'),
     (X:   32; Y:  240; Width:  32; Height:  20; Description: 'TC (focussed)'),
     (X:    0; Y:  260; Width:  32; Height:  20; Description:  'Z (focussed)'),
     (X:   32; Y:  260; Width:  32; Height:  20; Description: 'TZ (focussed)'),
     (X:    0; Y:  280; Width:  32; Height:  20; Description:  'L (focussed)'),
     (X:   32; Y:  280; Width:  32; Height:  20; Description: 'TL (focussed)'),
     (X:    0; Y:  300; Width:  32; Height:  20; Description:  'R (focussed)'),
     (X:   32; Y:  300; Width:  32; Height:  20; Description: 'TR (focussed)'));

  SlicesPauseMenuLabels: array[0..4] of TUIFileSlice =
    ((X:    0; Y:    0; Width: 152; Height:  32; Description: 'Resume'),
     (X:    0; Y:   32; Width: 152; Height:  32; Description: 'Quit'),
     (X:    0; Y:   64; Width: 152; Height:  32; Description: 'Load'),
     (X:    0; Y:   96; Width: 152; Height:  32; Description: 'Save'),
     (X:    0; Y:  128; Width: 152; Height:  32; Description: 'Joystick'));

  SlicesBatteryStates: array[0..5] of TUIFileSlice =
    ((X:    0; Y:    0; Width:  60; Height:  24; Description: '1/5'),
     (X:    0; Y:   24; Width:  60; Height:  24; Description: '2/5'),
     (X:    0; Y:   48; Width:  60; Height:  24; Description: '3/5'),
     (X:    0; Y:   72; Width:  60; Height:  24; Description: '4/5'),
     (X:    0; Y:   96; Width:  60; Height:  24; Description: '5/5'),
     (X:    0; Y:  120; Width:  60; Height:  24; Description: 'Charging'));


  UIFiles: array[0..54] of TUIFile =
    ((Filename: 'sfcdr.cpl';  Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 0; Description: 'Main background';                                   IsLanguage: False; Slices: usNone),
     (Filename: 'mksh.rcv';   Format: idfRGB565;   FWidth:  640; FHeight:  288; Group: 0; Description: 'Search keyboard, default state';                    IsLanguage: False; Slices: usNone),
     (Filename: 'hlink.bvs';  Format: idfRGB565;   FWidth:  640; FHeight:  288; Group: 0; Description: 'Search keyboard, selected state';                   IsLanguage: False; Slices: usKeyboard),
     (Filename: 'dxva2.nec';  Format: idfRGB565;   FWidth:  640; FHeight:  288; Group: 0; Description: 'Search keyboard, pressed state';                    IsLanguage: False; Slices: usKeyboard),
     (Filename: 'fhshl.skb';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, English selected';              IsLanguage: False; Slices: usNone),
     (Filename: 't2act.sgf';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, Chinese selected';              IsLanguage: False; Slices: usNone),
     (Filename: 'tvctu.uby';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, Arabic selected';               IsLanguage: False; Slices: usNone),
     (Filename: 'vdaz5.bjk';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, Russian selected';              IsLanguage: False; Slices: usNone),
     (Filename: 'eknjo.ofd';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, Spanish selected';              IsLanguage: False; Slices: usNone),
     (Filename: 'lf9lb.cut';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, Portuguese selected';           IsLanguage: False; Slices: usNone),
     (Filename: 'bfrjd.odb';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'Language selection, Korean selected';               IsLanguage: False; Slices: usNone),
     (Filename: 'sgotd.cwt';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'TV system selection, NTSC selected';                IsLanguage: False; Slices: usNone),
     (Filename: 'snbqj.uby';  Format: idfRGB565;   FWidth:  640; FHeight:  280; Group: 0; Description: 'TV system selection, PAL selected';                 IsLanguage: False; Slices: usNone),
     (Filename: 'c1eac.pal';  Format: idfBGRA8888; FWidth:   26; FHeight:   22; Group: 1; Description: 'Selected language and TV system checkbox';          IsLanguage: False; Slices: usNone),
     (Filename: 'okcg2.old';  Format: idfBGRA8888; FWidth:   24; FHeight:   24; Group: 1; Description: 'Favorited game star';                               IsLanguage: False; Slices: usNone),
     (Filename: 'appvc.ikb';  Format: idfBGRA8888; FWidth:  150; FHeight:  214; Group: 1; Description: 'Thumbnail background';                              IsLanguage: False; Slices: usNone),
     (Filename: 'sdclt.occ';  Format: idfBGRA8888; FWidth:  424; FHeight:   58; Group: 1; Description: 'Selection background';                              IsLanguage: False; Slices: usNone),
     (Filename: 'ectte.bke';  Format: idfBGRA8888; FWidth: 1200; FHeight:  120; Group: 1; Description: 'Bottom tabs, default state';                        IsLanguage: False; Slices: usBottomTabs),
     (Filename: 'nvinf.hsp';  Format: idfBGRA8888; FWidth: 1200; FHeight:  120; Group: 1; Description: 'Bottom tabs, selected state';                       IsLanguage: False; Slices: usBottomTabs),
     (Filename: 'exaxz.hsp';  Format: idfBGRA8888; FWidth:  448; FHeight:  768; Group: 1; Description: 'Top left screen logos';                             IsLanguage: False; Slices: usTopLeftLogos),
     (Filename: 'mhg4s.ihg';  Format: idfRGB565;   FWidth:  400; FHeight:  192; Group: 1; Description: 'Message box background and buttons';                IsLanguage: False; Slices: usMessageBox),
     (Filename: 'zaqrc.olc';  Format: idfBGRA8888; FWidth:    8; FHeight:  224; Group: 1; Description: 'Message box left/right borders';                    IsLanguage: False; Slices: usMessageBoxBorders),
     (Filename: 'qasfc.bel';  Format: idfBGRA8888; FWidth:  328; FHeight:  224; Group: 2; Description: '"Favorites are full !" (maximum is 1000)';          IsLanguage: True;  Slices: usLanguage328x224),
     (Filename: 'urlkp.bvs';  Format: idfBGRA8888; FWidth:  328; FHeight:  224; Group: 2; Description: '"Remove from favorites?"';                          IsLanguage: True;  Slices: usLanguage328x224),
     (Filename: 'ucby4.aax';  Format: idfBGRA8888; FWidth:  448; FHeight:  224; Group: 2; Description: '"Folder is empty!"';                                IsLanguage: True;  Slices: usLanguage448x224),
     (Filename: 'xjebd.clq';  Format: idfBGRA8888; FWidth:  448; FHeight:  224; Group: 2; Description: '"No games match the keyword!"';                     IsLanguage: True;  Slices: usLanguage448x224),
     (Filename: 'qdbec.ofd';  Format: idfBGRA8888; FWidth:  240; FHeight:  168; Group: 2; Description: 'Top left title: DOWNLOAD ROMS';                     IsLanguage: True;  Slices: usLanguage240x168),
     (Filename: 'ouenj.dut';  Format: idfBGRA8888; FWidth:  240; FHeight:  168; Group: 2; Description: 'Top left title: FAVORITES';                         IsLanguage: True;  Slices: usLanguage240x168),
     (Filename: 'jsnno.uby';  Format: idfBGRA8888; FWidth:  240; FHeight:  168; Group: 2; Description: 'Top left title: HISTORY';                           IsLanguage: True;  Slices: usLanguage240x168),
     (Filename: 'ntrcq.oba';  Format: idfBGRA8888; FWidth:  240; FHeight:  168; Group: 2; Description: 'Top left title: SEARCH';                            IsLanguage: True;  Slices: usLanguage240x168),
     (Filename: 'dufdr.cwr';  Format: idfBGRA8888; FWidth:  240; FHeight:  168; Group: 2; Description: 'Top left title: SETTING';                           IsLanguage: True;  Slices: usLanguage240x168),
     (Filename: 'wtrxj.lbd';  Format: idfBGRA8888; FWidth:  192; FHeight:  224; Group: 2; Description: 'Settings screen subtitle: "LANGUAGE"';              IsLanguage: True;  Slices: usLanguage192x224),
     (Filename: 'bxvtb.sby';  Format: idfBGRA8888; FWidth:  192; FHeight:  224; Group: 2; Description: 'Settings screen subtitle: "TV SYSTEM"';             IsLanguage: True;  Slices: usLanguage192x224),
     (Filename: 'dism.cef';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 3; Description: 'Pause menu background, ''Resume'' selected';        IsLanguage: False; Slices: usNone),
     (Filename: 'd2d1.hgp';   Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 3; Description: 'Pause menu background, ''Quit'' selected';          IsLanguage: False; Slices: usNone),
     (Filename: 'bisrv.nec';  Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 3; Description: 'Pause menu background, ''Load'' selected';          IsLanguage: False; Slices: usNone),
     (Filename: 'pwsso.occ';  Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 3; Description: 'Pause menu background, ''Save'' selected';          IsLanguage: False; Slices: usNone),
     (Filename: 'gpapi.bvs';  Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 3; Description: 'Pause menu background, ''Joystick'' selected';      IsLanguage: False; Slices: usNone),
     (Filename: 'mczwq.ikb';  Format: idfRGB565;   FWidth:  640; FHeight:  336; Group: 3; Description: 'Device logos';                                      IsLanguage: False; Slices: usDeviceLogos),
     (Filename: 'dpskc.ctp';  Format: idfRGB565;   FWidth:  384; FHeight:  320; Group: 3; Description: 'Save states';                                       IsLanguage: False; Slices: usSaveStates),
     (Filename: 'hctml.ers';  Format: idfRGB565;   FWidth:  320; FHeight: 2256; Group: 3; Description: 'GB300 with different buttons highlighted';          IsLanguage: False; Slices: usGB300Buttons),
     (Filename: 'lk7tc.bvs';  Format: idfBGRA8888; FWidth:   52; FHeight:  192; Group: 4; Description: 'Button labels in the pause menu''s overview';       IsLanguage: False; Slices: usButtonLabels),
     (Filename: 'ztrba.nec';  Format: idfRGB565;   FWidth:   64; FHeight:  320; Group: 4; Description: 'Button names in selection popup menu';              IsLanguage: False; Slices: usButtonPopup),
     (Filename: 'wshrm.nec';  Format: idfBGRA8888; FWidth:  217; FHeight:   37; Group: 4; Description: 'Confirmation box, yes highlighted';                 IsLanguage: False; Slices: usNone),
     (Filename: 'igc64.dll';  Format: idfBGRA8888; FWidth:  217; FHeight:   37; Group: 4; Description: 'Confirmation box, no highlighted';                  IsLanguage: False; Slices: usNone),
     (Filename: 'kmbcj.acp';  Format: idfBGRA8888; FWidth:  288; FHeight:  448; Group: 5; Description: '"Archive already exists, overwrite this archive?"'; IsLanguage: True;  Slices: usLanguage288x448),
     (Filename: 'dsuei.cpl';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in English';                 IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'fixas.ctp';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in Chinese';                 IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'drivr.ers';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in Arabic';                  IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'icuin.cpl';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in Russian';                 IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'qwave.bke';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in Spanish';                 IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'xajkg.hsp';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in Portuguese';              IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'irftp.ctp';  Format: idfBGRA8888; FWidth:  152; FHeight:  160; Group: 5; Description: 'Pause menu item labels in Korean';                  IsLanguage: False; Slices: usPauseMenuLabels),
     (Filename: 'bttlve.kbp'; Format: idfBGRA8888; FWidth:   60; FHeight:  144; Group: 6; Description: 'Battery states';                                    IsLanguage: False; Slices: usBatteryStates),
     (Filename: 'jccatm.kbp'; Format: idfRGB565;   FWidth:  640; FHeight:  480; Group: 6; Description: 'Empty battery screen';                              IsLanguage: False; Slices: usNone));

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
      function GetName(): string;
    public
      Data: array of TUIObject;
      property Name: string read GetName;
      function GetPNG(): TPngImage;
      function ContainsImage(const FileName: string): Boolean;
  end;

var
  UIPreviews: array of TUIPreview;

procedure LoadUIPreviews(Stream: TStream);

var
  CurrentLanguage: Byte;

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
          UIPreviews[High(UIPreviews)].FName := XML.GetAttribute('Name');
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
  if Filename = 'sdclt.occ' then
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
  if IsLanguage and (SliceIndex < 0) then
  Self.SliceIndex := CurrentLanguage
  else
  Self.SliceIndex := SliceIndex;

  GetSlices(GetSliceFromSlices);
end;

procedure TUIFile.GetSliceFromSlices(const Slices: array of TUIFileSlice);
begin
  Slice := Slices[SliceIndex];
end;

procedure TUIFile.GetSlices(Callback: TSliceHandler);
begin
  case Slices of
    usNone:
      Callback([]);
    usKeyboard:
      Callback(SlicesKeyboard);
    usBottomTabs:
      Callback(SlicesBottomTabs);
    usTopLeftLogos:
      Callback(SlicesTopLeftLogos);
    usMessageBox:
      Callback(SlicesMessageBox);
    usMessageBoxBorders:
      Callback(SlicesMessageBoxBorders);
    usLanguage328x224:
      Callback(SlicesLanguage328x224);
    usLanguage448x224:
      Callback(SlicesLanguage448x224);
    usLanguage240x168:
      Callback(SlicesLanguage240x168);
    usLanguage192x224:
      Callback(SlicesLanguage192x224);
    usLanguage288x448:
      Callback(SlicesLanguage288x448);
    usDeviceLogos:
      Callback(SlicesDeviceLogos);
    usSaveStates:
      Callback(SlicesSaveStates);
    usGB300Buttons:
      Callback(SlicesGB300Buttons);
    usButtonLabels:
      Callback(SlicesButtonLabels);
    usButtonPopup:
      Callback(SlicesButtonPopup);
    usPauseMenuLabels:
      Callback(SlicesPauseMenuLabels);
    usBatteryStates:
      Callback(SlicesBatteryStates);
  end;
end;

function TUIFile.GetWidth: Word;
begin
  if Filename = 'appvc.ikb' then
  Result := Foldername.ThumbnailSize.X + 6
  else
  if Filename = 'sdclt.occ' then
  Result := Foldername.SelectionSize.X
  else
  Result := FWidth;
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
    if (Index <= 7) and (Index >= 0) then
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
  AddFontRes := AddFontResourceExW(PWideChar(IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + 'yahei_Arial.ttf'), FR_PRIVATE, nil);
  OwnsFontResource := True;
  if AddFontRes > 0 then
  begin
    SetLength(LogFont, AddFontRes);
    lfsz := AddFontRes * SizeOf(TLogFontW);
    if not GetFontResourceInfo(PWideChar(IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + 'yahei_Arial.ttf'), lfsz, @LogFont[0], 2) then
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
              if UIF.IsLanguage then
              UIF.GetSlice(CurrentLanguage)
              else
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
            SetTextCharacterExtra(Result.Canvas.Handle, 1);
            Result.Canvas.Font.Height := Obj.S;
            Result.Canvas.Font.Color := Obj.C;
            Result.Canvas.Font.Quality := TFontQuality.fqAntialiased; // disable ClearType
            Result.Canvas.Brush.Style := bsClear; // disable image background
            r.Left := Obj.X;
            r.Top := Obj.Y;
            r.Width := 640;
            r.Height := 480;
            s := Obj.D + #13#10;
            Result.Canvas.TextRect(r, Obj.X, Obj.Y, s);
            //Result.Canvas.TextOut(Obj.X, Obj.Y, Obj.D + #13#10);
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
    RemoveFontResourceW(PWideChar(IncludeTrailingPathDelimiter(GB300Utils.Path + 'Resources') + 'yahei_Arial.ttf'));
  end;
end;

{ TUIObject }

function TUIObject.GetC: TColor;
begin
  if FC >= Low(Foldername.SelectedColors) then
  if FC <= High(Foldername.SelectedColors) then
  Exit(Foldername.SelectedColors[FC]);
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

end.
