unit GambatteColors;

// Port of:
// https://github.com/libretro/gambatte-libretro/blob/master/libgambatte/libretro/gbcpalettes.h

interface

type
  TGambatteColorMap = packed array[1..12] of Integer; // this is not TColor but R and B swapped!
  PGambatteColorMap = ^TGambatteColorMap; // Delphi does not allow const records in arrays, const arrays in records or const arrays in arrays, but it does allow const arrays of pointers no matter what it points to

  TGambatteColorMapping = record
    GameName: RawByteString;
    ColorMap: PGambatteColorMap;
  end;

const

default: TGambatteColorMap = ( // from standalone version
	$ffffff, $aaaaaa, $555555, $000000,
	$ffffff, $aaaaaa, $555555, $000000,
	$ffffff, $aaaaaa, $555555, $000000
);

(*

Created by replacing:
'(' by nothing
')' by nothing
'[]' by nothing
'static const unsigned short ' by nothing
' = {' by ': TGambatteColorMap = ('
'}' by ')'
'0x' by '$'

*)

gbdmg: TGambatteColorMap = ( // Original Game Boy
	$578200, $317400, $005121, $00420C,
	$578200, $317400, $005121, $00420C,
	$578200, $317400, $005121, $00420C
);

gbpoc: TGambatteColorMap = ( // Game Boy Pocket
	$A7B19A, $86927C, $535f49, $2A3325,
	$A7B19A, $86927C, $535f49, $2A3325,
	$A7B19A, $86927C, $535f49, $2A3325
);

gblit: TGambatteColorMap = ( // Game Boy Light
	$01CBDF, $01B6D5, $269BAD, $00778D,
	$01CBDF, $01B6D5, $269BAD, $00778D,
	$01CBDF, $01B6D5, $269BAD, $00778D
);

//
// Game Boy Color Palettes
//
p005: TGambatteColorMap = (
	$FFFFFF, $52FF00, $FF4200, $000000,
	$FFFFFF, $52FF00, $FF4200, $000000,
	$FFFFFF, $52FF00, $FF4200, $000000
);

p006: TGambatteColorMap = (
	$FFFFFF, $FF9C00, $FF0000, $000000,
	$FFFFFF, $FF9C00, $FF0000, $000000,
	$FFFFFF, $FF9C00, $FF0000, $000000
);

p007: TGambatteColorMap = (
	$FFFFFF, $FFFF00, $FF0000, $000000,
	$FFFFFF, $FFFF00, $FF0000, $000000,
	$FFFFFF, $FFFF00, $FF0000, $000000
);

p008: TGambatteColorMap = (
	$A59CFF, $FFFF00, $006300, $000000,
	$A59CFF, $FFFF00, $006300, $000000,
	$A59CFF, $FFFF00, $006300, $000000
);

p012: TGambatteColorMap = (
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $FFAD63, $843100, $000000
);

p013: TGambatteColorMap = (
	$000000, $008484, $FFDE00, $FFFFFF,
	$000000, $008484, $FFDE00, $FFFFFF,
	$000000, $008484, $FFDE00, $FFFFFF
);

p016: TGambatteColorMap = (
	$FFFFFF, $A5A5A5, $525252, $000000,
	$FFFFFF, $A5A5A5, $525252, $000000,
	$FFFFFF, $A5A5A5, $525252, $000000
);

p017: TGambatteColorMap = (
	$FFFFA5, $FF9494, $9494FF, $000000,
	$FFFFA5, $FF9494, $9494FF, $000000,
	$FFFFA5, $FF9494, $9494FF, $000000
);

p01B: TGambatteColorMap = (
	$FFFFFF, $FFCE00, $9C6300, $000000,
	$FFFFFF, $FFCE00, $9C6300, $000000,
	$FFFFFF, $FFCE00, $9C6300, $000000
);

p100: TGambatteColorMap = (
	$FFFFFF, $ADAD84, $42737B, $000000,
	$FFFFFF, $FF7300, $944200, $000000,
	$FFFFFF, $ADAD84, $42737B, $000000
);

p10B: TGambatteColorMap = (
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p10D: TGambatteColorMap = (
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $8C8CDE, $52528C, $000000
);

p110: TGambatteColorMap = (
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $7BFF31, $008400, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p11C: TGambatteColorMap = (
	$FFFFFF, $7BFF31, $0063C5, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $7BFF31, $0063C5, $000000
);

p20B: TGambatteColorMap = (
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p20C: TGambatteColorMap = (
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFC542, $FFD600, $943A00, $4A0000
);

p300: TGambatteColorMap = (
	$FFFFFF, $ADAD84, $42737B, $000000,
	$FFFFFF, $FF7300, $944200, $000000,
	$FFFFFF, $FF7300, $944200, $000000
);

p304: TGambatteColorMap = (
	$FFFFFF, $7BFF00, $B57300, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p305: TGambatteColorMap = (
	$FFFFFF, $52FF00, $FF4200, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p306: TGambatteColorMap = (
	$FFFFFF, $FF9C00, $FF0000, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p308: TGambatteColorMap = (
	$A59CFF, $FFFF00, $006300, $000000,
	$FF6352, $D60000, $630000, $000000,
	$FF6352, $D60000, $630000, $000000
);

p30A: TGambatteColorMap = (
	$B5B5FF, $FFFF94, $AD5A42, $000000,
	$000000, $FFFFFF, $FF8484, $943A3A,
	$000000, $FFFFFF, $FF8484, $943A3A
);

p30C: TGambatteColorMap = (
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFC542, $FFD600, $943A00, $4A0000,
	$FFC542, $FFD600, $943A00, $4A0000
);

p30D: TGambatteColorMap = (
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p30E: TGambatteColorMap = (
	$FFFFFF, $7BFF31, $008400, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p30F: TGambatteColorMap = (
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p312: TGambatteColorMap = (
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $7BFF31, $008400, $000000,
	$FFFFFF, $7BFF31, $008400, $000000
);

p319: TGambatteColorMap = (
	$FFE6C5, $CE9C84, $846B29, $5A3108,
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $FFAD63, $843100, $000000
);

p31C: TGambatteColorMap = (
	$FFFFFF, $7BFF31, $0063C5, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p405: TGambatteColorMap = (
	$FFFFFF, $52FF00, $FF4200, $000000,
	$FFFFFF, $52FF00, $FF4200, $000000,
	$FFFFFF, $5ABDFF, $FF0000, $0000FF
);

p406: TGambatteColorMap = (
	$FFFFFF, $FF9C00, $FF0000, $000000,
	$FFFFFF, $FF9C00, $FF0000, $000000,
	$FFFFFF, $5ABDFF, $FF0000, $0000FF
);

p407: TGambatteColorMap = (
	$FFFFFF, $FFFF00, $FF0000, $000000,
	$FFFFFF, $FFFF00, $FF0000, $000000,
	$FFFFFF, $5ABDFF, $FF0000, $0000FF
);

p500: TGambatteColorMap = (
	$FFFFFF, $ADAD84, $42737B, $000000,
	$FFFFFF, $FF7300, $944200, $000000,
	$FFFFFF, $5ABDFF, $FF0000, $0000FF
);

p501: TGambatteColorMap = (
	$FFFF9C, $94B5FF, $639473, $003A3A,
	$FFC542, $FFD600, $943A00, $4A0000,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p502: TGambatteColorMap = (
	$6BFF00, $FFFFFF, $FF524A, $000000,
	$FFFFFF, $FFFFFF, $63A5FF, $0000FF,
	$FFFFFF, $FFAD63, $843100, $000000
);

p503: TGambatteColorMap = (
	$52DE00, $FF8400, $FFFF00, $FFFFFF,
	$FFFFFF, $FFFFFF, $63A5FF, $0000FF,
	$FFFFFF, $FF8484, $943A3A, $000000
);

p508: TGambatteColorMap = (
	$A59CFF, $FFFF00, $006300, $000000,
	$FF6352, $D60000, $630000, $000000,
	$0000FF, $FFFFFF, $FFFF7B, $0084FF
);

p509: TGambatteColorMap = (
	$FFFFCE, $63EFEF, $9C8431, $5A5A5A,
	$FFFFFF, $FF7300, $944200, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p50B: TGambatteColorMap = (
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FFFF7B, $0084FF, $FF0000
);

p50C: TGambatteColorMap = (
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFC542, $FFD600, $943A00, $4A0000,
	$FFFFFF, $5ABDFF, $FF0000, $0000FF
);

p50D: TGambatteColorMap = (
	$FFFFFF, $8C8CDE, $52528C, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $FFAD63, $843100, $000000
);

p50E: TGambatteColorMap = (
	$FFFFFF, $7BFF31, $008400, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p50F: TGambatteColorMap = (
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $7BFF31, $008400, $000000
);

p510: TGambatteColorMap = (
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $7BFF31, $008400, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p511: TGambatteColorMap = (
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $00FF00, $318400, $004A00,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p512: TGambatteColorMap = (
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $7BFF31, $008400, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p514: TGambatteColorMap = (
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFF00, $FF0000, $630000, $000000,
	$FFFFFF, $7BFF31, $008400, $000000
);

p515: TGambatteColorMap = (
	$FFFFFF, $ADAD84, $42737B, $000000,
	$FFFFFF, $FFAD63, $843100, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

p518: TGambatteColorMap = (
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $7BFF31, $008400, $000000
);

p51A: TGambatteColorMap = (
	$FFFFFF, $FFFF00, $7B4A00, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000,
	$FFFFFF, $7BFF31, $008400, $000000
);

p51C: TGambatteColorMap = (
	$FFFFFF, $7BFF31, $0063C5, $000000,
	$FFFFFF, $FF8484, $943A3A, $000000,
	$FFFFFF, $63A5FF, $0000FF, $000000
);

// Extra palettes
pExt1: TGambatteColorMap = (
	$E5EA93, $C4C641, $5E7C39, $21442A,
	$E5EA93, $C4C641, $5E7C39, $21442A,
	$E5EA93, $C4C641, $5E7C39, $21442A
);

pExt2: TGambatteColorMap = (
	$F8F8F8, $83C656, $187890, $000000,
	$F8F8F8, $E18096, $7F3848, $000000,
	$F8F8F8, $FFDA03, $958401, $000000
);

pExt3: TGambatteColorMap = (
	$F8F8F8, $A59E8C, $49726C, $000000,
	$F8F8F8, $E49685, $6E241E, $000000,
	$F8F8F8, $D7543C, $7D3023, $000000
);

pExt4: TGambatteColorMap = (
	$9CA684, $727C5A, $464A35, $181810,
	$9CA684, $727C5A, $464A35, $181810,
	$9CA684, $727C5A, $464A35, $181810
);

//
// Super Game Boy Palettes
//
sgb1A: TGambatteColorMap = (	// 1-A SGB Default
	$F8E8C8, $D89048, $A82820, $301850,
	$F8E8C8, $D89048, $A82820, $301850,
	$F8E8C8, $D89048, $A82820, $301850
);

sgb1B: TGambatteColorMap = (
	$D8D8C0, $C8B070, $B05010, $000000,
	$D8D8C0, $C8B070, $B05010, $000000,
	$D8D8C0, $C8B070, $B05010, $000000
);

sgb1C: TGambatteColorMap = (
	$F8C0F8, $E89850, $983860, $383898,
	$F8C0F8, $E89850, $983860, $383898,
	$F8C0F8, $E89850, $983860, $383898
);

sgb1D: TGambatteColorMap = (
	$F8F8A8, $C08048, $F80000, $501800,
	$F8F8A8, $C08048, $F80000, $501800,
	$F8F8A8, $C08048, $F80000, $501800
);

sgb1E: TGambatteColorMap = (
	$F8D8B0, $78C078, $688840, $583820,
	$F8D8B0, $78C078, $688840, $583820,
	$F8D8B0, $78C078, $688840, $583820
);

sgb1F: TGambatteColorMap = (
	$D8E8F8, $E08850, $A80000, $004010,
	$D8E8F8, $E08850, $A80000, $004010,
	$D8E8F8, $E08850, $A80000, $004010
);

sgb1G: TGambatteColorMap = (
	$000050, $00A0E8, $787800, $F8F858,
	$000050, $00A0E8, $787800, $F8F858,
	$000050, $00A0E8, $787800, $F8F858
);

sgb1H: TGambatteColorMap = (
	$F8E8E0, $F8B888, $804000, $301800,
	$F8E8E0, $F8B888, $804000, $301800,
	$F8E8E0, $F8B888, $804000, $301800
);

sgb2A: TGambatteColorMap = (
	$F0C8A0, $C08848, $287800, $000000,
	$F0C8A0, $C08848, $287800, $000000,
	$F0C8A0, $C08848, $287800, $000000
);

sgb2B: TGambatteColorMap = (
	$F8F8F8, $F8E850, $F83000, $500058,
	$F8F8F8, $F8E850, $F83000, $500058,
	$F8F8F8, $F8E850, $F83000, $500058
);

sgb2C: TGambatteColorMap = (
	$F8C0F8, $E88888, $7830E8, $282898,
	$F8C0F8, $E88888, $7830E8, $282898,
	$F8C0F8, $E88888, $7830E8, $282898
);

sgb2D: TGambatteColorMap = (
	$F8F8A0, $00F800, $F83000, $000050,
	$F8F8A0, $00F800, $F83000, $000050,
	$F8F8A0, $00F800, $F83000, $000050
);

sgb2E: TGambatteColorMap = (
	$F8C880, $90B0E0, $281060, $100810,
	$F8C880, $90B0E0, $281060, $100810,
	$F8C880, $90B0E0, $281060, $100810
);

sgb2F: TGambatteColorMap = (
	$D0F8F8, $F89050, $A00000, $180000,
	$D0F8F8, $F89050, $A00000, $180000,
	$D0F8F8, $F89050, $A00000, $180000
);

sgb2G: TGambatteColorMap = (
	$68B838, $E05040, $E0B880, $001800,
	$68B838, $E05040, $E0B880, $001800,
	$68B838, $E05040, $E0B880, $001800
);

sgb2H: TGambatteColorMap = (
	$F8F8F8, $B8B8B8, $707070, $000000,
	$F8F8F8, $B8B8B8, $707070, $000000,
	$F8F8F8, $B8B8B8, $707070, $000000
);

sgb3A: TGambatteColorMap = (
	$F8D098, $70C0C0, $F86028, $304860,
	$F8D098, $70C0C0, $F86028, $304860,
	$F8D098, $70C0C0, $F86028, $304860
);

sgb3B: TGambatteColorMap = (
	$D8D8C0, $E08020, $005000, $001010,
	$D8D8C0, $E08020, $005000, $001010,
	$D8D8C0, $E08020, $005000, $001010
);

sgb3C: TGambatteColorMap = (
	$E0A8C8, $F8F878, $00B8F8, $202058,
	$E0A8C8, $F8F878, $00B8F8, $202058,
	$E0A8C8, $F8F878, $00B8F8, $202058
);

sgb3D: TGambatteColorMap = (
	$F0F8B8, $E0A878, $08C800, $000000,
	$F0F8B8, $E0A878, $08C800, $000000,
	$F0F8B8, $E0A878, $08C800, $000000
);

sgb3E: TGambatteColorMap = (
	$F8F8C0, $E0B068, $B07820, $504870,
	$F8F8C0, $E0B068, $B07820, $504870,
	$F8F8C0, $E0B068, $B07820, $504870
);

sgb3F: TGambatteColorMap = (
	$7878C8, $F868F8, $F8D000, $404040,
	$7878C8, $F868F8, $F8D000, $404040,
	$7878C8, $F868F8, $F8D000, $404040
);

sgb3G: TGambatteColorMap = (
	$60D850, $F8F8F8, $C83038, $380000,
	$60D850, $F8F8F8, $C83038, $380000,
	$60D850, $F8F8F8, $C83038, $380000
);

sgb3H: TGambatteColorMap = (
	$E0F8A0, $78C838, $488818, $081800,
	$E0F8A0, $78C838, $488818, $081800,
	$E0F8A0, $78C838, $488818, $081800
);

sgb4A: TGambatteColorMap = (
	$F0A868, $78A8F8, $D000D0, $000078,
	$F0A868, $78A8F8, $D000D0, $000078,
	$F0A868, $78A8F8, $D000D0, $000078
);

sgb4B: TGambatteColorMap = (
	$F0E8F0, $E8A060, $407838, $180808,
	$F0E8F0, $E8A060, $407838, $180808,
	$F0E8F0, $E8A060, $407838, $180808
);

sgb4C: TGambatteColorMap = (
	$F8E0E0, $D8A0D0, $98A0E0, $080000,
	$F8E0E0, $D8A0D0, $98A0E0, $080000,
	$F8E0E0, $D8A0D0, $98A0E0, $080000
);

sgb4D: TGambatteColorMap = (
	$F8F8B8, $90C8C8, $486878, $082048,
	$F8F8B8, $90C8C8, $486878, $082048,
	$F8F8B8, $90C8C8, $486878, $082048
);

sgb4E: TGambatteColorMap = (
	$F8D8A8, $E0A878, $785888, $002030,
	$F8D8A8, $E0A878, $785888, $002030,
	$F8D8A8, $E0A878, $785888, $002030
);

sgb4F: TGambatteColorMap = (
	$B8D0D0, $D880D8, $8000A0, $380000,
	$B8D0D0, $D880D8, $8000A0, $380000,
	$B8D0D0, $D880D8, $8000A0, $380000
);

sgb4G: TGambatteColorMap = (
	$B0E018, $B82058, $281000, $008060,
	$B0E018, $B82058, $281000, $008060,
	$B0E018, $B82058, $281000, $008060
);

sgb4H: TGambatteColorMap = (
	$F8F8C8, $B8C058, $808840, $405028,
	$F8F8C8, $B8C058, $808840, $405028,
	$F8F8C8, $B8C058, $808840, $405028
);

//
// Palettes by TheWolfBunny64 TheWolfBunny64 on DeviantArt
// https://www.deviantart.com/thewolfbunny64/gallery/69987002/game-boy-palettes
//
twb64_001_aqours_blue: TGambatteColorMap = (
	$00A0E9, $0080BA, $005074, $003045,
	$00A0E9, $0080BA, $005074, $003045,
	$00A0E9, $0080BA, $005074, $003045
);

twb64_002_anime_expo_ver: TGambatteColorMap = (
	$E5EAEB, $9BA3A6, $656E72, $242A2D,
	$E5EAEB, $9BA3A6, $656E72, $242A2D,
	$E5EAEB, $9BA3A6, $656E72, $242A2D
);

twb64_003_spongebob_yellow: TGambatteColorMap = (
	$F7E948, $C5BA39, $7B7424, $4A4515,
	$F7E948, $C5BA39, $7B7424, $4A4515,
	$F7E948, $C5BA39, $7B7424, $4A4515
);

twb64_004_patrick_star_pink: TGambatteColorMap = (
	$FF808B, $CC666F, $7F4045, $4C2629,
	$FF808B, $CC666F, $7F4045, $4C2629,
	$FF808B, $CC666F, $7F4045, $4C2629
);

twb64_005_neon_red: TGambatteColorMap = (
	$FF3C28, $CC3020, $7F1E14, $4C120C,
	$FF3C28, $CC3020, $7F1E14, $4C120C,
	$FF3C28, $CC3020, $7F1E14, $4C120C
);

twb64_006_neon_blue: TGambatteColorMap = (
	$0AB9E6, $0894B8, $055C73, $033745,
	$0AB9E6, $0894B8, $055C73, $033745,
	$0AB9E6, $0894B8, $055C73, $033745
);

twb64_007_neon_yellow: TGambatteColorMap = (
	$E6FF00, $B8CC00, $737F00, $454C00,
	$E6FF00, $B8CC00, $737F00, $454C00,
	$E6FF00, $B8CC00, $737F00, $454C00
);

twb64_008_neon_green: TGambatteColorMap = (
	$1EDC00, $18B000, $0F6E00, $094200,
	$1EDC00, $18B000, $0F6E00, $094200,
	$1EDC00, $18B000, $0F6E00, $094200
);

twb64_009_neon_pink: TGambatteColorMap = (
	$FF3278, $CC2860, $7F193C, $4C0F24,
	$FF3278, $CC2860, $7F193C, $4C0F24,
	$FF3278, $CC2860, $7F193C, $4C0F24
);

twb64_010_mario_red: TGambatteColorMap = (
	$E10F00, $B40C00, $700700, $430400,
	$E10F00, $B40C00, $700700, $430400,
	$E10F00, $B40C00, $700700, $430400
);

twb64_011_nick_orange: TGambatteColorMap = (
	$FF6700, $CC5200, $7F3300, $4C1E00,
	$FF6700, $CC5200, $7F3300, $4C1E00,
	$FF6700, $CC5200, $7F3300, $4C1E00
);

twb64_012_virtual_vision: TGambatteColorMap = (
	$4C0000, $7F0000, $CC0000, $FF0000,
	$1E0000, $780000, $C30000, $FF0000,
	$1E0000, $780000, $C30000, $FF0000
);

twb64_013_golden_wild: TGambatteColorMap = (
	$B99F65, $947F50, $5C4F32, $372F1E,
	$B99F65, $947F50, $5C4F32, $372F1E,
	$B99F65, $947F50, $5C4F32, $372F1E
);

twb64_014_dmg_099: TGambatteColorMap = (
	$84B510, $6BAD19, $3F642F, $313231,
	$84B510, $6BAD19, $3F642F, $313231,
	$84B510, $6BAD19, $3F642F, $313231
);

twb64_015_classic_blurple: TGambatteColorMap = (
	$7289DA, $5B6DAE, $38446D, $222941,
	$7289DA, $5B6DAE, $38446D, $222941,
	$7289DA, $5B6DAE, $38446D, $222941
);

twb64_016_765_production_ver: TGambatteColorMap = (
	$BBC4E4, $959CB6, $5D6272, $383A44,
	$BBC4E4, $959CB6, $5D6272, $383A44,
	$BBC4E4, $959CB6, $5D6272, $383A44
);

twb64_017_superball_ivory: TGambatteColorMap = (
	$EEF0BC, $BCBC8A, $828250, $646432,
	$EEF0BC, $BCBC8A, $828250, $646432,
	$EEF0BC, $BCBC8A, $828250, $646432
);

twb64_018_crunchyroll_orange: TGambatteColorMap = (
	$F47522, $C35D1B, $7A3A11, $49230A,
	$F47522, $C35D1B, $7A3A11, $49230A,
	$F47522, $C35D1B, $7A3A11, $49230A
);

twb64_019_muse_pink: TGambatteColorMap = (
	$E4007F, $B60065, $72003F, $440026,
	$E4007F, $B60065, $72003F, $440026,
	$E4007F, $B60065, $72003F, $440026
);

twb64_020_school_idol_blue: TGambatteColorMap = (
	$F9F9F8, $87ADF5, $3960D7, $283066,
	$F9F9F8, $87ADF5, $3960D7, $283066,
	$F9F9F8, $87ADF5, $3960D7, $283066
);

twb64_021_gamate_ver: TGambatteColorMap = (
	$6BA64A, $437A63, $255955, $12424C,
	$6BA64A, $437A63, $255955, $12424C,
	$6BA64A, $437A63, $255955, $12424C
);

twb64_022_greenscale_ver: TGambatteColorMap = (
	$9CBE0C, $6E870A, $2C6234, $0C360C,
	$9CBE0C, $6E870A, $2C6234, $0C360C,
	$9CBE0C, $6E870A, $2C6234, $0C360C
);

twb64_023_odyssey_gold: TGambatteColorMap = (
	$C2A000, $9B8000, $615000, $3A3000,
	$C2A000, $9B8000, $615000, $3A3000,
	$C2A000, $9B8000, $615000, $3A3000
);

twb64_024_super_saiyan_god: TGambatteColorMap = (
	$D70362, $AC024E, $6B0131, $40001D,
	$D70362, $AC024E, $6B0131, $40001D,
	$D70362, $AC024E, $6B0131, $40001D
);

twb64_025_super_saiyan_blue: TGambatteColorMap = (
	$05BCCC, $0496A3, $025D66, $01383D,
	$05BCCC, $0496A3, $025D66, $01383D,
	$05BCCC, $0496A3, $025D66, $01383D
);

twb64_026_animax_blue: TGambatteColorMap = (
	$3499E8, $297AB9, $1A4C74, $0F2D45,
	$3499E8, $297AB9, $1A4C74, $0F2D45,
	$3499E8, $297AB9, $1A4C74, $0F2D45
);

twb64_027_bmo_ver: TGambatteColorMap = (
	$C0FFCC, $99CCA3, $607F66, $394C3D,
	$C0FFCC, $99CCA3, $607F66, $394C3D,
	$C0FFCC, $99CCA3, $607F66, $394C3D
);

twb64_028_game_com_ver: TGambatteColorMap = (
	$A7BF6B, $6F8F4F, $0F4F2F, $000000,
	$A7BF6B, $6F8F4F, $0F4F2F, $000000,
	$A7BF6B, $6F8F4F, $0F4F2F, $000000
);

twb64_029_sanrio_pink: TGambatteColorMap = (
	$F9C2D0, $F485A1, $E74B5A, $83534D,
	$F9C2D0, $F485A1, $E74B5A, $83534D,
	$F9C2D0, $F485A1, $E74B5A, $83534D
);

twb64_030_timmy_turner_pink: TGambatteColorMap = (
	$BC486D, $963957, $5E2436, $381520,
	$BC486D, $963957, $5E2436, $381520,
	$BC486D, $963957, $5E2436, $381520
);

twb64_031_fairly_oddpalette: TGambatteColorMap = (
	$7BB850, $CE5A99, $7B365B, $3D1B2D,
	$7BB850, $CE5A99, $7B365B, $3D1B2D,
	$7BB850, $CE5A99, $7B365B, $3D1B2D
);

twb64_032_danny_phantom_silver: TGambatteColorMap = (
	$ABBBCC, $8895A3, $555D66, $33383D,
	$ABBBCC, $8895A3, $555D66, $33383D,
	$ABBBCC, $8895A3, $555D66, $33383D
);

twb64_033_links_awakening_dx_ver: TGambatteColorMap = (
	$F8F8B0, $78C078, $688840, $583820,
	$F8F8B0, $78C078, $688840, $583820,
	$F8F8B0, $78C078, $688840, $583820
);

twb64_034_travel_wood: TGambatteColorMap = (
	$F8D8B0, $A08058, $705030, $482810,
	$F8D8B0, $A08058, $705030, $482810,
	$F8D8B0, $A08058, $705030, $482810
);

twb64_035_pokemon_ver: TGambatteColorMap = (
	$F8E8F8, $F0B088, $807098, $181010,
	$F8E8F8, $F0B088, $807098, $181010,
	$F8E8F8, $F0B088, $807098, $181010
);

twb64_036_game_grump_orange: TGambatteColorMap = (
	$E9762F, $BA5E25, $743B17, $45230E,
	$E9762F, $BA5E25, $743B17, $45230E,
	$E9762F, $BA5E25, $743B17, $45230E
);

twb64_037_scooby_doo_mystery_ver: TGambatteColorMap = (
	$C6DE31, $F79321, $8F59A5, $2A1A31,
	$C6DE31, $F79321, $8F59A5, $2A1A31,
	$C6DE31, $F79321, $8F59A5, $2A1A31
);

twb64_038_pokemon_mini_ver: TGambatteColorMap = (
	$A5BEA5, $849884, $525F52, $313931,
	$A5BEA5, $849884, $525F52, $313931,
	$A5BEA5, $849884, $525F52, $313931
);

twb64_039_supervision_ver: TGambatteColorMap = (
	$7CC67C, $54A68C, $2C6264, $0C322C,
	$7CC67C, $54A68C, $2C6264, $0C322C,
	$7CC67C, $54A68C, $2C6264, $0C322C
);

twb64_040_dmg_ver: TGambatteColorMap = (
	$7F860F, $577C44, $365D48, $2A453B,
	$7F860F, $577C44, $365D48, $2A453B,
	$7F860F, $577C44, $365D48, $2A453B
);

twb64_041_pocket_ver: TGambatteColorMap = (
	$C4CFA1, $8B956D, $4D533C, $1F1F1F,
	$C4CFA1, $8B956D, $4D533C, $1F1F1F,
	$C4CFA1, $8B956D, $4D533C, $1F1F1F
);

twb64_042_light_ver: TGambatteColorMap = (
	$00B581, $009A71, $00694A, $004F3B,
	$00B581, $009A71, $00694A, $004F3B,
	$00B581, $009A71, $00694A, $004F3B
);

twb64_043_all_might_hero_palette: TGambatteColorMap = (
	$EFF0F0, $F3DB43, $D12021, $212F79,
	$EFF0F0, $F3DB43, $D12021, $212F79,
	$EFF0F0, $F3DB43, $D12021, $212F79
);

twb64_044_ua_high_school_uniform: TGambatteColorMap = (
	$EDEDED, $A4AAAF, $A02929, $0C4856,
	$EDEDED, $A4AAAF, $A02929, $0C4856,
	$EDEDED, $A4AAAF, $A02929, $0C4856
);

twb64_045_pikachu_yellow: TGambatteColorMap = (
	$FFDC00, $CCB000, $7F6E00, $4C4200,
	$FFDC00, $CCB000, $7F6E00, $4C4200,
	$FFDC00, $CCB000, $7F6E00, $4C4200
);

twb64_046_eevee_brown: TGambatteColorMap = (
	$C88D32, $A07028, $644619, $3C2A0F,
	$C88D32, $A07028, $644619, $3C2A0F,
	$C88D32, $A07028, $644619, $3C2A0F
);

twb64_047_microvision_ver: TGambatteColorMap = (
	$A0A0A0, $808080, $505050, $303030,
	$A0A0A0, $808080, $505050, $303030,
	$A0A0A0, $808080, $505050, $303030
);

twb64_048_ti83_ver: TGambatteColorMap = (
	$9CAA8C, $7C8870, $4E5546, $2E332A,
	$9CAA8C, $7C8870, $4E5546, $2E332A,
	$9CAA8C, $7C8870, $4E5546, $2E332A
);

twb64_049_aegis_cherry: TGambatteColorMap = (
	$DD3B64, $B02F50, $6E1D32, $42111E,
	$DD3B64, $B02F50, $6E1D32, $42111E,
	$DD3B64, $B02F50, $6E1D32, $42111E
);

twb64_050_labo_fawn: TGambatteColorMap = (
	$D7AA73, $AC885C, $6B5539, $403322,
	$D7AA73, $AC885C, $6B5539, $403322,
	$D7AA73, $AC885C, $6B5539, $403322
);

twb64_051_million_live_gold: TGambatteColorMap = (
	$CDB261, $A48E4D, $665930, $3D351D,
	$CDB261, $A48E4D, $665930, $3D351D,
	$CDB261, $A48E4D, $665930, $3D351D
);

twb64_052_squidward_sea_foam_green: TGambatteColorMap = (
	$B9D7CD, $94ACA4, $5C6B66, $37403D,
	$B9D7CD, $94ACA4, $5C6B66, $37403D,
	$B9D7CD, $94ACA4, $5C6B66, $37403D
);

twb64_053_vmu_ver: TGambatteColorMap = (
	$88CCA8, $6CA386, $446654, $081480,
	$88CCA8, $6CA386, $446654, $081480,
	$88CCA8, $6CA386, $446654, $081480
);

twb64_054_game_master_ver: TGambatteColorMap = (
	$829FA6, $687F84, $414F53, $272F31,
	$829FA6, $687F84, $414F53, $272F31,
	$829FA6, $687F84, $414F53, $272F31
);

twb64_055_android_green: TGambatteColorMap = (
	$3DDC84, $30B069, $1E6E42, $124227,
	$3DDC84, $30B069, $1E6E42, $124227,
	$3DDC84, $30B069, $1E6E42, $124227
);

twb64_056_amazon_vision: TGambatteColorMap = (
	$FFFFFF, $FF9900, $008296, $252F3E,
	$FFFFFF, $FF9900, $008296, $252F3E,
	$FFFFFF, $FF9900, $008296, $252F3E
);

twb64_057_google_red: TGambatteColorMap = (
	$EA4335, $BB352A, $75211A, $46140F,
	$EA4335, $BB352A, $75211A, $46140F,
	$EA4335, $BB352A, $75211A, $46140F
);

twb64_058_google_blue: TGambatteColorMap = (
	$4285F4, $346AC3, $21427A, $132749,
	$4285F4, $346AC3, $21427A, $132749,
	$4285F4, $346AC3, $21427A, $132749
);

twb64_059_google_yellow: TGambatteColorMap = (
	$FBBC05, $C89604, $7D5E02, $4B3801,
	$FBBC05, $C89604, $7D5E02, $4B3801,
	$FBBC05, $C89604, $7D5E02, $4B3801
);

twb64_060_google_green: TGambatteColorMap = (
	$34A853, $298642, $1A5429, $0F3218,
	$34A853, $298642, $1A5429, $0F3218,
	$34A853, $298642, $1A5429, $0F3218
);

twb64_061_wonderswan_ver: TGambatteColorMap = (
	$FEFEFE, $C2C2C2, $686868, $1D1D1D,
	$FEFEFE, $C2C2C2, $686868, $1D1D1D,
	$FEFEFE, $C2C2C2, $686868, $1D1D1D
);

twb64_062_neo_geo_pocket_ver: TGambatteColorMap = (
	$F0F0F0, $B0B0B0, $707070, $101010,
	$F0F0F0, $B0B0B0, $707070, $101010,
	$F0F0F0, $B0B0B0, $707070, $101010
);

twb64_063_dew_green: TGambatteColorMap = (
	$97D700, $78AC00, $4B6B00, $2D4000,
	$97D700, $78AC00, $4B6B00, $2D4000,
	$97D700, $78AC00, $4B6B00, $2D4000
);

twb64_064_coca_cola_vision: TGambatteColorMap = (
	$FFFFFF, $D7D7D7, $F40009, $000000,
	$FFFFFF, $D7D7D7, $F40009, $000000,
	$FFFFFF, $D7D7D7, $F40009, $000000
);

twb64_065_gameking_ver: TGambatteColorMap = (
	$8CCE94, $6B9C63, $405D3B, $184421,
	$8CCE94, $6B9C63, $405D3B, $184421,
	$8CCE94, $6B9C63, $405D3B, $184421
);

twb64_066_do_the_dew_ver: TGambatteColorMap = (
	$FFFFFF, $A1D23F, $D82A34, $29673C,
	$FFFFFF, $A1D23F, $D82A34, $29673C,
	$FFFFFF, $A1D23F, $D82A34, $29673C
);

twb64_067_digivice_ver: TGambatteColorMap = (
	$8C8C73, $70705C, $464639, $2A2A22,
	$8C8C73, $70705C, $464639, $2A2A22,
	$8C8C73, $70705C, $464639, $2A2A22
);

twb64_068_bikini_bottom_ver: TGambatteColorMap = (
	$F8F880, $48F8E0, $2098F0, $606000,
	$F8F880, $48F8E0, $2098F0, $606000,
	$F8F880, $48F8E0, $2098F0, $606000
);

twb64_069_blossom_pink: TGambatteColorMap = (
	$F59BB2, $C47C8E, $7A4D59, $492E35,
	$F59BB2, $C47C8E, $7A4D59, $492E35,
	$F59BB2, $C47C8E, $7A4D59, $492E35
);

twb64_070_bubbles_blue: TGambatteColorMap = (
	$64C4E9, $509CBA, $326274, $1E3A45,
	$64C4E9, $509CBA, $326274, $1E3A45,
	$64C4E9, $509CBA, $326274, $1E3A45
);

twb64_071_buttercup_green: TGambatteColorMap = (
	$BEDC8D, $98B070, $5F6E46, $39422A,
	$BEDC8D, $98B070, $5F6E46, $39422A,
	$BEDC8D, $98B070, $5F6E46, $39422A
);

twb64_072_nascar_ver: TGambatteColorMap = (
	$FFD659, $E4002B, $007AC2, $000000,
	$FFD659, $E4002B, $007AC2, $000000,
	$FFD659, $E4002B, $007AC2, $000000
);

twb64_073_lemon_lime_green: TGambatteColorMap = (
	$F1C545, $51A631, $30631D, $18310E,
	$F1C545, $51A631, $30631D, $18310E,
	$F1C545, $51A631, $30631D, $18310E
);

twb64_074_mega_man_v_ver: TGambatteColorMap = (
	$D0D0D0, $70A0E0, $406890, $082030,
	$D0D0D0, $70A0E0, $406890, $082030,
	$D0D0D0, $70A0E0, $406890, $082030
);

twb64_075_tamagotchi_ver: TGambatteColorMap = (
	$F1F0F9, $C0C0C7, $78787C, $3C3838,
	$F1F0F9, $C0C0C7, $78787C, $3C3838,
	$F1F0F9, $C0C0C7, $78787C, $3C3838
);

twb64_076_phantom_red: TGambatteColorMap = (
	$FD2639, $CA1E2D, $7E131C, $4B0B11,
	$FD2639, $CA1E2D, $7E131C, $4B0B11,
	$FD2639, $CA1E2D, $7E131C, $4B0B11
);

twb64_077_halloween_ver: TGambatteColorMap = (
	$FFCC00, $F68C00, $9540A5, $2C1331,
	$FFCC00, $F68C00, $9540A5, $2C1331,
	$FFCC00, $F68C00, $9540A5, $2C1331
);

twb64_078_christmas_ver: TGambatteColorMap = (
	$CBB96A, $20A465, $A03232, $300F0F,
	$CBB96A, $20A465, $A03232, $300F0F,
	$CBB96A, $20A465, $A03232, $300F0F
);

twb64_079_cardcaptor_pink: TGambatteColorMap = (
	$F2F4F7, $EAC3D6, $E10E82, $430427,
	$F2F4F7, $EAC3D6, $E10E82, $430427,
	$F2F4F7, $EAC3D6, $E10E82, $430427
);

twb64_080_pretty_guardian_gold: TGambatteColorMap = (
	$B4AA82, $908868, $5A5541, $363327,
	$B4AA82, $908868, $5A5541, $363327,
	$B4AA82, $908868, $5A5541, $363327
);

twb64_081_camoflauge_ver: TGambatteColorMap = (
	$BCAB90, $AC7E54, $79533D, $373538,
	$BCAB90, $AC7E54, $79533D, $373538,
	$BCAB90, $AC7E54, $79533D, $373538
);

twb64_082_legendary_super_saiyan: TGambatteColorMap = (
	$A6DA5B, $84AE48, $536D2D, $31411B,
	$A6DA5B, $84AE48, $536D2D, $31411B,
	$A6DA5B, $84AE48, $536D2D, $31411B
);

twb64_083_super_saiyan_rose: TGambatteColorMap = (
	$F7AFB3, $C58C8F, $7B5759, $4A3435,
	$F7AFB3, $C58C8F, $7B5759, $4A3435,
	$F7AFB3, $C58C8F, $7B5759, $4A3435
);

twb64_084_super_saiyan: TGambatteColorMap = (
	$FEFCC1, $CBC99A, $7F7E60, $4C4B39,
	$FEFCC1, $CBC99A, $7F7E60, $4C4B39,
	$FEFCC1, $CBC99A, $7F7E60, $4C4B39
);

twb64_085_perfected_ultra_instinct: TGambatteColorMap = (
	$C0C8D8, $99A0AC, $60646C, $393C40,
	$C0C8D8, $99A0AC, $60646C, $393C40,
	$C0C8D8, $99A0AC, $60646C, $393C40
);

twb64_086_saint_snow_red: TGambatteColorMap = (
	$BF3936, $982D2B, $5F1C1B, $391110,
	$BF3936, $982D2B, $5F1C1B, $391110,
	$BF3936, $982D2B, $5F1C1B, $391110
);

twb64_087_yellow_banana: TGambatteColorMap = (
	$FFDF08, $DE9E00, $AD6939, $734900,
	$FFDF08, $DE9E00, $AD6939, $734900,
	$FFDF08, $DE9E00, $AD6939, $734900
);

twb64_088_green_banana: TGambatteColorMap = (
	$63DF08, $4A9E00, $396939, $214900,
	$63DF08, $4A9E00, $396939, $214900,
	$63DF08, $4A9E00, $396939, $214900
);

twb64_089_super_saiyan_3: TGambatteColorMap = (
	$F8C838, $C6A02C, $7C641C, $4A3C10,
	$F8C838, $C6A02C, $7C641C, $4A3C10,
	$F8C838, $C6A02C, $7C641C, $4A3C10
);

twb64_090_super_saiyan_blue_evolved: TGambatteColorMap = (
	$1B97D1, $1578A7, $0D4B68, $082D3E,
	$1B97D1, $1578A7, $0D4B68, $082D3E,
	$1B97D1, $1578A7, $0D4B68, $082D3E
);

twb64_091_pocket_tales_ver: TGambatteColorMap = (
	$D0D860, $88A000, $385000, $000000,
	$D0D860, $88A000, $385000, $000000,
	$D0D860, $88A000, $385000, $000000
);

twb64_092_investigation_yellow: TGambatteColorMap = (
	$FFF919, $CCC714, $7F7C0C, $4C4A07,
	$FFF919, $CCC714, $7F7C0C, $4C4A07,
	$FFF919, $CCC714, $7F7C0C, $4C4A07
);

twb64_093_sees_blue: TGambatteColorMap = (
	$19D1FF, $14A7CC, $0C687F, $073E4C,
	$19D1FF, $14A7CC, $0C687F, $073E4C,
	$19D1FF, $14A7CC, $0C687F, $073E4C
);

twb64_094_ultra_instinct_sign: TGambatteColorMap = (
	$5A686F, $485358, $2D3437, $1B1F21,
	$5A686F, $485358, $2D3437, $1B1F21,
	$5A686F, $485358, $2D3437, $1B1F21
);

twb64_095_hokage_orange: TGambatteColorMap = (
	$EA8352, $BB6841, $754129, $462718,
	$EA8352, $BB6841, $754129, $462718,
	$EA8352, $BB6841, $754129, $462718
);

twb64_096_straw_hat_red: TGambatteColorMap = (
	$F8523C, $C64130, $7C291E, $4A1812,
	$F8523C, $C64130, $7C291E, $4A1812,
	$F8523C, $C64130, $7C291E, $4A1812
);

twb64_097_sword_art_cyan: TGambatteColorMap = (
	$59C3E2, $479CB4, $2C6171, $1A3A43,
	$59C3E2, $479CB4, $2C6171, $1A3A43,
	$59C3E2, $479CB4, $2C6171, $1A3A43
);

twb64_098_deku_alpha_emerald: TGambatteColorMap = (
	$39AD9E, $2D8A7E, $1C564F, $11332F,
	$39AD9E, $2D8A7E, $1C564F, $11332F,
	$39AD9E, $2D8A7E, $1C564F, $11332F
);

twb64_099_blue_stripes_ver: TGambatteColorMap = (
	$8BD3E1, $999B9C, $5B5D5D, $2D2E2E,
	$8BD3E1, $999B9C, $5B5D5D, $2D2E2E,
	$8BD3E1, $999B9C, $5B5D5D, $2D2E2E
);

twb64_100_precure_marble_raspberry: TGambatteColorMap = (
	$D6225C, $AB1B49, $6B112E, $400A1B,
	$D6225C, $AB1B49, $6B112E, $400A1B,
	$D6225C, $AB1B49, $6B112E, $400A1B
);

twb64_101_765pro_pink: TGambatteColorMap = (
	$F34F6D, $C23F57, $792736, $481720,
	$F34F6D, $C23F57, $792736, $481720,
	$F34F6D, $C23F57, $792736, $481720
);

twb64_102_cinderella_blue: TGambatteColorMap = (
	$2681C8, $1E67A0, $134064, $0B263C,
	$2681C8, $1E67A0, $134064, $0B263C,
	$2681C8, $1E67A0, $134064, $0B263C
);

twb64_103_million_yellow: TGambatteColorMap = (
	$FFC30B, $CC9C08, $7F6105, $4C3A03,
	$FFC30B, $CC9C08, $7F6105, $4C3A03,
	$FFC30B, $CC9C08, $7F6105, $4C3A03
);

twb64_104_sidem_green: TGambatteColorMap = (
	$0FBE94, $0C9876, $075F4A, $04392C,
	$0FBE94, $0C9876, $075F4A, $04392C,
	$0FBE94, $0C9876, $075F4A, $04392C
);

twb64_105_shiny_sky_blue: TGambatteColorMap = (
	$8DBBFF, $7095CC, $465D7F, $2A384C,
	$8DBBFF, $7095CC, $465D7F, $2A384C,
	$8DBBFF, $7095CC, $465D7F, $2A384C
);

twb64_106_angry_volcano_ver: TGambatteColorMap = (
	$F8B800, $F83800, $A81000, $1C0000,
	$F8B800, $F83800, $A81000, $1C0000,
	$F8B800, $F83800, $A81000, $1C0000
);

twb64_107_nba_vision: TGambatteColorMap = (
	$FFFFFF, $C8102E, $253B73, $000000,
	$FFFFFF, $C8102E, $253B73, $000000,
	$FFFFFF, $C8102E, $253B73, $000000
);

twb64_108_nfl_vision: TGambatteColorMap = (
	$FFFFFF, $D50A0A, $013369, $000000,
	$FFFFFF, $D50A0A, $013369, $000000,
	$FFFFFF, $D50A0A, $013369, $000000
);

twb64_109_mlb_vision: TGambatteColorMap = (
	$FFFFFF, $057AFF, $BF0D3E, $041E42,
	$FFFFFF, $057AFF, $BF0D3E, $041E42,
	$FFFFFF, $057AFF, $BF0D3E, $041E42
);

twb64_110_anime_digivice_ver: TGambatteColorMap = (
	$5B7B63, $48624F, $2D3D31, $1B241D,
	$5B7B63, $48624F, $2D3D31, $1B241D,
	$5B7B63, $48624F, $2D3D31, $1B241D
);

twb64_111_aquatic_iro: TGambatteColorMap = (
	$A0D8EF, $2CA9E1, $3E62AD, $192F60,
	$A0D8EF, $2CA9E1, $3E62AD, $192F60,
	$A0D8EF, $2CA9E1, $3E62AD, $192F60
);

twb64_112_tea_midori: TGambatteColorMap = (
	$D6E9CA, $88CB7F, $028760, $333631,
	$D6E9CA, $88CB7F, $028760, $333631,
	$D6E9CA, $88CB7F, $028760, $333631
);

twb64_113_sakura_pink: TGambatteColorMap = (
	$FDEFF2, $EEBBCB, $E7609E, $A25768,
	$FDEFF2, $EEBBCB, $E7609E, $A25768,
	$FDEFF2, $EEBBCB, $E7609E, $A25768
);

twb64_114_wisteria_murasaki: TGambatteColorMap = (
	$DBD0E6, $A59ACA, $7058A3, $2E2930,
	$DBD0E6, $A59ACA, $7058A3, $2E2930,
	$DBD0E6, $A59ACA, $7058A3, $2E2930
);

twb64_115_oni_aka: TGambatteColorMap = (
	$EC6D71, $D9333F, $A22041, $640125,
	$EC6D71, $D9333F, $A22041, $640125,
	$EC6D71, $D9333F, $A22041, $640125
);

twb64_116_golden_kiiro: TGambatteColorMap = (
	$F8E58C, $DCCB18, $A69425, $6A5D21,
	$F8E58C, $DCCB18, $A69425, $6A5D21,
	$F8E58C, $DCCB18, $A69425, $6A5D21
);

twb64_117_silver_shiro: TGambatteColorMap = (
	$DCDDDD, $AFAFB0, $727171, $383C3C,
	$DCDDDD, $AFAFB0, $727171, $383C3C,
	$DCDDDD, $AFAFB0, $727171, $383C3C
);

twb64_118_fruity_orange: TGambatteColorMap = (
	$F3BF88, $F08300, $9F563A, $241A08,
	$F3BF88, $F08300, $9F563A, $241A08,
	$F3BF88, $F08300, $9F563A, $241A08
);

twb64_119_akb48_pink: TGambatteColorMap = (
	$F676A6, $C45E84, $7B3B53, $492331,
	$F676A6, $C45E84, $7B3B53, $492331,
	$F676A6, $C45E84, $7B3B53, $492331
);

twb64_120_miku_blue: TGambatteColorMap = (
	$11ADD5, $0D8AAA, $08566A, $05333F,
	$11ADD5, $0D8AAA, $08566A, $05333F,
	$11ADD5, $0D8AAA, $08566A, $05333F
);

twb64_121_tri_digivice_ver: TGambatteColorMap = (
	$848F79, $697260, $42473C, $272A24,
	$848F79, $697260, $42473C, $272A24,
	$848F79, $697260, $42473C, $272A24
);

twb64_122_survey_corps_uniform: TGambatteColorMap = (
	$ACABA9, $AC7C59, $593D34, $321D1A,
	$ACABA9, $AC7C59, $593D34, $321D1A,
	$ACABA9, $AC7C59, $593D34, $321D1A
);

twb64_123_island_green: TGambatteColorMap = (
	$009B7E, $007C64, $004D3F, $002E25,
	$009B7E, $007C64, $004D3F, $002E25,
	$009B7E, $007C64, $004D3F, $002E25
);

twb64_124_nogizaka46_purple: TGambatteColorMap = (
	$812990, $672073, $401448, $260C2B,
	$812990, $672073, $401448, $260C2B,
	$812990, $672073, $401448, $260C2B
);

twb64_125_ninja_turtle_green: TGambatteColorMap = (
	$86BC25, $6B961D, $435E12, $28380B,
	$86BC25, $6B961D, $435E12, $28380B,
	$86BC25, $6B961D, $435E12, $28380B
);

twb64_126_slime_blue: TGambatteColorMap = (
	$2F8CCC, $2570A3, $174666, $0E2A3D,
	$2F8CCC, $2570A3, $174666, $0E2A3D,
	$2F8CCC, $2570A3, $174666, $0E2A3D
);

twb64_127_lime_midori: TGambatteColorMap = (
	$E0EBAF, $AACF53, $7B8D42, $475950,
	$E0EBAF, $AACF53, $7B8D42, $475950,
	$E0EBAF, $AACF53, $7B8D42, $475950
);

twb64_128_ghostly_aoi: TGambatteColorMap = (
	$84A2D4, $5A79BA, $19448E, $0F2350,
	$84A2D4, $5A79BA, $19448E, $0F2350,
	$84A2D4, $5A79BA, $19448E, $0F2350
);

twb64_129_retro_bogeda: TGambatteColorMap = (
	$FBFD1B, $FF6CFF, $6408FF, $000000,
	$FBFD1B, $FF6CFF, $6408FF, $000000,
	$FBFD1B, $FF6CFF, $6408FF, $000000
);

twb64_130_royal_blue: TGambatteColorMap = (
	$4655F5, $3844C4, $232A7A, $151949,
	$4655F5, $3844C4, $232A7A, $151949,
	$4655F5, $3540BB, $202773, $0C0E2B
);

twb64_131_neon_purple: TGambatteColorMap = (
	$B400E6, $9000B8, $5A0073, $360045,
	$B400E6, $9000B8, $5A0073, $360045,
	$B400E6, $9000B8, $5A0073, $360045
);

twb64_132_neon_orange: TGambatteColorMap = (
	$FAA005, $C88004, $7D5002, $4B3001,
	$FAA005, $C88004, $7D5002, $4B3001,
	$FAA005, $C88004, $7D5002, $4B3001
);

twb64_133_moonlight_vision: TGambatteColorMap = (
	$F8D868, $3890E8, $305078, $101010,
	$F8D868, $3890E8, $305078, $101010,
	$F8D868, $3890E8, $305078, $101010
);

twb64_134_rising_sun_red: TGambatteColorMap = (
	$BC002D, $960024, $5D0016, $38000D,
	$BC002D, $960024, $5D0016, $38000D,
	$BC002D, $960024, $5D0016, $38000D
);

twb64_135_burger_king_color_combo: TGambatteColorMap = (
	$F5EBDC, $FF8732, $D62300, $502314,
	$F5EBDC, $FF8732, $D62300, $502314,
	$F5EBDC, $FF8732, $D62300, $502314
);

twb64_136_grand_zeno_coat: TGambatteColorMap = (
	$FBFBFA, $FCE72D, $CE26A9, $3D0B32,
	$FBFBFA, $FCE72D, $CE26A9, $3D0B32,
	$FBFBFA, $FCE72D, $CE26A9, $3D0B32
);

twb64_137_pac_man_yellow: TGambatteColorMap = (
	$FFE300, $CCB500, $7F7100, $4C4400,
	$FFE300, $CCB500, $7F7100, $4C4400,
	$FFE300, $CCB500, $7F7100, $4C4400
);

twb64_138_irish_green: TGambatteColorMap = (
	$45BE76, $37985E, $225F3B, $143923,
	$45BE76, $37985E, $225F3B, $143923,
	$45BE76, $37985E, $225F3B, $143923
);

twb64_139_goku_gi: TGambatteColorMap = (
	$F9F0E1, $E7612C, $173F72, $061222,
	$F9F0E1, $E7612C, $173F72, $061222,
	$F9F0E1, $E7612C, $173F72, $061222
);

twb64_140_dragon_ball_orange: TGambatteColorMap = (
	$F0831D, $C06817, $78410E, $482708,
	$F0831D, $C06817, $78410E, $482708,
	$F0831D, $C06817, $78410E, $482708
);

twb64_141_christmas_gold: TGambatteColorMap = (
	$C0A94B, $99873C, $605425, $393216,
	$C0A94B, $99873C, $605425, $393216,
	$C0A94B, $99873C, $605425, $393216
);

twb64_142_pepsi_vision: TGambatteColorMap = (
	$FFFFFF, $FF1400, $1414C8, $000000,
	$FFFFFF, $FF1400, $1414C8, $000000,
	$FFFFFF, $FF1400, $1414C8, $000000
);

twb64_143_bubblun_green: TGambatteColorMap = (
	$6ADC31, $54B027, $356E18, $1F420E,
	$6ADC31, $54B027, $356E18, $1F420E,
	$6ADC31, $54B027, $356E18, $1F420E
);

twb64_144_bobblun_blue: TGambatteColorMap = (
	$1FD1FD, $18A7CA, $0F687E, $093E4B,
	$1FD1FD, $18A7CA, $0F687E, $093E4B,
	$1FD1FD, $18A7CA, $0F687E, $093E4B
);

twb64_145_baja_blast_storm: TGambatteColorMap = (
	$68C2A4, $539B83, $346152, $1F3A31,
	$68C2A4, $539B83, $346152, $1F3A31,
	$68C2A4, $539B83, $346152, $1F3A31
);

twb64_146_olympic_gold: TGambatteColorMap = (
	$D5B624, $AA911C, $6A5B12, $3F360A,
	$D5B624, $AA911C, $6A5B12, $3F360A,
	$D5B624, $AA911C, $6A5B12, $3F360A
);

twb64_147_lisani_orange: TGambatteColorMap = (
	$EB5E01, $BC4B00, $752F00, $461C00,
	$EB5E01, $BC4B00, $752F00, $461C00,
	$EB5E01, $BC4B00, $752F00, $461C00
);

twb64_148_liella_purple: TGambatteColorMap = (
	$A5469B, $84387C, $52234D, $31152E,
	$A5469B, $84387C, $52234D, $31152E,
	$A5469B, $84387C, $52234D, $31152E
);

twb64_149_olympic_silver: TGambatteColorMap = (
	$9EA59C, $7E847C, $4F524E, $2F312E,
	$9EA59C, $7E847C, $4F524E, $2F312E,
	$9EA59C, $7E847C, $4F524E, $2F312E
);

twb64_150_olympic_bronze: TGambatteColorMap = (
	$CD8152, $A46741, $664029, $3D2618,
	$CD8152, $A46741, $664029, $3D2618,
	$CD8152, $A46741, $664029, $3D2618
);

twb64_151_ana_flight_blue: TGambatteColorMap = (
	$00B3F0, $3B8BC0, $223F9A, $00146E,
	$00B3F0, $3B8BC0, $223F9A, $00146E,
	$00B3F0, $3B8BC0, $223F9A, $00146E
);

twb64_152_nijigasaki_orange: TGambatteColorMap = (
	$F39800, $C27900, $794C00, $482D00,
	$F39800, $C27900, $794C00, $482D00,
	$F39800, $C27900, $794C00, $482D00
);

twb64_153_holoblue: TGambatteColorMap = (
	$B0EDFA, $49C4F2, $3368D3, $063F5C,
	$B0EDFA, $49C4F2, $3368D3, $063F5C,
	$B0EDFA, $49C4F2, $3368D3, $063F5C
);

twb64_154_wwe_white_and_red: TGambatteColorMap = (
	$FFFFFF, $D7182A, $810E19, $40070C,
	$FFFFFF, $D7182A, $810E19, $40070C,
	$FFFFFF, $D7182A, $810E19, $40070C
);

twb64_155_yoshi_egg_green: TGambatteColorMap = (
	$66C430, $519C26, $336218, $1E3A0E,
	$66C430, $519C26, $336218, $1E3A0E,
	$66C430, $519C26, $336218, $1E3A0E
);

twb64_156_pokedex_red: TGambatteColorMap = (
	$EA5450, $BB4340, $752A28, $461918,
	$EA5450, $BB4340, $752A28, $461918,
	$EA5450, $BB4340, $752A28, $461918
);

twb64_157_familymart_vision: TGambatteColorMap = (
	$008CD6, $00A040, $006026, $003013,
	$008CD6, $00A040, $006026, $003013,
	$008CD6, $00A040, $006026, $003013
);

twb64_158_xbox_green: TGambatteColorMap = (
	$92C83E, $74A031, $49641F, $2B3C12,
	$92C83E, $74A031, $49641F, $2B3C12,
	$92C83E, $74A031, $49641F, $2B3C12
);

twb64_159_sonic_mega_blue: TGambatteColorMap = (
	$4084D9, $3369AD, $20426C, $132741,
	$4084D9, $3369AD, $20426C, $132741,
	$4084D9, $3369AD, $20426C, $132741
);

twb64_160_sprite_green: TGambatteColorMap = (
	$009B4E, $007C3E, $004D27, $002E17,
	$009B4E, $007C3E, $004D27, $002E17,
	$009B4E, $007C3E, $004D27, $002E17
);

twb64_161_scarlett_green: TGambatteColorMap = (
	$9BF00B, $7CC008, $4D7805, $2E4803,
	$9BF00B, $7CC008, $4D7805, $2E4803,
	$9BF00B, $7CC008, $4D7805, $2E4803
);

twb64_162_glitchy_blue: TGambatteColorMap = (
	$337EFB, $2864C8, $193F7D, $0F254B,
	$337EFB, $2864C8, $193F7D, $0F254B,
	$337EFB, $2864C8, $193F7D, $0F254B
);

twb64_163_classic_lcd: TGambatteColorMap = (
	$C6CBAD, $9EA28A, $636556, $3B3C33,
	$C6CBAD, $9EA28A, $636556, $3B3C33,
	$C6CBAD, $9EA28A, $636556, $3B3C33
);

twb64_164_3ds_virtual_console_ver: TGambatteColorMap = (
	$CECEAD, $A5A58C, $6B6B52, $292918,
	$CECEAD, $A5A58C, $6B6B52, $292918,
	$CECEAD, $A5A58C, $6B6B52, $292918
);

twb64_165_pocketstation_ver: TGambatteColorMap = (
	$969687, $78786C, $4B4B43, $2D2D28,
	$969687, $78786C, $4B4B43, $2D2D28,
	$969687, $78786C, $4B4B43, $2D2D28
);

twb64_166_timeless_gold_and_red: TGambatteColorMap = (
	$C8AA50, $B91E23, $6F1215, $37090A,
	$C8AA50, $B91E23, $6F1215, $37090A,
	$C8AA50, $B91E23, $6F1215, $37090A
);

twb64_167_smurfy_blue: TGambatteColorMap = (
	$2CB9EF, $2394BF, $165C77, $0D3747,
	$2CB9EF, $2394BF, $165C77, $0D3747,
	$2CB9EF, $2394BF, $165C77, $0D3747
);

twb64_168_swampy_ogre_green: TGambatteColorMap = (
	$C1D62E, $9AAB24, $606B17, $39400D,
	$C1D62E, $9AAB24, $606B17, $39400D,
	$C1D62E, $9AAB24, $606B17, $39400D
);

twb64_169_sailor_spinach_green: TGambatteColorMap = (
	$7BB03C, $628C30, $3D581E, $243412,
	$7BB03C, $628C30, $3D581E, $243412,
	$7BB03C, $628C30, $3D581E, $243412
);

twb64_170_shenron_green: TGambatteColorMap = (
	$5AC34A, $489C3B, $2D6125, $1B3A16,
	$5AC34A, $489C3B, $2D6125, $1B3A16,
	$5AC34A, $489C3B, $2D6125, $1B3A16
);

twb64_171_berserk_blood: TGambatteColorMap = (
	$BB1414, $951010, $5D0A0A, $380606,
	$BB1414, $951010, $5D0A0A, $380606,
	$BB1414, $951010, $5D0A0A, $380606
);

twb64_172_super_star_pink: TGambatteColorMap = (
	$F3A5AA, $C28488, $795255, $483133,
	$F3A5AA, $C28488, $795255, $483133,
	$F3A5AA, $C28488, $795255, $483133
);

twb64_173_gamebuino_classic_ver: TGambatteColorMap = (
	$81A17E, $678064, $40503F, $263025,
	$81A17E, $678064, $40503F, $263025,
	$81A17E, $678064, $40503F, $263025
);

twb64_174_barbie_pink: TGambatteColorMap = (
	$F200A1, $C10080, $790050, $480030,
	$F200A1, $C10080, $790050, $480030,
	$F200A1, $C10080, $790050, $480030
);

twb64_175_yoasobi_amaranth: TGambatteColorMap = (
	$F2285A, $C12048, $79142D, $480C1B,
	$F2285A, $C12048, $79142D, $480C1B,
	$F2285A, $C12048, $79142D, $480C1B
);

twb64_176_nokia_3310_ver: TGambatteColorMap = (
	$73A684, $5C8469, $395342, $223127,
	$73A684, $5C8469, $395342, $223127,
	$73A684, $5C8469, $395342, $223127
);

twb64_177_clover_green: TGambatteColorMap = (
	$39B54A, $2D903B, $1C5A25, $113616,
	$39B54A, $2D903B, $1C5A25, $113616,
	$39B54A, $2D903B, $1C5A25, $113616
);

twb64_178_goku_gt_gi: TGambatteColorMap = (
	$DBE3E6, $F0AC18, $3D6EA5, $122131,
	$DBE3E6, $F0AC18, $3D6EA5, $122131,
	$DBE3E6, $F0AC18, $3D6EA5, $122131
);

twb64_179_famicom_disk_yellow: TGambatteColorMap = (
	$F3C200, $C29B00, $796100, $483A00,
	$F3C200, $C29B00, $796100, $483A00,
	$F3C200, $C29B00, $796100, $483A00
);

twb64_180_team_rocket_uniform: TGambatteColorMap = (
	$EEEFEB, $E94E60, $755E88, $474F4D,
	$EEEFEB, $E94E60, $755E88, $474F4D,
	$EEEFEB, $E94E60, $755E88, $474F4D
);

twb64_181_seiko_timely_vision: TGambatteColorMap = (
	$FFBF00, $4393E6, $0050A5, $202121,
	$FFBF00, $4393E6, $0050A5, $202121,
	$FFBF00, $4393E6, $0050A5, $202121
);

twb64_182_pastel109: TGambatteColorMap = (
	$F2D53F, $FD87B2, $3DACB8, $5503A6,
	$F2D53F, $FD87B2, $3DACB8, $5503A6,
	$F2D53F, $FD87B2, $3DACB8, $5503A6
);

twb64_183_doraemon_tricolor: TGambatteColorMap = (
	$FFE800, $00A8F4, $E60000, $450000,
	$FFE800, $00A8F4, $E60000, $450000,
	$FFE800, $00A8F4, $E60000, $450000
);

twb64_184_fury_blue: TGambatteColorMap = (
	$2B5F98, $224C79, $152F4C, $0C1C2D,
	$2B5F98, $224C79, $152F4C, $0C1C2D,
	$2B5F98, $224C79, $152F4C, $0C1C2D
);

twb64_185_good_smile_vision: TGambatteColorMap = (
	$9FA0A0, $EE7700, $8E4700, $472300,
	$9FA0A0, $EE7700, $8E4700, $472300,
	$9FA0A0, $EE7700, $8E4700, $472300
);

twb64_186_puyo_puyo_green: TGambatteColorMap = (
	$48E236, $39B42B, $24771B, $154310,
	$48E236, $39B42B, $24771B, $154310,
	$48E236, $39B42B, $24771B, $154310
);

twb64_187_circle_k_color_combo: TGambatteColorMap = (
	$F99B2A, $EC2E24, $8D1B15, $460D0A,
	$F99B2A, $EC2E24, $8D1B15, $460D0A,
	$F99B2A, $EC2E24, $8D1B15, $460D0A
);

twb64_188_pizza_hut_red: TGambatteColorMap = (
	$E3383E, $B52C31, $711C1F, $441012,
	$E3383E, $B52C31, $711C1F, $441012,
	$E3383E, $B52C31, $711C1F, $441012
);

twb64_189_emerald_green: TGambatteColorMap = (
	$50C878, $40A060, $28643C, $183C24,
	$50C878, $40A060, $28643C, $183C24,
	$50C878, $40A060, $28643C, $183C24
);

twb64_190_grand_ivory: TGambatteColorMap = (
	$D9D6BE, $ADAB98, $6C6B5F, $414039,
	$D9D6BE, $ADAB98, $6C6B5F, $414039,
	$D9D6BE, $ADAB98, $6C6B5F, $414039
);

twb64_191_demons_gold: TGambatteColorMap = (
	$BAAF56, $948C44, $5D572B, $373419,
	$BAAF56, $948C44, $5D572B, $373419,
	$BAAF56, $948C44, $5D572B, $373419
);

twb64_192_sega_tokyo_blue: TGambatteColorMap = (
	$0082D4, $0068A9, $00416A, $00273F,
	$0082D4, $0068A9, $00416A, $00273F,
	$0082D4, $0068A9, $00416A, $00273F
);

twb64_193_champions_tunic: TGambatteColorMap = (
	$E2DCB1, $009EDD, $875B40, $281B13,
	$E2DCB1, $009EDD, $875B40, $281B13,
	$E2DCB1, $009EDD, $875B40, $281B13
);

twb64_194_dk_barrel_brown: TGambatteColorMap = (
	$C3742F, $9C5C25, $613A17, $3A220E,
	$C3742F, $9C5C25, $613A17, $3A220E,
	$C3742F, $9C5C25, $613A17, $3A220E
);

twb64_195_eva_01: TGambatteColorMap = (
	$54CF54, $F99B22, $765898, $303345,
	$54CF54, $F99B22, $765898, $303345,
	$54CF54, $F99B22, $765898, $303345
);

twb64_196_wild_west_vision: TGambatteColorMap = (
	$D9D7C7, $C3976A, $924A36, $3A160E,
	$D9D7C7, $C3976A, $924A36, $3A160E,
	$D9D7C7, $C3976A, $924A36, $3A160E
);

twb64_197_optimus_prime_palette: TGambatteColorMap = (
	$D3D3D3, $D92121, $0047AB, $001533,
	$D3D3D3, $D92121, $0047AB, $001533,
	$D3D3D3, $D92121, $0047AB, $001533
);

twb64_198_niconico_sea_green: TGambatteColorMap = (
	$19C3A4, $149C83, $0C6152, $073A31,
	$19C3A4, $149C83, $0C6152, $073A31,
	$19C3A4, $149C83, $0C6152, $073A31
);

twb64_199_duracell_copper: TGambatteColorMap = (
	$C8895D, $A06D4A, $64442E, $3C291B,
	$C8895D, $A06D4A, $64442E, $3C291B,
	$C8895D, $A06D4A, $64442E, $3C291B
);

twb64_200_tokyo_skytree_cloudy_blue: TGambatteColorMap = (
	$82B5C7, $68909F, $415A63, $27363B,
	$82B5C7, $68909F, $415A63, $27363B,
	$82B5C7, $68909F, $415A63, $27363B
);

twb64_201_dmg_gold: TGambatteColorMap = (
$A1B560, $80904C, $505A30, $30361C,
$A1B560, $80904C, $505A30, $30361C,
$A1B560, $80904C, $505A30, $30361C
);

twb64_202_lcd_clock_green: TGambatteColorMap = (
$50B580, $409066, $285A40, $183626,
$50B580, $409066, $285A40, $183626,
$50B580, $409066, $285A40, $183626
);

twb64_203_famicom_frenzy: TGambatteColorMap = (
$EFECDA, $D9BE72, $A32135, $231916,
$EFECDA, $D9BE72, $A32135, $231916,
$EFECDA, $D9BE72, $A32135, $231916
);

twb64_204_dk_arcade_blue: TGambatteColorMap = (
$47A2DE, $3881B1, $23516F, $153042,
$47A2DE, $3881B1, $23516F, $153042,
$47A2DE, $3881B1, $23516F, $153042
);

twb64_205_advanced_indigo: TGambatteColorMap = (
$796ABA, $605494, $3C355D, $241F37,
$796ABA, $605494, $3C355D, $241F37,
$796ABA, $605494, $3C355D, $241F37
);

twb64_206_ultra_black: TGambatteColorMap = (
$4D5263, $3D414F, $262931, $17181D,
$4D5263, $3D414F, $262931, $17181D,
$4D5263, $3D414F, $262931, $17181D
);

twb64_207_chaos_emerald_green: TGambatteColorMap = (
$A0E000, $80C800, $409800, $208000,
$A0E000, $80C800, $409800, $208000,
$A0E000, $80C800, $409800, $208000
);

twb64_208_blue_bomber_vision: TGambatteColorMap = (
$E2CDA7, $639AFC, $0D4DC4, $000000,
$E2CDA7, $639AFC, $0D4DC4, $000000,
$E2CDA7, $639AFC, $0D4DC4, $000000
);

twb64_209_krispy_kreme_vision: TGambatteColorMap = (
$FFFFFF, $CF152D, $166938, $000000,
$FFFFFF, $CF152D, $166938, $000000,
$FFFFFF, $CF152D, $166938, $000000
);

twb64_210_steam_gray: TGambatteColorMap = (
$C5C3C0, $9D9C99, $626160, $3B3A39,
$C5C3C0, $9D9C99, $626160, $3B3A39,
$C5C3C0, $9D9C99, $626160, $3B3A39
);

twb64_211_dream_land_gb_ver: TGambatteColorMap = (
$F6FF70, $B9D03A, $788B1D, $48530E,
$F6FF70, $B9D03A, $788B1D, $48530E,
$F6FF70, $B9D03A, $788B1D, $48530E
);

twb64_212_pokemon_pinball_ver: TGambatteColorMap = (
$E8F8B8, $A0B050, $786030, $181820,
$E8F8B8, $A0B050, $786030, $181820,
$E8F8B8, $A0B050, $786030, $181820
);

twb64_213_poketch_ver: TGambatteColorMap = (
$70B070, $508050, $385030, $102818,
$70B070, $508050, $385030, $102818,
$70B070, $508050, $385030, $102818
);

twb64_214_collection_of_saga_ver: TGambatteColorMap = (
$B2C0A8, $769A67, $345D51, $041820,
$B2C0A8, $769A67, $345D51, $041820,
$B2C0A8, $769A67, $345D51, $041820
);

twb64_215_rocky_valley_holiday: TGambatteColorMap = (
$C0F0F8, $D89078, $805850, $204008,
$C0F0F8, $D89078, $805850, $204008,
$C0F0F8, $D89078, $805850, $204008
);

twb64_216_giga_kiwi_dmg: TGambatteColorMap = (
$D0E040, $A0A830, $607028, $384828,
$D0E040, $A0A830, $607028, $384828,
$D0E040, $A0A830, $607028, $384828
);

twb64_217_dmg_pea_green: TGambatteColorMap = (
$D7E894, $AEC440, $527F39, $204631,
$D7E894, $AEC440, $527F39, $204631,
$D7E894, $AEC440, $527F39, $204631
);

twb64_218_timing_hero_ver: TGambatteColorMap = (
$CCCC99, $8C994C, $4C6718, $202E00,
$CCCC99, $8C994C, $4C6718, $202E00,
$CCCC99, $8C994C, $4C6718, $202E00
);

twb64_219_invincible_yellow_and_blue: TGambatteColorMap = (
$FEE566, $39C9EB, $22788D, $113C46,
$FEE566, $39C9EB, $22788D, $113C46,
$FEE566, $39C9EB, $22788D, $113C46
);

twb64_220_grinchy_green: TGambatteColorMap = (
$B7BE1C, $929816, $5B5F0E, $363908,
$B7BE1C, $929816, $5B5F0E, $363908,
$B7BE1C, $929816, $5B5F0E, $363908
);

twb64_221_animate_vision: TGambatteColorMap = (
$FFFFFF, $F9BE00, $385EAA, $231815,
$FFFFFF, $F9BE00, $385EAA, $231815,
$FFFFFF, $F9BE00, $385EAA, $231815
);

twb64_222_school_idol_mix: TGambatteColorMap = (
$F39800, $00A0E9, $A5469B, $31152E,
$F39800, $00A0E9, $A5469B, $31152E,
$F39800, $00A0E9, $A5469B, $31152E
);

twb64_223_green_awakening: TGambatteColorMap = (
$F1FFDD, $98DB75, $367050, $000B16,
$F1FFDD, $98DB75, $367050, $000B16,
$F1FFDD, $98DB75, $367050, $000B16
);

twb64_224_goomba_brown: TGambatteColorMap = (
$AA593B, $88472F, $552C1D, $331A11,
$AA593B, $88472F, $552C1D, $331A11,
$AA593B, $88472F, $552C1D, $331A11
);

twb64_225_warioware_microblue: TGambatteColorMap = (
$1189CA, $0D6DA1, $084465, $05293C,
$1189CA, $0D6DA1, $084465, $05293C,
$1189CA, $0D6DA1, $084465, $05293C
);

twb64_226_konosuba_sherbet: TGambatteColorMap = (
$F08200, $E5006E, $890042, $440021,
$F08200, $E5006E, $890042, $440021,
$F08200, $E5006E, $890042, $440021
);

twb64_227_spooky_purple: TGambatteColorMap = (
$9E7CD2, $7E63A8, $4F3E69, $2F253F,
$9E7CD2, $7E63A8, $4F3E69, $2F253F,
$9E7CD2, $7E63A8, $4F3E69, $2F253F
);

twb64_228_treasure_gold: TGambatteColorMap = (
$CBB524, $A2901C, $655A12, $3C360A,
$CBB524, $A2901C, $655A12, $3C360A,
$CBB524, $A2901C, $655A12, $3C360A
);

twb64_229_cherry_blossom_pink: TGambatteColorMap = (
$F07EB0, $C0648C, $783F58, $482534,
$F07EB0, $C0648C, $783F58, $482534,
$F07EB0, $C0648C, $783F58, $482534
);

twb64_230_golden_trophy: TGambatteColorMap = (
$E8D018, $B9A613, $74680C, $453E07,
$E8D018, $B9A613, $74680C, $453E07,
$E8D018, $B9A613, $74680C, $453E07
);

twb64_231_glacial_winter_blue: TGambatteColorMap = (
$87C1E2, $6C9AB4, $436071, $283943,
$87C1E2, $6C9AB4, $436071, $283943,
$87C1E2, $6C9AB4, $436071, $283943
);

twb64_232_leprechaun_green: TGambatteColorMap = (
$378861, $2C6C4D, $1B4430, $10281D,
$378861, $2C6C4D, $1B4430, $10281D,
$378861, $2C6C4D, $1B4430, $10281D
);

twb64_233_saitama_super_blue: TGambatteColorMap = (
$277ABC, $1F6196, $133D5E, $0B2438,
$277ABC, $1F6196, $133D5E, $0B2438,
$277ABC, $1F6196, $133D5E, $0B2438
);

twb64_234_saitama_super_green: TGambatteColorMap = (
$16AE85, $118B6A, $0B5742, $063427,
$16AE85, $118B6A, $0B5742, $063427,
$16AE85, $118B6A, $0B5742, $063427
);

twb64_235_duolingo_green: TGambatteColorMap = (
$58CC02, $46A301, $2C6601, $1A3D00,
$58CC02, $46A301, $2C6601, $1A3D00,
$58CC02, $46A301, $2C6601, $1A3D00
);

twb64_236_super_mushroom_vision: TGambatteColorMap = (
$F7CEC3, $CC9E22, $923404, $000000,
$F7CEC3, $CC9E22, $923404, $000000,
$F7CEC3, $CC9E22, $923404, $000000
);

twb64_237_ancient_husuian_brown: TGambatteColorMap = (
$B39F90, $8F7F73, $594F48, $352F2B,
$B39F90, $8F7F73, $594F48, $352F2B,
$B39F90, $8F7F73, $594F48, $352F2B
);

twb64_238_sky_pop_ivory: TGambatteColorMap = (
$E5E0B8, $BEBB95, $86825A, $525025,
$E5E0B8, $BEBB95, $86825A, $525025,
$E5E0B8, $BEBB95, $86825A, $525025
);

twb64_239_lawson_blue: TGambatteColorMap = (
$0068B7, $005392, $00345B, $001F36,
$0068B7, $005392, $00345B, $001F36,
$0068B7, $005392, $00345B, $001F36
);

twb64_240_anime_expo_red: TGambatteColorMap = (
$EE3B33, $BE2F28, $771D19, $47110F,
$EE3B33, $BE2F28, $771D19, $47110F,
$EE3B33, $BE2F28, $771D19, $47110F
);

twb64_241_brilliant_diamond_blue: TGambatteColorMap = (
$7FBBE1, $6595B4, $3F5D70, $263843,
$7FBBE1, $6595B4, $3F5D70, $263843,
$7FBBE1, $6595B4, $3F5D70, $263843
);

twb64_242_shining_pearl_pink: TGambatteColorMap = (
$D28EA0, $A87180, $694750, $3F2A30,
$D28EA0, $A87180, $694750, $3F2A30,
$D28EA0, $A87180, $694750, $3F2A30
);

twb64_243_funimation_melon: TGambatteColorMap = (
$96FF00, $FF149F, $5B0BB5, $000000,
$96FF00, $FF149F, $5B0BB5, $000000,
$96FF00, $FF149F, $5B0BB5, $000000
);

twb64_244_teyvat_brown: TGambatteColorMap = (
$B89469, $937654, $5C4A34, $372C1F,
$B89469, $937654, $5C4A34, $372C1F,
$B89469, $937654, $5C4A34, $372C1F
);

twb64_245_chozo_blue: TGambatteColorMap = (
$4EB3E1, $3E8FB4, $275970, $173543,
$4EB3E1, $3E8FB4, $275970, $173543,
$4EB3E1, $3E8FB4, $275970, $173543
);

twb64_246_spotify_green: TGambatteColorMap = (
$1ED760, $18AC4C, $0F6B30, $09401C,
$1ED760, $18AC4C, $0F6B30, $09401C,
$1ED760, $18AC4C, $0F6B30, $09401C
);

twb64_247_dr_pepper_red: TGambatteColorMap = (
$8A2231, $6E1B27, $451118, $290A0E,
$8A2231, $6E1B27, $451118, $290A0E,
$8A2231, $6E1B27, $451118, $290A0E
);

twb64_248_nhk_silver_gray: TGambatteColorMap = (
$808080, $666666, $404040, $262626,
$808080, $666666, $404040, $262626,
$808080, $666666, $404040, $262626
);

twb64_249_dunkin_vision: TGambatteColorMap = (
$FF6E0C, $F20C90, $910756, $48032B,
$FF6E0C, $F20C90, $910756, $48032B,
$FF6E0C, $F20C90, $910756, $48032B
);

twb64_250_deku_gamma_palette: TGambatteColorMap = (
$F0E8D6, $B6BEC8, $166668, $24262B,
$F0E8D6, $B6BEC8, $166668, $24262B,
$F0E8D6, $B6BEC8, $166668, $24262B
);

twb64_251_universal_studios_blue: TGambatteColorMap = (
$036CE2, $0256B4, $013671, $002043,
$036CE2, $0256B4, $013671, $002043,
$036CE2, $0256B4, $013671, $002043
);

twb64_252_hogwarts_goldius: TGambatteColorMap = (
$B6A571, $91845A, $5B5238, $363121,
$B6A571, $91845A, $5B5238, $363121,
$B6A571, $91845A, $5B5238, $363121
);

twb64_253_kentucky_fried_red: TGambatteColorMap = (
$AB182F, $881325, $550C17, $33070E,
$AB182F, $881325, $550C17, $33070E,
$AB182F, $881325, $550C17, $33070E
);

twb64_254_cheeto_orange: TGambatteColorMap = (
$E57600, $B75E00, $723B00, $442300,
$E57600, $B75E00, $723B00, $442300,
$E57600, $B75E00, $723B00, $442300
);

twb64_255_namco_idol_pink: TGambatteColorMap = (
$FF74B8, $CC5C93, $7F3A5C, $4C2237,
$FF74B8, $CC5C93, $7F3A5C, $4C2237,
$FF74B8, $CC5C93, $7F3A5C, $4C2237
);

twb64_256_dominos_pizza_vision: TGambatteColorMap = (
$FFFFFF, $E31837, $006491, $000000,
$FFFFFF, $E31837, $006491, $000000,
$FFFFFF, $E31837, $006491, $000000
);

twb64_257_pac_man_vision: TGambatteColorMap = (
$FFFF00, $FFB897, $3732FF, $000000,
$FFFF00, $FFB897, $3732FF, $000000,
$FFFF00, $FFB897, $3732FF, $000000
);

twb64_258_bills_pc_screen: TGambatteColorMap = (
$F87800, $B86000, $783800, $000000,
$F87800, $B86000, $783800, $000000,
$F87800, $B86000, $783800, $000000
);

twb64_259_ebott_prolouge: TGambatteColorMap = (
$C08226, $854A1D, $4A290B, $2C1708,
$C08226, $854A1D, $4A290B, $2C1708,
$C08226, $854A1D, $4A290B, $2C1708
);

twb64_260_fools_gold_and_silver: TGambatteColorMap = (
$C5C66D, $97A1B0, $5A6069, $2D3034,
$C5C66D, $97A1B0, $5A6069, $2D3034,
$C5C66D, $97A1B0, $5A6069, $2D3034
);

twb64_261_uta_vision: TGambatteColorMap = (
$F4F4F4, $F1A7B5, $E24465, $262C48,
$F4F4F4, $F1A7B5, $E24465, $262C48,
$F4F4F4, $F1A7B5, $E24465, $262C48
);

twb64_262_metallic_paldea_brass: TGambatteColorMap = (
$A29834, $817929, $514C1A, $302D0F,
$A29834, $817929, $514C1A, $302D0F,
$A29834, $817929, $514C1A, $302D0F
);

twb64_263_classy_christmas: TGambatteColorMap = (
$E8E7DF, $8BAB95, $9E5C5E, $534D57,
$E8E7DF, $8BAB95, $9E5C5E, $534D57,
$E8E7DF, $8BAB95, $9E5C5E, $534D57
);

twb64_264_winter_christmas: TGambatteColorMap = (
$DDDDDD, $65B08F, $AE3B40, $341113,
$DDDDDD, $65B08F, $AE3B40, $341113,
$DDDDDD, $65B08F, $AE3B40, $341113
);

twb64_265_idol_world_tricolor: TGambatteColorMap = (
$FFC30B, $F34F6D, $2681C8, $0B263C,
$FFC30B, $F34F6D, $2681C8, $0B263C,
$FFC30B, $F34F6D, $2681C8, $0B263C
);

twb64_266_inkling_tricolor: TGambatteColorMap = (
$EAFF3D, $FF505E, $603BFF, $1C114C,
$EAFF3D, $FF505E, $603BFF, $1C114C,
$EAFF3D, $FF505E, $603BFF, $1C114C
);

twb64_267_7_eleven_color_combo: TGambatteColorMap = (
$FF6C00, $EB0F2A, $147350, $062218,
$FF6C00, $EB0F2A, $147350, $062218,
$FF6C00, $EB0F2A, $147350, $062218
);

twb64_268_pac_palette: TGambatteColorMap = (
$FFD800, $FF8C00, $DC0000, $420000,
$FFD800, $FF8C00, $DC0000, $420000,
$FFD800, $FF8C00, $DC0000, $420000
);

twb64_269_vulnerable_blue: TGambatteColorMap = (
$3732FF, $7F5C4B, $CC9378, $FFB897,
$3732FF, $7F5C4B, $CC9378, $FFB897,
$3732FF, $7F5C4B, $CC9378, $FFB897
);

twb64_270_nightvision_green: TGambatteColorMap = (
$1E390E, $335F17, $519825, $66BF2F,
$1E390E, $335F17, $519825, $66BF2F,
$1E390E, $335F17, $519825, $66BF2F
);

twb64_271_bandai_namco_tricolor: TGambatteColorMap = (
$F6B700, $DF4F61, $0069B1, $001F35,
$F6B700, $DF4F61, $0069B1, $001F35,
$F6B700, $DF4F61, $0069B1, $001F35
);

twb64_272_gold_silver_and_bronze: TGambatteColorMap = (
$BEB049, $86949A, $996843, $2D1F14,
$BEB049, $86949A, $996843, $2D1F14,
$BEB049, $86949A, $996843, $2D1F14
);

twb64_273_deku_vigilante_palette: TGambatteColorMap = (
$ADA89A, $878B92, $38534E, $131315,
$ADA89A, $878B92, $38534E, $131315,
$ADA89A, $878B92, $38534E, $131315
);

twb64_274_super_famicom_supreme: TGambatteColorMap = (
$FEDA5A, $44AC71, $D94040, $0846BA,
$FEDA5A, $44AC71, $D94040, $0846BA,
$FEDA5A, $44AC71, $D94040, $0846BA
);

twb64_275_absorbent_and_yellow: TGambatteColorMap = (
$FFF752, $AEC600, $687600, $343B00,
$FFF752, $AEC600, $687600, $343B00,
$FFF752, $AEC600, $687600, $343B00
);

twb64_276_765pro_tricolor: TGambatteColorMap = (
$B4E04B, $E22B30, $2743D2, $0B143F,
$B4E04B, $E22B30, $2743D2, $0B143F,
$B4E04B, $E22B30, $2743D2, $0B143F
);

twb64_277_gamecube_glimmer: TGambatteColorMap = (
$B6BED3, $11A396, $CF4151, $3E1318,
$B6BED3, $11A396, $CF4151, $3E1318,
$B6BED3, $11A396, $CF4151, $3E1318
);

twb64_278_1st_vision_pastel: TGambatteColorMap = (
$EA7CB1, $7FAF5A, $385EAD, $101C33,
$EA7CB1, $7FAF5A, $385EAD, $101C33,
$EA7CB1, $7FAF5A, $385EAD, $101C33
);

twb64_279_perfect_majin_emperor: TGambatteColorMap = (
$FDC1BF, $A3B453, $8550A9, $271832,
$FDC1BF, $A3B453, $8550A9, $271832,
$FDC1BF, $A3B453, $8550A9, $271832
);

twb64_280_j_pop_idol_sherbet: TGambatteColorMap = (
$F19DB5, $5BBEE5, $812990, $260C2B,
$F19DB5, $5BBEE5, $812990, $260C2B,
$F19DB5, $5BBEE5, $812990, $260C2B
);

twb64_281_ryuuguu_sunset: TGambatteColorMap = (
$FFE43F, $FD99E1, $9238BE, $2B1039,
$FFE43F, $FD99E1, $9238BE, $2B1039,
$FFE43F, $FD99E1, $9238BE, $2B1039
);

twb64_282_tropical_starfall: TGambatteColorMap = (
$63FDFB, $EF58F7, $4344C1, $141439,
$63FDFB, $EF58F7, $4344C1, $141439,
$63FDFB, $EF58F7, $4344C1, $141439
);

twb64_283_colorful_horizons: TGambatteColorMap = (
$F6CF72, $60BDC7, $D15252, $373939,
$F6CF72, $60BDC7, $D15252, $373939,
$F6CF72, $60BDC7, $D15252, $373939
);

twb64_284_blackpink_blink_pink: TGambatteColorMap = (
$F4A7BA, $C38594, $7A535D, $493237,
$F4A7BA, $C38594, $7A535D, $493237,
$F4A7BA, $C38594, $7A535D, $493237
);

twb64_285_dmg_switch: TGambatteColorMap = (
$8CAD28, $6C9421, $426B29, $214231,
$8CAD28, $6C9421, $426B29, $214231,
$8CAD28, $6C9421, $426B29, $214231
);

twb64_286_pocket_switch: TGambatteColorMap = (
$B5C69C, $8D9C7B, $637251, $303820,
$B5C69C, $8D9C7B, $637251, $303820,
$B5C69C, $8D9C7B, $637251, $303820
);

twb64_287_sunny_passion_paradise: TGambatteColorMap = (
$F0BA40, $E06846, $1E6CAE, $092034,
$F0BA40, $E06846, $1E6CAE, $092034,
$F0BA40, $E06846, $1E6CAE, $092034
);

twb64_288_saiyan_beast_silver: TGambatteColorMap = (
$969BAF, $787C8C, $4B4D57, $2D2E34,
$969BAF, $787C8C, $4B4D57, $2D2E34,
$969BAF, $787C8C, $4B4D57, $2D2E34
);

twb64_289_radiant_smile_ramp: TGambatteColorMap = (
$FFF89B, $01B3C4, $E6016B, $1B1C81,
$FFF89B, $01B3C4, $E6016B, $1B1C81,
$FFF89B, $01B3C4, $E6016B, $1B1C81
);

twb64_290_a_rise_blue: TGambatteColorMap = (
$30559C, $26447C, $182A4E, $0E192E,
$30559C, $26447C, $182A4E, $0E192E,
$30559C, $26447C, $182A4E, $0E192E
);

twb64_291_tropical_twice_apricot: TGambatteColorMap = (
$FCC89B, $FF5FA2, $993961, $4C1C30,
$FCC89B, $FF5FA2, $993961, $4C1C30,
$FCC89B, $FF5FA2, $993961, $4C1C30
);

twb64_292_odyssey_boy: TGambatteColorMap = (
$ACBE8C, $7E8E67, $505445, $222421,
$ACBE8C, $7E8E67, $505445, $222421,
$ACBE8C, $7E8E67, $505445, $222421
);

twb64_293_frog_coin_green: TGambatteColorMap = (
$FFF7DE, $00EF00, $398400, $003900,
$FFF7DE, $00EF00, $398400, $003900,
$FFF7DE, $00EF00, $398400, $003900
);

twb64_294_garfield_vision: TGambatteColorMap = (
$F5EA8B, $E59436, $964220, $2D1309,
$F5EA8B, $E59436, $964220, $2D1309,
$F5EA8B, $E59436, $964220, $2D1309
);

twb64_295_bedrock_caveman_vision: TGambatteColorMap = (
$FF7F00, $009EB8, $005E6E, $002F37,
$FF7F00, $009EB8, $005E6E, $002F37,
$FF7F00, $009EB8, $005E6E, $002F37
);

twb64_296_bangtan_army_purple: TGambatteColorMap = (
$8048D8, $6639AC, $40246C, $261540,
$8048D8, $6639AC, $40246C, $261540,
$8048D8, $6639AC, $40246C, $261540
);

twb64_297_le_sserafim_fearless_blue: TGambatteColorMap = (
$81A5F9, $6784C7, $40527C, $26314A,
$81A5F9, $6784C7, $40527C, $26314A,
$81A5F9, $6784C7, $40527C, $26314A
);

twb64_298_baja_blast_beach: TGambatteColorMap = (
$DBE441, $83CCC5, $4E7A76, $273D3B,
$DBE441, $83CCC5, $4E7A76, $273D3B,
$DBE441, $83CCC5, $4E7A76, $273D3B
);

twb64_299_3ds_virtual_console_green: TGambatteColorMap = (
$BDFF21, $9CEF29, $5A8C42, $4A4A4A,
$BDFF21, $9CEF29, $5A8C42, $4A4A4A,
$BDFF21, $9CEF29, $5A8C42, $4A4A4A
);

twb64_300_wonder_purple: TGambatteColorMap = (
$E658DF, $B846B2, $732C6F, $451A42,
$E658DF, $B846B2, $732C6F, $451A42,
$E658DF, $B846B2, $732C6F, $451A42
);

//
// Palettes by PixelShift
// https://github.com/libretro/gambatte-libretro/issues/219
//
pixelshift_01_arctic_green: TGambatteColorMap = (
	$C4F0C2, $5AB9A8, $1E606E, $2D1B00,
	$C4F0C2, $5AB9A8, $1E606E, $2D1B00,
	$C4F0C2, $5AB9A8, $1E606E, $2D1B00
);

pixelshift_02_arduboy: TGambatteColorMap = (
	$000000, $000000, $FFFFFF, $FFFFFF,
	$000000, $000000, $FFFFFF, $FFFFFF,
	$000000, $000000, $FFFFFF, $FFFFFF
);

pixelshift_03_bgb_0_3_emulator: TGambatteColorMap = (
	$E8FCCC, $ACD490, $548C70, $142C38,
	$E8FCCC, $ACD490, $548C70, $142C38,
	$E8FCCC, $ACD490, $548C70, $142C38
);

pixelshift_04_camouflage: TGambatteColorMap = (
	$968969, $48623F, $60513A, $272727,
	$968969, $48623F, $60513A, $272727,
	$968969, $48623F, $60513A, $272727
);

pixelshift_05_chocolate_bar: TGambatteColorMap = (
	$F7D9BA, $C2925C, $975447, $310300,
	$F7D9BA, $C2925C, $975447, $310300,
	$F7D9BA, $C2925C, $975447, $310300
);

pixelshift_06_cmyk: TGambatteColorMap = (
	$8CDFFD, $FD80C6, $FFF68C, $3E3E3E,
	$8CDFFD, $FD80C6, $FFF68C, $3E3E3E,
	$8CDFFD, $FD80C6, $FFF68C, $3E3E3E
);

pixelshift_07_cotton_candy: TGambatteColorMap = (
	$F8FFFF, $90D9FC, $FF7A99, $000000,
	$F8FFFF, $90D9FC, $FF7A99, $000000,
	$F8FFFF, $90D9FC, $FF7A99, $000000
);

pixelshift_08_easy_greens: TGambatteColorMap = (
	$EBDD77, $A1BC00, $0D8833, $004333,
	$EBDD77, $A1BC00, $0D8833, $004333,
	$EBDD77, $A1BC00, $0D8833, $004333
);

pixelshift_09_gamate: TGambatteColorMap = (
	$33CC33, $20983E, $006666, $003958,
	$33CC33, $20983E, $006666, $003958,
	$33CC33, $20983E, $006666, $003958
);

pixelshift_10_game_boy_light: TGambatteColorMap = (
	$02EA75, $01B158, $00793C, $004120,
	$02EA75, $01B158, $00793C, $004120,
	$02EA75, $01B158, $00793C, $004120
);

pixelshift_11_game_boy_pocket: TGambatteColorMap = (
	$929775, $656A55, $535849, $282C26,
	$929775, $656A55, $535849, $282C26,
	$929775, $656A55, $535849, $282C26
);

pixelshift_12_game_boy_pocket_alt: TGambatteColorMap = (
	$89A18E, $758A78, $627262, $30372F,
	$89A18E, $758A78, $627262, $30372F,
	$89A18E, $758A78, $627262, $30372F
);

pixelshift_13_game_pocket_computer: TGambatteColorMap = (
	$FFFFFF, $FFFFFF, $000000, $000000,
	$FFFFFF, $FFFFFF, $000000, $000000,
	$FFFFFF, $FFFFFF, $000000, $000000
);

pixelshift_14_game_and_watch_ball: TGambatteColorMap = (
	$8E9F8D, $8E9F8D, $343837, $343837,
	$8E9F8D, $8E9F8D, $343837, $343837,
	$8E9F8D, $8E9F8D, $343837, $343837
);

pixelshift_15_gb_backlight_blue: TGambatteColorMap = (
	$3FC1FF, $068EFF, $0058FF, $00006D,
	$3FC1FF, $068EFF, $0058FF, $00006D,
	$3FC1FF, $068EFF, $0058FF, $00006D
);

pixelshift_16_gb_backlight_faded: TGambatteColorMap = (
	$FFFFFF, $E2E2E2, $9E9E9E, $808080,
	$FFFFFF, $E2E2E2, $9E9E9E, $808080,
	$FFFFFF, $E2E2E2, $9E9E9E, $808080
);

pixelshift_17_gb_backlight_orange: TGambatteColorMap = (
	$FDA910, $F88806, $E96B08, $833403,
	$FDA910, $F88806, $E96B08, $833403,
	$FDA910, $F88806, $E96B08, $833403
);

pixelshift_18_gb_backlight_white_: TGambatteColorMap = (
	$BAC9E8, $9091C9, $6731FF, $0C0FD0,
	$BAC9E8, $9091C9, $6731FF, $0C0FD0,
	$BAC9E8, $9091C9, $6731FF, $0C0FD0
);

pixelshift_19_gb_backlight_yellow_dark: TGambatteColorMap = (
	$99931A, $8B7E0F, $63530F, $4F3B08,
	$99931A, $8B7E0F, $63530F, $4F3B08,
	$99931A, $8B7E0F, $63530F, $4F3B08
);

pixelshift_20_gb_bootleg: TGambatteColorMap = (
	$89AABB, $9EB481, $4A714A, $4A2D2C,
	$F7C6B5, $DE7B52, $9C3900, $4A3100,
	$F7C6B5, $DE7B52, $9C3900, $4A3100
);

pixelshift_21_gb_hunter: TGambatteColorMap = (
	$B4B0AD, $7D7A78, $464544, $101010,
	$B4B0AD, $7D7A78, $464544, $101010,
	$B4B0AD, $7D7A78, $464544, $101010
);

pixelshift_22_gb_kiosk: TGambatteColorMap = (
	$01FC00, $00D100, $00BF00, $005C09,
	$01FC00, $00D100, $00BF00, $005C09,
	$01FC00, $00D100, $00BF00, $005C09
);

pixelshift_23_gb_kiosk_2: TGambatteColorMap = (
	$FFFF93, $C2DE00, $536500, $003500,
	$FFFF93, $C2DE00, $536500, $003500,
	$FFFF93, $C2DE00, $536500, $003500
);

pixelshift_24_gb_new: TGambatteColorMap = (
	$88CF45, $58B865, $23854B, $1D684B,
	$88CF45, $58B865, $23854B, $1D684B,
	$88CF45, $58B865, $23854B, $1D684B
);

pixelshift_25_gb_nuked: TGambatteColorMap = (
	$70AC80, $A88D08, $85211F, $00004F,
	$70AC80, $A88D08, $85211F, $00004F,
	$70AC80, $A88D08, $85211F, $00004F
);

pixelshift_26_gb_old: TGambatteColorMap = (
	$7E8416, $577B46, $385D49, $2E463D,
	$7E8416, $577B46, $385D49, $2E463D,
	$7E8416, $577B46, $385D49, $2E463D
);

pixelshift_27_gbp_bivert: TGambatteColorMap = (
	$ADD2FE, $73AAE6, $3982CF, $005BB8,
	$ADD2FE, $73AAE6, $3982CF, $005BB8,
	$ADD2FE, $73AAE6, $3982CF, $005BB8
);

pixelshift_28_gb_washed_yellow_backlight: TGambatteColorMap = (
	$C4F796, $8DC472, $6488AA, $1C4599,
	$C4F796, $8DC472, $6488AA, $1C4599,
	$C4F796, $8DC472, $6488AA, $1C4599
);

pixelshift_29_ghost: TGambatteColorMap = (
	$FFF1EB, $E096A8, $70579C, $0A0912,
	$FFF1EB, $E096A8, $70579C, $0A0912,
	$FFF1EB, $E096A8, $70579C, $0A0912
);

pixelshift_30_glow_in_the_dark: TGambatteColorMap = (
	$4DEEAA, $339E71, $194F38, $000000,
	$4DEEAA, $339E71, $194F38, $000000,
	$4DEEAA, $339E71, $194F38, $000000
);

pixelshift_31_gold_bar: TGambatteColorMap = (
	$FCFFD6, $FFDB57, $D27D2C, $854C30,
	$FCFFD6, $FFDB57, $D27D2C, $854C30,
	$FCFFD6, $FFDB57, $D27D2C, $854C30
);

pixelshift_32_grapefruit: TGambatteColorMap = (
	$FFF5DD, $F4B26B, $B76591, $65296C,
	$FFF5DD, $F4B26B, $B76591, $65296C,
	$FFF5DD, $F4B26B, $B76591, $65296C
);

pixelshift_33_gray_green_mix: TGambatteColorMap = (
	$E8E8E8, $A0A0A0, $585858, $101010,
	$E0F8D0, $88C070, $346856, $081820,
	$E0F8D0, $88C070, $346856, $081820
);

pixelshift_34_missingno: TGambatteColorMap = (
	$FFFFFF, $F0B088, $807098, $181010,
	$FFFFFF, $F0B088, $807098, $181010,
	$FFFFFF, $F0B088, $807098, $181010
);

pixelshift_35_ms_dos: TGambatteColorMap = (
	$000000, $000000, $17F117, $17F117,
	$000000, $000000, $17F117, $17F117,
	$000000, $000000, $17F117, $17F117
);

pixelshift_36_newspaper: TGambatteColorMap = (
	$646464, $505050, $323232, $000000,
	$646464, $505050, $323232, $000000,
	$646464, $505050, $323232, $000000
);

pixelshift_37_pip_boy: TGambatteColorMap = (
	$05160C, $062D1A, $0DB254, $1BC364,
	$05160C, $062D1A, $0DB254, $1BC364,
	$05160C, $062D1A, $0DB254, $1BC364
);

pixelshift_38_pocket_girl: TGambatteColorMap = (
	$F7FFAE, $FFB3CB, $96FBC7, $74569B,
	$F7FFAE, $FFB3CB, $96FBC7, $74569B,
	$F7FFAE, $FFB3CB, $96FBC7, $74569B
);

pixelshift_39_silhouette: TGambatteColorMap = (
	$E8E8E8, $A0A0A0, $585858, $000000,
	$000000, $000000, $000000, $000000,
	$000000, $000000, $000000, $000000
);

pixelshift_40_sunburst: TGambatteColorMap = (
	$E1EEC3, $ECE774, $F6903D, $F05053,
	$E1EEC3, $ECE774, $F6903D, $F05053,
	$E1EEC3, $ECE774, $F6903D, $F05053
);

pixelshift_41_technicolor: TGambatteColorMap = (
	$FFF5F7, $E6B8C1, $456B73, $15191A,
	$FFF5F7, $E6B8C1, $456B73, $15191A,
	$FFF5F7, $E6B8C1, $456B73, $15191A
);

pixelshift_42_tron: TGambatteColorMap = (
	$000000, $2A0055, $5500AA, $8000FF,
	$AAA9B2, $757576, $0099EC, $0065A8,
	$AAA9B2, $757576, $0099EC, $0065A8
);

pixelshift_43_vaporwave: TGambatteColorMap = (
	$4ADBE5, $E54CB0, $574797, $1A2D40,
	$4ADBE5, $E54CB0, $574797, $1A2D40,
	$4ADBE5, $E54CB0, $574797, $1A2D40
);

pixelshift_44_virtual_boy: TGambatteColorMap = (
	$D90708, $960708, $530607, $070303,
	$D90708, $960708, $530607, $070303,
	$D90708, $960708, $530607, $070303
);

pixelshift_45_wish: TGambatteColorMap = (
	$8BE5FF, $608FCF, $7550E8, $622E4C,
	$8BE5FF, $608FCF, $7550E8, $622E4C,
	$8BE5FF, $608FCF, $7550E8, $622E4C
);

const
(*

Created by replacing:
'{' by '(GameName: '
' }' by ')'
''' by ''''
'"' by '''
', ' by '; ColorMap: @'

*)

gbcTitlePalettes: array[0..120] of TGambatteColorMapping = (
 (GameName: 'ALLEY WAY'; ColorMap: @p008),
	(GameName: 'ASTEROIDS'; ColorMap: @p30E),	// unofficial ('ASTEROIDS/MISCMD' alt.)
	(GameName: 'ASTEROIDS/MISCMD'; ColorMap: @p30E),
	(GameName: 'ATOMIC PUNK'; ColorMap: @p30F),	// unofficial ('DYNABLASTER' alt.)
	(GameName: 'BA.TOSHINDEN'; ColorMap: @p50F),
	(GameName: 'BALLOON KID'; ColorMap: @p006),
	(GameName: 'BASEBALL'; ColorMap: @p503),
	(GameName: 'BATTLETOADS'; ColorMap: @p312),	// unofficial
	(GameName: 'BOMBER MAN GB'; ColorMap: @p31C),	// unofficial ('WARIO BLAST' alt.)
	(GameName: 'BOY AND BLOB GB1'; ColorMap: @p512),
	(GameName: 'BOY AND BLOB GB2'; ColorMap: @p512),
	(GameName: 'BT2RAGNAROKWORLD'; ColorMap: @p312),
	(GameName: 'CENTIPEDE'; ColorMap: @p31C),	// unofficial ('MILLI/CENTI/PEDE' alt.)
	(GameName: 'DEFENDER/JOUST'; ColorMap: @p50F),
	(GameName: 'DMG FOOTBALL'; ColorMap: @p30E),
	(GameName: 'DONKEY KONG'; ColorMap: @p306),
	(GameName: 'DONKEYKONGLAND'; ColorMap: @p50C),
	(GameName: 'DONKEYKONGLAND 2'; ColorMap: @p50C),
	(GameName: 'DONKEYKONGLAND 3'; ColorMap: @p50C),
	(GameName: 'DONKEYKONGLAND95'; ColorMap: @p501),
	(GameName: 'DR.MARIO'; ColorMap: @p20B),
	(GameName: 'DYNABLASTER'; ColorMap: @p30F),
	(GameName: 'EMPIRE STRIKES'; ColorMap: @p512),	// unofficial
	(GameName: 'F1RACE'; ColorMap: @p012),
	(GameName: 'FOOTBALL INT''L'; ColorMap: @p502),	// unofficial ('SOCCER' alt.)
	(GameName: 'G&W GALLERY'; ColorMap: @p304),
	(GameName: 'GALAGA&GALAXIAN'; ColorMap: @p013),
	(GameName: 'GAME&WATCH'; ColorMap: @p012),
	(GameName: 'Game and Watch 2'; ColorMap: @p304),
	(GameName: 'GAMEBOY GALLERY'; ColorMap: @p304),
	(GameName: 'GAMEBOY GALLERY2'; ColorMap: @p304),
	(GameName: 'GBWARS'; ColorMap: @p500),
	(GameName: 'GBWARST'; ColorMap: @p500),	// unofficial ('GBWARS' alt.)
	(GameName: 'GOLF'; ColorMap: @p30E),
	(GameName: 'HOSHINOKA-BI'; ColorMap: @p508),
	(GameName: 'JAMES  BOND  007'; ColorMap: @p11C),
	(GameName: 'KAERUNOTAMENI'; ColorMap: @p10D),
	(GameName: 'KEN GRIFFEY JR'; ColorMap: @p31C),
	(GameName: 'KID ICARUS'; ColorMap: @p30D),
	(GameName: 'KILLERINSTINCT95'; ColorMap: @p50D),
	(GameName: 'KINGOFTHEZOO'; ColorMap: @p30F),
	(GameName: 'KIRAKIRA KIDS'; ColorMap: @p012),
	(GameName: 'KIRBY BLOCKBALL'; ColorMap: @p508),
	(GameName: 'KIRBY DREAM LAND'; ColorMap: @p508),
	(GameName: 'KIRBY''S PINBALL'; ColorMap: @p308),
	(GameName: 'KIRBY2'; ColorMap: @p508),
	(GameName: 'LOLO'; ColorMap: @p50F),	// unofficial ('LOLO2' alt.)
	(GameName: 'LOLO2'; ColorMap: @p50F),
	(GameName: 'MAGNETIC SOCCER'; ColorMap: @p50E),
	(GameName: 'MANSELL'; ColorMap: @p012),
	(GameName: 'MARIO & YOSHI'; ColorMap: @p305),
	(GameName: 'MARIO''S PICROSS'; ColorMap: @p012),
	(GameName: 'MARIOLAND2'; ColorMap: @p509),
	(GameName: 'MEGA MAN 2'; ColorMap: @p50F),
	(GameName: 'MEGAMAN'; ColorMap: @p50F),
	(GameName: 'MEGAMAN3'; ColorMap: @p50F),
	(GameName: 'MEGAMAN4'; ColorMap: @p50F),	// unofficial
	(GameName: 'MEGAMAN5'; ColorMap: @p50F),	// unofficial
	(GameName: 'METROID2'; ColorMap: @p514),
	(GameName: 'MILLI/CENTI/PEDE'; ColorMap: @p31C),
	(GameName: 'MISSILE COMMAND'; ColorMap: @p30E),	// unofficial ('ASTEROIDS/MISCMD' alt.)
	(GameName: 'MOGURANYA'; ColorMap: @p300),
	(GameName: 'MYSTIC QUEST'; ColorMap: @p50E),
	(GameName: 'NETTOU KOF 95'; ColorMap: @p50F),
	(GameName: 'NETTOU KOF 96'; ColorMap: @p50F),	// unofficial
	(GameName: 'NETTOU TOSHINDEN'; ColorMap: @p50F),	// unofficial ('BA.TOSHINDEN' alt.)
	(GameName: 'NEW CHESSMASTER'; ColorMap: @p30F),
	(GameName: 'OTHELLO'; ColorMap: @p50E),
	(GameName: 'PAC-IN-TIME'; ColorMap: @p51C),
	(GameName: 'PENGUIN WARS'; ColorMap: @p30F),	// unofficial ('KINGOFTHEZOO' alt.)
	(GameName: 'PENGUINKUNWARSVS'; ColorMap: @p30F),	// unofficial ('KINGOFTHEZOO' alt.)
	(GameName: 'PICROSS 2'; ColorMap: @p012),
	(GameName: 'PINOCCHIO'; ColorMap: @p20C),
	(GameName: 'POKEBOM'; ColorMap: @p30C),
	(GameName: 'POKEMON BLUE'; ColorMap: @p10B),
	(GameName: 'POKEMON GREEN'; ColorMap: @p11C),
	(GameName: 'POKEMON RED'; ColorMap: @p110),
	(GameName: 'POKEMON YELLOW'; ColorMap: @p007),
	(GameName: 'QIX'; ColorMap: @p407),
	(GameName: 'RADARMISSION'; ColorMap: @p100),
	(GameName: 'ROCKMAN WORLD'; ColorMap: @p50F),
	(GameName: 'ROCKMAN WORLD2'; ColorMap: @p50F),
	(GameName: 'ROCKMANWORLD3'; ColorMap: @p50F),
	(GameName: 'ROCKMANWORLD4'; ColorMap: @p50F),	// unofficial
	(GameName: 'ROCKMANWORLD5'; ColorMap: @p50F),	// unofficial
	(GameName: 'SEIKEN DENSETSU'; ColorMap: @p50E),
	(GameName: 'SOCCER'; ColorMap: @p502),
	(GameName: 'SOLARSTRIKER'; ColorMap: @p013),
	(GameName: 'SPACE INVADERS'; ColorMap: @p013),
	(GameName: 'STAR STACKER'; ColorMap: @p012),
	(GameName: 'STAR WARS'; ColorMap: @p512),
	(GameName: 'STAR WARS-NOA'; ColorMap: @p512),
	(GameName: 'STREET FIGHTER 2'; ColorMap: @p50F),
	(GameName: 'SUPER BOMBLISS  '; ColorMap: @p006),	// unofficial ('TETRIS BLAST' alt.)
	(GameName: 'SUPER MARIOLAND'; ColorMap: @p30A),
	(GameName: 'SUPER RC PRO-AM'; ColorMap: @p50F),
	(GameName: 'SUPERDONKEYKONG'; ColorMap: @p501),
	(GameName: 'SUPERMARIOLAND3'; ColorMap: @p500),
	(GameName: 'TENNIS'; ColorMap: @p502),
	(GameName: 'TETRIS'; ColorMap: @p007),
	(GameName: 'TETRIS ATTACK'; ColorMap: @p405),
	(GameName: 'TETRIS BLAST'; ColorMap: @p006),
	(GameName: 'TETRIS FLASH'; ColorMap: @p407),
	(GameName: 'TETRIS PLUS'; ColorMap: @p31C),
	(GameName: 'TETRIS2'; ColorMap: @p407),
	(GameName: 'THE CHESSMASTER'; ColorMap: @p30F),
	(GameName: 'TOPRANKINGTENNIS'; ColorMap: @p502),
	(GameName: 'TOPRANKTENNIS'; ColorMap: @p502),
	(GameName: 'TOY STORY'; ColorMap: @p30E),
	(GameName: 'VEGAS STAKES'; ColorMap: @p50E),
	(GameName: 'WARIO BLAST'; ColorMap: @p31C),
	(GameName: 'WARIOLAND2'; ColorMap: @p515),
	(GameName: 'WAVERACE'; ColorMap: @p50B),
	(GameName: 'WORLD CUP'; ColorMap: @p30E),
	(GameName: 'X'; ColorMap: @p016),
	(GameName: 'YAKUMAN'; ColorMap: @p012),
	(GameName: 'YOSHI''S COOKIE'; ColorMap: @p406),
	(GameName: 'YOSSY NO COOKIE'; ColorMap: @p406),
	(GameName: 'YOSSY NO PANEPON'; ColorMap: @p405),
	(GameName: 'YOSSY NO TAMAGO'; ColorMap: @p305),
	(GameName: 'ZELDA'; ColorMap: @p511));

sgbTitlePalettes: array[0..63] of TGambatteColorMapping = (
	(GameName: 'ALLEY WAY'; ColorMap: @sgb3F),
	(GameName: 'BALLOON KID'; ColorMap: @sgb1A),	// unofficial ('BALLôôN KID' alt.)
	(GameName: RawByteString('BALLôôN KID'); ColorMap: @sgb1A),
	(GameName: 'BASEBALL'; ColorMap: @sgb2G),
	(GameName: 'CASINO FUNPAK'; ColorMap: @sgb1A),	// unofficial (Nintendo Power Issue #67)
	(GameName: 'CONTRA ALIEN WAR'; ColorMap: @sgb1F),	// unofficial (Nintendo Power Issue #66)
	(GameName: 'CONTRA SPIRITS'; ColorMap: @sgb1F),	// unofficial ('CONTRA ALIEN WAR' alt.)
	(GameName: 'CUTTHROAT ISLAND'; ColorMap: @sgb3E),	// unofficial (Nintendo Power Issue #82)
	(GameName: 'DMG FOOTBALL'; ColorMap: @sgb4B),	// unofficial
	(GameName: 'DR.MARIO'; ColorMap: @sgb3B),
	(GameName: 'F1RACE'; ColorMap: @sgb4B),	// unofficial
	(GameName: 'FRANK THOMAS BB'; ColorMap: @sgb1B),	// unofficial (Nintendo Power Issue #80)
	(GameName: 'GBWARS'; ColorMap: @sgb3E),
	(GameName: 'GBWARST'; ColorMap: @sgb3E),	// unofficial ('GBWARS' alt.)
	(GameName: 'GOLF'; ColorMap: @sgb3H),
	(GameName: 'HOSHINOKA-BI'; ColorMap: @sgb2C),
	(GameName: 'ITCHY & SCRATCHY'; ColorMap: @sgb4B),	// unofficial (Nintendo Power Issue #63)
	(GameName: 'JEOPARDY'; ColorMap: @sgb2F),	// unofficial
	(GameName: 'JEOPARDY SPORTS'; ColorMap: @sgb2F),	// unofficial (Nintendo Power Issue #62)
	(GameName: 'JUNGLE BOOK'; ColorMap: @sgb4B),	// unofficial (Nintendo Power Issue #62)
	(GameName: 'KAERUNOTAMENI'; ColorMap: @sgb2A),
	(GameName: 'KID ICARUS'; ColorMap: @sgb2F),
	(GameName: 'KIRBY BLOCKBALL'; ColorMap: @sgb4D),	// unofficial (Nintendo Power Issue #83)
	(GameName: 'KIRBY DREAM LAND'; ColorMap: @sgb2C),
	(GameName: 'KIRBY''S PINBALL'; ColorMap: @sgb1C),
	(GameName: 'MARIO & YOSHI'; ColorMap: @sgb2D),
	(GameName: 'MARIOLAND2'; ColorMap: @sgb3D),
	(GameName: 'METROID2'; ColorMap: @sgb4G),
	(GameName: 'MORTAL KOMBAT'; ColorMap: @sgb4D),	// unofficial
	(GameName: 'MORTAL KOMBAT 3'; ColorMap: @sgb1B),	// unofficial (Nintendo Power Issue #79)
	(GameName: 'MORTAL KOMBAT II'; ColorMap: @sgb4D),	// unofficial (Nintendo Power Issue #65)
	(GameName: 'MORTALKOMBAT DUO'; ColorMap: @sgb4D),	// unofficial
	(GameName: 'MORTALKOMBATI&II'; ColorMap: @sgb4D),	// unofficial
	(GameName: 'NBA JAM'; ColorMap: @sgb2F),	// unofficial (Nintendo Power Issue #68)
	(GameName: 'NBA JAM TE'; ColorMap: @sgb2F),	// unofficial (Nintendo Power Issue #68)
	(GameName: 'PLAT JEOPARDY!'; ColorMap: @sgb2F),	// unofficial
	(GameName: 'POCAHONTAS'; ColorMap: @sgb4D),	// unofficial (Nintendo Power Issue #83)
	(GameName: 'PROBOTECTOR 2'; ColorMap: @sgb1F),	// unofficial ('CONTRA ALIEN WAR' alt.)
	(GameName: 'QIX'; ColorMap: @sgb4A),
	(GameName: 'RADARMISSION'; ColorMap: @sgb4B),	// unofficial
	(GameName: 'RVT             '; ColorMap: @sgb4B),	// unofficial (Nintendo Power Issue #63)
	(GameName: 'SOLARSTRIKER'; ColorMap: @sgb1G),
	(GameName: 'SPACE INVADERS'; ColorMap: @sgb4D),	// unofficial (Nintendo Power Issue #62)
	(GameName: 'SUPER MARIOLAND'; ColorMap: @sgb1F),
	(GameName: 'SUPERMARIOLAND3'; ColorMap: @sgb1B),
	(GameName: 'TARZAN'; ColorMap: @sgb2A),	// unofficial (Nintendo Power Issue #62)
	(GameName: 'TAZ-MANIA'; ColorMap: @sgb1A),	// unofficial (Nintendo Power Issue #64)
	(GameName: 'TEEN JEOPARDY!'; ColorMap: @sgb2F),	// unofficial
	(GameName: 'TENNIS'; ColorMap: @sgb3G),
	(GameName: 'TETRIS'; ColorMap: @sgb3A),
	(GameName: 'TETRIS FLASH'; ColorMap: @sgb2B),	// unofficial ('TETRIS2' alt.)
	(GameName: 'TETRIS2'; ColorMap: @sgb2B),	// unofficial
	(GameName: 'THE GETAWAY     '; ColorMap: @sgb1B),	// unofficial (Nintendo Power Issue #80)
	(GameName: 'TOPRANKINGTENNIS'; ColorMap: @sgb4B),	// unofficial
	(GameName: 'TOPRANKTENNIS'; ColorMap: @sgb4B),	// unofficial
	(GameName: 'WAVERACE'; ColorMap: @sgb4C),	// unofficial
	(GameName: 'WORLD CUP'; ColorMap: @sgb4H),	// unofficial
	(GameName: 'X'; ColorMap: @sgb4D),
	(GameName: 'YAKUMAN'; ColorMap: @sgb3C),
	(GameName: 'YOGIS GOLDRUSH'; ColorMap: @sgb3B),	// unofficial (Nintendo Power Issue #65)
	(GameName: 'YOSHI''S COOKIE'; ColorMap: @sgb1D),
	(GameName: 'YOSSY NO COOKIE'; ColorMap: @sgb1D),
	(GameName: 'YOSSY NO TAMAGO'; ColorMap: @sgb2D),
	(GameName: 'ZELDA'; ColorMap: @sgb1E));

const
  gambatte_gb_internal_palette: array[0..50] of PGambatteColorMap = (
    @gbdmg, @gbpoc, { <-> } @gblit, @p518, @p012, @p50D, @p319, @p31C, @p016, @p005, @p013, @p007, @p017, @p510, @p51A,
    @sgb1A, @sgb1B, @sgb1C, @sgb1D, @sgb1E, @sgb1F, @sgb1G, @sgb1H, @sgb2A, @sgb2B, @sgb2C, @sgb2D, @sgb2E, @sgb2F, @sgb2G, @sgb2H, @sgb3A, @sgb3B, @sgb3C, @sgb3D, @sgb3E, @sgb3F, @sgb3G, @sgb3H, @sgb4A, @sgb4B, @sgb4C, @sgb4D, @sgb4E, @sgb4F, @sgb4G, @sgb4H,
    @pExt1, @pExt2, @pExt3, @pExt4);

  gambatte_gb_palette_twb64_1: array[0..99] of PGambatteColorMap = (
    @twb64_001_aqours_blue, @twb64_002_anime_expo_ver, @twb64_003_spongebob_yellow, @twb64_004_patrick_star_pink, @twb64_005_neon_red, @twb64_006_neon_blue, @twb64_007_neon_yellow, @twb64_008_neon_green, @twb64_009_neon_pink, @twb64_010_mario_red,
    @twb64_011_nick_orange, @twb64_012_virtual_vision, @twb64_013_golden_wild, @twb64_014_dmg_099, @twb64_015_classic_blurple, @twb64_016_765_production_ver, @twb64_017_superball_ivory, @twb64_018_crunchyroll_orange, @twb64_019_muse_pink, @twb64_020_school_idol_blue,
    @twb64_021_gamate_ver, @twb64_022_greenscale_ver, @twb64_023_odyssey_gold, @twb64_024_super_saiyan_god, @twb64_025_super_saiyan_blue, @twb64_026_animax_blue, @twb64_027_bmo_ver, @twb64_028_game_com_ver, @twb64_029_sanrio_pink, @twb64_030_timmy_turner_pink,
    @twb64_031_fairly_oddpalette, @twb64_032_danny_phantom_silver, @twb64_033_links_awakening_dx_ver, @twb64_034_travel_wood, @twb64_035_pokemon_ver, @twb64_036_game_grump_orange, @twb64_037_scooby_doo_mystery_ver, @twb64_038_pokemon_mini_ver, @twb64_039_supervision_ver, @twb64_040_dmg_ver,
    @twb64_041_pocket_ver, @twb64_042_light_ver, @twb64_043_all_might_hero_palette, @twb64_044_ua_high_school_uniform, @twb64_045_pikachu_yellow, @twb64_046_eevee_brown, @twb64_047_microvision_ver, @twb64_048_ti83_ver, @twb64_049_aegis_cherry, @twb64_050_labo_fawn,
    @twb64_051_million_live_gold, @twb64_052_squidward_sea_foam_green, @twb64_053_vmu_ver, @twb64_054_game_master_ver, @twb64_055_android_green, @twb64_056_amazon_vision, @twb64_057_google_red, @twb64_058_google_blue, @twb64_059_google_yellow, @twb64_060_google_green,
    @twb64_061_wonderswan_ver, @twb64_062_neo_geo_pocket_ver, @twb64_063_dew_green, @twb64_064_coca_cola_vision, @twb64_065_gameking_ver, @twb64_066_do_the_dew_ver, @twb64_067_digivice_ver, @twb64_068_bikini_bottom_ver, @twb64_069_blossom_pink, @twb64_070_bubbles_blue,
    @twb64_071_buttercup_green, @twb64_072_nascar_ver, @twb64_073_lemon_lime_green, @twb64_074_mega_man_v_ver, @twb64_075_tamagotchi_ver, @twb64_076_phantom_red, @twb64_077_halloween_ver, @twb64_078_christmas_ver, @twb64_079_cardcaptor_pink, @twb64_080_pretty_guardian_gold,
    @twb64_081_camoflauge_ver, @twb64_082_legendary_super_saiyan, @twb64_083_super_saiyan_rose, @twb64_084_super_saiyan, @twb64_085_perfected_ultra_instinct, @twb64_086_saint_snow_red, @twb64_087_yellow_banana, @twb64_088_green_banana, @twb64_089_super_saiyan_3, @twb64_090_super_saiyan_blue_evolved,
    @twb64_091_pocket_tales_ver, @twb64_092_investigation_yellow, @twb64_093_sees_blue, @twb64_094_ultra_instinct_sign, @twb64_095_hokage_orange, @twb64_096_straw_hat_red, @twb64_097_sword_art_cyan, @twb64_098_deku_alpha_emerald, @twb64_099_blue_stripes_ver, @twb64_100_precure_marble_raspberry);

  gambatte_gb_palette_twb64_2: array[0..99] of PGambatteColorMap = (
    @twb64_101_765pro_pink, @twb64_102_cinderella_blue, @twb64_103_million_yellow, @twb64_104_sidem_green, @twb64_105_shiny_sky_blue, @twb64_106_angry_volcano_ver, @twb64_107_nba_vision, @twb64_108_nfl_vision, @twb64_109_mlb_vision, @twb64_110_anime_digivice_ver,
    @twb64_111_aquatic_iro, @twb64_112_tea_midori, @twb64_113_sakura_pink, @twb64_114_wisteria_murasaki, @twb64_115_oni_aka, @twb64_116_golden_kiiro, @twb64_117_silver_shiro, @twb64_118_fruity_orange, @twb64_119_akb48_pink, @twb64_120_miku_blue,
    @twb64_121_tri_digivice_ver, @twb64_122_survey_corps_uniform, @twb64_123_island_green, @twb64_124_nogizaka46_purple, @twb64_125_ninja_turtle_green, @twb64_126_slime_blue, @twb64_127_lime_midori, @twb64_128_ghostly_aoi, @twb64_129_retro_bogeda, @twb64_130_royal_blue,
    @twb64_131_neon_purple, @twb64_132_neon_orange, @twb64_133_moonlight_vision, @twb64_134_rising_sun_red, @twb64_135_burger_king_color_combo, @twb64_136_grand_zeno_coat, @twb64_137_pac_man_yellow, @twb64_138_irish_green, @twb64_139_goku_gi, @twb64_140_dragon_ball_orange,
    @twb64_141_christmas_gold, @twb64_142_pepsi_vision, @twb64_143_bubblun_green, @twb64_144_bobblun_blue, @twb64_145_baja_blast_storm, @twb64_146_olympic_gold, @twb64_147_lisani_orange, @twb64_148_liella_purple, @twb64_149_olympic_silver, @twb64_150_olympic_bronze,
    @twb64_151_ana_flight_blue, @twb64_152_nijigasaki_orange, @twb64_153_holoblue, @twb64_154_wwe_white_and_red, @twb64_155_yoshi_egg_green, @twb64_156_pokedex_red, @twb64_157_familymart_vision, @twb64_158_xbox_green, @twb64_159_sonic_mega_blue, @twb64_160_sprite_green,
    @twb64_161_scarlett_green, @twb64_162_glitchy_blue, @twb64_163_classic_lcd, @twb64_164_3ds_virtual_console_ver, @twb64_165_pocketstation_ver, @twb64_166_timeless_gold_and_red, @twb64_167_smurfy_blue, @twb64_168_swampy_ogre_green, @twb64_169_sailor_spinach_green, @twb64_170_shenron_green,
    @twb64_171_berserk_blood, @twb64_172_super_star_pink, @twb64_173_gamebuino_classic_ver, @twb64_174_barbie_pink, @twb64_175_yoasobi_amaranth, @twb64_176_nokia_3310_ver, @twb64_177_clover_green, @twb64_178_goku_gt_gi, @twb64_179_famicom_disk_yellow, @twb64_180_team_rocket_uniform,
    @twb64_181_seiko_timely_vision, @twb64_182_pastel109, @twb64_183_doraemon_tricolor, @twb64_184_fury_blue, @twb64_185_good_smile_vision, @twb64_186_puyo_puyo_green, @twb64_187_circle_k_color_combo, @twb64_188_pizza_hut_red, @twb64_189_emerald_green, @twb64_190_grand_ivory,
    @twb64_191_demons_gold, @twb64_192_sega_tokyo_blue, @twb64_193_champions_tunic, @twb64_194_dk_barrel_brown, @twb64_195_eva_01, @twb64_196_wild_west_vision, @twb64_197_optimus_prime_palette, @twb64_198_niconico_sea_green, @twb64_199_duracell_copper, @twb64_200_tokyo_skytree_cloudy_blue);

  gambatte_gb_palette_twb64_3: array[0..99] of PGambatteColorMap = (
    @twb64_201_dmg_gold, @twb64_202_lcd_clock_green, @twb64_203_famicom_frenzy, @twb64_204_dk_arcade_blue, @twb64_205_advanced_indigo, @twb64_206_ultra_black, @twb64_207_chaos_emerald_green, @twb64_208_blue_bomber_vision, @twb64_209_krispy_kreme_vision, @twb64_210_steam_gray,
    @twb64_211_dream_land_gb_ver, @twb64_212_pokemon_pinball_ver, @twb64_213_poketch_ver, @twb64_214_collection_of_saga_ver, @twb64_215_rocky_valley_holiday, @twb64_216_giga_kiwi_dmg, @twb64_217_dmg_pea_green, @twb64_218_timing_hero_ver, @twb64_219_invincible_yellow_and_blue, @twb64_220_grinchy_green,
    @twb64_221_animate_vision, @twb64_222_school_idol_mix, @twb64_223_green_awakening, @twb64_224_goomba_brown, @twb64_225_warioware_microblue, @twb64_226_konosuba_sherbet, @twb64_227_spooky_purple, @twb64_228_treasure_gold, @twb64_229_cherry_blossom_pink, @twb64_230_golden_trophy,
    @twb64_231_glacial_winter_blue, @twb64_232_leprechaun_green, @twb64_233_saitama_super_blue, @twb64_234_saitama_super_green, @twb64_235_duolingo_green, @twb64_236_super_mushroom_vision, @twb64_237_ancient_husuian_brown, @twb64_238_sky_pop_ivory, @twb64_239_lawson_blue, @twb64_240_anime_expo_red,
    @twb64_241_brilliant_diamond_blue, @twb64_242_shining_pearl_pink, @twb64_243_funimation_melon, @twb64_244_teyvat_brown, @twb64_245_chozo_blue, @twb64_246_spotify_green, @twb64_247_dr_pepper_red, @twb64_248_nhk_silver_gray, @twb64_249_dunkin_vision, @twb64_250_deku_gamma_palette,
    @twb64_251_universal_studios_blue, @twb64_252_hogwarts_goldius, @twb64_253_kentucky_fried_red, @twb64_254_cheeto_orange, @twb64_255_namco_idol_pink, @twb64_256_dominos_pizza_vision, @twb64_257_pac_man_vision, @twb64_258_bills_pc_screen, @twb64_259_ebott_prolouge, @twb64_260_fools_gold_and_silver,
    @twb64_261_uta_vision, @twb64_262_metallic_paldea_brass, @twb64_263_classy_christmas, @twb64_264_winter_christmas, @twb64_265_idol_world_tricolor, @twb64_266_inkling_tricolor, @twb64_267_7_eleven_color_combo, @twb64_268_pac_palette, @twb64_269_vulnerable_blue, @twb64_270_nightvision_green,
    @twb64_271_bandai_namco_tricolor, @ twb64_272_gold_silver_and_bronze, @twb64_273_deku_vigilante_palette, @twb64_274_super_famicom_supreme, @twb64_275_absorbent_and_yellow, @twb64_276_765pro_tricolor, @twb64_277_gamecube_glimmer, @twb64_278_1st_vision_pastel, @twb64_279_perfect_majin_emperor, @twb64_280_j_pop_idol_sherbet,
    @twb64_281_ryuuguu_sunset, @twb64_282_tropical_starfall, @twb64_283_colorful_horizons, @twb64_284_blackpink_blink_pink, @twb64_285_dmg_switch, @twb64_286_pocket_switch, @twb64_287_sunny_passion_paradise, @twb64_288_saiyan_beast_silver, @twb64_289_radiant_smile_ramp, @twb64_290_a_rise_blue,
    @twb64_291_tropical_twice_apricot, @twb64_292_odyssey_boy, @twb64_293_frog_coin_green, @twb64_294_garfield_vision, @twb64_295_bedrock_caveman_vision, @twb64_296_bangtan_army_purple, @twb64_297_le_sserafim_fearless_blue, @twb64_298_baja_blast_beach, @twb64_299_3ds_virtual_console_green, @twb64_300_wonder_purple);

  gambatte_gb_palette_pixelshift_1: array[0..44] of PGambatteColorMap = (
    @pixelshift_01_arctic_green, @pixelshift_02_arduboy, @pixelshift_03_bgb_0_3_emulator, @pixelshift_04_camouflage, @pixelshift_05_chocolate_bar, @pixelshift_06_cmyk, @pixelshift_07_cotton_candy, @pixelshift_08_easy_greens, @pixelshift_09_gamate, @pixelshift_10_game_boy_light,
    @pixelshift_11_game_boy_pocket, @pixelshift_12_game_boy_pocket_alt, @pixelshift_13_game_pocket_computer, @pixelshift_14_game_and_watch_ball, @pixelshift_15_gb_backlight_blue, @pixelshift_16_gb_backlight_faded, @pixelshift_17_gb_backlight_orange, @pixelshift_18_gb_backlight_white_, @pixelshift_19_gb_backlight_yellow_dark, @pixelshift_20_gb_bootleg,
    @pixelshift_21_gb_hunter, @pixelshift_22_gb_kiosk, @pixelshift_23_gb_kiosk_2, @pixelshift_24_gb_new, @pixelshift_25_gb_nuked, @pixelshift_26_gb_old, @pixelshift_27_gbp_bivert, @pixelshift_28_gb_washed_yellow_backlight, @pixelshift_29_ghost, @pixelshift_30_glow_in_the_dark,
    @pixelshift_31_gold_bar, @pixelshift_32_grapefruit, @pixelshift_33_gray_green_mix, @pixelshift_34_missingno, @pixelshift_35_ms_dos, @pixelshift_36_newspaper, @pixelshift_37_pip_boy, @pixelshift_38_pocket_girl, @pixelshift_39_silhouette, @pixelshift_40_sunburst,
    @pixelshift_41_technicolor, @pixelshift_42_tron, @pixelshift_43_vaporwave, @pixelshift_44_virtual_boy, @pixelshift_45_wish);

implementation

end.
