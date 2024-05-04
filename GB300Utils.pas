unit GB300Utils;

interface

uses
  SysUtils, Classes, Graphics, pngimage, Windows, Generics.Collections,
  inifiles;

var
  Path: string = 'M:\'; // must include trailing backslash

type
  TImageDataFormat = (idfRGB565, idfBGRA8888);

procedure GetDIBStreamFromStream(Input, Output: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0); overload;
function  GetDIBStreamFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TMemoryStream; overload;
function  GetDIBImageFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TWICImage;
function  GetPNGImageFromStream(Input: TStream; Format: TImageDataFormat; Width: Integer; Height: Integer = 0): TPngImage;
procedure WriteGraphicToStream(Input: TGraphic; Output: TStream; Format: TImageDataFormat; ExpectedWidth, ExpectedHeight: Integer; ExpectAlpha: Boolean);


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
    strict private
      FileNameLength: Word;
      ExtraFieldLength: Word;
    public
      FileName: string;
      ExtraField: RawByteString;
      procedure LoadFromStream(Stream: TStream);
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
    strict private
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
    public
      property StoredCRC: Cardinal read GetStoredCRC write SetStoredCRC;
      property CalculatedCRC: Cardinal read GetCalculatedCRC;
      property BootLogo: TGraphic read GetBootLogo write SetBootLogo; // needs to be freed by caller
      property IsCRCValid: Boolean read GetIsCRCValid;
      procedure SaveBootLogoToStream(Stream: TStream);
      function GetScreenIndex(): TScreenIndex;
      class property Path: string read GetPath;
      const
        CRCOffset = $18c;
        DisplayInitOffset = $6cbfa4; // we're starting 2 bytes early because the init code basically starts there
        BootLogoOffset = $670a54;
        BootLogoWidth = 640;
        BootLogoHeight = 136;
  end;

  TFoldername = record
    private
      function GetAbsoluteFolder(Index: Byte): string;
    public
      const
        Header = 'GB300';
      var
        Languages: Integer;
        DefaultColor: TColor;
        SelectedColors: array[0..9] of TColor;
        Folders: array[0..9] of string;
        TabCount: Integer;
        InitialLeftTab: Integer;
        InitialSelectedTab: Integer;
        DownloadROMsFile: Integer;
        FavoritesFile: Integer;
        HistoryFile: Integer;
        SearchTab: Integer;
        SystemTab: Integer;
        ThumbnailPosition: TPoint;
        ThumbnailSize: TPoint;
        SelectionSize: TPoint;
        procedure LoadFromFile();
        procedure SaveToFile();
        function GetTabName(Index: Byte): string;
        function GetTabStaticName(Index: Byte): string;
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
      FStream: TMemoryStream;
      function GetROM: TMemoryStream;
      function GetThumbnail: TGraphic;
      procedure SetThumbnail(const Value: TGraphic);
      function GetROMFileName: string;
      function GetHeader: TZipLocalHeader;
      function GetThumbnailSize: Integer;
      class function GetDefaultThumbnailSize: Integer; static;
      function GetIsMultiCore: Boolean; overload;
      function GetMCName: TMulticoreName; overload;
    public
      property HasImage: Boolean read FHasImage;
      property IsCompressed: Boolean read FIsCompressed;
      property IsFinalBurn: Boolean read FIsFinalBurn;
      property Thumbnail: TGraphic read GetThumbnail write SetThumbnail; // needs to be freed by caller
      procedure SaveThumbnailToStream(Stream: TStream);
      procedure Compress(const Lead: Integer);
      procedure MakeFinalBurn();
      procedure Decompress();
      property ROMFileName: string read GetROMFileName;
      property MCName: TMulticoreName read GetMCName;
      class function GetMCName(FN: string): TMulticoreName; overload;
      property IsMultiCore: Boolean read GetIsMultiCore;
      class function GetIsMultiCore(FN: string): Boolean; overload;
      property ROM: TMemoryStream read GetROM; // needs to be freed by caller
      procedure SetROM(Value: TStream; const Name: string);
      procedure LoadFromFile(FolderIndex: Byte; FileName: string);
      procedure SaveToFile(FolderIndex: Byte; FileName: string);
      property ThumbnailSize: Integer read GetThumbnailSize;
      constructor Create();
      destructor Destroy(); override;
      class function FileNameToType(const FileName: string): TFileType;
      class function FileNameToImageIndex(const FileName: string): Integer;
      class function FileTypeToFilter(FileType: TFileType; AllFiles: Boolean): string;
      class function FileTypeToThumbExt(FileType: TFileType): string;
      class procedure Patch(ROM: TStream; PatchFile: string); overload;
      procedure Patch(PatchFile: string); overload;
      class function GetROMsIn(FolderIndex: Byte): TList<string>;
      function GetCRC: Cardinal;
  end;

  TState = class (TMemoryStream)
    function GetScreenshot: TPngImage; // PNG
    function GetScreenshotData(var Dimensions: TPoint): TMemoryStream; // no header
    procedure SaveScreenshotToStream(Stream: TStream); // DIB
    procedure SaveStateToStream(Stream: TStream);
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
    function Apply(FileNameList: TNameList; FolderIndex: Byte): Boolean; // supports moving and deleting (adding is not required because it will not change anything)
    procedure Rename(FolderIndex: Byte; OldFileName: string; NewFileName: string);
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
  FileNamesFilenames:    array[0..7] of string = ('rdbui.tax', 'urefs.tax', 'scksp.tax', 'vdsdc.tax', 'pnpui.tax', 'vfnet.tax', 'mswb7.tax', 'tsmfk.tax');
  ChineseNamesFilenames: array[0..6] of string = ('fhcfg.nec', 'adsnt.nec', 'setxa.nec', 'umboa.nec', 'wjere.nec', 'htuiw.nec', 'msdtc.nec');
  PinyinNamesFilenames:  array[0..6] of string = ('nethn.bvs', 'xvb6c.bvs', 'wmiui.bvs', 'qdvd6.bvs', 'mgdel.bvs', 'sppnp.bvs', 'mfpmp.bvs');

  DefaultFoldername: TFoldername =
    (Languages: 7;
     DefaultColor: clWhite;
     SelectedColors: ($80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff, $80ff);
     Folders: ('FC', 'PCE', 'SFC', 'MD', 'GB', 'GBC', 'GBA', 'ROMS', 'ROMS', 'ROMS');
     TabCount: 12;
     InitialLeftTab: 0;
     InitialSelectedTab: 3;
     DownloadROMsFile: 7;
     FavoritesFile: 8;
     HistoryFile: 9;
     SearchTab: 10;
     SystemTab: 11;
     ThumbnailPosition: (X: 20; Y: 112);
     ThumbnailSize: (X: 144; Y: 208);
     SelectionSize: (X: 424; Y: 58));

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
  HasMulticore: Boolean;
  NoIntro: TDictionary<Cardinal, TNoIntro> = nil;
  INI: TIniFile;

implementation

uses
  Zlib, DateUtils;

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
  Result.SaveToFile('temp.png');
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

function TBIOS.GetBootLogo: TGraphic;
begin
  Position := BootLogoOffset;
  Result := GetDIBImageFromStream(Self, idfRGB565, BootLogoWidth, BootLogoHeight);
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

function TBIOS.GetIsCRCValid: Boolean;
begin
  Result := StoredCRC = CalculatedCRC;
end;

class function TBIOS.GetPath: string;
begin
  Result := IncludeTrailingPathDelimiter(GB300Utils.Path + 'bios') + 'bisrv.asd';
end;

function TBIOS.GetScreenIndex: TScreenIndex;
function Match(Resource: Word): Boolean;
var
  RS: TResourceStream;
  B1, B2: Byte;
begin
  RS := TResourceStream.CreateFromID(HInstance, Resource, RT_RCDATA);
  try
    Self.Position := TBIOS.DisplayInitOffset;
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
begin
  if Match(300) then
  Exit(siGB300);
  if Match(2000) then
  Exit(siSF2000);
  Result := siUnmatched;
end;

function TBIOS.GetStoredCRC: Cardinal;
begin
  Position := CRCOffset;
  ReadData(Result);
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

procedure TBIOS.SetStoredCRC(Value: Cardinal);
begin
  Position := CRCOffset;
  WriteData(Value);
end;

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
  Count: Cardinal; // limited to 1000, but still an Int32
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
      if r.FolderIndex <= High(FileNamesFilenames) then
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

procedure TReferenceList.Rename(FolderIndex: Byte; OldFileName, NewFileName: string);
var
  i: Integer;
  r: TReference;
begin
  for i := 0 to Self.Count - 1 do
  if Self[i].FolderIndex = FolderIndex then
  if Self[i].FileName = OldFileName then
  begin
    r := Self[i];
    r.FileName := NewFileName;
    Self[i] := r;
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
      Header.FileName := ROMFileName;
      Header.UncompressedSize := FStream.Size;
      Header.LastModFileDateTime.AsDateTime := Now();
      Header.CRC32 := GetCRC();

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

constructor TROMFile.Create;
begin
  FStream := TMemoryStream.Create();
end;

procedure TROMFile.Decompress;
var
  OldStream: TStream;
begin
  OldStream := FStream;
  FStream := ROM;
  FIsCompressed := False;
  FHasImage := False;
  OldStream.Free();
end;

destructor TROMFile.Destroy;
begin
  FStream.Free();
  inherited;
end;

class function TROMFile.FileNameToImageIndex(const FileName: string): Integer;
begin
  if TROMFile.GetIsMultiCore(FileName) then
  Result := Ord(TROMFile.FileNameToType(TROMFile.GetMCName(FileName).Name))
  else
  Result := Ord(TROMFile.FileNameToType(FileName));
end;

class function TROMFile.FileNameToType(const FileName: string): TFileType;
var
  Ext: string;
begin
  Ext := Lowercase(ExtractFileExt(FileName));
  Delete(Ext, 1, 1);
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
  if (Ext = 'zfc') or (Ext = 'zsf') or (Ext = 'zpc') or (Ext = 'zmd') or (Ext = 'zgb') then
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
    ftGB, ftGBA: Result := '.zgb';
    else Result := '.zfb';
  end;
end;

function TROMFile.GetCRC: Cardinal;
var
  ROM: TMemoryStream;
  HeaderTest: Cardinal;
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
      ROM.Position := 0;
      Exit(not update_crc($ffffffff, Pointer(NativeInt(ROM.Memory)+ROM.Position), ROM.Size-ROM.Position));
    finally
      ROM.Free();
    end;
  end;


  if IsCompressed then
  Exit(GetHeader().CRC32);

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
var
  Ext: string;
begin
  Ext := Lowercase(ExtractFileExt(FN));
  Result := (Pos(';', FN) > 0) and ((Ext = '.gba') or (Ext = '.gbz') or (Ext = '.agb'));
end;

function TROMFile.GetIsMultiCore: Boolean;
var
  s: string;
begin
  s := FROMName;
  Result := GetIsMultiCore(s);

  if Result then
  if IsCompressed then
  //Result := GetCRC() = 0
  else
  if not FIsFinalBurn then // if this is already FinalBurn, Result is already True
  Result := FStream.Size = 0;
end;

class function TROMFile.GetMCName(FN: string): TMulticoreName;
begin
  Result.Name := ChangeFileExt(FN, '');
  Result.Core := Lowercase(Copy(Result.Name, 1, Pos(';', Result.Name) - 1));
  Delete(Result.Name, 1, Length(Result.Core) + 1);
  Result.AbsoluteFileName := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path + 'ROMS') + Result.Core) + Result.Name;
end;

function TROMFile.GetMCName: TMulticoreName;
begin
  if not IsMultiCore then
  raise Exception.Create('Cannot parse multicore name for non-multicore file (internal error, please report)');

  Result := GetMCName(FROMName);
end;

function TROMFile.GetROM: TMemoryStream;
var
  Header: TZipLocalHeader;
  ZLib: TZDecompressionStream;
begin
  Result := TMemoryStream.Create();
  try
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
    if IsMultiCore then
    begin
      Result.LoadFromFile(GetMCName().AbsoluteFileName);
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
//var
//  Temp: RawByteString;
begin
  {if IsFinalBurn then
  begin
    FStream.Position := ThumbnailSize + 4;
    SetLength(Temp, FStream.Size - FStream.Position - 2);
    FStream.Read(Temp[1], Length(Temp));
    Result := UTF8ToUnicodeString(Temp);
  end
  else}
  if GetIsMultiCore(FROMName) then
  Result := GetMCName(FROMName).Name
  else
  if IsCompressed then
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
        if ExtDir.ContainsKey(ExtractFileExt(SearchRec.Name)) then
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

function TROMFile.GetThumbnailSize: Integer;
begin
  // TODO: support incorrect image sizes?
  Result := GetDefaultThumbnailSize;
end;

procedure TROMFile.LoadFromFile(FolderIndex: Byte; FileName: string);
var
  c: Cardinal;
begin
  FStream.LoadFromFile(IncludeTrailingPathDelimiter(Path + Foldername.Folders[FolderIndex]) + FileName);
  FHasImage := False;
  FIsCompressed := False;
  FIsFinalBurn := False;
  FStream.ReadData(c);
  case c of
    $03575157, $04034B50: FIsCompressed := True;
    else
      if FStream.Size > ThumbnailSize + SizeOf(Cardinal) then
      begin
        FStream.Position := ThumbnailSize;
        FStream.ReadData(c);
        case c of
          0:
            begin
              FIsFinalBurn := True;
              FHasImage := True;
            end;
          $03575157, $04034B50:
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
    FIsFinalBurn := True;
  finally
    Temp.Free();
  end;
end;

procedure TROMFile.Patch(PatchFile: string);
var
  TempROM: TMemoryStream;
begin
  TempROM := ROM;
  try
    Patch(TempROM, PatchFile);
    SetROM(TempROM, ROMFileName);
  finally
    TempROM.Free();
  end;
end;

class procedure TROMFile.Patch(ROM: TStream; PatchFile: string);
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

procedure TROMFile.SaveThumbnailToStream(Stream: TStream);
begin
  FStream.Position := 0;
  GetDIBStreamFromStream(FStream, Stream, idfRGB565, Foldername.ThumbnailSize.X, Foldername.ThumbnailSize.Y);
end;

procedure TROMFile.SaveToFile(FolderIndex: Byte; FileName: string);
var
  MS: TMemoryStream;
begin
  if GetIsMultiCore(FileName) then // new name is Multicore
  begin
    with GetMCName(FileName) do
    FStream.SaveToFile(AbsoluteFileName);
    if not FileExists(Foldername.AbsoluteFolder[FolderIndex] + FileName) then // no stub
    begin
      MS := TMemoryStream.Create();
      try
        MS.SaveToFile(Foldername.AbsoluteFolder[FolderIndex] + FileName); // make stub
      finally
        MS.Free();
      end;
    end;
  end
  else
  FStream.SaveToFile(Foldername.AbsoluteFolder[FolderIndex] + FileName);
  // requires recreating TROMFile
end;

procedure TROMFile.SetROM(Value: TStream; const Name: string);
var
  Image: TMemoryStream;
begin
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

{ TZipLocalHeader }

procedure TZipLocalHeader.LoadFromStream(Stream: TStream);
var
  i: Word;
  TempFileName: RawByteString;
begin
  Stream.Read(Self, 30);
  SetLength(TempFileName, FileNameLength);
  Stream.Read(TempFileName[1], FileNameLength);
  if FileNameLength > 0 then
  SetLength(ExtraField, ExtraFieldLength);
  if ExtraFieldLength > 0 then
  Stream.Read(ExtraField[1], ExtraFieldLength);
  // Adjustment for WQW
  if MagicNumber = $03575157 then
  for i := 1 to FileNameLength do
  TempFileName[i] := AnsiChar(Byte(TempFileName[i]) xor $e5);
  if (GeneralPurposeBitFlag shr 11) and 1 = 1 then
  FileName := UTF8ToUnicodeString(TempFileName)
  else
  FileName := string(TempFileName);
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
  Stream.Read(TempFileName[1], FileNameLength);
  SetLength(ExtraField, ExtraFieldLength);
  Stream.Read(ExtraField[1], ExtraFieldLength);
  SetLength(TempFileComment, FileCommentLength);
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
  for i := 0 to 7 do
  ForceDirectories(IncludeTrailingPathDelimiter(Path + Folders[i]) + 'save');
end;

function TFoldername.GetAbsoluteFolder(Index: Byte): string;
begin
  Result := IncludeTrailingPathDelimiter(Path + Foldername.Folders[Index]);
end;

function TFoldername.GetTabName(Index: Byte): string;
begin
  case Index of
    0..6: Exit(Folders[Index]);
    7: Exit(Folders[DownloadROMsFile]);
  end;
  if Index = FavoritesFile then
  Exit('Favorites');
  if Index = HistoryFile then
  Exit('History');
  if Index = SearchTab then
  Exit('Search');
  if Index = SystemTab then
  Exit('System');
  Result := '';
end;

function TFoldername.GetTabStaticName(Index: Byte): string;
begin
  if Index = 10 then
  Exit('Search');
  if Index = 11 then
  Exit('System');
  Exit(GetTabName(Index));
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

    if SL.Count <> 17 then
    raise Exception.Create('Invalid ''Foldername.ini'' line count');

    // Row 0
    if SL[0] <> 'GB300' then
    raise Exception.CreateFmt('Invalid ''Foldername.ini'' device name (%s)', [SL[0]]);

    // Row 1
    if SL[1] <> '7' then
    raise Exception.CreateFmt('Unsupported ''Foldername.ini'' language count (%s)', [SL[0]]);
    Languages := StrToInt(SL[1]);

    // Row 2
    s := SL[2];
    DefaultColor := GetTokenHex();

    // Row 3-12
    for i := 0 to 9 do
    HandleFolder(i);

    // Row 13
    s := SL[13];
    if GetToken <> '12' then
    raise Exception.Create('Unsupported Foldername.ini total tab count');
    TabCount := 12;
    InitialLeftTab := StrToInt(GetToken());
    if (InitialLeftTab < 0) or (InitialLeftTab > 11) then
    raise Exception.Create('Invalid Foldername.ini initial left tab index');
    InitialSelectedTab := StrToInt(GetToken());
    if (InitialSelectedTab < 0) or (InitialSelectedTab > 5) then
    raise Exception.Create('Invalid Foldername.ini initial selected tab index');

    // Row 14
    if SL[14] <> '7 8 9 10 11' then
    raise Exception.Create('Unsupported Foldername.ini configuration for the last 5 tabs');
    DownloadROMsFile := 7;
    FavoritesFile := 8;
    HistoryFile := 9;
    SearchTab := 10;
    SystemTab := 11;

    // Row 15
    s := SL[15];
    ThumbnailPosition.X := StrToInt(GetToken());
    ThumbnailPosition.Y := StrToInt(GetToken());
    ThumbnailSize.X := StrToInt(GetToken());
    ThumbnailSize.Y := StrToInt(GetToken());

    // Row 16
    s := SL[16];
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
    SL.Add(IntToStr(TabCount) + ' ' + IntToStr(InitialLeftTab) + ' ' + IntToStr(InitialSelectedTab));
    SL.Add(IntToStr(DownloadROMsFile) + ' ' + IntToStr(FavoritesFile) + ' ' + IntToStr(HistoryFile) + ' ' + IntToStr(SearchTab) + ' ' + IntToStr(SystemTab));
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
    Zlib := TZDecompressionStream.Create(Self);
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

procedure TState.SaveStateToStream(Stream: TStream);
var
  Offset1, Offset2: Cardinal;
  Zlib: TZDecompressionStream;
begin
  Position := Size - 4;
  ReadData(Offset2);
  Position := 0;
  ReadData(Offset1);
  if Offset1 + 4 = Offset2 then
  begin
    Zlib := TZDecompressionStream.Create(Self);
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
