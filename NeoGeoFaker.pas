unit NeoGeoFaker;

interface

uses
  Generics.Collections, Classes;

type
  TNeoGeoFakeSource = record
    Name: string;
    Title: string;
    Status: string;
    Stock: string;
    Msg: string;
    CMode: Integer;
    PMode: Integer;
    Target: string;
    C, M, P, S, V: array of Cardinal;
    DifOld: TArray<Cardinal>;
    DifDif: TArray<Cardinal>;
    class procedure EnsureXMLLoaded(); static;
  end;

  TNeoGeoFakeTargetSize = array[0..4] of Integer;
  TOutputWriter = procedure(Stream: TMemoryStream; FileName: string) of object;
  TStreamMethod = procedure(Stream: TStream) of object;

  TNeoGeoFakeTarget = class
    class procedure C0(Stream: TStream); virtual; abstract;
    class procedure C1(Stream: TStream); virtual; abstract;
    class procedure M(Stream: TStream); virtual; abstract;
    class procedure P(Stream: TStream); virtual; abstract;
    class procedure S(Stream: TStream); virtual;
    class procedure V(Stream: TStream); virtual; abstract;
    class function GetSizes(): TNeoGeoFakeTargetSize;
    class function GetName(): string; virtual; abstract;
    class procedure Partition(Stream: TStream; FileName: string; Size, CRC: Cardinal; FakeCRC: Boolean = False);
    class procedure FakeCRC(Stream: TBytesStream; Target: Cardinal);
    class var
      OutputWriter: TOutputWriter;
    private class var
      TempSize: Cardinal;
  end;

  TNeoGeoFakeTargetClass = class of TNeoGeoFakeTarget;

  kof98n = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  garoup = class(TNeoGeoFakeTarget) // needs modified BIOS!
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  garou = class(TNeoGeoFakeTarget) // does not share any similarities with garoup
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  jockeygp = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kof2000 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kof2001 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kof2002 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kof2003 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kof99 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  matrim = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslug3 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslug4 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslug5 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  pnyaa = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  rotd = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  samsho5 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  sengoku3 = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  samsh5sp = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kf10thep = class(TNeoGeoFakeTarget) // does not share any similarities with kof2002
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kf2k3bl = class(TNeoGeoFakeTarget) // does not share any similarities with kof2003
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kf2k3bla = class(kf2k3bl)
    class procedure P(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kf2k3pl = class(kf2k3bl)
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  cthd2003 = class(kof2001)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  ct2k3sp = class(cthd2003)
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  ct2k3sa = class(cthd2003)
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslug3h = class(mslug3)
    class procedure P(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslug3b6 = class(mslug3h)
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslug3hd = class(mslug3h)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  ms5plus = class(mslug5)
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  mslugx = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  svcboot = class(TNeoGeoFakeTarget)
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class procedure V(Stream: TStream); override;
    class function GetName(): string; override;
  end;

  kf2k5uni = class(kf10thep) // for C, only the last file of each is different
    class procedure C0(Stream: TStream); override;
    class procedure C1(Stream: TStream); override;
    class procedure M(Stream: TStream); override;
    class procedure P(Stream: TStream); override;
    class procedure S(Stream: TStream); override;
    class function GetName(): string; override;
  end;

var
  FakeSources: TDictionary<string, TNeoGeoFakeSource> = nil;

implementation

uses
  RedeemerXML, SysUtils, pngimage, GB300Utils, Math;

var
  crc_table_rev: Array[0..255] of Cardinal;
  crc_table_rev_computed: Boolean = False;

{ TNeoGeoFakeSource }

class procedure TNeoGeoFakeSource.EnsureXMLLoaded;
var
  XML: TRedeemerXML;
procedure HandleRecord();
var
  Temp: TNeoGeoFakeSource;
procedure TryHandleDiff();
var
  CRC: string;
begin
  if XML.GetAttribute('dif', CRC) then
  begin
      SetLength(Temp.DifOld, Length(Temp.DifOld) + 1);
      SetLength(Temp.DifDif, Length(Temp.DifOld));
      Temp.DifOld[High(Temp.DifOld)] := Cardinal(StrToInt('x' + XML.GetAttribute('crc')));
      Temp.DifDif[High(Temp.DifOld)] := Cardinal(StrToInt('x' + XML.GetAttribute('dif')));
  end;
end;
begin
  // this is its own method to always start with an empty record
  Temp.Name := XML.GetAttribute('name');
  Temp.Status := XML.GetAttribute('status');
  Temp.Stock := XML.GetAttribute('stock');
  Temp.Msg := XML.GetAttribute('msg');
  Temp.CMode := StrToIntDef(XML.GetAttribute('c'), 1);
  Temp.PMode := StrToIntDef(XML.GetAttribute('p'), 0);
  Temp.Target := XML.GetAttributeDef('target', 'garoup');
  while XML.GoToAndGetNextTag() do
  begin
    if XML.CurrentTag = '/fake' then
    begin
      FakeSources.Add(Temp.Name, Temp);
      Exit;
    end
    else
    if XML.CurrentTag = 'title' then
    Temp.Title := XML.GetInnerTextAndSkip()
    else
    if XML.CurrentTag = 'p' then
    begin
      SetLength(Temp.P, Length(Temp.P) + 1);
      Temp.P[High(Temp.P)] := Cardinal(StrToInt('x' + XML.GetAttribute('crc')));
      TryHandleDiff();
    end
    else
    if XML.CurrentTag = 's' then
    begin
      SetLength(Temp.S, Length(Temp.S) + 1);
      Temp.S[High(Temp.S)] := Cardinal(StrToInt('x' + XML.GetAttribute('crc')));
      TryHandleDiff();
    end
    else
    if XML.CurrentTag = 'c' then
    begin
      SetLength(Temp.C, Length(Temp.C) + 1);
      Temp.C[High(Temp.C)] := Cardinal(StrToInt('x' + XML.GetAttribute('crc')));
      TryHandleDiff();
    end
    else
    if XML.CurrentTag = 'm' then
    begin
      SetLength(Temp.M, Length(Temp.M) + 1);
      Temp.M[High(Temp.M)] := Cardinal(StrToInt('x' + XML.GetAttribute('crc')));
      TryHandleDiff();
    end
    else
    if XML.CurrentTag = 'v' then
    begin
      SetLength(Temp.V, Length(Temp.V) + 1);
      Temp.V[High(Temp.V)] := Cardinal(StrToInt('x' + XML.GetAttribute('crc')));
      TryHandleDiff();
    end;
  end;
end;
var
  RS: TResourceStream;
  SS: TStringStream;
begin
  if Assigned(FakeSources) then
  Exit;

  FakeSources := TDictionary<string, TNeoGeoFakeSource>.Create();
  RS := TResourceStream.CreateFromID(hInstance, 2, 'XML');
  try
    SS := TStringStream.Create();
    try
      SS.LoadFromStream(RS);
      XML := TRedeemerXML.Create(SS.DataString);
      try
        while XML.GoToAndGetNextTag() do
        if XML.CurrentTag = 'fake' then
        HandleRecord();
      finally
      end;
    finally
      SS.Free();
    end;
  finally
    RS.Free();
  end;
end;

{ TNeoGeoFakeTarget }

class procedure TNeoGeoFakeTarget.FakeCRC(Stream: TBytesStream; Target: Cardinal);
// submethod taken from PNGDelphi and adjusted to a reverse version
procedure make_crc_table_rev;
var
  c: Cardinal;
  n, k: Integer;
begin
  {fill the crc table}
  for n := 0 to 255 do
  begin
    c := Cardinal(n) shl 24;
    for k := 0 to 7 do
    begin
      if Boolean(c shr 31) then
        c := ((c xor $edb88320) shl 1) or 1
      else
        c := c shl 1;
    end;
    crc_table_rev[n] := c;
  end;
  crc_table_rev_computed := True;
end;
// Thanks to osaka for providing efficient code that even I could understand and adapt
var
  CRC: Cardinal;
  i: Integer;
begin
  CRC := update_crc($ffffffff, Stream.Memory, Stream.Size - 4);
  Stream.Position := Stream.Size - 4;
  Stream.WriteData(CRC);

  if not crc_table_rev_computed then
  make_crc_table_rev();

  Target := not Target;
  for i := Stream.Size - 1 downto Stream.Size - 4 do
  Target := (Target shl 8) xor crc_table_rev[Target shr 24] xor Stream.Bytes[i];

  Stream.Position := Stream.Size - 4;
  Stream.WriteData(Target);
end;

class function TNeoGeoFakeTarget.GetSizes: TNeoGeoFakeTargetSize;
begin
  TempSize := 0;
  C0(nil);
  C1(nil);
  Result[0] := TempSize div 1024;

  TempSize := 0;
  M(nil);
  Result[1] := TempSize div 1024;

  TempSize := 0;
  P(nil);
  Result[2] := TempSize div 1024;

  TempSize := 0;
  S(nil);
  Result[3] := TempSize div 1024;

  TempSize := 0;
  V(nil);
  Result[4] := TempSize div 1024;
end;

class procedure TNeoGeoFakeTarget.Partition(Stream: TStream; FileName: string; Size, CRC: Cardinal; FakeCRC: Boolean);
var
  BS: TBytesStream;
begin
  if not Assigned(Stream) then
  begin
    TempSize := TempSize + Size;
    Exit;
  end;

  BS := TBytesStream.Create();
  try
    BS.Size := Size;
    if Stream.Size - Stream.Position > 0 then
    BS.CopyFrom2(Stream, Min(Size, Stream.Size - Stream.Position));
    if FakeCRC then
    Self.FakeCRC(BS, CRC);
    OutputWriter(BS, FileName);
  finally
    BS.Free();
  end;
end;

class procedure TNeoGeoFakeTarget.S(Stream: TStream);
begin
end;

{ kof98n }

class procedure kof98n.C0(Stream: TStream);
begin
  Partition(Stream, '242-c1.bin', $800000, $e564ecd6);
  Partition(Stream, '242-c3.bin', $800000, $22127b4f);
  Partition(Stream, '242-c5.bin', $800000, $9d10bed3);
  Partition(Stream, '242-c7.bin', $800000, $f6d7a38a);
end;

class procedure kof98n.C1(Stream: TStream);
begin
  Partition(Stream, '242-c2.bin', $800000, $bd959b60);
  Partition(Stream, '242-c4.bin', $800000, $0b4fa044);
  Partition(Stream, '242-c6.bin', $800000, $da07b6a2);
  Partition(Stream, '242-c8.bin', $800000, $c823e045);
end;

class function kof98n.GetName: string;
begin
  Result := 'The King of Fighters ''98 - The Slugfest / King of Fighters ''98 - dream match never ends (not encrypted)';
end;

class procedure kof98n.M(Stream: TStream);
begin
  Partition(Stream, '242-m1.bin', $040000, $4e7a6b1b);
end;

class procedure kof98n.P(Stream: TStream);
begin
  Partition(Stream, '242-pn1.bin',$100000, $61ac868a);
  Partition(Stream, '242-p2.bin', $400000, $980aba4c);
end;

class procedure kof98n.S(Stream: TStream);
begin
  Partition(Stream, '242-s1.bin', $020000, $7f7b4805);
end;

class procedure kof98n.V(Stream: TStream);
begin
  Partition(Stream, '242-v1.bin', $400000, $b9ea8051);
  Partition(Stream, '242-v2.bin', $400000, $cc11106e);
  Partition(Stream, '242-v3.bin', $400000, $044ea4e1);
  Partition(Stream, '242-v4.bin', $400000, $7985ea30);
end;

{ garoup }

class procedure garoup.C0(Stream: TStream);
begin
  Partition(Stream, '253-c1p.bin', $800000, $5bb5d137);
  Partition(Stream, '253-c3p.bin', $800000, $234d16fc);
  Partition(Stream, '253-c5p.bin', $800000, $722615d2);
  Partition(Stream, '253-c7p.bin', $800000, $d68e806f);
end;

class procedure garoup.C1(Stream: TStream);
begin
  Partition(Stream, '253-c2p.bin', $800000, $5c8d2960);
  Partition(Stream, '253-c4p.bin', $800000, $b9b5b993);
  Partition(Stream, '253-c6p.bin', $800000, $0a6fab38);
  Partition(Stream, '253-c8p.bin', $800000, $f778fe99);
end;

class function garoup.GetName: string;
begin
  Result := 'Garou - Mark of the Wolves (prototype)';
end;

class procedure garoup.M(Stream: TStream);
begin
  Partition(Stream, '253-m1p.bin', $040000, $bbe464f7);
end;

class procedure garoup.P(Stream: TStream);
begin
  Partition(Stream, '253-p1p.bin', $100000, $c72f0c16);
  Partition(Stream, '253-p2p.bin', $800000, $bf8de565);
end;

class procedure garoup.S(Stream: TStream);
begin
  Partition(Stream, '253-s1p.bin', $020000, $779989de);
end;

class procedure garoup.V(Stream: TStream);
begin
  Partition(Stream, '253-v1p.bin', $400000, $274f3923);
  Partition(Stream, '253-v2p.bin', $400000, $8f86dabe);
  Partition(Stream, '253-v3p.bin', $400000, $05fd06cd);
  Partition(Stream, '253-v4p.bin', $400000, $14984063);
end;

{ garou }

class procedure garou.C0(Stream: TStream);
begin
  Partition(Stream, '253-c1.bin', $800000, $0603e046);
  Partition(Stream, '253-c3.bin', $800000, $6737c92d);
  Partition(Stream, '253-c5.bin', $800000, $3eab5557);
  Partition(Stream, '253-c7.bin', $800000, $c0e995ae);
end;

class procedure garou.C1(Stream: TStream);
begin
  Partition(Stream, '253-c2.bin', $800000, $0917d2a4);
  Partition(Stream, '253-c4.bin', $800000, $5ba92ec6);
  Partition(Stream, '253-c6.bin', $800000, $308d098b);
  Partition(Stream, '253-c8.bin', $800000, $21a11303);
end;

class function garou.GetName: string;
begin
  Result := 'Garou - Mark of the Wolves (set 1)';
end;

class procedure garou.M(Stream: TStream);
begin
  Partition(Stream, '253-m1.bin', $040000, $36a806be);
end;

class procedure garou.P(Stream: TStream);
begin
  Partition(Stream, '253-sma.bin', $040000, $98bc93dc);
  Partition(Stream, '253-ep1.p1',  $200000, $ea3171a4);
  Partition(Stream, '253-ep2.p2',  $200000, $382f704b);
  Partition(Stream, '253-ep3.p3',  $200000, $e395bfdd);
  Partition(Stream, '253-ep4.p4',  $200000, $da92c08e);
end;

class procedure garou.V(Stream: TStream);
begin
  Partition(Stream, '253-v1.bin', $400000, $263e388c);
  Partition(Stream, '253-v2.bin', $400000, $2c6bc7be);
  Partition(Stream, '253-v3.bin', $400000, $0425b27d);
  Partition(Stream, '253-v4.bin', $400000, $a54be8a9);
end;

{ jockeygp }

class procedure jockeygp.C0(Stream: TStream);
begin
  Partition(Stream, 'jgp-c1.bin', $800000, $a9acbf18);
end;

class procedure jockeygp.C1(Stream: TStream);
begin
  Partition(Stream, 'jgp-c2.bin', $800000, $6289eef9);
end;

class function jockeygp.GetName: string;
begin
  Result := 'Jockey Grand Prix';
end;

class procedure jockeygp.M(Stream: TStream);
begin
  Partition(Stream, 'jgp-m1_decrypted.bin', $080000, $1cab4de2);
  Partition(Stream, 'jgp-m1.bin', $080000, $d163c690);
end;

class procedure jockeygp.P(Stream: TStream);
begin
  Partition(Stream, 'jgp-p1.bin', $100000, $2fb7f388);
end;

class procedure jockeygp.V(Stream: TStream);
begin
  Partition(Stream, 'jgp-v1.bin', $200000, $443eadba);
end;

{ kof2000 }

class procedure kof2000.C0(Stream: TStream);
begin
  Partition(Stream, '257-c1.bin', $800000, $cef1cdfa);
  Partition(Stream, '257-c3.bin', $800000, $101e6560);
  Partition(Stream, '257-c5.bin', $800000, $89775412);
  Partition(Stream, '257-c7.bin', $800000, $7da11fe4);
end;

class procedure kof2000.C1(Stream: TStream);
begin
  Partition(Stream, '257-c2.bin', $800000, $f7bf0003);
  Partition(Stream, '257-c4.bin', $800000, $bd2fc1b1);
  Partition(Stream, '257-c6.bin', $800000, $fa7200d5);
  Partition(Stream, '257-c8.bin', $800000, $b1afa60b);
end;

class function kof2000.GetName: string;
begin
  Result := 'The King of Fighters 2000';
end;

class procedure kof2000.M(Stream: TStream);
begin
  Partition(Stream, '257-m1_decrypted.bin', $040000, $d404db70);
  Partition(Stream, '257-m1.bin', $040000, $4b749113);
end;

class procedure kof2000.P(Stream: TStream);
begin
  Partition(Stream, '257-sma.bin', $040000, $71c6e6bb);
  Partition(Stream, '257-p1.bin',  $400000, $60947b4c);
  Partition(Stream, '257-p2.bin',  $400000, $1b7ec415);
end;

class procedure kof2000.V(Stream: TStream);
begin
  Partition(Stream, '257-v1.bin', $400000, $17cde847);
  Partition(Stream, '257-v2.bin', $400000, $1afb20ff);
  Partition(Stream, '257-v3.bin', $400000, $4605036a);
  Partition(Stream, '257-v4.bin', $400000, $764bbd6b);
end;

{ kof2001 }

class procedure kof2001.C0(Stream: TStream);
begin
  Partition(Stream, '262-c1-08-e0.bin', $800000, $99cc785a);
  Partition(Stream, '262-c3-08-e0.bin', $800000, $fb14ff87);
  Partition(Stream, '262-c5-08-e0.bin', $800000, $91f24be4);
  Partition(Stream, '262-c7-08-e0.bin', $800000, $54d9d1ec);
end;

class procedure kof2001.C1(Stream: TStream);
begin
  Partition(Stream, '262-c2-08-e0.bin', $800000, $50368cbf);
  Partition(Stream, '262-c4-08-e0.bin', $800000, $4397faf8);
  Partition(Stream, '262-c6-08-e0.bin', $800000, $a31e4403);
  Partition(Stream, '262-c8-08-e0.bin', $800000, $59289a6b);
end;

class function kof2001.GetName: string;
begin
  Result := 'The King of Fighters 2001';
end;

class procedure kof2001.M(Stream: TStream);
begin
  Partition(Stream, '265-262_decrypted-m1.bin', $040000, $4bcc537b);
  Partition(Stream, '265-262-m1.bin', $040000, $a7f8119f);
end;

class procedure kof2001.P(Stream: TStream);
begin
  Partition(Stream, '262-p1.bin', $100000, $9381750d);
  Partition(Stream, '262-p2.bin', $400000, $8e0d8329);
end;

class procedure kof2001.V(Stream: TStream);
begin
  Partition(Stream, '262-v1-08-e0.bin', $400000, $83d49ecf);
  Partition(Stream, '262-v2-08-e0.bin', $400000, $003f1843);
  Partition(Stream, '262-v3-08-e0.bin', $400000, $2ae38dbe);
  Partition(Stream, '262-v4-08-e0.bin', $400000, $26ec4dd9);
end;

{ kof2002 }

class procedure kof2002.C0(Stream: TStream);
begin
  Partition(Stream, '265-c1.bin', $800000, $2b65a656);
  Partition(Stream, '265-c3.bin', $800000, $875e9fd7);
  Partition(Stream, '265-c5.bin', $800000, $61bd165d);
  Partition(Stream, '265-c7.bin', $800000, $1a2749d8);
end;

class procedure kof2002.C1(Stream: TStream);
begin
  Partition(Stream, '265-c2.bin', $800000, $adf18983);
  Partition(Stream, '265-c4.bin', $800000, $2da13947);
  Partition(Stream, '265-c6.bin', $800000, $03fdd1eb);
  Partition(Stream, '265-c8.bin', $800000, $ab0bb549);
end;

class function kof2002.GetName: string;
begin
  Result := 'The King of Fighters 2002';
end;

class procedure kof2002.M(Stream: TStream);
begin
  Partition(Stream, '265-m1_decrypted.bin', $020000, $1c661a4b);
  Partition(Stream, '265-m1.bin', $020000, $85aaa632);
end;

class procedure kof2002.P(Stream: TStream);
begin
  Partition(Stream, '265-p1.bin', $100000, $9ede7323);
  Partition(Stream, '265-p2.bin', $400000, $327266b8);
end;

class procedure kof2002.V(Stream: TStream);
begin
  Partition(Stream, '265-v1.bin', $800000, $15e8f3f5);
  Partition(Stream, '265-v2.bin', $800000, $da41d6f9);
end;

{ kof2003 }

class procedure kof2003.C0(Stream: TStream);
begin
  Partition(Stream, '271-c1c.bin', $800000, $b1dc25d0);
  Partition(Stream, '271-c3c.bin', $800000, $0a1fbeab);
  Partition(Stream, '271-c5c.bin', $800000, $704ea371);
  Partition(Stream, '271-c7c.bin', $800000, $189aba7f);
end;

class procedure kof2003.C1(Stream: TStream);
begin
  Partition(Stream, '271-c2c.bin', $800000, $d5362437);
  Partition(Stream, '271-c4c.bin', $800000, $87b19a0c);
  Partition(Stream, '271-c6c.bin', $800000, $20a1164c);
  Partition(Stream, '271-c8c.bin', $800000, $20ec4fdc);
end;

class function kof2003.GetName: string;
begin
  Result := 'The King of Fighters 2003 (World / US, MVS)';
end;

class procedure kof2003.M(Stream: TStream);
begin
  Partition(Stream, '271-m1_decrypted.bin', $080000, $0e86af8f);
  Partition(Stream, '271-m1c.bin', $080000, $f5515629);
end;

class procedure kof2003.P(Stream: TStream);
begin
  Partition(Stream, '271-p1c.bin', $400000, $530ecc14);
  Partition(Stream, '271-p2c.bin', $400000, $fd568da9);
  Partition(Stream, '271-p3c.bin', $100000, $aec5b4a9);
end;

class procedure kof2003.V(Stream: TStream);
begin
  Partition(Stream, '271-v1c.bin', $800000, $ffa3f8c7);
  Partition(Stream, '271-v2c.bin', $800000, $5382c7d1);
end;

{ kof99 }

class procedure kof99.C0(Stream: TStream);
begin
  Partition(Stream, '251-c1.bin', $800000, $0f9e93fe);
  Partition(Stream, '251-c3.bin', $800000, $238755d2);
  Partition(Stream, '251-c5.bin', $800000, $0b0abd0a);
  Partition(Stream, '251-c7.bin', $800000, $ff65f62e);
end;

class procedure kof99.C1(Stream: TStream);
begin
  Partition(Stream, '251-c2.bin', $800000, $e71e2ea3);
  Partition(Stream, '251-c4.bin', $800000, $438c8b22);
  Partition(Stream, '251-c6.bin', $800000, $65bbf281);
  Partition(Stream, '251-c8.bin', $800000, $8d921c68);
end;

class function kof99.GetName: string;
begin
  Result := 'The King of Fighters ''99 - Millennium Battle (set 1)';
end;

class procedure kof99.M(Stream: TStream);
begin
  Partition(Stream, '251-m1.bin', $020000, $5e74539c);
end;

class procedure kof99.P(Stream: TStream);
begin
  Partition(Stream, '251-sma.kc', $040000, $6c9d0647);
  Partition(Stream, '251-p1.bin', $400000, $006e4532);
  Partition(Stream, '251-pg2.bin', $400000, $d9057f51);
end;

class procedure kof99.V(Stream: TStream);
begin
  Partition(Stream, '251-v1.bin', $400000, $ef2eecc8);
  Partition(Stream, '251-v2.bin', $400000, $73e211ca);
  Partition(Stream, '251-v3.bin', $400000, $821901da);
  Partition(Stream, '251-v4.bin', $200000, $b49e6178);
end;

{ matrim }

class procedure matrim.C0(Stream: TStream);
begin
  Partition(Stream, '266-c1.bin', $800000, $505f4e30);
  Partition(Stream, '266-c3.bin', $800000, $f1cc6ad0);
  Partition(Stream, '266-c5.bin', $800000, $9a15dd6b);
  Partition(Stream, '266-c7.bin', $800000, $4b71f780);
end;

class procedure matrim.C1(Stream: TStream);
begin
  Partition(Stream, '266-c2.bin', $800000, $3cb57482);
  Partition(Stream, '266-c4.bin', $800000, $45b806b7);
  Partition(Stream, '266-c6.bin', $800000, $281cb939);
  Partition(Stream, '266-c8.bin', $800000, $29873d33);
end;

class function matrim.GetName: string;
begin
  Result := 'Matrimelee / Shin Gouketsuji Ichizoku Toukon';
end;

class procedure matrim.M(Stream: TStream);
begin
  Partition(Stream, '266-m1_decrypted.bin', $020000, $d2f3742d);
  Partition(Stream, '266-m1.bin', $020000, $456c3e6c);
end;

class procedure matrim.P(Stream: TStream);
begin
  Partition(Stream, '266-p1.bin', $100000, $5d4c2dc7);
  Partition(Stream, '266-p2.bin', $400000, $a14b1906);
end;

class procedure matrim.V(Stream: TStream);
begin
  Partition(Stream, '266-v1.bin', $800000, $a4f83690);
  Partition(Stream, '266-v2.bin', $800000, $d0f69eda);
end;

{ mslug3 }

class procedure mslug3.C0(Stream: TStream);
begin
  Partition(Stream, '256-c1.bin', $800000, $5a79c34e);
  Partition(Stream, '256-c3.bin', $800000, $6e69d36f);
  Partition(Stream, '256-c5.bin', $800000, $7aacab47);
  Partition(Stream, '256-c7.bin', $800000, $cfceddd2);
end;

class procedure mslug3.C1(Stream: TStream);
begin
  Partition(Stream, '256-c2.bin', $800000, $944c362c);
  Partition(Stream, '256-c4.bin', $800000, $b755b4eb);
  Partition(Stream, '256-c6.bin', $800000, $c698fd5d);
  Partition(Stream, '256-c8.bin', $800000, $4d9be34c);
end;

class function mslug3.GetName: string;
begin
  Result := 'Metal Slug 3';
end;

class procedure mslug3.M(Stream: TStream);
begin
  Partition(Stream, '256-m1.bin', $080000, $eaeec116);
end;

class procedure mslug3.P(Stream: TStream);
begin
  Partition(Stream, '256-sma.bin', $040000, $9cd55736);
  Partition(Stream, '256-p1.bin', $400000, $b07edfd5);
  Partition(Stream, '256-p2.bin', $400000, $6097c26b);
end;

class procedure mslug3.V(Stream: TStream);
begin
  Partition(Stream, '256-v1.bin', $400000, $f2690241);
  Partition(Stream, '256-v2.bin', $400000, $7e2a10bd);
  Partition(Stream, '256-v3.bin', $400000, $0eaec17c);
  Partition(Stream, '256-v4.bin', $400000, $9b4b22d4);
end;

{ mslug4 }

class procedure mslug4.C0(Stream: TStream);
begin
  Partition(Stream, '263-c1.bin', $800000, $84865f8a);
  Partition(Stream, '263-c3.bin', $800000, $1a343323);
  Partition(Stream, '263-c5.bin', $800000, $a748854f);
end;

class procedure mslug4.C1(Stream: TStream);
begin
  Partition(Stream, '263-c2.bin', $800000, $81df97f2);
  Partition(Stream, '263-c4.bin', $800000, $942cfb44);
  Partition(Stream, '263-c6.bin', $800000, $5c8ba116);
end;

class function mslug4.GetName: string;
begin
  Result := 'Metal Slug 4';
end;

class procedure mslug4.M(Stream: TStream);
begin
  Partition(Stream, '263-m1_decrypted.bin', $020000, $ef5db532);
  Partition(Stream, '263-m1.bin', $020000, $46ac8228);
end;

class procedure mslug4.P(Stream: TStream);
begin
  Partition(Stream, '263-pg1.bin', $100000, $27e4def3);
  Partition(Stream, '263-p2.bin', $400000, $fdb7aed8);
end;

class procedure mslug4.V(Stream: TStream);
begin
  Partition(Stream, '263-v1.bin', $800000, $01e9b9cd);
  Partition(Stream, '263-v2.bin', $800000, $4ab2bf81);
end;

{ mslug5 }

class procedure mslug5.C0(Stream: TStream);
begin
  Partition(Stream, '268-c1c.bin', $800000, $ab7c389a);
  Partition(Stream, '268-c3c.bin', $800000, $3af955ea);
  Partition(Stream, '268-c5c.bin', $800000, $959c8177);
  Partition(Stream, '268-c7c.bin', $800000, $6d72a969);
end;

class procedure mslug5.C1(Stream: TStream);
begin
  Partition(Stream, '268-c2c.bin', $800000, $3560881b);
  Partition(Stream, '268-c4c.bin', $800000, $c329c373);
  Partition(Stream, '268-c6c.bin', $800000, $010a831b);
  Partition(Stream, '268-c8c.bin', $800000, $551d720e);
end;

class function mslug5.GetName: string;
begin
  Result := 'Metal Slug 5';
end;

class procedure mslug5.M(Stream: TStream);
begin
  Partition(Stream, '268-m1_decrypted.bin', $010000, $3c0655a7);
  Partition(Stream, '268-m1.bin', $080000, $4a5a6e0e);
end;

class procedure mslug5.P(Stream: TStream);
begin
  Partition(Stream, '268-p1cr.bin', $400000, $d0466792);
  Partition(Stream, '268-p2cr.bin', $400000, $fbf6b61e);
end;

class procedure mslug5.V(Stream: TStream);
begin
  Partition(Stream, '268-v1c.bin', $800000, $ae31d60c);
  Partition(Stream, '268-v2c.bin', $800000, $c40613ed);
end;

{ pnyaa }

class procedure pnyaa.C0(Stream: TStream);
begin
  Partition(Stream, '267-c1.bin', $800000, $5eebee65);
end;

class procedure pnyaa.C1(Stream: TStream);
begin
  Partition(Stream, '267-c2.bin', $800000, $2b67187b);
end;

class function pnyaa.GetName: string;
begin
  Result := 'Pochi and Nyaa';
end;

class procedure pnyaa.M(Stream: TStream);
begin
  Partition(Stream, '267-m1_decrypted.bin', $080000, $d58eaa8e);
  Partition(Stream, '267-m1.bin', $080000, $c7853ccd);
end;

class procedure pnyaa.P(Stream: TStream);
begin
  Partition(Stream, '267-p1.bin', $100000, $112fe2c0);
end;

class procedure pnyaa.V(Stream: TStream);
begin
  Partition(Stream, '267-v1.bin', $400000, $e2e8e917);
end;

{ rotd }

class procedure rotd.C0(Stream: TStream);
begin
  Partition(Stream, '264-c1.bin', $800000, $4f148fee);
  Partition(Stream, '264-c3.bin', $800000, $64d84c98);
  Partition(Stream, '264-c5.bin', $800000, $6b99b978);
  Partition(Stream, '264-c7.bin', $800000, $231d681e);
end;

class procedure rotd.C1(Stream: TStream);
begin
  Partition(Stream, '264-c2.bin', $800000, $7cf5ff72);
  Partition(Stream, '264-c4.bin', $800000, $2f394a95);
  Partition(Stream, '264-c6.bin', $800000, $847d5c7d);
  Partition(Stream, '264-c8.bin', $800000, $c5edb5c4);
end;

class function rotd.GetName: string;
begin
  Result := 'Rage of the Dragons';
end;

class procedure rotd.M(Stream: TStream);
begin
  Partition(Stream, '264-m1_decrypted.bin', $020000, $c5d36af9);
  Partition(Stream, '264-m1.bin', $020000, $4dbd7b43);
end;

class procedure rotd.P(Stream: TStream);
begin
  Partition(Stream, '264-p1.bin', $800000, $b8cc969d);
end;

class procedure rotd.V(Stream: TStream);
begin
  Partition(Stream, '264-v1.bin', $800000, $fa005812);
  Partition(Stream, '264-v2.bin', $800000, $c3dc8bf0);
end;

{ samsho5 }

class procedure samsho5.C0(Stream: TStream);
begin
  Partition(Stream, '270-c1.bin', $800000, $14ffffac);
  Partition(Stream, '270-c3.bin', $800000, $838f0260);
  Partition(Stream, '270-c5.bin', $800000, $bd30b52d);
  Partition(Stream, '270-c7.bin', $800000, $d28fbc3c);
end;

class procedure samsho5.C1(Stream: TStream);
begin
  Partition(Stream, '270-c2.bin', $800000, $401f7299);
  Partition(Stream, '270-c4.bin', $800000, $041560a5);
  Partition(Stream, '270-c6.bin', $800000, $86a69c70);
  Partition(Stream, '270-c8.bin', $800000, $02c530a6);
end;

class function samsho5.GetName: string;
begin
  Result := 'Samurai Shodown V / Samurai Spirits Zero (set 1)';
end;

class procedure samsho5.M(Stream: TStream);
begin
  Partition(Stream, '270-m1_decrypted.bin', $040000, $e94a5e2b);
  Partition(Stream, '270-m1.bin', $080000, $49c9901a);
end;

class procedure samsho5.P(Stream: TStream);
begin
  Partition(Stream, '270-p1.bin', $400000, $4a2a09e6);
  Partition(Stream, '270-p2.bin', $400000, $e0c74c85);
end;

class procedure samsho5.V(Stream: TStream);
begin
  Partition(Stream, '270-v1.bin', $800000, $62e434eb);
  Partition(Stream, '270-v2.bin', $800000, $180f3c9a);
end;

{ sengoku3 }

class procedure sengoku3.C0(Stream: TStream);
begin
  Partition(Stream, '261-c1.bin', $800000, $ded84d9c);
  Partition(Stream, '261-c3.bin', $800000, $84e2034a);
end;

class procedure sengoku3.C1(Stream: TStream);
begin
  Partition(Stream, '261-c2.bin', $800000, $b8eb4348);
  Partition(Stream, '261-c4.bin', $800000, $0b45ae53);
end;

class function sengoku3.GetName: string;
begin
  Result := 'Sengoku 3';
end;

class procedure sengoku3.M(Stream: TStream);
begin
  Partition(Stream, '261-m1.bin', $020000, $36ed9cdd);
end;

class procedure sengoku3.P(Stream: TStream);
begin
  Partition(Stream, '261-p1.bin', $200000, $e0d4bc0a);
end;

class procedure sengoku3.V(Stream: TStream);
begin
  Partition(Stream, '261-v1.bin', $400000, $64c30081);
  Partition(Stream, '261-v2.bin', $400000, $392a9c47);
  Partition(Stream, '261-v3.bin', $400000, $c1a7ebe3);
  Partition(Stream, '261-v4.bin', $200000, $9000d085);
end;

{ samsh5sp }

class procedure samsh5sp.C0(Stream: TStream);
begin
  Partition(Stream, '272-c1.bin', $800000, $4f97661a);
  Partition(Stream, '272-c3.bin', $800000, $8c3c7502);
  Partition(Stream, '272-c5.bin', $800000, $6ce085bc);
  Partition(Stream, '272-c7.bin', $800000, $1417b742);
end;

class procedure samsh5sp.C1(Stream: TStream);
begin
  Partition(Stream, '272-c2.bin', $800000, $a3afda4f);
  Partition(Stream, '272-c4.bin', $800000, $32d5e2e2);
  Partition(Stream, '272-c6.bin', $800000, $05c8dc8e);
  Partition(Stream, '272-c8.bin', $800000, $d49773cd);
end;

class function samsh5sp.GetName: string;
begin
  Result := 'Samurai Shodown V Special / Samurai Spirits Zero Special (set 1, uncensored)';
end;

class procedure samsh5sp.M(Stream: TStream);
begin
  Partition(Stream, '272-m1_decrypted.bin', $080000, $203d744e);
  Partition(Stream, '272-m1.bin', $080000, $adeebf40);
end;

class procedure samsh5sp.P(Stream: TStream);
begin
  Partition(Stream, '272-p1.bin', $400000, $fb7a6bba);
  Partition(Stream, '272-p2.bin', $400000, $63492ea6);
end;

class procedure samsh5sp.V(Stream: TStream);
begin
  Partition(Stream, '272-v1.bin', $800000, $76a94127);
  Partition(Stream, '272-v2.bin', $800000, $4ba507f1);
end;

{ kf10thep }

class procedure kf10thep.C0(Stream: TStream);
begin
  Partition(Stream, 'kf10-c1a.bin', $400000, $3bbc0364);
  Partition(Stream, 'kf10-c1b.bin', $400000, $b5abfc28);
  Partition(Stream, 'kf10-c3a.bin', $400000, $5b3d4a16);
  Partition(Stream, 'kf10-c3b.bin', $400000, $9d2bba19);
  Partition(Stream, 'kf10-c5a.bin', $400000, $a289d1e1);
  Partition(Stream, 'kf10-c5b.bin', $400000, $404fff02);
  Partition(Stream, 'kf10-c7a.bin', $400000, $be79c5a8);
  Partition(Stream, '5008-c7b.rom', $400000, $33604ef0);
end;

class procedure kf10thep.C1(Stream: TStream);
begin
  Partition(Stream, 'kf10-c2a.bin', $400000, $91230075);
  Partition(Stream, 'kf10-c2b.bin', $400000, $6cc4c6e1);
  Partition(Stream, 'kf10-c4a.bin', $400000, $c6f3419b);
  Partition(Stream, 'kf10-c4b.bin', $400000, $5a4050cb);
  Partition(Stream, 'kf10-c6a.bin', $400000, $e6494b5d);
  Partition(Stream, 'kf10-c6b.bin', $400000, $f2ccfc9e);
  Partition(Stream, 'kf10-c8a.bin', $400000, $a5952ca4);
  Partition(Stream, '5008-c8b.rom', $400000, $51f6a8f8);
end;

class function kf10thep.GetName: string;
begin
  Result := 'The King of Fighters 10th Anniversary Extra Plus (The King of Fighters 2002 bootleg)';
end;

class procedure kf10thep.M(Stream: TStream);
begin
  Partition(Stream, '5008-m1.rom', $020000, $5a47d9ad);
end;

class procedure kf10thep.P(Stream: TStream);
begin
  Partition(Stream, '5008-p1.rom', $200000, $bf5469ba);
  Partition(Stream, '5008-p2.rom', $400000, $a649ec38);
  Partition(Stream, '5008-p3.rom', $200000, $e629e13c);
end;

class procedure kf10thep.S(Stream: TStream);
begin
  Partition(Stream, '5008-s1.rom', $020000, $92410064);
end;

class procedure kf10thep.V(Stream: TStream);
begin
  Partition(Stream, 'kf10-v1.bin', $800000, $0fc9a58d);
  Partition(Stream, 'kf10-v2.bin', $800000, $b8c475a4);
end;

{ kf2k3bl }

class procedure kf2k3bl.C0(Stream: TStream);
begin
  Partition(Stream, '2k3-c1.bin', $800000, $e42fc226);
  Partition(Stream, '2k3-c3.bin', $800000, $d334fdd9);
  Partition(Stream, '2k3-c5.bin', $800000, $8a91aae4);
  Partition(Stream, '2k3-c7.bin', $800000, $374ea523);
end;

class procedure kf2k3bl.C1(Stream: TStream);
begin
  Partition(Stream, '2k3-c2.bin', $800000, $1b5e3b58);
  Partition(Stream, '2k3-c4.bin', $800000, $0d457699);
  Partition(Stream, '2k3-c6.bin', $800000, $9f8674b8);
  Partition(Stream, '2k3-c8.bin', $800000, $75211f4d);
end;

class function kf2k3bl.GetName: string;
begin
  Result := 'The King of Fighters 2003 (bootleg set 1)';
end;

class procedure kf2k3bl.M(Stream: TStream);
begin
  Partition(Stream, '271-m1bl.bin', $020000, $3a4969ff);
end;

class procedure kf2k3bl.P(Stream: TStream);
begin
  Partition(Stream, '271-p1bl.bin', $400000, $92ed6ee3);
  Partition(Stream, '271-p2bl.bin', $400000, $5d3d8bb3);
end;

class procedure kf2k3bl.S(Stream: TStream);
begin
  Partition(Stream, '271-s1bl.bin', $020000, $482c48a5);
end;

class procedure kf2k3bl.V(Stream: TStream);
begin
  Partition(Stream, '2k3-v1.bin', $400000, $d2b8aa5e);
  Partition(Stream, '2k3-v2.bin', $400000, $71956ee2);
  Partition(Stream, '2k3-v3.bin', $400000, $ddbbb199);
  Partition(Stream, '2k3-v4.bin', $400000, $01b90c4f);
end;

{ kf2k3bla }

class function kf2k3bla.GetName: string;
begin
  Result := 'The King of Fighters 2003 (bootleg set 2)';
end;

class procedure kf2k3bla.P(Stream: TStream);
begin
  Partition(Stream, '271-p1bl.rom', $100000, $4ea414dd);
  Partition(Stream, '271-p3bl.rom', $400000, $370acbff);
  Partition(Stream, '271-p2bl.rom', $200000, $9c04fc52);
end;

{ kf2k3pl }

class function kf2k3pl.GetName: string;
begin
  Result := 'The King of Fighters 2004 Plus / Hero (The King of Fighters 2003 bootleg)';
end;

class procedure kf2k3pl.P(Stream: TStream);
begin
  Partition(Stream, '271-p1pl.bin', $100000, $07b84112);
  Partition(Stream, '271-p3bl.rom', $400000, $370acbff);
  Partition(Stream, '271-p2bl.rom', $200000, $9c04fc52);
end;

class procedure kf2k3pl.S(Stream: TStream);
begin
  Partition(Stream, '271-s1pl.bin', $020000, $ad548a36);
end;

{ cthd2003 }

class procedure cthd2003.C0(Stream: TStream);
begin
  Partition(Stream, '5003-c1.bin', $800000, $68f54b67);
  Partition(Stream, '5003-c3.bin', $800000, $ac4aff71);
  Partition(Stream, '5003-c5.bin', $800000, $c7c1ae50);
  Partition(Stream, '5003-c7.bin', $800000, $64ddfe0f);
end;

class procedure cthd2003.C1(Stream: TStream);
begin
  Partition(Stream, '5003-c2.bin', $800000, $2f8849d5);
  Partition(Stream, '5003-c4.bin', $800000, $afef5d66);
  Partition(Stream, '5003-c6.bin', $800000, $613197f9);
  Partition(Stream, '5003-c8.bin', $800000, $917a1439);
end;

class function cthd2003.GetName: string;
begin
  Result := 'Crouching Tiger Hidden Dragon 2003 (The King of Fighters 2001 bootleg)';
end;

class procedure cthd2003.M(Stream: TStream);
begin
  Partition(Stream, '5003-m1.bin', $020000, $1a8c274b);
end;

class procedure cthd2003.P(Stream: TStream);
begin
  Partition(Stream, '5003-p1.bin', $100000, $bb7602c1);
  Partition(Stream, '5003-p2.bin', $400000, $adc1c22b);
end;

class procedure cthd2003.S(Stream: TStream);
begin
  Partition(Stream, '5003-s1.bin', $020000, $5ba29aab);
end;

{ ct2k3sp }

class function ct2k3sp.GetName: string;
begin
  Result := 'Crouching Tiger Hidden Dragon 2003 Super Plus (The King of Fighters 2001 bootleg)';
end;

class procedure ct2k3sp.P(Stream: TStream);
begin
  Partition(Stream, '5003-p1sp.bin', $100000, $bb7602c1);
  Partition(Stream, '5003-p2.bin', $400000, $adc1c22b);
end;

class procedure ct2k3sp.S(Stream: TStream);
begin
  Partition(Stream, '5003-s1sp.bin', $040000, $5ba29aab); // also different size
end;

{ ct2k3sa }

class function ct2k3sa.GetName: string;
begin
  Result := 'Crouching Tiger Hidden Dragon 2003 Super Plus alternate (The King of Fighters 2001 bootleg)';
end;

class procedure ct2k3sa.P(Stream: TStream);
begin
  Partition(Stream, '5003-p1sa.bin', $100000, $013a509d);
  Partition(Stream, '5003-p2.bin', $400000, $adc1c22b);
end;

class procedure ct2k3sa.S(Stream: TStream);
begin
  Partition(Stream, '5003-s1sa.bin', $020000, $4e1f7eae);
end;

{ mslug3h }

class function mslug3h.GetName: string;
begin
  Result := 'Metal Slug 3 (not encrypted)';
end;

class procedure mslug3h.P(Stream: TStream);
begin
  Partition(Stream, '256-ph1.bin', $100000, $9c42ca85);
  Partition(Stream, '256-ph2.bin', $400000, $1f3d8ce8);
end;

{ mslug3b6 }

class function mslug3b6.GetName: string;
begin
  Result := 'Metal Slug 6 (Metal Slug 3 bootleg)';
end;

class procedure mslug3b6.P(Stream: TStream);
begin
  Partition(Stream, '299-p1.bin', $200000, $5f2fe228);
  Partition(Stream, '299-p2.bin', $400000, $193fa835);
end;

class procedure mslug3b6.S(Stream: TStream);
begin
  Partition(Stream, '299-s1.bin', $020000, $6f8b9635);
end;

{ mslug3hd }

class procedure mslug3hd.C0(Stream: TStream);
begin
  Partition(Stream, '256-c1_decrypted.bin', $800000, $3540398c);
  Partition(Stream, '256-c3_decrypted.bin', $800000, $bfaade82);
  Partition(Stream, '256-c5_decrypted.bin', $800000, $48ca7f28);
  Partition(Stream, '256-c7_decrypted.bin', $800000, $9395b809);
end;

class procedure mslug3hd.C1(Stream: TStream);
begin
  Partition(Stream, '256-c2_decrypted.bin', $800000, $bdd220f0);
  Partition(Stream, '256-c4_decrypted.bin', $800000, $1463add6);
  Partition(Stream, '256-c6_decrypted.bin', $800000, $806eb36f);
  Partition(Stream, '256-c8_decrypted.bin', $800000, $a369f9d4);
end;

class function mslug3hd.GetName: string;
begin
  Result := 'Metal Slug 3 (not encrypted)';
end;

{ ms5plus }

class function ms5plus.GetName: string;
begin
  Result := 'Metal Slug 5 Plus (bootleg)';
end;

class procedure ms5plus.P(Stream: TStream);
begin
  Partition(Stream, '268-p1p.bin', $100000, $106b276f);
  Partition(Stream, '268-p2p.bin', $200000, $d6a458e8);
  Partition(Stream, '268-p3p.bin', $200000, $439ec031);
end;

class procedure ms5plus.S(Stream: TStream);
begin
  Partition(Stream, '268-s1p.bin', $020000, $21e04432);
end;

{ mslugx }

class procedure mslugx.C0(Stream: TStream);
begin
  Partition(Stream, '250-c1.bin', $800000, $09a52c6f);
  Partition(Stream, '250-c3.bin', $800000, $fd602019);
  Partition(Stream, '250-c5.bin', $800000, $a4b56124);
end;

class procedure mslugx.C1(Stream: TStream);
begin
  Partition(Stream, '250-c2.bin', $800000, $31679821);
  Partition(Stream, '250-c4.bin', $800000, $31354513);
  Partition(Stream, '250-c6.bin', $800000, $83e3e69d);
end;

class function mslugx.GetName: string;
begin
  Result := 'Metal Slug X - Super Vehicle-001';
end;

class procedure mslugx.M(Stream: TStream);
begin
  Partition(Stream, '250-m1.bin', $020000, $fd42a842);
end;

class procedure mslugx.P(Stream: TStream);
begin
  Partition(Stream, '250-p1.bin', $100000, $81f1f60b);
  Partition(Stream, '250-p2.bin', $400000, $1fda2e12);
end;

class procedure mslugx.S(Stream: TStream);
begin
  Partition(Stream, '250-s1.bin', $020000, $fb6f441d);
end;

class procedure mslugx.V(Stream: TStream);
begin
  Partition(Stream, '250-v1.bin', $400000, $c79ede73);
  Partition(Stream, '250-v2.bin', $400000, $ea9aabe1);
  Partition(Stream, '250-v3.bin', $200000, $2ca65102);
end;

{ svcboot }

class procedure svcboot.C0(Stream: TStream);
begin
  Partition(Stream, 'svc-c1.bin', $800000, $a7826b89);
  Partition(Stream, 'svc-c3.bin', $800000, $71ed8063);
  Partition(Stream, 'svc-c5.bin', $800000, $9817c082);
  Partition(Stream, 'svc-c7.bin', $800000, $4358d7b9);
end;

class procedure svcboot.C1(Stream: TStream);
begin
  Partition(Stream, 'svc-c2.bin', $800000, $ed3c2089);
  Partition(Stream, 'svc-c4.bin', $800000, $250bde2d);
  Partition(Stream, 'svc-c6.bin', $800000, $2bc0307f);
  Partition(Stream, 'svc-c8.bin', $800000, $366deee5);
end;

class function svcboot.GetName: string;
begin
  Result := 'SNK vs. CAPCOM SVC CHAOS (bootleg)';
end;

class procedure svcboot.M(Stream: TStream);
begin
  Partition(Stream, 'svc-m1.bin', $020000, $804328c3);
end;

class procedure svcboot.P(Stream: TStream);
begin
  Partition(Stream, 'svc-p1.bin', $800000, $0348f162);
end;

class procedure svcboot.S(Stream: TStream);
begin
  Partition(Stream, 'svc-s1.bin', $020000, $70b44df1);
end;

class procedure svcboot.V(Stream: TStream);
begin
  Partition(Stream, 'svc-v2.bin', $400000, $b5097287);
  Partition(Stream, 'svc-v1.bin', $400000, $bd3a391f);
  Partition(Stream, 'svc-v4.bin', $400000, $33fc0b37);
  Partition(Stream, 'svc-v3.bin', $400000, $aa9849a0);
end;

{ kf2k5uni }

class procedure kf2k5uni.C0(Stream: TStream);
begin
  Partition(Stream, 'kf10-c1a.bin', $400000, $3bbc0364);
  Partition(Stream, 'kf10-c1b.bin', $400000, $b5abfc28);
  Partition(Stream, 'kf10-c3a.bin', $400000, $5b3d4a16);
  Partition(Stream, 'kf10-c3b.bin', $400000, $9d2bba19);
  Partition(Stream, 'kf10-c5a.bin', $400000, $a289d1e1);
  Partition(Stream, 'kf10-c5b.bin', $400000, $404fff02);
  Partition(Stream, 'kf10-c7a.bin', $400000, $be79c5a8);
  Partition(Stream, 'kf10-c7b.bin', $400000, $3fdb3542);
end;

class procedure kf2k5uni.C1(Stream: TStream);
begin
  Partition(Stream, 'kf10-c2a.bin', $400000, $91230075);
  Partition(Stream, 'kf10-c2b.bin', $400000, $6cc4c6e1);
  Partition(Stream, 'kf10-c4a.bin', $400000, $c6f3419b);
  Partition(Stream, 'kf10-c4b.bin', $400000, $5a4050cb);
  Partition(Stream, 'kf10-c6a.bin', $400000, $e6494b5d);
  Partition(Stream, 'kf10-c6b.bin', $400000, $f2ccfc9e);
  Partition(Stream, 'kf10-c8a.bin', $400000, $a5952ca4);
  Partition(Stream, 'kf10-c8b.bin', $400000, $661b7a52);
end;

class function kf2k5uni.GetName: string;
begin
  Result := 'The King of Fighters 10th Anniversary 2005 Unique (bootleg of The King of Fighters 2002)';
end;

class procedure kf2k5uni.M(Stream: TStream);
begin
  Partition(Stream, '5006-m1.bin', $020000, $9050bfe7);
end;

class procedure kf2k5uni.P(Stream: TStream);
begin
  Partition(Stream, '5006-p2a.bin', $400000, $ced883a2);
  Partition(Stream, '5006-p1.bin', $400000, $72c39c46);
end;

class procedure kf2k5uni.S(Stream: TStream);
begin
  Partition(Stream, '5006-s1.bin', $020000, $91f8c544);
end;

end.
