unit PaletteColors;

interface

// Gambatte is the only emulator that cares about the three different palettes of its platform, whereas the other emulators do not

type
  T2BitColorMap = packed array[1..4] of Integer; // this is not TColor but R and B swapped!
  P2BitColorMap = ^T2BitColorMap; // Delphi does not allow const records in arrays, const arrays in records or const arrays in arrays, but it does allow const arrays of pointers no matter what it points to

  T1BitColorMap = packed array[1..2] of Integer;
  P1BitColorMap = ^T1BitColorMap;

  TSlow1BitColorMap = packed array[1..3] of Integer;
  PSlow1BitColorMap = ^TSlow1BitColorMap;

const

// Gearboy
// taken from source: https://github.com/drhelius/Gearboy/blob/97599691c7277835c66392171c7e249dc8364acc/platforms/libretro/libretro.cpp#L85

gearboy_Original: T2BitColorMap = (
	$879603, $4d6b03, $2b5503, $144403
);

gearboy_Sharp: T2BitColorMap = (
	$F5FAEF, $86C270, $2F6957, $0B1920
);

gearboy_BW: T2BitColorMap = (
	$FFFFFF, $AAAAAA, $555555, $000000
);

gearboy_Autumn: T2BitColorMap = (
	$F8E8C8, $D89048, $A83420, $301850
);

gearboy_Soft: T2BitColorMap = (
	$E0E0AA, $B0B87C, $72825B, $393417
);

gearboy_Slime: T2BitColorMap = (
	$D4EBA5, $62B87C, $27765D, $1D3939
);

gearboy_palette: array[0..5] of P2BitColorMap = (
  @gearboy_Original, @gearboy_Sharp, @gearboy_BW, @gearboy_Autumn, @gearboy_Soft, @gearboy_Slime
);

// Potator
// taken from source: https://github.com/libretro/potator/blob/master/common/gpu.c

sv_color_scheme_default: T2BitColorMap = (
  $fcfcfc, $a8a8a8, $545454, $000000
);

sv_color_scheme_amber: T2BitColorMap = (
  $fc9a00, $a86600, $543300, $000000
);

sv_color_scheme_green: T2BitColorMap = (
  $32e332, $229722, $114c11, $000000
);

sv_color_scheme_blue: T2BitColorMap = (
  $009afc, $0066a8, $003354, $000000
);

sv_color_scheme_bgb: T2BitColorMap = (
  $e0f8d0, $88c070, $346856, $081820
);

sv_color_scheme_wataroo: T2BitColorMap = (
  $7bc77b, $52a68c, $2e6260, $0d322e
);

sv_color_scheme_gb_dmg: T2BitColorMap = (
  $578200, $317400, $005121, $00420c
);

sv_color_scheme_gb_pocket: T2BitColorMap = (
  $a7b19a, $86927c, $535f49, $2a3325
);

sv_color_scheme_gb_light: T2BitColorMap = (
  $01cbdf, $01b6d5, $269bad, $00778d
);

sv_color_scheme_blossom_pink: T2BitColorMap = (
  $f09898, $a86a6a, $603c3c, $180f0f
);

sv_color_scheme_bubbles_blue: T2BitColorMap = (
  $88d0f0, $5f91a8, $365360, $0d1418
);

sv_color_scheme_buttercup_green: T2BitColorMap = (
  $b8e088, $809c5f, $495936, $12160d
);

sv_color_scheme_digivice: T2BitColorMap = (
  $8c8c73, $646453, $38382e, $000000
);

sv_color_scheme_game_com: T2BitColorMap = (
  $a7bf6b, $6f8f4f, $0f4f2f, $000000
);

sv_color_scheme_gameking: T2BitColorMap = (
  $8cce94, $6b9c63, $506541, $184221
);

sv_color_scheme_game_master: T2BitColorMap = (
  $829fa6, $5a787e, $384a50, $2d2d2b
);

sv_color_scheme_golden_wild: T2BitColorMap = (
  $b99f65, $816f46, $4a3f28, $120f0a
);

sv_color_scheme_greenscale: T2BitColorMap = (
  $9cbe0c, $6e870a, $2c6234, $0c360c
);

sv_color_scheme_hokage_orange: T2BitColorMap = (
  $ea8352, $a35b39, $5d3420, $170d08
);

sv_color_scheme_labo_fawn: T2BitColorMap = (
  $d7aa73, $967650, $56442e, $15110b
);

sv_color_scheme_legendary_super_saiyan: T2BitColorMap = (
  $a5db5a, $73993e, $425724, $101509
);

sv_color_scheme_microvision: T2BitColorMap = (
  $a0a0a0, $787878, $505050, $303030
);

sv_color_scheme_million_live_gold: T2BitColorMap = (
  $cdb261, $8f7c43, $524726, $141109
);

sv_color_scheme_odyssey_gold: T2BitColorMap = (
  $c2a000, $877000, $4d4000, $131000
);

sv_color_scheme_shiny_sky_blue: T2BitColorMap = (
  $8cb6df, $627f9c, $384859, $0e1216
);

sv_color_scheme_slime_blue: T2BitColorMap = (
  $2f8ccc, $20628e, $123851, $040e14
);

sv_color_scheme_ti_83: T2BitColorMap = (
  $9ca684, $727c5a, $464a35, $181810
);

sv_color_scheme_travel_wood: T2BitColorMap = (
  $f8d8b0, $a08058, $705030, $482810
);

sv_color_scheme_virtual_boy: T2BitColorMap = (
  $e30000, $950000, $560000, $000000
);

potator_palette: array[0..28] of P2BitColorMap = (
  @sv_color_scheme_default, @sv_color_scheme_amber, @sv_color_scheme_green, @sv_color_scheme_blue, @sv_color_scheme_bgb, @sv_color_scheme_wataroo,
  @sv_color_scheme_gb_dmg, @sv_color_scheme_gb_pocket, @sv_color_scheme_gb_light, @sv_color_scheme_blossom_pink, @sv_color_scheme_bubbles_blue, @sv_color_scheme_buttercup_green,
  @sv_color_scheme_digivice, @sv_color_scheme_game_com, @sv_color_scheme_gameking, @sv_color_scheme_game_master,
  @sv_color_scheme_golden_wild, @sv_color_scheme_greenscale, @sv_color_scheme_hokage_orange, @sv_color_scheme_labo_fawn, @sv_color_scheme_legendary_super_saiyan,
  @sv_color_scheme_microvision, @sv_color_scheme_million_live_gold, @sv_color_scheme_odyssey_gold, @sv_color_scheme_shiny_sky_blue, @sv_color_scheme_slime_blue,
  @sv_color_scheme_ti_83, @sv_color_scheme_travel_wood, @sv_color_scheme_virtual_boy
);



// My emulator doesn't need a frickin' excellent name (Mednafen) Cygne
// taken from source https://github.com/libretro/beetle-wswan-libretro/blob/master/libretro.c#L213
// however, it's swapped and the intermediate values are calculated by the emulator at runtime, and palette presets do not exist in Mednafen's release; and the input colors are swapped

wswan_default: T1BitColorMap = (
  $000000, $FFFFFF
);

wswan_wonderswan: T1BitColorMap = (
  $3E3D20, $9B9D66
);

wswan_wondeswan_color: T1BitColorMap = (
  $1B201E, $D7D49D
);

wswan_swancrystal: T1BitColorMap = (
  $151108, $FFFCCA
);

wswan_gb_dmg: T1BitColorMap = (
  $00420C, $578200
);

wswan_gb_pocket: T1BitColorMap = (
  $2A3325, $A7B19A
);

wswan_gb_light: T1BitColorMap = (
  $00778D, $01CBDF
);

wswan_blossom_pink: T1BitColorMap = (
  $180F0F, $F09898
);

wswan_bubbles_blue: T1BitColorMap = (
  $0D1418, $88D0F0
);

wswan_buttercup_green: T1BitColorMap = (
  $12160D, $B8E088
);

wswan_digivice: T1BitColorMap = (
  $000000, $8C8C73
);

wswan_game_com: T1BitColorMap = (
  $000000, $A7BF6B
);

wswan_gameking: T1BitColorMap = (
  $184221, $8CCE94
);

wswan_game_master: T1BitColorMap = (
  $2D2D2B, $829FA6
);

wswan_golden_wild: T1BitColorMap = (
  $120F0A, $B99F65
);

wswan_greenscale: T1BitColorMap = (
  $0C360C, $9CBE0C
);

wswan_hokage_orange: T1BitColorMap = (
  $170D08, $EA8352
);

wswan_labo_fawn: T1BitColorMap = (
  $15110B, $D7AA73
);

wswan_legendary_super_saiyan: T1BitColorMap = (
  $101509, $A5DB5A
);

wswan_microvision: T1BitColorMap = (
  $303030, $A0A0A0
);

wswan_million_live_gold: T1BitColorMap = (
  $141109, $CDB261
);

wswan_odyssey_gold: T1BitColorMap = (
  $131000, $C2A000
);

wswan_shiny_sky_blue: T1BitColorMap = (
  $0E1216, $8CB6DF
);

wswan_slime_blue: T1BitColorMap = (
  $040E14, $2F8CCC
);

wswan_ti_83: T1BitColorMap = (
  $181810, $9CA684
);

wswan_travel_wood: T1BitColorMap = (
  $482810, $F8D8B0
);

wswan_virtual_boy: T1BitColorMap = (
  $000000, $E30000
);

wswan_mono_palette: array[0..26] of P1BitColorMap = (
  @wswan_default, @wswan_wonderswan, @wswan_wondeswan_color, @wswan_swancrystal, @wswan_gb_dmg, @wswan_gb_pocket, @wswan_gb_light, @wswan_blossom_pink, @wswan_bubbles_blue, @wswan_buttercup_green, @wswan_digivice, @wswan_game_com, @wswan_gameking, @wswan_game_master, @wswan_golden_wild, @wswan_greenscale, @wswan_hokage_orange, @wswan_labo_fawn, @wswan_legendary_super_saiyan, @wswan_microvision, @wswan_million_live_gold, @wswan_odyssey_gold, @wswan_shiny_sky_blue, @wswan_slime_blue, @wswan_ti_83, @wswan_travel_wood, @wswan_virtual_boy
);



// PokeMini
// taken from screenshots of the Windows version, which are identical to the GB300 except for RGB565 rounding, but different from source
// in some cases of fading, the colors from source seem to be used

pokem_default: TSlow1BitColorMap = (
  $a0b4a0, $405340, $122412
);

pokem_old: TSlow1BitColorMap = (
  $85a288, $5d6e58, $495542
);

pokem_monochrome: TSlow1BitColorMap = (
  $e1e1e1, $494949, $000000
);

pokem_green: TSlow1BitColorMap = (
  $00e100, $004900, $000000
);

pokem_green_vector: TSlow1BitColorMap = (
  $001c00, $00b400, $00fd00
);

pokem_red: TSlow1BitColorMap = (
  $e10000, $490000, $000000
);

pokem_red_vector: TSlow1BitColorMap = (
  $1c0000, $b40000, $fd0000
);

pokem_blue_lcd: TSlow1BitColorMap = (
  $b0b0fe, $6464fe, $4040fe
);

pokem_ledbacklight: TSlow1BitColorMap = (
  $bfbfb9, $5a5a4c, $2a2a17
);

pokem_girl_power: TSlow1BitColorMap = (
  $f373d4, $ba359b, $9f187f
);

pokem_blue: TSlow1BitColorMap = (
  $00001c, $0000b4, $0000fd
);

pokem_blue_vector: TSlow1BitColorMap = (
  $00001c, $0000b4, $0000fd
);

pokem_sepia: TSlow1BitColorMap = (
  $c7ad7d, $8c6536, $6f4214
);

pokem_monochrome_vector: TSlow1BitColorMap = (
  $1c1c1c, $b4b4b4, $fdfdfd
);

pokem_palette: array[0..13] of PSlow1BitColorMap = (
  @pokem_default, @pokem_old, @pokem_monochrome, @pokem_green, @pokem_green_vector, @pokem_red, @pokem_red_vector, @pokem_blue_lcd, @pokem_ledbacklight, @pokem_girl_power, @pokem_blue, @pokem_blue_vector, @pokem_sepia, @pokem_monochrome_vector
);


implementation

end.
