This file contains some technical background information on the Neo Geo ROM Faker that is part of GB300+SF2000 Tool.

Terms:
- **Clone:** An umbrella term used to refer to a ROM's various hacks, bootlegs, decryptions.
- **Parent:** Not a clone.
- **Set:** ZIP file containing the files belonging to a game. The name and the ZIP file's content is specified by the emulator (in its source code), but may vary between the different forks of MAME, namely MAME itself, FBNeo and HBName. Unlike most other emulators that aim to support "any" ROMs for a given platform, MAME and its forks are programmed to load only very certain sets and nothing else. For the SF2000 and GB300 v2, [the number of known sets is 1431](https://vonmillhausen.github.io/sf2000/arcade/DataFrog_SF2000_FBA.html).
- **Non-Merged:** A set (usually of a clone), containing all files needed to play the set's game. Working with non-merged sets increases file size of the sets, but is easier to handle because you know that you have what you need.
- **Overdump:** A ROM file which is bigger than the actual ROM and therefore doesn't use its entire file size.


## What Does This Feature Do?

It arranges the memory (ROM) of an unspported Neo Geo set's files so this memory can be loaded if saved as a supported set's file layout.

One could try a similar procedure with other drivers, most notably CPS1 (FBA's CPS2 support is basically complete and there is no homebrew scene).


## Finding a Host Set to Hijack

First of all, one has to understand how to interpret errors. If there is no loading indicator other than "Loading...", the ZIP file content is usually incomplete. For this, FBA checks the ZIP headers only. It sometimes checks for names, and somtimes for CRC and size. I cannot really say which of the two. If a ZIP header contains a manipulated CRC or size (that doesn't actually match the file's data), this single file in question is not loaded, but FBA will still continue.

What I need is a set that ticks as many boxes as possible:
- Known by SF2000 and either working or `loadcorrupt`, see `madcock`'s list linked above.
- Big ROM, so there is enough space to fit the target ROM in. Each of the 5 areas (Character, Music, Program, Strings, Voice) has to be among the largest.
- If I have to fake CRC, the last 4 bytes of every file will change. If a ROM area is not split into multiple files, this is usually safe because they don't use every single byte. Splitting normally only exists for Character, Program and Voice. I only consider splitting the program ROM actually "risky", so that should be one large file. Note that Character ROM almost exclusively exists in interleaved pairs (progressive and quad interleaved exist as well), so if you modify two CROMs' last four bytes, you end up modifying only the last eight bytes in memory, not 4 bytes each in the middle and in the end.
- No hooks (overrides), especially no Init hook. Big ROMs are usually more recent (after 1998), but those are encrypted and therefore have an Init hook for at least this reason. Addionally, they often have no SROM. Strangely, FBA often loads unencrypted clones with their (encrypted) parent ROM's Init hook, so the hook must be able to determine whether or not to decrypt. In FBN however, these unencrypted clones do not have any hooks anymore. This is also how I implemented them (`fd` hacks) in my own version of M2K.

Note: I think that _all_ MROMs and SROMs over 128 KiB are overdumps (e.g. empty, repeats or "random" data).

Candidate host sets:
- `svcpcb`: It has only one pair of giant Character ROMs, so the last four bytes of each can be manipulated for the target CRC without any risk. It has by far the largest P-ROM around, too. However, the V-ROM is partioned into two files and Strings ROM is only 128 KiB and might be exceeded by a few ROMs. It was hard to find the decrypted M1 that is required but does not come with commonly-available `svcpcb` romsets theirselves. FBA source suggests that a file with the same CRC comes with e.g. `svcnd`, which is true. Still, it does not load. I'm blaming it on the size: According to my memory estimation formula, a peak 148352 KiB of RAM are required to load it.
- `ms5pcb`: Voice ROM is a single file, but Character are two pairs now and Program is two ROMs as well. Again, Strings ROM is only 128 KiB, but the set is too big anyway.
- `rotd`: This I believe is the largest fully-playable ROM. Main advantage is that it only has a single PROM of 8 MiB. However, it has no SROM and is encrypted.
- `rotdnd`: It only has voice encrypted, but is otherwise quite a good candidate.
- `kof98n` and `garoup`: These are the the largest sets with absolutely no hooks at all. However, it is split into four pairs of CROM, two PROMs and four VROMs. PROM is split into two parts, one of 1024 and one of 4096 KiB. It has 256 KiB MRAM and 16 MiB VRAM, which is more than `kof99` and its variants (especially unhooked `kof99p`) with 128 KiB and 14 MiB respectively. `s1945pn` as well as probably `kof99n` and `kof2000n` are similar to `kof99p` but have no SROM.
- `mslug5nd`: Single 6 MiB P-ROM, but only 128 KiB of S-ROM. However, it's a `loadhang` according to `madcock`'s list.
- `magdrop2`: ROM doesn't work anyway, no split ROMs, probably no CRC check? Good candidate to patch higher sizes into `bisrv.asd`. However, loading large files again uses more RAM for the file to be loaded.

When I tested with `kof98n` and `garoup`, it turned out that FBA sometimes applies some strange modifications to C-ROM if `kof98n` was my host set, causing massive glitches. Manipulations to C-ROM that made absolutely no sense sometimes "fixed" it. However, `garoup` always worked, so I chose `garoup` as my host set. As `garoup` itself does not work, it also qualified for bigger P-ROM BIOS patch. Downside: Almost all unencrypted sets (except for most `mslugx` clones) will not work without that BIOS patch.


### Maximum In-Memory Size of a Set

The maximum in-memory size of a set on stock FBA is around 97 to 98 MiB (for comparison, this number is around 63.1 MiB for `m2k` on multicore).

But what does "in-memory" mean and how is this calculated? First, we have to take a look at the loading order as displayed by the device:
1. C-ROM
2. `sfix.sfx` (128 KiB)
3. S-ROM
4. P-ROM
5. M-ROM
6. `vs-bios.rom` (128 KiB) [if it freezes at this step, first try restarting the device, especially if you just played a set that had issues]
7. V-ROM
8. `sm1.sm1` (128 KiB)
9. `000-lo.lo` (64 KiB)

To calculate the in-memory size of a set, do the following steps for _each_ of the steps above:
- Calculate the sum of memory required by the steps when all files in each step have been loaded, from the first step to the current one (inclusive).
- Add the largest single file in the current step only.
After calculating these nine values, take the biggest of them (which in 99% of all cases is the seventh value, V-ROM). This value must not exceed the said 98 MiB. The above calculation steps mean that an area can be bigger if it is split into more pieces. This is likely the only reason why almost all sets with 8 MiB V-ROM files do not have audio. The stock-supported set with the most files is probably `kf10thep`, splitting the C-ROM into 16 files of 4 MiB.

Note that the load order is different for `m2k`. The order can be defined for each set, but this isn't the case for `m2k`'s official release, which always loads C-ROM last. Because C is normally the biggest ROM _and_ has the biggest single file (normally up to 8 MiB), this is bad. It is the _only_ reason why `m2k` on multicore cannot load `lastblad` and `kof97` (as well as `mslug4fd` and `preisl2n` if it supported these, though `mslug4fd` also requires not loading the overdumped part of the C-ROM).


### Sets Exceeding Memory Limits

AFAIK, all three `*pcb` versions are overdumps. `kf2k3pcb` and `svcpcb` are the only official releases that – in their original size – wouldn't fit in the frog's memory no matter how you split their ROMs (`ms5pcb` however could fit if split more appropriately). `badapple` and `cphd` too are _massive_ over-"dumps" (they're homebrew, so they technically aren't dumps).

Only ten KoF-series hacks _actually_ exceed the maximum size of `garoup` and the device in general.

Sets that do not load:
- `kf2k1pkz`: 80 MiB C, 5 MiB P, 16 MiB V (base set is unsupported)
- `kf2k1ult`: 112 MiB C, 6 MiB P, 24 MiB V (base set is unsupported)
- `kof98ae`: 96 MiB C, 7 MiB P, 24 MiB V
- `kof98cp`: 96 MiB C, 9 MiB P, 24 MiB V
- `kof99ae`: 96 MiB C, 9 MiB P, 14 MiB V

Sets that load but (slightly) glitch:
- `kof98mix`: 80MiB C, 5 MiB P, 16 MiB V

Sets that I didn't see glitch at all during my tests, despite being too big:
- `kf2k2ps2`:	80 MiB C, 6.25 MiB P, 16 MiB V
- `kof98eck`: 80 MiB C, 5 MiB P, 16 MiB V
- `kof98ult`: 96 MiB C, 7 MiB P, 24 MiB V
- `kof2kotc`: 64 MiB C, 5 MiB P, 20 MiB V


## Compatibility Overview

Improvements for ROM that should have been supported by stock:
- `mslug5nd`: loadhang -> fully working
- `bangbedp`: noload -> fully working

There are a lot of ROMs that the emulator itself just cannot load (`madcock` calls this `loadcorrupt`). This usually applies to all clones of a set and already exists for the following parent sets known to the stock emulator:
- `diggerma`
- `karnovr`
- `kizuna`
- `kof2001` (`cthd2003` and its clones however do work)
- `lastbld2`
- `mslug4`
- `magdrop2`
- `rbff2`
- `sengoku3`
- `viewpoin`
- `vliner`
- `wjammers`

Because the issue comes from the sets' content (in other words: the game), being on the above list does not disqualify a game from becoming a host ROM. The size of this list significantly increases when you add games that stock not only doesn't know, but also don't work if faked by this project.


### Comparison to `m2k` on multicore

`m2k` on multicore is much slower than stock FBA. However, it can load some of the games above. Because MAME is much older than FBA, FBA's lack of support for the following games could be considered a regression (or fault by whoever made the Frog's firmware).

Official `m2k` can run (stock FBA was supposed to support all of them, but doesn't):
- `karnovr`
- `kizuna`
- `magdrop2`
- `viewpoin`
- `wjammers`
`lastbld2` is included in `m2k`'s official game list, but is too big.

My own fork of `m2k` can load the following games that stock FBA was supposed to support but doesn't:
- `diggerma`
- `mslug4` (only in form of `mslug4fd`)
- `sengoku3` (only in form of `sengk3fd`)

Games that stock FBA neither knows nor is able to run if forced to, but are supported by my own version of `m2k`:
- `b2b`
- `knightsch` (you can run this into BSoD on `m2k`, though)
- `santaball`
- `xeviousng`

A binary release of my version of `m2k` is not currently available for neither SF2000 nor GB300 v2. Feel free to [download](https://github.com/nummacway/libretro-mamenummacwaytausend) and compile yourself.
