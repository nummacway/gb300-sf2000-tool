unit GB300Utils;

interface

uses
  SysUtils, Classes, Graphics, pngimage, Windows, Generics.Collections,
  inifiles;

type
  TCurrentDevice = (cdGB300, cdSF2000);

var
  Path: string; // must include trailing backslash
  CurrentDevice: TCurrentDevice;

const
  UserROMsFolderIndex = 0;
  FCFolderIndex = 1; // for the feature that converts NFC to NES
  ArcadeFolderIndex = 7; // where ZIP is launched with FBA

type
  TImageDataFormat = (idfRGB565, idfBGRA8888);

procedure GetDIBStreamFromStream(Input, Output: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0); overload;
function  GetDIBStreamFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TMemoryStream; overload;
function  GetDIBImageFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TWICImage;
function  GetPNGImageFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TPngImage;
procedure WriteGraphicToStream(Input: TGraphic; Output: TStream; Format: TImageDataFormat; ExpectedWidth, ExpectedHeight: Integer; ExpectAlpha: Boolean);
function  GetFileSize(const FileName: string): Int64;
function  SwapColor(Color: TColor): TColor; // LE to BE
procedure AutoScaleThumbnail(Picture: TPicture);


type
  TStreamHelper = class helper for TStream
    function CopyFrom2(const Source: TStream; Count: Int64 = 0; BufferSize: Integer = $100000): Int64; // CopyFrom() that can handle Count 0 like you think it would
    {$IF CompilerVersion < 24.0}
    // Port of trivial functions added in XE3 (not sure about the writer functions, which are more important, because you can only pass symbols but not expressions to Write)
    procedure ReadData(var Buffer: ShortInt); overload;
    procedure ReadData(var Buffer: Byte); overload;
    procedure ReadData(var Buffer: SmallInt); overload;
    procedure ReadData(var Buffer: Word); overload;
    procedure ReadData(var Buffer: Integer); overload;
    procedure ReadData(var Buffer: Cardinal); overload;
    procedure ReadData(var Buffer: AnsiChar); overload;
    procedure WriteData(const Buffer: ShortInt); overload;
    procedure WriteData(const Buffer: Byte); overload;
    procedure WriteData(const Buffer: SmallInt); overload;
    procedure WriteData(const Buffer: Word); overload;
    procedure WriteData(const Buffer: Integer); overload;
    procedure WriteData(const Buffer: Cardinal); overload;
    {$IFEND}
  end;

  // This is either 22.0 or 23.0
  {$IF CompilerVersion < 23.0}
  TStringsHelper = class helper for TStrings
    procedure SaveToFileNoBOM(const FileName: string; Encoding: TEncoding);
    procedure SaveToStreamNoBOM(Stream: TStream; Encoding: TEncoding);
  end;
  {$IFEND}

  // The ZIP records are a simple ZIP reader/writer. TZipFile, introduced in XE2, seems to be an overkill too unflexible for this project.
  // They support the obfuscated form of the header used by the GB300 and similar devices.

  TDOSDateTime = packed record
    private
      function GetAsDateTime: TDateTime;
      procedure SetAsDateTime(const Value: TDateTime);
    public
      property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
      var
      case Boolean of
        False:
        (
          LastModFileTime: Word;
          LastModFileDate: Word;
        );
        True:
        (
          LastModFileDateTime: Cardinal;
        );
  end;

  TZipLocalHeader = packed record
    private
      MagicNumber: Cardinal;
    public
      VersionNeededToExtract: Word;
      GeneralPurposeBitFlag: Word;
      CompressionMethod: Word;
      LastModFileDateTime: TDOSDateTime;
      CRC32: Cardinal;
      CompressedSize: Cardinal;
      UncompressedSize: Cardinal;
    private
      FileNameLength: Word;
      ExtraFieldLength: Word;
    public
      FileName: string;
      ExtraField: RawByteString;
      function LoadFromStream(Stream: TStream): Boolean;
      procedure SaveToStream(Stream: TStream);
      procedure Init();
  end;

  TZipCentralDirectory = packed record
    private
      MagicNumber: Cardinal;
    public
      VersionMadeBy: Word;
      VersionNeededToExtract: Word;
      GeneralPurposeBitFlag: Word;
      CompressionMethod: Word;
      LastModFileDateTime: TDOSDateTime;
      CRC32: Cardinal;
      CompressedSize: Cardinal;
      UncompressedSize: Cardinal;
    private
      FileNameLength: Word;
      ExtraFieldLength: Word;
      FileCommentLength: Word;
    public
      DiskNumberStart: Word;
      InternalFileAttributes: Word;
      ExternalFileAttributes: Cardinal;
      RelativeOffsetOfLocalHeader: Cardinal;
      FileName: string;
      ExtraField: RawByteString;
      FileComment: string;
      procedure Assign(LocalHeader: TZipLocalHeader);
      procedure LoadFromStream(Stream: TStream);
      procedure SaveToStream(Stream: TStream);
      procedure Init();
  end;

  TZipEndOfCentralDirectory = packed record
    private
      MagicNumber: Cardinal;
    public
      NumberOfThisDisk: Word;
      NumberOfTheDiskWithTheStartOfTheCentralDirectory: Word;
      TotalNumberOfEntriesInTheCentralDirectoryOnThisDisk: Word;
      TotalNumberOfEntriesInTheCentralDirectory: Word;
      SizeOfTheCentralDirectory: Cardinal;
      OffsetOfStartOfTheCentralDirectoryWithRespectToTheStartingDiskNumber: Cardinal;
    strict private
      ZIPFileCommentLength: Word;
    public
      ZIPFileComment: RawByteString;
      procedure LoadFromStream(Stream: TStream);
      procedure SaveToStream(Stream: TStream);
      procedure Init();
  end;

  TScreenIndex = (siUnmatched = -1, siGB300, siSF2000);

  TBIOS = class (TBytesStream) // TBytesStream is needed for CRC-32 calculation
    private
      function GetCalculatedCRC(): Cardinal;
      function GetStoredCRC(): Cardinal;
      procedure SetStoredCRC(Value: Cardinal);
      function GetBootLogo: TGraphic;
      procedure SetBootLogo(Value: TGraphic);
      function GetIsCRCValid: Boolean;
      class function GetPath: string; static;
      {function GetVT03: Boolean;
      function GetVT03LUT565: Boolean;
      procedure SetVT03LUT565(const Value: Boolean);
      function GetFDS: Boolean;
      procedure SetFDS(const Value: Boolean);          }
      function Match(Resource: Word; Offset: Int64): Boolean;
      procedure DoPatch(Resource: Word; Offset: Int64);
      function GetSizeSupported: TCurrentDevice; overload;
      function GetBootLogoOffset: Integer;
      function GetBootLogoHeight: Integer;
      function GetBootLogoWidth: Integer;
      function GetGaroupP2SizeOffset: Integer;
      function GetGaroupP2Size: Integer;
      procedure SetGaroupP2Size(const Value: Integer);
    public
      property StoredCRC: Cardinal read GetStoredCRC write SetStoredCRC;
      property CalculatedCRC: Cardinal read GetCalculatedCRC;
      property BootLogo: TGraphic read GetBootLogo write SetBootLogo; // needs to be freed by caller
      property IsCRCValid: Boolean read GetIsCRCValid;
      procedure SaveBootLogoToStream(Stream: TStream);
      class property Path: string read GetPath;
      {property VT03: Boolean read GetVT03;
      property VT03LUT565: Boolean read GetVT03LUT565 write SetVT03LUT565;
      property FDS: Boolean read GetFDS write SetFDS;    }
      class procedure Patch(Resource: Word; Offset: Int64);
      property SizeSupported: TCurrentDevice read GetSizeSupported;
      class function GetSizeSupported(Size: Integer): TCurrentDevice; overload;
      property BootLogoOffset: Integer read GetBootLogoOffset;
      property BootLogoWidth: Integer read GetBootLogoWidth;
      property BootLogoHeight: Integer read GetBootLogoHeight;
      property GaroupP2SizeOffset: Integer read GetGaroupP2SizeOffset;
      property GaroupP2Size: Integer read GetGaroupP2Size write SetGaroupP2Size;
      const
        CRCOffset = $18c;
        //DisplayInitOffset = $6cbfa4; // not currently used; we're starting 2 bytes early because the init code basically starts there
        //VT03Offset = $319a30; // not currently used
        //VT03LUTOffset = $62270; // not currently used
        //SearchResultSelColorOffset = $6cec30; // not currently used
        //FDSOffset = $34f170; // not currently used
  end;

  TFoldername = record
    private
      function GetAbsoluteFolder(Index: Byte): string;
    public
      const
        Header = 'SF2000';
      var
        Languages: Integer;
        DefaultColor: TColor;
        SelectedColors: array[0..9] of TColor;
        Folders: array[0..9] of string;
        TabCount: Integer;
        InitialLeftTab: Integer;
        UserSettingsTab: Integer;
        ThumbnailPosition: TPoint;
        ThumbnailSize: TPoint;
        SelectionSize: TPoint;
        procedure LoadFromFile();
        procedure SaveToFile();
        function GetTabName(Index: Byte): string;
        property AbsoluteFolder[Index: Byte]: string read GetAbsoluteFolder;
        procedure ForceAllDirectories();
  end;

  TFileType = (ftUnknown = -1, ftFC, ftPCE, ftSFC, ftMD, ftGB, ftGBA, ftCompressed, ftThumbnailed);

  TMultiCoreName = record
    Core: string;
    Name: string;
    AbsoluteFileName: string;
  end;

  TROMFile = class
    private
      FIsCompressed: Boolean;
      FHasImage: Boolean;
      FIsFinalBurn: Boolean;
      FROMName: string;
      FFileName: string;
      FStream: TMemoryStream;
      function GetROM: TBytesStream;
      function GetThumbnail: TGraphic;
      procedure SetThumbnail(const Value: TGraphic);
      function GetROMFileName: string;
      function GetFinalBurnTarget: string;
      function GetHeader: TZipLocalHeader;
      function GetThumbnailSize: Integer;
      class function GetDefaultThumbnailSize: Integer; static;
      function GetIsMultiCore: Boolean; overload;
      function GetMCName: TMulticoreName; overload;
      type FourCharString = packed array[1..4] of AnsiChar;
    public
      property HasImage: Boolean read FHasImage;
      property IsCompressed: Boolean read FIsCompressed;
      property IsFinalBurn: Boolean read FIsFinalBurn;
      property Thumbnail: TGraphic read GetThumbnail write SetThumbnail; // needs to be freed by caller
      procedure SaveThumbnailToStreamDIB(Stream: TStream);
      function GetThumbnailAsPNG(): TPNGImage;
      procedure Compress(const Lead: Integer);
      procedure MakeFinalBurn(); deprecated;
      procedure Decompress();
      property ROMFileName: string read GetROMFileName;
      //property FileName: string read FFileName;
      property MCName: TMulticoreName read GetMCName;
      property FinalBurnTarget: string read GetFinalBurnTarget;
      class function GetMCName(FN: string): TMulticoreName; overload;
      property IsMultiCore: Boolean read GetIsMultiCore;
      class function GetIsMultiCore(FN: string): Boolean; overload;
      property ROM: TBytesStream read GetROM; // needs to be freed by caller
      procedure SetROM(Value: TStream; const Name: string);
      procedure LoadFromFile(FolderIndex: Byte; FileName: string);
      procedure SaveToFile(FolderIndex: Byte; FileName: string; SaveStubIfMC: Boolean);
      property ThumbnailSize: Integer read GetThumbnailSize;
      constructor Create();
      constructor CreateFinalBurn(FN: string);
      destructor Destroy(); override;
      class function FileNameToType(const FileName: string): TFileType;
      class function FileNameToImageIndex(const FileName: string): Integer;
      class function FileTypeToFilter(FileType: TFileType; AllFiles: Boolean): string;
      class function FileTypeToThumbExt(FileType: TFileType): string;
      class procedure PatchIPS(ROM: TStream; PatchFile: string);
      class function PatchBPS(ROM: TBytesStream; PatchFile: string): TBytesStream;
      class function UnUNIF(ROM: TMemoryStream): TPoint; // converts UNIF to raw NES; needs TMemoryStream because other streams are not guaranteed to be able to become smaller (which they will in this method); returns PRG (X) and CHR (Y) size
      procedure Patch(PatchFile: string);
      class function GetROMsIn(FolderIndex: Byte): TList<string>;
      function GetCRC: Cardinal;
      class function RenameRelated(FolderIndex: Byte; OldFileName, NewFileName: string): Boolean;
      function ChangeExt(const OldExtWithDot, NewExtWithDot: FourCharString): Boolean;
      procedure CopyThumbnail(Source: TROMFile);
  end;

  TState = class (TMemoryStream)
    function GetScreenshot: TPngImage; // PNG
    function GetScreenshotData(var Dimensions: TPoint): TMemoryStream; // no header
    procedure SaveScreenshotToStream(Stream: TStream); // DIB
    procedure SaveStateToStream(const StateFileName: string; Stream: TStream);
    procedure WriteStateFromStream(const StateFileName: string; Stream: TStream); // also saves the state to disk
    constructor CreateStateFromStream(const StateFileName: string; Stream: TStream; Height, Width: Integer; IsUncompressed: Boolean); // also saves the state to disk
    class function GetMCStateFileName(const StateFileName: string): string; overload;
    class function GetMCStateFileName(ROMFileName: string; Index: Integer): string; overload;
  end;

  TNameList = class (TList<string>)
    procedure LoadFromFile(RelativeFilename: string);
    procedure SaveToFile(const RelativeFilename: string);
  end;

  TNameLists = class
    FileNames: TNameList;
    ChineseNames: TNameList;
    PinyinNames: TNameList;
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFiles(const FolderIndex: Byte);
    procedure SaveToFiles(const FolderIndex: Byte);
    procedure Add(const FileName, ChineseName, PinyinName: string);
    procedure Insert(Index: Integer; const FileName, ChineseName, PinyinName: string);
    procedure Delete(Index: Integer);
  end;

  TReferenceFileName = (rfFavorites, rfHistory);

  TReference =  record
    FileIndex: Word;
    FolderIndex: Word;
    FileName: string;
  end;

  TReferenceList = class (TList<TReference>)
    procedure LoadFromFile(RelativeFilename: string); overload;
    procedure LoadFromFile(RelativeFilename: string; FileNames: TObjectList<TNameList>); overload;
    class function GetFileNames(): TObjectList<TNameList>;
    procedure SaveToFile(const RelativeFilename: string); overload;
    procedure SaveToFile(FileName: TReferenceFileName); overload;
    function Apply(FileNameList: TNameList; FolderIndex: Byte): Boolean; // supports moving and deleting in static lists (appending is not required because it will not change anything)
    function Rename(FolderIndex: Byte; OldFileName: string; NewFileName: string): Boolean;
    function ContainsFile(FolderIndex: Byte; FileName: string): Boolean;
    function AddFile(FolderIndex: Byte; FileName: string): Boolean;
    procedure RemoveFile(FolderIndex: Byte; FileName: string);
  end;

  TNoIntro = record
    public
      CRC32: Cardinal;
    private
      FGameID: SmallInt;
      FLength: Byte;
      function GetGameID(): Word;
      function GetIsVerified(): Boolean;
    public
      property GameID: Word read GetGameID;
      property IsVerified: Boolean read GetIsVerified;
    public
      Name: AnsiString;
      procedure LoadFromStream(Stream: TStream);
  end;

const
                                                // ROMS         FC           SFC          MD           GB           GBC          GBA          ARCADE       PCE
  FileNamesFilenames:    array[0..8] of string = ('tsmfk.tax', 'rdbui.tax', 'urefs.tax', 'scksp.tax', 'vdsdc.tax', 'pnpui.tax', 'vfnet.tax', 'mswb7.tax', 'kjbyr.tax');
  ChineseNamesFilenames: array[1..8] of string =              ('fhcfg.nec', 'adsnt.nec', 'setxa.nec', 'umboa.nec', 'wjere.nec', 'htuiw.nec', 'msdtc.nec', 'djoin.nec');
  PinyinNamesFilenames:  array[1..8] of string =              ('nethn.bvs', 'xvb6c.bvs', 'wmiui.bvs', 'qdvd6.bvs', 'mgdel.bvs', 'sppnp.bvs', 'mfpmp.bvs', 'ke89a.bvs');

  DefaultFoldernameGB300: TFoldername =
    (Languages: 17;
     DefaultColor: clWhite;
     SelectedColors: ($c424ff, $1bdb68, $12a3ff, $ec7501, $eaa617, $ec7501, $c73185, $eaa617, $123fff, $80ff);
     Folders: ('ROMS', 'FC', 'SFC', 'MD', 'GB', 'GBC', 'GBA', 'ARCADE', 'PCE', 'ROMS');
     TabCount: 9;
     InitialLeftTab: 7;
     UserSettingsTab: 0;
     ThumbnailPosition: (X: 24; Y: 184);
     ThumbnailSize: (X: 144; Y: 208);
     SelectionSize: (X: 40; Y: 24));

  DefaultFoldernameSF2000: TFoldername =
    (Languages: 17;
     DefaultColor: clWhite;
     SelectedColors: ($80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff);
     Folders: ('ROMS', 'FC', 'SFC', 'MD', 'GB', 'GBC', 'GBA', 'ARCADE', 'ROMS', 'ROMS');
     TabCount: 8;
     InitialLeftTab: 7;
     UserSettingsTab: 0;
     ThumbnailPosition: (X: 24; Y: 184);
     ThumbnailSize: (X: 144; Y: 208);
     SelectionSize: (X: 40; Y: 24));

  ExtensionsFC          = '*.fds;*.nes;*.unf;*.nfc';
  ExtensionsPCE         = '*.pce';
  ExtensionsSFC         = '*.smc;*.fig;*.sfc;*.gd3;*.gd7;*.dx2;*.bsx;*.swc';
  ExtensionsMD          = '*.bin;*.gen;*.smd;*.md;*.sms';
  ExtensionsGB          = '*.gb;*.gbc;*.sgb';
  ExtensionsGBA         = '*.gba;*.agb;*.gbz';
  ExtensionsCompressed  = '*.zip;*.bkp;*.zfb';
  ExtensionsThumbnailed = '*.zfc;*.zpc;*.zsf;*.zmd;*.zgb';

  ExtensionsROMs = ExtensionsFC         + ';' +
                   ExtensionsPCE        + ';' +
                   ExtensionsSFC        + ';' +
                   ExtensionsMD         + ';' +
                   ExtensionsGB         + ';' +
                   ExtensionsGBA;
  Extensions = ExtensionsFC         + ';' +
               ExtensionsPCE        + ';' +
               ExtensionsSFC        + ';' +
               ExtensionsMD         + ';' +
               ExtensionsGB         + ';' +
               ExtensionsGBA        + ';' +
               ExtensionsCompressed + ';' +
               ExtensionsThumbnailed;

var
  Foldername: TFoldername;
  Favorites: TReferenceList = nil;
  History: TReferenceList = nil;
  ShowChineseNames: Boolean;
  UsePrettyGameNames: Boolean;
  UseZFBForMulticore: Boolean;
  UseMaxCompression: Boolean;
  HasMulticore: Boolean;
  HasGaroupPatch: Boolean;
  NoIntro: TDictionary<Cardinal, TNoIntro> = nil;
  INI: TIniFile;

implementation

uses
  Zlib, DateUtils, System.Types, StrUtils, GraphUtil, Math, AnsiStrings;

procedure GetDIBStreamFromStream(Input, Output: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0); overload;
var
  Header: BITMAPFILEHEADER;
  Info: BITMAPINFOHEADER;
begin
  if (Width mod 2 = 1) and (Format = idfRGB565) then
  raise EInvalidGraphicOperation.Create('Due to the DIB stream format, only an even width is supported for RGB565.');

  // Create base header
  Header.bfType := $4D42;
  case Format of
    idfRGB565:
      Header.bfOffBits := 66; // bfOffBits <> 54 does not load properly in Delphi's TBitmap, so TWICImage must be used
    idfBGRA8888:
      Header.bfOffBits := 54;
  end;
  Info.biSize := SizeOf(BITMAPINFOHEADER);

  // Collect basic image information
  case Format of
    idfRGB565:
      Info.biBitCount := 16;
    idfBGRA8888:
      Info.biBitCount := 32;
  end;

  Info.biWidth := Width;
  if Height = 0 then
  Info.biHeight := -((Input.Size - Input.Position) * 8 div (Info.biWidth * Info.biBitCount))
  else
  Info.biHeight := -Height; // negative -> read from top to bottom

  Info.biPlanes := 1;
  case Format of
    idfRGB565: Info.biCompression := BI_BITFIELDS;
    idfBGRA8888: Info.biCompression := BI_RGB;
  end;
  // Most of this stuff is unimportant
  Info.biSizeImage := Info.biWidth * Abs(Info.biHeight) * Info.biBitCount div 8;
  Info.biXPelsPerMeter := 0;
  Info.biYPelsPerMeter := 0;
  Info.biClrUsed := 0;
  Info.biClrImportant := 0;
  Header.bfSize := Header.bfOffBits + Info.biSizeImage;
  Header.bfReserved1 := 0;
  Header.bfReserved2 := 0;

  // Write output
  Output.Write(Header, SizeOf(BITMAPFILEHEADER));
  Output.Write(Info, SizeOf(BITMAPINFOHEADER));
  if Format = idfRGB565 then
  begin
    Output.WriteData(Integer($F800));
    Output.WriteData(Integer($07E0));
    Output.WriteData(Integer($001F));
  end;
  Output.CopyFrom2(Input, Info.biSizeImage); // this requires the bytes per row to be divisable by 4
end;

function GetDIBStreamFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TMemoryStream; overload;
begin
  Result := TMemoryStream.Create();
  try
    GetDIBStreamFromStream(Input, Result, Format, Width, Height);
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
end;

function GetDIBImageFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TWICImage;
var
  MS: TMemoryStream;
begin
  MS := GetDIBStreamFromStream(Input, Format, Width, Height);
  try
    MS.Position := 0;
    Result := TWICImage.Create();
    try
      Result.LoadFromStream(MS);
    except
      try
        Result.Free();
      except
      end;
      raise;
    end;
  finally
    MS.Free();
  end;
end;

function GetPNGImageFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TPngImage;
var
  x, y: Integer;
  RGB565: Word;
  BGRA8888: Cardinal;
  Scanline, AlphaScanline: pByteArray;
begin
  // Calculate height if none is set
  if Height = 0 then
  case Format of
    idfRGB565:
      Height := (Input.Size - Input.Position) div Width div 2;
    idfBGRA8888:
      Height := (Input.Size - Input.Position) div Width div 4;
  end;

  if Format = idfRGB565 then
  Result := TPngImage.CreateBlank(COLOR_RGB, 8, Width, Height)
  else
  Result := TPngImage.CreateBlank(COLOR_RGBALPHA, 8, Width, Height);
  try
    case Format of
      idfRGB565:
        for y := 0 to Height - 1 do
        begin
          Scanline := Result.Scanline[y];
          for x := 0 to Width - 1 do
          begin
            Input.ReadData(RGB565);
            Scanline^[x*3  ] := Round(((RGB565       ) and 31) * 255e0 / 31);
            Scanline^[x*3+1] := Round(((RGB565 shr  5) and 63) * 255e0 / 63);
            Scanline^[x*3+2] := Round(((RGB565 shr 11)       ) * 255e0 / 31);
          end;
        end;
      idfBGRA8888:
        for y := 0 to Height - 1 do
        begin
          Scanline := Result.Scanline[y];
          AlphaScanline := Result.AlphaScanline[y];
          for x := 0 to Width - 1 do
          begin
            Input.ReadData(BGRA8888);
            Scanline^[x*3+2] := Byte(BGRA8888 shr 16);
            Scanline^[x*3+1] := Byte(BGRA8888 shr 8);
            Scanline^[x*3  ] := Byte(BGRA8888 shr 0);
            AlphaScanline^[x] := Byte(BGRA8888 shr 24);
          end;
        end;
    end;
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
end;

procedure WriteGraphicToStream(Input: TGraphic; Output: TStream; Format: TImageDataFormat; ExpectedWidth, ExpectedHeight: Integer; ExpectAlpha: Boolean);
function PrepareImage(): Boolean;
var
  Temp: TPNGImage;
begin
  if (Format = idfBGRA8888) and ExpectAlpha then
  begin
    // _Original_ input must be readible.
    if Input is TPngImage then
    begin
      if (Input as TPngImage).Header.BitDepth <> 8 then
      raise EInvalidGraphic.CreateFmt('The image you are trying to replace requires input from a PNG image with an 8-bit alpha channel, but this is a %d-bit image.', [(Input as TPngImage).Header.BitDepth]);

      if (Input as TPngImage).TransparencyMode <> ptmPartial then
      raise EInvalidGraphic.Create('The image you are trying to replace requires input from a PNG image with an 8-bit alpha channel, but it doesn''t have an alpha channel.');

      Exit(False);  // PNG files with 8-bit alpha are fine
    end
    else
    raise EInvalidGraphic.Create('The image you are trying to replace requires input from a PNG image with an 8-bit alpha channel, but this isn''t a PNG image.');
  end;

  //if Input is TPngImage then
  //if (Input as TPngImage).Header.BitDepth = 8 then
  //Exit(False);

  Temp := TPngImage.CreateBlank(COLOR_RGB, 8, ExpectedWidth, ExpectedHeight);
  try
    Temp.Canvas.Draw(0, 0, Input);
    Input := Temp;
    Exit(True);
  except
    try
      Temp.Free();
    except
    end;
    raise;
  end;
end;
var
  OwnsInput: Boolean;
  PNG: TPngImage;
  x, y: Integer;
  Scanline, AlphaScanline: pByteArray;
begin
  if (ExpectedWidth <> Input.Width) or (ExpectedHeight <> Input.Height) then
  raise EInvalidGraphic.CreateFmt('Unexpected width or height (%d×%d instead of %d×%d).', [Input.Width, Input.Height, ExpectedWidth, ExpectedHeight]);

  OwnsInput := PrepareImage();
  try
    PNG := Input as TPngImage;
    case Format of
      idfRGB565:
        for y := 0 to ExpectedHeight - 1 do
        begin
          Scanline := PNG.Scanline[y];
          for x := 0 to ExpectedWidth - 1 do
          Output.WriteData(Word(
            (Round(Scanline^[x*3+2] * 31e0 / 255) shl 11) or
            (Round(Scanline^[x*3+1] * 63e0 / 255) shl 5) or
            (Round(Scanline^[x*3  ] * 31e0 / 255))));
        end;
      idfBGRA8888:
        case PNG.Header.ColorType of
          COLOR_RGB:
            for y := 0 to ExpectedHeight - 1 do
            begin
              Scanline := PNG.Scanline[y];
              for x := 0 to ExpectedWidth - 1 do
              begin
                Output.WriteData(Scanline^[x*3  ]);
                Output.WriteData(Scanline^[x*3+1]);
                Output.WriteData(Scanline^[x*3+2]);
                Output.WriteData(Byte(255));
              end;
            end;
          COLOR_RGBALPHA:
            for y := 0 to ExpectedHeight - 1 do
            begin
              Scanline := PNG.Scanline[y];
              AlphaScanline := PNG.AlphaScanline[y];
              for x := 0 to ExpectedWidth - 1 do
              begin
                Output.WriteData(Scanline^[x*3  ]);
                Output.WriteData(Scanline^[x*3+1]);
                Output.WriteData(Scanline^[x*3+2]);
                Output.WriteData(AlphaScanline^[x]);
              end;
            end;
          COLOR_GRAYSCALEALPHA:
            for y := 0 to ExpectedHeight - 1 do
            begin
              Scanline := PNG.Scanline[y];
              AlphaScanline := PNG.AlphaScanline[y];
              for x := 0 to ExpectedWidth - 1 do
              begin
                Output.WriteData(Scanline^[x]);
                Output.WriteData(Scanline^[x]);
                Output.WriteData(Scanline^[x]);
                Output.WriteData(AlphaScanline^[x]);
              end;
            end;
        end;
    end;
  finally
    if OwnsInput then
    Input.Free();
  end;
end;

function IsAscii(s: string): Boolean;
var
  c: Char;
begin
  for c in s do
  if (Ord(c) and $ff80) <> 0 then
  Exit(False);
  Result := True;
end;

function GetFileSize(const FileName: string): Int64;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    try
      Result := FileStream.Size;
    except
      Result := 0;
    end;
  finally
    FileStream.Free;
  end;
end;

function SwapColor(Color: TColor): TColor;
begin
  Color := Color and $ffffff;
  Result := (Color shr 16) or (Color and $ff00) or ((Color and $ff) shl 16);
end;

procedure AutoScaleThumbnail(Picture: TPicture);
var
  PNG: TPNGImage;
  BMP, BMP2: Graphics.TBitmap;
begin
  if (Picture.Width <> Foldername.ThumbnailSize.X) or (Picture.Height <> Foldername.ThumbnailSize.Y) then
  begin
    PNG := TPNGImage.CreateBlank(COLOR_RGB, 8, Picture.Width, Picture.Height);
    try
      PNG.Canvas.Draw(0,0,Picture.Graphic);
      BMP := Graphics.TBitmap.Create();
      try
        PNG.AssignTo(BMP);
        BMP2 := Graphics.TBitmap.Create();
        try
          ScaleImage(BMP, BMP2, Max(Foldername.ThumbnailSize.X / BMP.Width, Foldername.ThumbnailSize.Y / BMP.Height));
          PNG.SetSize(Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y);
          PNG.Canvas.Draw((Foldername.ThumbnailSize.X - BMP2.Width) div 2, (Foldername.ThumbnailSize.Y - BMP2.Height) div 2, BMP2);
          Picture.Graphic.Assign(PNG);
        finally
          BMP2.Free();
        end;
      finally
        BMP.Free();
      end;
    finally
      PNG.Free();
    end;
  end;
end;

{ TStreamHelper }

function TStreamHelper.CopyFrom2(const Source: TStream; Count: Int64; BufferSize: Integer): Int64;
begin
  if Count > 0 then
  Result := CopyFrom(Source, Count, BufferSize)
  else
  Result := 0;
end;


{$IF CompilerVersion < 24.0}
procedure TStreamHelper.ReadData(var Buffer: ShortInt);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.ReadData(var Buffer: Byte);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.ReadData(var Buffer: SmallInt);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.ReadData(var Buffer: Word);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.ReadData(var Buffer: Integer);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.ReadData(var Buffer: Cardinal);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.ReadData(var Buffer: AnsiChar);
begin
  Read(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.WriteData(const Buffer: ShortInt);
begin
  Write(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.WriteData(const Buffer: Byte);
begin
  Write(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.WriteData(const Buffer: SmallInt);
begin
  Write(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.WriteData(const Buffer: Word);
begin
  Write(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.WriteData(const Buffer: Integer);
begin
  Write(Buffer, SizeOf(Buffer));
end;

procedure TStreamHelper.WriteData(const Buffer: Cardinal);
begin
  Write(Buffer, SizeOf(Buffer));
end;
{$IFEND}

{ TBIOS }

procedure TBIOS.DoPatch(Resource: Word; Offset: Int64);
var
  RS: TResourceStream;
begin
  RS := TResourceStream.CreateFromID(HInstance, Resource, RT_RCDATA);
  try
    Self.Position := Offset;
    Self.CopyFrom(RS);
    Self.StoredCRC := Self.CalculatedCRC;
  finally
    RS.Free();
  end;
end;

function TBIOS.GetBootLogo: TGraphic;
begin
  Position := BootLogoOffset;
  Result := GetDIBImageFromStream(Self, idfRGB565, BootLogoWidth, BootLogoHeight);
end;

function TBIOS.GetBootLogoHeight: Integer;
begin
  if CurrentDevice = cdGB300 then
  Result := 249
  else
  Result := 200;
end;

function TBIOS.GetBootLogoOffset: Integer;
begin
  if CurrentDevice = cdGB300 then
  case Size of
    12951332: Result := 10577116-248*2;
    12949540: Result := 10577116-248*2+$a15cde-$A163D6;
    else raise Exception.Create('GB300+SF2000 Tool does not know this BIOS size''s boot logo offset');
  end
  else
  case Size of
    12624628: Result := $9B3618; // 1.71
    12624436: Result := $9B3530; // 1.6 (incl. multicore)
    else raise Exception.Create('GB300+SF2000 Tool does not know this BIOS size''s boot logo offset (only BIOS v1.71 and v1.6 (multicore) are supported)');
  end;
end;

function TBIOS.GetBootLogoWidth: Integer;
begin
  if CurrentDevice = cdGB300 then
  Result := 248
  else
  Result := 512;
end;

function TBIOS.GetCalculatedCRC: Cardinal;
var
  i, j: Cardinal;
  tabCRC32: array[0..255] of Cardinal;
begin
  for i := 0 to 255 do
  begin
    Result := i shl 24;
    for j := 0 to 7 do
    if Result and (1 shl 31) <> 0 then
    Result := (Result shl 1) xor $4c11db7
    else
    Result := Result shl 1;
    tabCRC32[i] := Result;
  end;

  Result := $ffffffff;
  for i := 512 to Self.Size - 1 do
  begin
    Result := (Result shl 8) xor tabCRC32[(Result shr 24) xor Self.Bytes[i]];
  end;
end;

{function TBIOS.GetFDS: Boolean;
begin
  if Bytes[FDSOffset    ] = $a7 then
  if Bytes[FDSOffset+$01] = $f0 then
  if Bytes[FDSOffset+$02] = $0b then
  if Bytes[FDSOffset+$24] = $a7 then
  if Bytes[FDSOffset+$25] = $f0 then
  if Bytes[FDSOffset+$26] = $0b then
  if Bytes[FDSOffset+$40] = $a7 then
  if Bytes[FDSOffset+$41] = $f0 then
  if Bytes[FDSOffset+$42] = $0b then
  Exit(True);
  Result := False;
end;  }

function TBIOS.GetGaroupP2Size: Integer;
begin
  Position := GaroupP2SizeOffset;
  ReadData(Result);
end;

function TBIOS.GetGaroupP2SizeOffset: Integer;
begin
  // size of 253-p2p.bin
  if CurrentDevice = cdGB300 then
  case Size of
    12951332: Result := $B34968;
    12949540: Result := $B34278;
    else raise Exception.Create('GB300+SF2000 Tool does not know this BIOS size''s ''253-p2p.bin'' size offset');
  end
  else
  case Size of
    12624628: Result := $AE5038; // 1.71
    12624436: Result := $AE4F48; // 1.6 (incl. multicore)
    else raise Exception.Create('GB300+SF2000 Tool does not know this BIOS size''s ''253-p2p.bin'' size offset (only BIOS v1.71 and v1.6 (multicore) are supported)');
  end;
end;

function TBIOS.GetIsCRCValid: Boolean;
begin
  Result := StoredCRC = CalculatedCRC;
end;

class function TBIOS.GetPath: string;
begin
  Result := IncludeTrailingPathDelimiter(GB300Utils.Path + 'bios') + 'bisrv.asd';
end;

class function TBIOS.GetSizeSupported(Size: Integer): TCurrentDevice;
begin
  case Size of
      12951332, 12949540: Result := cdGB300;
      12624628, 12624436: Result := cdSF2000;
      7299832: raise Exception.Create('You are using the GB300 v1 firmware which is not supported by this version of the tool.'+#13#10#13#10'You have two options:'#13#10'- Use GB300 Tool v1.0b (available from the GitHub link in this tool)'#13#10'- Upgrade your GB300''s firmware to v2. See nummacway.github.io/gb300 for details.');
      else raise Exception.Create('GB300+SF2000 Tool does not know your BIOS size.'#13#10#13#10'It currently supports both known versions of GB300 v2 as well as SF2000 v1.6 (aka multicore) and v1.71.');
    end;
end;

function TBIOS.GetSizeSupported: TCurrentDevice;
begin
  Result := GetSizeSupported(Size);
end;

function TBIOS.GetStoredCRC: Cardinal;
begin
  Position := CRCOffset;
  ReadData(Result);
end;

{function TBIOS.GetVT03: Boolean;
begin
  Result := Match(3191, TBIOS.VT03Offset);
end;

function TBIOS.GetVT03LUT565: Boolean;
var
  w: Word;
  i: Word;
begin
  Position := VT03LUTOffset;
  for i := 1 to 4096 do
  begin
    ReadData(w);
    if w and $20 <> 0 then
    Exit(False);
  end;
  Result := True;
end; }

function TBIOS.Match(Resource: Word; Offset: Int64): Boolean;
var
  RS: TResourceStream;
  B1, B2: Byte;
begin
  RS := TResourceStream.CreateFromID(HInstance, Resource, RT_RCDATA);
  try
    Self.Position := Offset;
    while RS.Position < RS.Size do
    begin
      RS.ReadData(B1);
      Self.ReadData(B2);
      if B1 <> B2 then
      Exit(False);
    end;
  finally
    RS.Free();
  end;
  Result := True;
end;

class procedure TBIOS.Patch(Resource: Word; Offset: Int64);
var
  BIOS: TBIOS;
begin
  BIOS := TBIOS.Create();
  try
    BIOS.LoadFromFile(TBIOS.Path);
    BIOS.DoPatch(Resource, Offset);
    BIOS.SaveToFile(TBIOS.Path);
  finally
    BIOS.Free();
  end;
end;

procedure TBIOS.SaveBootLogoToStream(Stream: TStream);
begin
  Position := BootLogoOffset;
  GetDIBStreamFromStream(Self, Stream, idfRGB565, BootLogoWidth, BootLogoHeight);
end;

procedure TBIOS.SetBootLogo(Value: TGraphic);
begin
  Position := BootLogoOffset;
  WriteGraphicToStream(Value, Self, idfRGB565, BootLogoWidth, BootLogoHeight, False);
end;

{procedure TBIOS.SetFDS(const Value: Boolean);
const
  Data: array[Boolean] of Cardinal = ($c098c98, $c0bf0a7); // they're actually only 3-byte values, but there no convenient datatype (cannot make multi-dimensional array constants), so I'm using 4-byte here
begin
  Position := FDSOffset;
  WriteData(Data[Value]);
  Position := FDSOffset+$24;
  WriteData(Data[Value]);
  Position := FDSOffset+$40;
  WriteData(Data[Value]);
end;    }

procedure TBIOS.SetGaroupP2Size(const Value: Integer);
begin
  Position := GaroupP2SizeOffset;
  WriteData(Value);
end;

procedure TBIOS.SetStoredCRC(Value: Cardinal);
begin
  Position := CRCOffset;
  WriteData(Value);
end;

{procedure TBIOS.SetVT03LUT565(const Value: Boolean);
var
  RS: TResourceStream;
  w: Word;
  i: Word;
begin
  RS := TResourceStream.CreateFromID(HInstance, 555, RT_RCDATA);
  try
    Position := VT03LUTOffset;
    for i := 1 to 4096 do
    begin
      RS.ReadData(w);
      if Value then
      w := (w and $1f) or ((w and $7fe0) shl 1); // convert RGB555 to RGB565
      WriteData(w);
    end;
  finally
    RS.Free();
  end;
end;  }

{ TNameArray }

procedure TNameList.LoadFromFile(RelativeFilename: string);
var
  MS: TMemoryStream;
  Count: Cardinal;
  Offsets: array of Cardinal;
  Offset: Cardinal;
  OffsetBias: Cardinal;
  Char: AnsiChar;
  Name: RawByteString;
begin
  RelativeFilename := IncludeTrailingPathDelimiter(Path + 'Resources') + RelativeFilename;
  Self.Clear();
  if not FileExists(RelativeFilename) then
  Exit;
  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(RelativeFilename);
    MS.ReadData(Count);
    SetLength(Offsets, Count);
    if Count = 0 then
    Exit;
    MS.Read(Offsets[0], Count * SizeOf(Cardinal));
    OffsetBias := SizeOf(Cardinal) * (Count + 1); // Count items + Count itself
    for Offset in Offsets do
    begin
      MS.Position := Offset + OffsetBias;
      Name := '';
      MS.ReadData(Char);
      while Ord(Char) <> 0 do
      begin
        Name := Name + Char;
        MS.ReadData(Char);
      end;
      Self.Add(UTF8ToUnicodeString(Name));
    end;
  finally
    MS.Free();
  end;
end;

procedure TNameList.SaveToFile(const RelativeFilename: string);
var
  MS1, MS2: TMemoryStream;
  Name: string;
  NameUTF8: RawByteString;
begin
  MS1 := TMemoryStream.Create();
  MS2 := TMemoryStream.Create();
  try
    MS1.WriteData(Cardinal(Count));
    for Name in Self do
    begin
      NameUTF8 := UTF8Encode(Name);
      MS1.WriteData(Cardinal(MS2.Position));
      MS2.Write(NameUTF8[1], Length(NameUTF8));
      MS2.WriteData(Byte(0));
    end;
    MS1.CopyFrom(MS2);
    MS1.SaveToFile(IncludeTrailingPathDelimiter(Path + 'Resources') + RelativeFilename);
  finally
    MS1.Free();
    MS2.Free();
  end;
end;

{ TNameLists }

procedure TNameLists.Insert(Index: Integer; const FileName, ChineseName, PinyinName: string);
begin
  FileNames.Insert(Index, FileName);
  ChineseNames.Insert(Index, ChineseName);
  PinyinNames.Insert(Index, PinyinName);
end;

procedure TNameLists.Add(const FileName, ChineseName, PinyinName: string);
begin
  FileNames.Add(FileName);
  ChineseNames.Add(ChineseName);
  PinyinNames.Add(PinyinName);
end;

constructor TNameLists.Create;
begin
  FileNames := TNameList.Create();
  ChineseNames := TNameList.Create();
  PinyinNames := TNameList.Create();
end;

procedure TNameLists.Delete(Index: Integer);
begin
  FileNames.Delete(Index);
  ChineseNames.Delete(Index);
  PinyinNames.Delete(Index);
end;

destructor TNameLists.Destroy;
begin
  FileNames.Free();
  ChineseNames.Free();
  PinyinNames.Free();
  inherited;
end;

procedure TNameLists.LoadFromFiles(const FolderIndex: Byte);
begin
  FileNames.LoadFromFile(FileNamesFilenames[FolderIndex]);
  ChineseNames.LoadFromFile(ChineseNamesFilenames[FolderIndex]);
  PinyinNames.LoadFromFile(PinyinNamesFilenames[FolderIndex]);
end;

procedure TNameLists.SaveToFiles(const FolderIndex: Byte);
begin
  FileNames.SaveToFile(FileNamesFilenames[FolderIndex]);
  ChineseNames.SaveToFile(ChineseNamesFilenames[FolderIndex]);
  PinyinNames.SaveToFile(PinyinNamesFilenames[FolderIndex]);
end;

{ TReferenceList }

function TReferenceList.AddFile(FolderIndex: Byte; FileName: string): Boolean;
var
  i: Integer;
  NameList: TNameList;
  Ref: TReference;
begin
  NameList := TNameList.Create();
  try
    NameList.LoadFromFile(FileNamesFilenames[FolderIndex]);
    i := NameList.IndexOf(FileName);
    Result := i > -1;
    if Result then
    begin
      Ref.FileIndex := i;
      Ref.FolderIndex := FolderIndex;
      Ref.FileName := FileName;
      Add(Ref);
    end;
  finally
    NameList.Free();
  end;
end;

function TReferenceList.Apply(FileNameList: TNameList; FolderIndex: Byte): Boolean;
var
  Cache: TDictionary<string, Word>;
  s: string;
  i: Integer;
  r: TReference;
begin
  Result := False;
  Cache := TDictionary<string, Word>.Create();
  try
    for s in FileNameList do
    Cache.Add(s, Cache.Count);

    for i := Self.Count - 1 downto 0 do
    if Self[i].FolderIndex = FolderIndex then
    begin
      if Cache.ContainsKey(Self[i].FileName) then
      begin
        if r.FileIndex <> Cache[Self[i].FileName] then
        begin
          r := Self[i];
          r.FileIndex := Cache[Self[i].FileName];
          Self[i] := r;
          Result := True;
        end;
      end
      else
      begin
        Self.Delete(i);
        Result := True;
      end;
    end;
  finally
    Cache.Free();
  end;
end;

procedure TReferenceList.LoadFromFile(RelativeFilename: string);
var
  Names: TObjectList<TNameList>;
begin
  Names := GetFileNames();
  try
    LoadFromFile(RelativeFilename, Names);
  finally
    Names.Free();
  end;
end;

function TReferenceList.ContainsFile(FolderIndex: Byte; FileName: string): Boolean;
var
  Ref: TReference;
begin
  for Ref in Self do
  if Ref.FolderIndex = FolderIndex then
  if Ref.FileName = FileName then
  Exit(True);
  Result := False;
end;

class function TReferenceList.GetFileNames: TObjectList<TNameList>;
var
  s: string;
begin
  Result := TObjectList<TNameList>.Create(True);
  try
    for s in FileNamesFilenames do
    if (CurrentDevice = cdGB300) or (s <> FileNamesFilenames[High(FileNamesFilenames)]) then // no PCE on SF2000
    begin
      Result.Add(TNameList.Create());
      Result.Last().LoadFromFile(s);
    end;
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
end;

procedure TReferenceList.LoadFromFile(RelativeFilename: string; FileNames: TObjectList<TNameList>);
var
  MS: TMemoryStream;
  i: Integer;
  r: TReference;
  Count: Integer; // limited to 1000, but still an Int32
begin
  RelativeFilename := IncludeTrailingPathDelimiter(Path + 'Resources') + RelativeFilename;
  Self.Clear();
  if not FileExists(RelativeFilename) then
  Exit;

  MS := TMemoryStream.Create();
  try
    MS.LoadFromFile(RelativeFilename);
    MS.ReadData(Count);
    for i := 0 to Count - 1 do
    begin
      MS.ReadData(r.FolderIndex);
      MS.ReadData(r.FileIndex);
      if r.FolderIndex < FileNames.Count then
      if r.FileIndex < FileNames[r.FolderIndex].Count then
      begin
        r.FileName := FileNames[r.FolderIndex][r.FileIndex];
        Self.Add(r);
      end;
    end;
  finally
    MS.Free();
  end;
end;

procedure TReferenceList.RemoveFile(FolderIndex: Byte; FileName: string);
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
  if Self[i].FolderIndex = FolderIndex then
  if Self[i].FileName = FileName then
  Delete(i);
end;

function TReferenceList.Rename(FolderIndex: Byte; OldFileName, NewFileName: string): Boolean;
var
  i: Integer;
  r: TReference;
begin
  Result := False;
  for i := 0 to Self.Count - 1 do
  if Self[i].FolderIndex = FolderIndex then
  if Self[i].FileName = OldFileName then
  begin
    r := Self[i];
    r.FileName := NewFileName;
    Self[i] := r;
    Result := True;
    // No break here, reference lists can theoretically contain the same entry more than once (even though this isn't normally possible)
  end;
end;

procedure TReferenceList.SaveToFile(FileName: TReferenceFileName);
begin
  case FileName of
    rfFavorites: SaveToFile('Favorites.bin');
    rfHistory:   SaveToFile('History.bin');
  end;
end;

procedure TReferenceList.SaveToFile(const RelativeFilename: string);
var
  MS: TMemoryStream;
  r: TReference;
begin
  MS := TMemoryStream.Create();
  try
    MS.WriteData(Cardinal(Self.Count));
    for r in Self do
    begin
      MS.WriteData(r.FolderIndex);
      MS.WriteData(r.FileIndex);
    end;
    MS.SaveToFile(IncludeTrailingPathDelimiter(Path + 'Resources') + RelativeFilename);
  finally
    MS.Free();
  end;
end;

{ TThumbnailedFile }

procedure TROMFile.Compress(const Lead: Integer);
var
  OldStream: TStream;
  ZLib: TZCompressionStream;
  TempStream: TMemoryStream;
  Header: TZipLocalHeader;
  Directory: TZipCentralDirectory;
  EndOfDirectory: TZipEndofCentralDirectory;
  Start: Integer;
begin
  if IsCompressed then
  Exit;

  OldStream := nil;
  try
    TempStream := TMemoryStream.Create();
    try
      //TempStream.SetSize(Lead);
      TempStream.Position := Lead;
      Header.Init();
      if IsMultiCore then
      Header.FileName := 'gb300tool.gba' // anything .gba
      else
      Header.FileName := GetROMFileName();
      Header.UncompressedSize := FStream.Size;
      Header.LastModFileDateTime.AsDateTime := Now();
      Header.CRC32 := not update_crc($ffffffff, FStream.Memory, FStream.Size);

      Header.SaveToStream(TempStream);
      Start := TempStream.Position;
      ZLib := TZCompressionStream.Create(TempStream, zcMax, -15);
      try
        FStream.Position := 0;
        ZLib.CopyFrom(FStream);
      finally
        ZLib.Free();
      end;
      Header.CompressedSize := TempStream.Position - Start;
      TempStream.Position := Lead;
      Header.SaveToStream(TempStream);

      TempStream.Position := TempStream.Position + Header.CompressedSize;
      Directory.Assign(Header); // includes init
      Directory.RelativeOffsetOfLocalHeader := 0;
      Start := TempStream.Position;
      Directory.SaveToStream(TempStream);

      EndOfDirectory.Init();
      EndOfDirectory.OffsetOfStartOfTheCentralDirectoryWithRespectToTheStartingDiskNumber := Start - Lead;
      EndOfDirectory.SizeOfTheCentralDirectory := TempStream.Position - Start;
      EndOfDirectory.SaveToStream(TempStream);

      OldStream := FStream;
      FStream := TempStream;
      FIsCompressed := True;
      FHasImage := False;
    except
      try
        TempStream.Free();
      except
      end;
      raise
    end;
  finally
    OldStream.Free();
  end;
end;

procedure TROMFile.CopyThumbnail(Source: TROMFile);
begin
  if not HasImage then
  raise Exception.Create('Internal error: Trying to copy a thumbnail to a file that is not already thumbnailed');
  if not Source.HasImage then
  raise Exception.Create('Trying to copy a thumbnail from a file that is not thumbnailed');
  if ThumbnailSize <> Source.ThumbnailSize then // cannot currently happen
  raise Exception.Create('Thumbnail size mismatch');

  FStream.Position := 0;
  Source.FStream.Position := 0;
  FStream.CopyFrom2(Source.FStream, ThumbnailSize);
end;

constructor TROMFile.Create;
begin
  FStream := TMemoryStream.Create();
end;

constructor TROMFile.CreateFinalBurn(FN: string);
var
  i: Integer;
  rs: RawByteString;
begin
  Create();
  for i := 1 to Foldername.ThumbnailSize.X * Foldername.ThumbnailSize.Y do
  FStream.WriteData(Word(0));
  FStream.WriteData(Cardinal(0));
  rs := UTF8Encode(FN);
  FStream.Write(rs[1], Length(rs));
  FStream.WriteData(Word(0));
  FIsFinalBurn := True;
  FHasImage := True;
end;

procedure TROMFile.Decompress;
var
  OldStream: TStream;
begin
  if IsMultiCore then
  begin
    FStream.Clear;
    FIsCompressed := False;
    FHasImage := False;
  end
  else
  begin
    OldStream := FStream;
    FStream := ROM;
    FIsCompressed := False;
    FHasImage := False;
    OldStream.Free();
  end;
end;

destructor TROMFile.Destroy;
begin
  FStream.Free();
  inherited;
end;

function TROMFile.ChangeExt(const OldExtWithDot, NewExtWithDot: FourCharString): Boolean;
type
  TFourChars = record
    case Boolean of
      False: (Int: Cardinal);
      True: (Str: FourCharString);
end;
var
  Header: TZipLocalHeader;
  CentralDirOffset: Cardinal;
  CentralDir: TZipCentralDirectory;
  Ext: TFourChars;
begin
  Result := False;

  if not IsCompressed then
  Exit;

  Header := GetHeader();
  if not EndsText(string(OldExtWithDot), Header.FileName) then
  Exit;

  CentralDirOffset := FStream.Position + Header.CompressedSize;

  FStream.Position := FStream.Position - Header.ExtraFieldLength - 4;
  FStream.ReadData(Ext);
  if AnsiStrings.SameText(Ext.Str, OldExtWithDot) then
  Ext.Str := NewExtWithDot // not wisewang'ed
  else
  begin // if EndsText matched with the decoded header, the file has the correct extension, but if it's still binarily different, the header must be wisewang'ed
    Ext.Str := NewExtWithDot;
    Ext.Int := Ext.Int xor $e5e5e5e5;
  end;
  FStream.Position := FStream.Position - 4;
  FStream.WriteData(Ext);

  FStream.Position := CentralDirOffset;
  CentralDir.LoadFromStream(FStream);
  FStream.Position := FStream.Position - CentralDir.FileCommentLength - CentralDir.ExtraFieldLength - 4;
  FStream.WriteData(Ext);

  Result := True;
end;

class function TROMFile.FileNameToImageIndex(const FileName: string): Integer;
var
  MCExt: string;
  MCName: TMulticoreName;
  Ext: string;
begin
  if TROMFile.GetIsMultiCore(FileName) then
  begin
    // prepare names
    MCName := TROMFile.GetMCName(FileName);
    MCExt := Copy(Lowercase(ExtractFileExt(MCName.Name)), 2, 1337);

    if (MCName.Core = 'a26') or (MCName.Core = 'a5200') or (MCName.Core = 'a78') or (MCName.Core = 'a8000') then
    Exit(13);  // A78 icon used for other platforms since officially compatible

    if StartsStr('amstrad', MCName.Core) then
    Exit(20);

    if (MCName.Core = 'col') or (MCExt = 'col') then
    Exit(14);

    if (MCName.Core = 'fcf') then
    Exit(15);

    if (MCName.Core = 'gg') or (MCName.Core = 'sega') or (MCName.Core = 'gpgx') then
    begin
      // older SEGA platforms
      if MCExt = 'gg' then
      Exit(10);
      if MCExt = 'sg' then
      Exit(18);
      if (MCExt = 'sms') or (MCName.Core = 'gg') then // SMS or fallback in case of gearsystem
      Exit(9);
    end;

    if (MCName.Core = 'int') then
    Exit(17);

    if StartsStr('lnx', MCName.Core) then
    Exit(23);

    if (MCName.Core = 'msx') then
    begin
      if MCExt = 'sg' then
      Exit(18);
      // we had col before
      // I think the other platforms in blueMSX suck, so I don't support them
    end;

    if StartsStr('nes', MCName.Core) then
    Exit(0);

    if StartsStr('pce', MCName.Core) then
    Exit(1);

    // pcfx does not work properly, so we ignore that

    if (MCName.Core = 'pokem') then
    Exit(11);

    if (MCName.Core = 'sega') or (MCName.Core = 'gpgx') then
    Exit(3);

    if (MCName.Core = 'm2k') or (MCExt = 'geo') then
    Exit(24);

    if StartsStr('snes', MCName.Core) then
    Exit(2);

    if (MCName.Core = 'spec') then
    Exit(21);

    if (MCName.Core = 'vec') then
    Exit(16);

    if (MCName.Core = 'wsv') then
    Exit(19);

    if (MCName.Core = 'wswan') then
    Exit(12);

    // generic matching
    if Pos('gba', MCName.Core) > 0 then
    Exit(5);

    if StartsStr('gb', MCName.Core) then // anything that starts with gb and is not gba is considered a game boy
    Exit(4);

    Exit(FileNameToImageIndex(MCName.Name));
  end;

  Ext := Copy(Lowercase(ExtractFileExt(FileName)), 2, 1337);

  if Ext = 'zfb' then
  Result := 25
  else
  if Ext = 'sms' then // only stock extension with an icon seperate from the others
  Result := 9
  else
  if (Ext = 'iso') or (Ext = 'chd') or (Ext = 'ccd') or (Ext = 'cue') then // generic disc icon
  Result := 8
  else
  Result := Ord(TROMFile.FileNameToType(FileName));
end;

class function TROMFile.FileNameToType(const FileName: string): TFileType;
var
  Ext: string;
begin
  Ext := Copy(Lowercase(ExtractFileExt(FileName)), 2, 1337);
  if (Ext = 'fds') or (Ext = 'nes') or (Ext = 'unf') or (Ext = 'nfc') then
  Result := ftFC
  else
  if (Ext = 'pce') then
  Result := ftPCE
  else
  if (Ext = 'smc') or (Ext = 'fig') or (Ext = 'sfc') or (Ext = 'gd3') or (Ext = 'gd7') or (Ext = 'dx2') or (Ext = 'bsx') or (Ext = 'swc') then
  Result := ftSFC
  else
  if (Ext = 'bin') or (Ext = 'gen') or (Ext = 'smd') or (Ext = 'md') or (Ext = 'sms') then
  Result := ftMD
  else
  if (Ext = 'gb') or (Ext = 'gbc') or (Ext = 'sgb') then
  Result := ftGB
  else
  if (Ext = 'gba') or (Ext = 'agb') or (Ext = 'gbz') then
  Result := ftGBA
  else
  if (Ext = 'zip') or (Ext = 'bkp') or (Ext = 'zfb') then
  Result := ftCompressed
  else
  if (Ext = 'zfc') or (Ext = 'zsf') or (Ext = 'zpc') or (Ext = 'zmd') or (Ext = 'zgb') then // do not add ZFB here! (context menu feature of stock ROM list use this)
  Result := ftThumbnailed
  else
  Result := ftUnknown;
end;

class function TROMFile.FileTypeToFilter(FileType: TFileType; AllFiles: Boolean): string;
begin

  case FileType of
    ftFC: Result := 'Family Computer ROMs (*.fds, *.nes, *.unf, *.nfc)|'+ExtensionsFC;
    ftPCE: Result := 'PC Engine ROMs (*.pce)|'+ExtensionsPCE+'|';
    ftSFC: Result := 'Super Family Computer ROMs (*.smc, *.fig, *.sfc, *.gd3, *.gd7, *.dx2, *.bsx, *.swc)|'+ExtensionsSFC;
    ftMD: Result := 'Mega Drive ROMs (*.bin, *.gen, *.smd, *.md, *.sms)|'+ExtensionsMD;
    ftGB: Result := 'Game Boy (Color) ROMs (*.gb, *.gbc, *.sgb)|'+ExtensionsGB;
    ftGBA: Result := 'Game Boy Advance ROMs (*.gba, *.agb, *.gbz)|'+ExtensionsGBA;
    ftCompressed: Result := 'Archives (*.zip, *.bkp, *.zfb)|'+ExtensionsCompressed;
    ftThumbnailed: Result := 'Thumbnailed archives (*.zfc, *.zpc, *.zsf, *.zmd, *.zgb)|'+ExtensionsThumbnailed;
    else Result := '';
  end;
  if AllFiles then
  Result := Result + '|All files (*.*)|*.*';
end;

class function TROMFile.FileTypeToThumbExt(FileType: TFileType): string;
begin
  case FileType of
    ftFC: Result := '.zfc';
    ftPCE: Result := '.zpc';
    ftSFC: Result := '.zsf';
    ftMD: Result := '.zmd';
    //ftGB, ftGBA: Result := '.zgb';
    //else Result := '.zfb'; // is not a file that is created from _other_ files even on the SF2000, and prevents the feature from working on the GB300 because .zfb is not even thumbnailed
    else Result := '.zgb';
  end;
end;

function TROMFile.GetCRC: Cardinal;
var
  ROM: TMemoryStream;
  HeaderTest: Cardinal;
  FN: string;
  Ext: string;
begin
  // NES usually uses a 16-byte header
  if FileNameToType(GetROMFileName()) = ftFC then
  begin
    ROM := Self.ROM;
    try
      ROM.ReadData(HeaderTest);
      if HeaderTest = $1a53454e then // iNES
      ROM.Position := 16
      else
      if HeaderTest = $46494e55 then // UNIF
      UnUNIF(ROM) // convert to raw
      else
      ROM.Position := 0;
      Exit(not update_crc($ffffffff, Pointer(NativeInt(ROM.Memory)+ROM.Position), ROM.Size-ROM.Position));
    finally
      ROM.Free();
    end;
  end;

  if not IsMultiCore then
  if IsCompressed then
  Exit(GetHeader().CRC32);


  if IsMultiCore then
  begin
    FN := GetMCName().AbsoluteFileName;
    Ext := Lowercase(ExtractFileExt(FN));

    if (Ext = '.chd') or (Ext = '.img') or (Ext = '.cue') or (Ext = '.iso') or (Ext = '.zip') then
    Exit(0); // don't hash images (makes no sense and/or is slow)

    if not FileExists(FN) then
    Exit(0);

    if GetFileSize(FN) > 100000000 then
    Exit(0);
  end;

  ROM := Self.ROM;
  try
    Result := not update_crc($ffffffff, ROM.Memory, ROM.Size);
  finally
    ROM.Free();
  end;
end;

class function TROMFile.GetDefaultThumbnailSize: Integer;
begin
  Result := 2 * Foldername.ThumbnailSize.X * Foldername.ThumbnailSize.Y;
end;

function TROMFile.GetFinalBurnTarget: string;
var
  Temp: RawByteString;
begin
  if not IsFinalBurn then
  raise Exception.Create('Internal error: GetFinalBurnTarget() called for non-ZFB file');
  FStream.Position := ThumbnailSize + 4;
  SetLength(Temp, FStream.Size - FStream.Position - 2);
  FStream.Read(Temp[1], Length(Temp));
  Result := UTF8ToUnicodeString(Temp);
end;

function TROMFile.GetHeader: TZipLocalHeader;
begin
  if not IsCompressed then
  raise EInvalidImage.Create('Cannot get ZIP header from uncompressed file');

  if HasImage then // there cannot be an image unless the ROM is compressed
  FStream.Position := ThumbnailSize
  else
  FStream.Position := 0;

  Result.LoadFromStream(FStream);
end;

class function TROMFile.GetIsMultiCore(FN: string): Boolean;
begin
  while Pos('/', FN) > 0 do
  Delete(FN, 1, Pos('/', FN));
  // we cannot savely decide if a compressed or thumbnailed file is multicore without reading the file content
  // maybe checking for existence of the actual ROM would be an idea?
  Result := (Pos(';', FN) > 0) and (FileNameToType(FN) in [ftCompressed, ftThumbnailed, ftGBA]);
end;

function TROMFile.GetIsMultiCore: Boolean;
var
  s: string;
begin
  s := FROMName;
  Result := False;

  if FIsFinalBurn then
  Result := GetIsMultiCore(GetFinalBurnTarget())
  else
  if IsCompressed then
  begin
    // if this is a zip, the file name (without the ext) has to contain a semicolon and the extension of the ROM must be .gba
    if Pos(';', FFileName) > 0 then
    if FileNameToType(GetHeader().FileName) = ftGBA then
    Result := True;
    //Result := GetCRC() = 0 // size doesn't matter to the console I think
  end
  else
  //if not FIsFinalBurn then // if this is already FinalBurn, Result is already True
  //Result := FStream.Size = 0;
  Result := GetIsMultiCore(FFileName);
end;

class function TROMFile.GetMCName(FN: string): TMulticoreName;
begin
  while Pos('/', FN) > 0 do
  Delete(FN, 1, Pos('/', FN));

  Result.Name := ChangeFileExt(FN, '');
  Result.Core := Lowercase(Copy(Result.Name, 1, Pos(';', Result.Name) - 1));
  Delete(Result.Name, 1, Length(Result.Core) + 1);
  Result.AbsoluteFileName := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + Result.Core) + Result.Name;
end;

function TROMFile.GetMCName: TMulticoreName;
begin
  if not IsMultiCore then
  raise Exception.Create('Cannot parse multicore name for non-multicore file (internal error, please report)');

  if IsFinalBurn then
  Result := GetMCName(GetFinalBurnTarget())
  else
  Result := GetMCName(FFileName);
end;

function TROMFile.GetROM: TBytesStream;
var
  Header: TZipLocalHeader;
  ZLib: TZDecompressionStream;
begin
  Result := TBytesStream.Create();
  try
    if IsMultiCore then
    begin
      Result.LoadFromFile(GetMCName().AbsoluteFileName);
    end
    else
    if IsCompressed then
    begin
      Header := GetHeader(); // also moves position to the start of the compressed stream

      case Header.CompressionMethod of
        0:
          Result.CopyFrom(FStream, Header.UncompressedSize);
        8:
          begin
            ZLib := TZDecompressionStream.Create(FStream, -15);
            try
              Result.CopyFrom(ZLib, Header.UncompressedSize);
            finally
              Zlib.Free();
            end;
          end;
        else raise EInvalidImage.CreateFmt('Unsupported ZIP compression method %d', [Header.CompressionMethod]);
      end;
    end
    else
    begin
      FStream.Position := 0;
      Result.CopyFrom(FStream);
    end;
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
  Result.Position := 0;
end;

function TROMFile.GetROMFileName: string;
begin
  if IsFinalBurn then
  begin
    Result := GetFinalBurnTarget();
    if GetIsMultiCore(Result) then
    Result := GetMCName(Result).Name;
  end
  else
  if GetIsMultiCore() then
  Result := GetMCName(FFileName).Name
  else
  if IsCompressed then // the filename inside the ZIP does not matter, only the ext does and that has been evaluated in GetIsMulticore
  Result := GetHeader().FileName
  else
  Result := FROMName;
end;

class function TROMFile.GetROMsIn(FolderIndex: Byte): TList<string>;
var
  Path: string;
  SearchRec: TSearchRec;
  ExtDir: TDictionary<string, Cardinal>;
  ExtList: TStringList;
  Ext: string;
begin
  ExtDir := TDictionary<string, Cardinal>.Create(); // the second argument has no use; this is only used for the performance of ContainsKey
  try
    ExtList := TStringList.Create();
    try
      ExtList.Delimiter := ';';
      ExtList.StrictDelimiter := True;
      ExtList.DelimitedText := StringReplace(Extensions, '*', '', [rfReplaceAll]);
      for Ext in ExtList do
      ExtDir.Add(Ext, 0);
    finally
      ExtList.Free();
    end;

    Path := IncludeTrailingPathDelimiter(GB300Utils.Path + Foldername.Folders[FolderIndex]) + '*';
    Result := TList<string>.Create();
    try
      if FindFirst(Path, not faDirectory, SearchRec) <> 0 then
      Exit;
      repeat
        if ExtDir.ContainsKey(Lowercase(ExtractFileExt(SearchRec.Name))) then
        Result.Add(SearchRec.Name);
      until (FindNext(SearchRec) <> 0);
    except
      try
        Result.Free();
      except
      end;
      raise;
    end;
  finally
    ExtDir.Free();
  end;
end;

function TROMFile.GetThumbnail: TGraphic;
begin
  if not HasImage then
  raise EInvalidImage.Create('No image exists');

  FStream.Position := 0;
  Result := GetDIBImageFromStream(FStream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y);
end;

function TROMFile.GetThumbnailAsPNG: TPNGImage;
begin
  if not HasImage then
  raise EInvalidImage.Create('No image exists');

  FStream.Position := 0;
  Result := GetPNGImageFromStream(FStream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y);
end;

function TROMFile.GetThumbnailSize: Integer;
begin
  // TODO: support incorrect image sizes?
  Result := GetDefaultThumbnailSize;
end;

procedure TROMFile.LoadFromFile(FolderIndex: Byte; FileName: string);
var
  c: Cardinal;
  w: Word;
begin
  FStream.LoadFromFile(IncludeTrailingPathDelimiter(Path + Foldername.Folders[FolderIndex]) + FileName);
  FHasImage := False;
  FIsCompressed := False;
  FIsFinalBurn := False;
  FStream.ReadData(c);
  FFileName := FileName;
  case c of
    $03575157, $04034B50: FIsCompressed := True;
    else
      if FStream.Size > ThumbnailSize + SizeOf(Cardinal) then
      begin
        FStream.Position := ThumbnailSize;
        FStream.ReadData(c);
        case c of
          0, 1: // 1 is rare and its use is unknown
            if InRange(FStream.Size - GetThumbnailSize(), 6 + 1, 6 + 255) then
            begin
              FStream.Position := FStream.Size - 2;
              FStream.ReadData(w);
              if w = 0 then
              begin
                FIsFinalBurn := True;
                FHasImage := True;
              end;
            end;
          $03575157, $04034B50: // Wang QunWei's or Phil Katz's header
            begin
              FIsCompressed := True;
              FHasImage := True;
            end;
        end;
      end;
  end;
  FStream.ReadData(c);
  if not IsCompressed then
  FROMName := FileName;
end;

procedure TROMFile.MakeFinalBurn();
var
  Temp: TMemoryStream;
  FN: RawByteString;
begin
  if IsFinalBurn then
  raise Exception.Create('This is already a ZFB');

  if not IsMultiCore then
  raise Exception.Create('ZFB is only supported for empty multicore stubs');

  if not HasImage then
  raise Exception.Create('Creating ZFB files requires an existing thumbnail image');

  Temp := TMemoryStream.Create();
  try
    FStream.Position := 0;
    Temp.CopyFrom2(FStream, ThumbnailSize);
    Temp.WriteData(Cardinal(0));
    FN := UTF8Encode(ROMFileName);
    Temp.Write(FN[1], Length(FN));
    Temp.WriteData(Word(0));
    FStream.Clear();
    FStream.CopyFrom(Temp);
    //FIsFinalBurn := True;
  finally
    Temp.Free();
  end;
end;

procedure TROMFile.Patch(PatchFile: string);
var
  TempROM: TBytesStream;
  NewROM: TBytesStream;
begin
  TempROM := ROM;
  try
    if SameText(ExtractFileExt(PatchFile), '.ips') then
    begin
      PatchIPS(TempROM, PatchFile);
      SetROM(TempROM, ROMFileName);
    end
    else
    if SameText(ExtractFileExt(PatchFile), '.bps') then
    begin
      NewROM := PatchBPS(TempROM, PatchFile);
      try
        SetROM(NewROM, ROMFileName);
      finally
        NewROM.Free();
      end;
    end
    else
    raise Exception.Create('Please select an IPS or BPS file');
  finally
    TempROM.Free();
  end;
end;

class function TROMFile.PatchBPS(ROM: TBytesStream; PatchFile: string): TBytesStream;
var
  Patch: TBytesStream;
function ReadBigint(): UInt64;
var
  Shift: Integer;
  X: Byte;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    Patch.ReadData(X);
    Result := Result + UInt64(X and $7f) shl Shift;
    if (X and $80) <> 0 then
    Exit;
    Inc(Shift, 7);
    Result := Result + UInt64(1) shl Shift;
  end;
end;
var
  Header: Cardinal;
  Checksum: Cardinal;
  SourceChecksum: Cardinal;
  Action: UInt64;
  Count: UInt64;
  ArgumentRaw: UInt64;
  SourceRelativeOffset: Int64; // offsets that aren't relative
  TargetRelativeOffset: Int64;
begin
  SourceRelativeOffset := 0;
  TargetRelativeOffset := 0;
  Result := TBytesStream.Create();
  try
    Patch := TBytesStream.Create();
    try
      Patch.LoadFromFile(PatchFile);

      Patch.ReadData(Header);
      if Header <> $31535042 then
      raise EInvalidImage.Create('This is not a valid BPS file');

      // how to make bad file formats: put the most important information that is required to open the file at the end (I'm talking about you, MP4 creators!)
      Patch.Position := Patch.Size - 12;
      Patch.ReadData(SourceChecksum);
      Checksum := not update_crc($ffffffff, ROM.Memory, ROM.Size);
      if Checksum <> SourceChecksum then
      raise Exception.Create('CRC mismatch in source file');
      // don't care about the rest

      Patch.Position := 4;
      if ROM.Size <> ReadBigInt() then
      raise EStreamError.Create('Incorrect input ROM size');
      Result.Size := ReadBigInt();
      Count := ReadBigInt(); // must read this before reading Patch.Position
      Patch.Position := Patch.Position + Int64(Count); // don't care about metadata

      while Patch.Position < Patch.Size - 12 do
      begin
        Action := ReadBigint();
        Count := Action shr 2 + 1;
        case Action and 3 of
          0: // SourceRead
            begin
              ROM.Position := Result.Position;
              Result.CopyFrom2(ROM, Count);
            end;
          1: // TargetRead - what a shitty name for method that does not read from the target at all
            Result.CopyFrom2(Patch, Count);
          2: // SourceCopy
            begin
              ArgumentRaw := ReadBigint();
              if (ArgumentRaw and 1) = 0 then
              SourceRelativeOffset := SourceRelativeOffset + Int64(ArgumentRaw shr 1)
              else
              SourceRelativeOffset := SourceRelativeOffset - Int64(ArgumentRaw shr 1);
              for Count := Count downto 1 do
              begin
                Result.WriteData(ROM.Bytes[SourceRelativeOffset]);
                Inc(SourceRelativeOffset);
              end;
            end;
          3: // TargetCopy
            begin
              ArgumentRaw := ReadBigint();
              if (ArgumentRaw and 1) = 0 then
              TargetRelativeOffset := TargetRelativeOffset + Int64(ArgumentRaw shr 1)
              else
              TargetRelativeOffset := TargetRelativeOffset - Int64(ArgumentRaw shr 1);
              for Count := Count downto 1 do
              begin
                Result.WriteData(Result.Bytes[TargetRelativeOffset]);
                Inc(TargetRelativeOffset);
              end;
            end;
        end;
      end;
    finally
      Patch.Free();
    end;
  except
    Result.Free();
    raise;
  end;
end;

class procedure TROMFile.PatchIPS(ROM: TStream; PatchFile: string);
var
  Patch: TMemoryStream;
function ReadBE(Count: Byte): Cardinal;
var
  Temp: Byte;
begin
  if Patch.Position = Patch.Size then
  raise EInvalidImage.Create('Unexpected end of file'); // prevent infinite loop

  Result := 0;
  for Count := Count downto 1 do
  begin
    Result := Result shl 8;
    Patch.ReadData(Temp);
    Result := Result or Temp;
  end;
end;
var
  Header: RawByteString;
  Offset: Cardinal;
  Count: Word;
  Data: Byte;
begin
  Patch := TMemoryStream.Create();
  try
    Patch.LoadFromFile(PatchFile);
    SetLength(Header, 5);
    Patch.Read(Header[1], 5);
    if Header <> 'PATCH' then
    raise EInvalidImage.Create('This is not a valid IPS file');

    Offset := ReadBE(3);
    while Offset <> $454f46 do // FOE
    begin
      ROM.Position := Offset;
      Count := ReadBE(2);
      if Count = 0 then
      begin
        Count := ReadBE(2);
        Patch.ReadData(Data);
        for Count := Count downto 1 do
        ROM.WriteData(Data);
      end
      else
      ROM.CopyFrom2(Patch, Count);
      Offset := ReadBE(3);
    end;

    // truncation extension - it doesn't make much sense, so we do not complain if applied to streams that cannot be truncated
    case Patch.Size - Patch.Position of
      0:
        Exit;
      3:
        begin
          Offset := ReadBE(3);
          ROM.Size := Offset;
        end;
      else
        raise EInvalidImage.Create('Unexpected data found after EOF');
    end;
  finally
    Patch.Free();
  end;
end;

class function TROMFile.RenameRelated(FolderIndex: Byte; OldFileName, NewFileName: string): Boolean;
function TryRenameFile(const OldName, NewName: string): Boolean;
begin
  if FileExists(OldName) then
  begin
    ForceDirectories(ExtractFilePath(NewName));
    Result := RenameFile(OldName, NewName)
  end
  else
  Result := True;
end;
var
  OldBase, NewBase: string;
  i: Byte;
begin
  Result := True;
  //OldFileName := Foldername.AbsoluteFolder[FolderIndex] + OldFileName;
  //NewFileName := Foldername.AbsoluteFolder[FolderIndex] + NewFileName;

  OldBase := IncludeTrailingPathDelimiter(Foldername.AbsoluteFolder[FolderIndex] + 'save') + OldFileName + '.sa';
  NewBase := IncludeTrailingPathDelimiter(Foldername.AbsoluteFolder[FolderIndex] + 'save') + NewFileName + '.sa';
  for i := 0 to 3 do
  if not TryRenameFile(OldBase + IntToStr(i), NewBase + IntToStr(i)) then
  Result := False;

  // It's important not to rename .zfb targets!
  if GetIsMultiCore(OldFileName) then
  if GetIsMultiCore(NewFileName) then
  begin
    if not TryRenameFile(GetMCName(OldFileName).AbsoluteFileName, GetMCName(NewFileName).AbsoluteFileName) then
    Result := False;

    OldBase := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + 'save') + ChangeFileExt(GetMCName(OldFileName).Name, '') + '.state';
    NewBase := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + 'save') + ChangeFileExt(GetMCName(NewFileName).Name, '') + '.state';
    for i := 0 to 3 do
    if not TryRenameFile(OldBase + IntToStr(i), NewBase + IntToStr(i)) then
    Result := False;
  end;

  // Battery, GBA only
  // it is debatable if we should rename `.sav` in ROMs as well, as it is sometimes put there
  if FileNameToType(OldFileName) = ftGBA then
  if not TryRenameFile(ChangeFileExt(OldFileName, '.sav'), ChangeFileExt(NewFileName, '.sav')) then
  Result := False;
end;

procedure TROMFile.SaveThumbnailToStreamDIB(Stream: TStream);
begin
  if not HasImage then
  raise EInvalidImage.Create('No image exists');

  FStream.Position := 0;
  GetDIBStreamFromStream(FStream, Stream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y);
end;

procedure TROMFile.SaveToFile(FolderIndex: Byte; FileName: string; SaveStubIfMC: Boolean);
var
  FS: TFileStream;
  DoSaveMulticore: Boolean;
  TargetMC: string;
begin
  DoSaveMulticore := False;
  if not IsFinalBurn then // Final Burn does not have to point to an _existing_ stub
  if not IsCompressed then
  if GetIsMultiCore(FileName) then // new name is Multicore (I'd hope the old one is too, because else this won't work)
  DoSaveMulticore := True;

  if DoSaveMulticore then
  begin
    TargetMC := Foldername.AbsoluteFolder[FolderIndex] + FileName;
    if not FileExists(TargetMC) or SaveStubIfMC then // no stub
    begin
      ForceDirectories(ExtractFilePath(TargetMC));
      FS := TFileStream.Create(TargetMC, fmCreate);
      FS.Free();
    end;
  end;
  if not DoSaveMulticore or FIsFinalBurn then
  FStream.SaveToFile(Foldername.AbsoluteFolder[FolderIndex] + FileName);
  FFileName := FileName;
  // requires recreating TROMFile
end;

procedure TROMFile.SetROM(Value: TStream; const Name: string);
var
  Image: TMemoryStream;
  FS: TFileStream;
begin
  if IsMulticore then
  begin
    FS := TFileStream.Create(GetMCName.AbsoluteFileName, fmCreate);
    try
      FS.CopyFrom(Value);
    finally
      FS.Free();
    end;
    Exit;
  end;

  Image := TMemoryStream.Create();
  try
    if HasImage then
    begin
      FStream.Position := 0;
      Image.CopyFrom2(FStream, ThumbnailSize);
    end;

    FStream.Clear();
    FStream.CopyFrom(Value);
    FHasImage := False;
    if IsCompressed then
    begin
      FIsCompressed := False;
      FROMName := Name;
      Compress(Image.Size);
      FHasImage := True;
    end;

    if FHasImage then
    begin
      FStream.Position := 0;
      Image.Position := 0;
      FStream.CopyFrom2(Image, Image.Size);
    end;
  finally
    Image.Free();
  end;
end;

procedure TROMFile.SetThumbnail(const Value: TGraphic);
var
  OldStream: TMemoryStream;
  TempStream: TMemoryStream;
begin
  if not HasImage then
  begin
    if not IsCompressed then
    begin
      // not yet compressed: we need to compress the ROM to add an image
      TempStream := TMemoryStream.Create();
      try
        WriteGraphicToStream(Value, TempStream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y, False); // make sure the image conversion works before making any other change
        Compress(GetDefaultThumbnailSize());

        FStream.Position := 0;
        TempStream.Position := 0;
        FStream.CopyFrom2(TempStream, GetDefaultThumbnailSize());
        FHasImage := True;
      finally
        TempStream.Free();
      end;
    end
    else
    begin
      // we need shift the ZIP file to make room for the image
      TempStream := TMemoryStream.Create();
      try
        WriteGraphicToStream(Value, TempStream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y, False);
        FStream.Position := 0;
        TempStream.CopyFrom(FStream);
      except
        try
          TempStream.Free();
        except
        end;
        raise;
      end;
      OldStream := FStream;
      FStream := TempStream;
      FHasImage := True;
      OldStream.Free();
    end;
  end
  else
  begin
    if ThumbnailSize = GetDefaultThumbnailSize() then // could in theory be changed to ">=", but that wastes memory
    begin
      // this is easiest variant: just stuff in the image as it will take exactly the space it needs
      FStream.Position := 0;
      WriteGraphicToStream(Value, FStream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y, False);
    end
    else
    begin
      // we need shift the ZIP file to make a default-sized image fit
      TempStream := TMemoryStream.Create();
      try
        WriteGraphicToStream(Value, TempStream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y, False);
        FStream.Position := ThumbnailSize;
        TempStream.CopyFrom2(FStream, FStream.Size - FStream.Position);
      except
        try
          TempStream.Free();
        except
        end;
        raise;
      end;
      OldStream := FStream;
      FStream := TempStream;
      OldStream.Free();
    end;
  end;
end;

class function TROMFile.UnUNIF(ROM: TMemoryStream): TPoint;
type
TChunk = record
  case Boolean of // gotta love unions
    False: (Int: Integer);
    True: (Str: array[1..4] of AnsiChar);
end;
var
  Chunk: TChunk;
  Length: Cardinal;
  PRG: TObjectDictionary<Byte,TMemoryStream>;
  CHR: TObjectDictionary<Byte,TMemoryStream>;
  MS: TMemoryStream;
  Index: Byte;
begin
  ROM.Position := 0; // must be stand-alone as UNIF does not know the EOF
  ROM.ReadData(Chunk);
  if Chunk.Str <> 'UNIF' then
  Exit;

  Result := Point(0, 0);
  PRG := TObjectDictionary<Byte,TMemoryStream>.Create([doOwnsValues]);
  CHR := TObjectDictionary<Byte,TMemoryStream>.Create([doOwnsValues]);
  try
    ROM.Position := 32;
    while ROM.Position < ROM.Size do
    begin
      ROM.ReadData(Chunk);
      ROM.ReadData(Length);
      if Length = 0 then
      Continue;
      if (Copy(Chunk.Str, 1, 3) = 'PRG') or (Copy(Chunk.Str, 1, 3) = 'CHR') then
      begin
        Index := StrToInt('x' + string(Chunk.Str[4]));
        MS := TMemoryStream.Create();
        try
          MS.CopyFrom2(ROM, Length);
          if Copy(Chunk.Str, 1, 3) = 'PRG' then
          begin
            PRG.Add(Index, MS);
            Inc(Result.X, Length);
          end;
          if Copy(Chunk.Str, 1, 3) = 'CHR' then
          begin
            CHR.Add(Index, MS);
            Inc(Result.Y, Length);
          end;
        except
          MS.Free();
          raise;
        end;
      end
      else
      ROM.Position := ROM.Position + Length;
    end;

    ROM.Clear();
    for Index := 0 to 15 do
    if PRG.ContainsKey(Index) then
    ROM.CopyFrom(PRG[Index]); // this way of calling CopyFrom also sets Position to 0 in the source stream
    for Index := 0 to 15 do
    if CHR.ContainsKey(Index) then
    ROM.CopyFrom(CHR[Index]); // dito
  finally
    PRG.Free();
    CHR.Free();
    ROM.Position := 0;
  end;
end;

{ TZipLocalHeader }

function TZipLocalHeader.LoadFromStream(Stream: TStream): Boolean;
var
  i: Word;
  TempFileName: RawByteString;
begin
  Stream.Read(Self, 30);
  SetLength(TempFileName, FileNameLength);
  if FileNameLength > 0 then
  Stream.Read(TempFileName[1], FileNameLength);
  SetLength(ExtraField, ExtraFieldLength);
  if ExtraFieldLength > 0 then
  Stream.Read(ExtraField[1], ExtraFieldLength);

  if MagicNumber <> $03575157 then
  if MagicNumber <> $04034b50 then
  Exit(False);

  // Adjustment for WQW
  if MagicNumber = $03575157 then
  for i := 1 to FileNameLength do
  TempFileName[i] := AnsiChar(Byte(TempFileName[i]) xor $e5);
  if (GeneralPurposeBitFlag shr 11) and 1 = 1 then
  FileName := UTF8ToUnicodeString(TempFileName)
  else
  FileName := string(TempFileName);

  Result := True;
end;

procedure TZipLocalHeader.Init;
begin
  MagicNumber := $04034b50;
  VersionNeededToExtract := 20;
  GeneralPurposeBitFlag := 0;
  CompressionMethod := 8;
end;

procedure TZipLocalHeader.SaveToStream(Stream: TStream);
var
  TempFileName: RawByteString;
begin
  MagicNumber := $04034b50; // always saves unobfuscated
  if IsAscii(FileName) then
  GeneralPurposeBitFlag := GeneralPurposeBitFlag and not (1 shl 11) // ASCII
  else
  GeneralPurposeBitFlag := GeneralPurposeBitFlag or (1 shl 11); // UTF-8
  TempFileName := UTF8Encode(FileName); // has no effect if ASCII or not
  FileNameLength := Length(TempFileName);
  ExtraFieldLength := Length(ExtraField);
  Stream.Write(Self, 30);
  if FileNameLength > 0 then // to not access [1] where the length is 0
  Stream.Write(TempFileName[1], FileNameLength);
  if ExtraFieldLength > 0 then
  Stream.Write(ExtraField[1], ExtraFieldLength);
end;

{ TZipCentralDirectory }

procedure TZipCentralDirectory.Assign(LocalHeader: TZipLocalHeader);
begin
  MagicNumber := $02014b50;
  Init();
  VersionNeededToExtract := LocalHeader.VersionNeededToExtract;
  GeneralPurposeBitFlag := LocalHeader.GeneralPurposeBitFlag;
  CompressionMethod := LocalHeader.CompressionMethod;
  LastModFileDateTime := LocalHeader.LastModFileDateTime;
  CRC32 := LocalHeader.CRC32;
  CompressedSize := LocalHeader.CompressedSize;
  UncompressedSize := LocalHeader.UncompressedSize;
  FileName := LocalHeader.FileName;
  ExtraField := LocalHeader.ExtraField;
end;

procedure TZipCentralDirectory.LoadFromStream(Stream: TStream);
var
  i: Word;
  TempFileName: RawByteString;
  TempFileComment: RawByteString;
begin
  Stream.Read(Self, 46);
  SetLength(TempFileName, FileNameLength);
  if FileNameLength > 0 then
  Stream.Read(TempFileName[1], FileNameLength);
  SetLength(ExtraField, ExtraFieldLength);
  if ExtraFieldLength > 0 then
  Stream.Read(ExtraField[1], ExtraFieldLength);
  SetLength(TempFileComment, FileCommentLength);
  if FileCommentLength > 0 then
  Stream.Read(TempFileComment[1], FileCommentLength);
  // Adjustment for WQW
  if MagicNumber = $02575157 then
  for i := 1 to FileNameLength do
  TempFileName[i] := AnsiChar(Byte(TempFileName[i]) xor $e5);

  if (GeneralPurposeBitFlag shr 11) and 1 = 1 then
  begin
    FileName := UTF8ToUnicodeString(TempFileName);
    FileComment := UTF8ToUnicodeString(TempFileComment);
  end
  else
  begin
    FileName := string(TempFileName);
    FileComment := string(TempFileComment);
  end;
end;

procedure TZipCentralDirectory.Init;
begin
  MagicNumber := $02014b50;
  VersionMadeBy := 20;
  VersionNeededToExtract := 20;
  GeneralPurposeBitFlag := 0;
  CompressionMethod := 8;
  DiskNumberStart := 0;
  InternalFileAttributes := 0;
  ExternalFileAttributes := 0;
end;

procedure TZipCentralDirectory.SaveToStream(Stream: TStream);
var
  TempFileName: RawByteString;
  TempFileComment: RawByteString;
begin
  MagicNumber := $02014b50;
  if IsAscii(FileName) and IsAscii(FileComment) then
  GeneralPurposeBitFlag := GeneralPurposeBitFlag and not (1 shl 11) // ASCII
  else
  GeneralPurposeBitFlag := GeneralPurposeBitFlag or (1 shl 11); // UTF-8
  TempFileName := UTF8Encode(FileName);
  TempFileComment := UTF8Encode(FileComment);
  FileNameLength := Length(TempFileName);
  ExtraFieldLength := Length(ExtraField);
  FileCommentLength := Length(TempFileComment);
  Stream.Write(Self, 46);
  if FileNameLength > 0 then
  Stream.Write(TempFileName[1], FileNameLength);
  if ExtraFieldLength > 0 then
  Stream.Write(ExtraField[1], ExtraFieldLength);
  if FileCommentLength > 0 then
  Stream.Write(TempFileComment[1], FileCommentLength);
end;

{ TFoldername }

procedure TFoldername.ForceAllDirectories;
var
  i: Byte;
begin
  for i := 0 to 8 do
  ForceDirectories(IncludeTrailingPathDelimiter(Path + Folders[i]) + 'save');
end;

function TFoldername.GetAbsoluteFolder(Index: Byte): string;
begin
  Result := IncludeTrailingPathDelimiter(Path + Foldername.Folders[Index]);
end;

function TFoldername.GetTabName(Index: Byte): string;
begin
  case Index of
    0..8: Exit(Folders[Index]);
  end;
  Result := '';
end;

procedure TFoldername.LoadFromFile;
var
  SL: TStringList;
  s: string;
  i: Integer;
function GetToken: string;
var
  i: Integer;
begin
  if s = '' then
  raise Exception.Create('Invalid line format');

  i := Pos(' ', s);
  if i = 0 then
  Result := s
  else
  begin
    Result := Copy(s, 1, i-1);
    Delete(s, 1, i);
  end;
end;
function GetTokenHex: Integer;
var
  s: string;
begin
  s := GetToken();
  if not TryStrToInt('0x'+s, Result) then
  raise Exception.CreateFmt('Invalid color format (%s)', [s]);

  Result := ((Result shr 16) and $ff) or (Result and $ff00) or ((Result shl 16) and $ff0000);
end;
procedure HandleFolder(i: Integer);
begin
  s := SL[i+3];
  SelectedColors[i] := GetTokenHex();
  Folders[i] := GetToken();
end;
begin
  SL := TStringList.Create();
  try
    SL.LoadFromFile(IncludeTrailingPathDelimiter(Path + 'Resources') + 'Foldername.ini', TEncoding.UTF8);

    if SL.Count <> 16 then
    raise Exception.Create('Invalid ''Foldername.ini'' line count – if you are still using GB300 v1, get GB300 v2 from Reddit or GB300 Tool v1 from GitHub');

    // Row 0
    if SL[0] <> 'SF2000' then
    raise Exception.CreateFmt('Invalid ''Foldername.ini'' device name (%s)', [SL[0]]);

    // Row 1
    //if SL[1] <> '7' then
    //raise Exception.CreateFmt('Unsupported ''Foldername.ini'' language count (%s)', [SL[0]]);
    Languages := StrToInt(SL[1]);

    // Row 2
    s := SL[2];
    DefaultColor := GetTokenHex();

    // Row 3-12
    for i := 0 to 9 do
    HandleFolder(i);

    // Row 13
    s := SL[13];
    //if GetToken <> '12' then
    //raise Exception.Create('Unsupported Foldername.ini total tab count');
    TabCount := StrToInt(GetToken());
    InitialLeftTab := StrToInt(GetToken());
    //if (InitialLeftTab < 0) or (InitialLeftTab > 11) then
    //raise Exception.Create('Invalid Foldername.ini initial left tab index');
    UserSettingsTab := StrToInt(GetToken());
    //if (InitialSelectedTab < 0) or (InitialSelectedTab > 5) then
    //raise Exception.Create('Invalid Foldername.ini initial selected tab index');

    // Row 15
    s := SL[14];
    ThumbnailPosition.X := StrToInt(GetToken());
    ThumbnailPosition.Y := StrToInt(GetToken());
    ThumbnailSize.X := StrToInt(GetToken());
    ThumbnailSize.Y := StrToInt(GetToken());

    // Row 16
    s := SL[15];
    SelectionSize.X := StrToInt(GetToken());
    SelectionSize.Y := StrToInt(GetToken());
  finally
    SL.Free();
  end;
end;

procedure TFoldername.SaveToFile;
function IntColorToHex(Color: TColor): string;
begin
  Result := IntToHex(((Color shr 16) and $ff) or (Color and $ff00) or ((Color shl 16) and $ff0000), 6);
end;
var
  SL: TStringList;
  i: Integer;
begin
  SL := TStringList.Create();
  try
    // Row 0-2
    SL.Add(Header);
    SL.Add(IntToStr(Languages));
    SL.Add(IntColorToHex(DefaultColor));

    // Row 3-12
    for i := 0 to 9 do
    SL.Add(IntColorToHex(SelectedColors[i]) + ' ' + Folders[i]);

    // Row 13-16
    SL.Add(IntToStr(TabCount) + ' ' + IntToStr(InitialLeftTab) + ' ' + IntToStr(UserSettingsTab));
    SL.Add(IntToStr(ThumbnailPosition.X) + ' ' + IntToStr(ThumbnailPosition.Y) + ' ' + IntToStr(ThumbnailSize.X) + ' ' + IntToStr(ThumbnailSize.Y));
    SL.Add(IntToStr(SelectionSize.X) + ' ' + IntToStr(SelectionSize.Y));

    {$IF CompilerVersion < 23.0}
    SL.SaveToFileNoBOM(IncludeTrailingPathDelimiter(Path + 'Resources') + 'Foldername.ini', TEncoding.UTF8);
    {$ELSE}
    SL.WriteBOM := False;
    SL.SaveToFile(IncludeTrailingPathDelimiter(Path + 'Resources') + 'Foldername.ini', TEncoding.UTF8);
    {$IFEND}
  finally
    SL.Free();
  end;
end;

{ TState }

constructor TState.CreateStateFromStream(const StateFileName: string; Stream: TStream; Height, Width: Integer; IsUncompressed: Boolean);
var
  MCFNCandidate: string;
  Dummy: TPNGImage;
  Value: Cardinal;
  Zlib: TZCompressionStream;
  Offset2: Cardinal;
  BeforeZlib: Cardinal;
begin
  inherited Create();

  MCFNCandidate := ChangeFileExt(ExtractFileName(StateFileName), '');
  if not IsUncompressed then
  if TROMFile.GetIsMultiCore(MCFNCandidate) then
  IsUncompressed := True;

  Value := 0;
  if not IsUncompressed then
  WriteData(Value); // Size of zlib (0, because none exists right now)
  Offset2 := Position;

  Dummy := TPngImage.CreateBlank(COLOR_RGB, 8, Width, Height);
  try
    Value := Dummy.Width;
    WriteData(Value);
    Value := Dummy.Height;
    WriteData(Value);
    WriteData(Value); // just write anything to overwrite it later
    BeforeZlib := Position;

    Zlib := TZCompressionStream.Create(Self, zcMax, 15); // no negative window - both deflated files have zlib header!
    try
      WriteGraphicToStream(Dummy, Zlib, idfRGB565, Dummy.Width, Dummy.Height, False);
    finally
      Zlib.Free();
    end;
  finally
    Dummy.Free();
  end;
  WriteData(Offset2);
  Position := BeforeZlib - 4;
  Value := Size - BeforeZlib - 4;
  WriteData(Value);

  WriteStateFromStream(StateFileName, Stream);
  if TROMFile.GetIsMultiCore(MCFNCandidate) then // multicore needs the screenshot to be written
  Self.SaveToFile(StateFileName);
end;

class function TState.GetMCStateFileName(ROMFileName: string; Index: Integer): string;
begin
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + 'save') + ChangeFileExt(TROMFile.GetMCName(ROMFileName).Name, '.state' + IntToStr(Index));
end;

class function TState.GetMCStateFileName(const StateFileName: string): string;
var
  MCFNCandidate: string;
begin
  MCFNCandidate := ChangeFileExt(ExtractFileName(StateFileName), '');
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + 'save') + ChangeFileExt(TROMFile.GetMCName(MCFNCandidate).Name, '.state' + RightStr(StateFileName, 1));
end;

function TState.GetScreenshot: TPngImage;
var
  MS: TMemoryStream;
  Dimensions: TPoint;
begin
  MS := GetScreenshotData(Dimensions);
  try
    MS.Position := 0;
    Result := GetPNGImageFromStream(MS, idfRGB565, Dimensions.X, Dimensions.Y);
  finally
    MS.Free();
  end;
end;

function TState.GetScreenshotData(var Dimensions: TPoint): TMemoryStream;
var
  Offset: Cardinal;
  Zlib: TZDecompressionStream;
begin
  Position := Size - 4;
  ReadData(Offset);
  Position := Offset;
  ReadData(Dimensions.X);
  ReadData(Dimensions.Y);
  Position := Position + 4;
  Result := TMemoryStream.Create();
  try
    Zlib := TZDecompressionStream.Create(Self); // no negative window - both deflated files have zlib header!
    try
      Result.CopyFrom(Zlib, Dimensions.X * Dimensions.Y * 2);
    finally
      Zlib.Free();
    end;
  except
    try
      Result.Free();
    except
    end;
    raise;
  end;
end;

procedure TState.SaveScreenshotToStream(Stream: TStream);
var
  MS: TMemoryStream;
  Dimensions: TPoint;
begin
  MS := GetScreenshotData(Dimensions);
  try
    GetDIBStreamFromStream(MS, Stream, idfRGB565, Dimensions.X, Dimensions.Y);
  finally
    MS.Free();
  end;
end;

procedure TState.SaveStateToStream(const StateFileName: string; Stream: TStream);
var
  Offset1, Offset2: Cardinal;
  Zlib: TZDecompressionStream;
  MCFNCandidate: string;
  FS: TFileStream;
begin
  MCFNCandidate := ChangeFileExt(ExtractFileName(StateFileName), '');
  if TROMFile.GetIsMultiCore(MCFNCandidate) then
  begin
    FS := TFileStream.Create(GetMCStateFileName(StateFileName), fmOpenRead or fmShareDenyNone);
    Stream.CopyFrom(FS);
    Exit;
  end;

  Position := Size - 4;
  ReadData(Offset2);
  Position := 0;
  ReadData(Offset1);
  if Offset1 + 4 = Offset2 then // not .nfc
  begin
    Zlib := TZDecompressionStream.Create(Self); // no negative window - both deflated files have zlib header!
    try
      Stream.CopyFrom(Zlib);
    finally
      Zlib.Free();
    end;
  end
  else
  begin
    Position := 0;
    Stream.CopyFrom2(Self, Offset2);
  end;
end;

procedure TState.WriteStateFromStream(const StateFileName: string; Stream: TStream);
var
  Offset1, Offset2: Cardinal;
  Zlib: TZCompressionStream;
  MCFNCandidate: string;
  FS: TFileStream;
  ScreenshotData: TMemoryStream;
begin
  MCFNCandidate := ChangeFileExt(ExtractFileName(StateFileName), '');
  if TROMFile.GetIsMultiCore(MCFNCandidate) then
  begin
    FS := TFileStream.Create(GetMCStateFileName(StateFileName), fmCreate);
    try
      FS.CopyFrom(Stream);
      Exit;
    finally
      FS.Free();
    end;
  end;

  Position := Size - 4;
  ReadData(Offset2);
  Position := Offset2;
  ScreenshotData := TMemoryStream.Create();
  try
    ScreenshotData.CopyFrom2(Self, Self.Size - Self.Position - 4);
    Position := 0;
    ReadData(Offset1);
    Clear();
    WriteData(Offset1); // just write some 4 bytes, doesn't matter which
    if Offset1 + 4 = Offset2 then // not .nfc
    begin
      Zlib := TZCompressionStream.Create(Self, zcMax, 15); // no negative window - both deflated files have zlib header!
      try
        Zlib.CopyFrom(Stream);
      finally
        Zlib.Free();
      end;
      // Write "header"
      Position := 0;
      Offset1 := Size - 4;
      WriteData(Offset1);
    end
    else
    begin
      Position := 0;
      CopyFrom(Stream);
    end;
    // Write Screenshot
    Position := Size;
    Offset2 := Size;
    CopyFrom(ScreenshotData);
    WriteData(Offset2);
    SaveToFile(StateFileName);
  finally
    ScreenshotData.Free();
  end;
end;

{$IF CompilerVersion < 23.0}

{ TStringsHelper }

procedure TStringsHelper.SaveToFileNoBOM(const FileName: string;
  Encoding: TEncoding);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStreamNoBOM(Stream, Encoding);
  finally
    Stream.Free;
  end;
end;

procedure TStringsHelper.SaveToStreamNoBOM(Stream: TStream; Encoding: TEncoding);
var
  Buffer, Preamble: TBytes;
begin
  if Encoding = nil then
    Encoding := TEncoding.Default;
  Buffer := Encoding.GetBytes(GetTextStr);
  Stream.WriteBuffer(Buffer[0], Length(Buffer));
end;
{$IFEND}

{ TNoIntro }

function TNoIntro.GetGameID: Word;
begin
  Result := Abs(FGameID);
end;

function TNoIntro.GetIsVerified: Boolean;
begin
  Result := WordBool($8000 and FGameID);
end;

procedure TNoIntro.LoadFromStream(Stream: TStream);
begin
  Stream.ReadData(CRC32);
  Stream.ReadData(FGameID);
  Stream.ReadData(FLength);
  SetLength(Name, FLength);
  Stream.Read(Name[1], FLength);
end;

{ TDOSDateTime }

function TDOSDateTime.GetAsDateTime: TDateTime;
var
  Year, Month, Day: Word;
  Hour, Minute, Second: Word;
begin
  Year := LastModFileDate shr 9 + 1980;
  Month := (LastModFileDate shr 5) and $f;
  Day := LastModFileDate and $1f;
  Hour := LastModFileTime shr 11;
  Minute := (LastModFileTime shr 5) and $3f;
  Second := (LastModFileTime and $1f) shl 1;
  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, 0);
end;

procedure TDOSDateTime.SetAsDateTime(const Value: TDateTime);
var
  Year, Month, Day: Word;
  Hour, Minute, Second: Word;
  Void: Word;
begin
  DecodeDateTime(Value, Year, Month, Day, Hour, Minute, Second, Void);
  LastModFileDate := Word(((Year - 1980) shl 9) or (Month shl 5) or Day); // converting to word to ignore any overflows
  LastModFileTime := Word((Hour shl 11) or (Minute shl 5) or (Second shr 1));
end;

{ TZipEndOfCentralDirectory }

procedure TZipEndOfCentralDirectory.Init;
begin
  MagicNumber := $06054b50;
  NumberOfThisDisk := 0;
  NumberOfTheDiskWithTheStartOfTheCentralDirectory := 0;
  TotalNumberOfEntriesInTheCentralDirectoryOnThisDisk := 1;
  TotalNumberOfEntriesInTheCentralDirectory := 1;
end;

procedure TZipEndOfCentralDirectory.LoadFromStream(Stream: TStream);
begin
  Stream.Read(Self, 22);
  SetLength(ZIPFileComment, ZIPFileCommentLength);
  Read(ZIPFileComment[1], ZIPFIleCommentLength);
end;

procedure TZipEndOfCentralDirectory.SaveToStream(Stream: TStream);
begin
  MagicNumber := $06054b50;
  ZIPFileCommentLength := Length(ZIPFileComment);
  Stream.Write(Self, 22);
  if ZIPFileCommentLength > 0 then
  Stream.Write(ZIPFileComment[1], ZIPFileCommentLength);
end;

end.
