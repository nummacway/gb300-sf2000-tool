unit RedeemerEntities;

interface

uses
  StrUtils, SysUtils;

type
  TEntityName = record
    Name: Ansistring;
    Code: Cardinal;
  end;

function UCS4Chr(const c: Cardinal): UnicodeString;
function RemoveEntities(const s: string): string;

const
  Entities: array[0..4] of TEntityName = (
                                            (Name: 'amp'; Code: $00000026),
                                            (Name: 'apos;'; Code: $00000027),
                                            (Name: 'gt'; Code: $0000003E),
                                            (Name: 'lt'; Code: $0000003C),
                                            (Name: 'quot;'; Code: $00000022));

implementation

uses AnsiStrings;

function UCS4Chr(const c: Cardinal): UnicodeString;
begin
  if c < $10000 then
  Result := Chr(c)
  else
  Result := Chr((c - $10000) shr 10 and $3FF or $D800) + Chr((c - $10000) and $3FF or $DC00);
end;

function RemoveEntities(const s: string): string;
var
  i, j, k: Integer;
  s2: string;
  entityresult: string;
procedure FindEntity(const Pattern: AnsiString; const Low, High: Integer; var Result: string);
var
  n: Integer;
begin
  // Fail
  if Low > High then
  Exit;

  n := (Low+High) div 2;

  if StartsStr(Entities[n].Name, Pattern) then
  begin
    Result := Chr(Word(Entities[n].Code));
    if Entities[n].Code > 65535 then
    Result := Result + Chr(Word(Entities[n].Code shr 16));
    inc(i,Length(Entities[n].Name));
    // Die, die kein Apostroph haben, können eins haben
    if not AnsiStrings.EndsStr(';', Entities[n].Name) then
    if Copy(Pattern, 1 + Length(Entities[n].Name), 1) = ';' then
    inc(i);
  end
  else
  if Entities[n].Name > Pattern then
  FindEntity(Pattern, Low, n-1, Result)
  else
  if Entities[n].Name < Pattern then
  FindEntity(Pattern, n+1, High, Result);
end;
begin
  j := Length(s);
  k := 0;
  i := 1;
  Result := '';
  while i <= j do
  begin
    if s[i] = '&' then
    begin
      inc(i);
      s2 := Copy(s, i, 32);
      if StartsStr('#', s2) then
      begin
        s2 := Copy(s, i + 1, PosEx(';', s, i) - i - 1);
        if TryStrToInt(s2, k) then // Unterstützt netterweise Hex-Strings
        Result := Result + UCS4Chr(k)
        else
        Result := Result + '&#' + s2 + ';';
        inc(i, Length(s2) + 3);
      end
      else
      begin
        Entityresult := '&';
        FindEntity(AnsiString(s2), Low(Entities), High(Entities), EntityResult);
        Result := Result + EntityResult;
      end;
    end
    else
    begin
      Result := Result + s[i];
      inc(i);
    end;
  end;
end;

end.
