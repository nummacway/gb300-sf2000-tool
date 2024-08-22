This is a tool for managing your [Sup+ GB300 (Game Box) console](https://nummacway.github.io/gb300/).

It is supposed to be the GB300's counterpart to what Tadpole is for the similar Data Frog SF2000, even though the interface is completely different. GB300 Tool does not work with the SF2000 and prevents you from even trying to do so. (There is [a hack of GB300's `bisrv.asd` for SF2000](https://vonmillhausen.github.io/sf2000/#gb300-firmware-ported) made with the intention of using GB300 Tool. There is also [a version with multicore](https://discord.com/channels/741895796315914271/1092831839955193987/1237247978520055828).)

**GB300 Tool does not yet work with "GB300 v2" (the one that has MAME).** The "GB300 v1" (which this tool is for) is the one where you navigate the menu using the shoulder buttons.


## Download

**[Download from GitHub](https://github.com/nummacway/gb300tool/releases/)**


## Requirements

Software:
- Just some halfway-recent Windows. It does run on Linux via Wine, but the _Live Previews_ feature makes heavy use of the undocumented Windows API feature `GetFontResourceInfoW` (loading a font in an arbitrary directory by just its file name) that is reportedly not supported by Wine.

Hardware:
- microSD (TF) reader (or SD reader with an adapter) that – unlike a phone – has a drive letter
- Screen resolution must not be lower than that of the [OLPC XO-1](https://en.wikipedia.org/wiki/OLPC_XO), the world's cheapest laptop ever made, released in 2007

**Because I was repeatedly asked: No, I will _not_ support laptops that are even worse than a 2007 50-dollar children's laptop.**

If you want to build it yourself, you need Embarcadero Delphi. It should compile with no to minimal changes starting from Delphi XE2. GB300 Tool makes heavy use of negative Zlib window sizes (aka headerless Deflate streams) which are not possible in earlier versions (maybe XE works as well, I don't know). There is a way newer free Community Edition that will do the job.


## Features

**General features:**

- Small
- Fast startup times
- Works quite smooth (depends on Windows GDI and TF card/reader performance)
- Clean interface with all icons handcrafted just for this software, according to the OpenMoji style guide
- Many explanations right inside the tool (more details on this page)
- Supports drag and drop and multi-select (actions in the ROM details still apply to displayed single file only)


**Features in detail:**

**ROMs**
- Add and remove ROMs in the seven "static" lists and user ROMs
- Manually reorder and alphabetically sort ROMs in the "static" lists
- Identify ROMs using No-Intro (includes No-Intro game ID, name and verification status; ignores NES header if one is present)
- Rename, duplicate, compress and decompress ROM files
- Import (replace) and export ROM files
- Apply IPS (International Patching System; RLE and truncate extensions supported) and BPS (beat Patching System) patches
- Import, export and add thumbnails (supports automatic scaling)
- Export save state images (screenshots) to file or clipboard
- Toggle favorites
- Full multicore support, including per-game configuration (and per-game Gambatte custom palettes, too!)
- Mass import thumbnail images from images with matching file names

**Favorites**
- Remove favorites
- Manually reorder or alphabetically sort favorites

**BIOS & Device**
- Patch bootloader
- Work around bootloader issues
- Enable GBA BIOS
- Fix BIOS CRC
- Change boot logo
- Patch BIOS after swapping in the SF2000's screen
- Change search result selection color
- Enable Famicom Disk System
- Enable VT02/VT03 support and patch VT03 LUT
- Fix broken MD thumbnails (45 of these exist on the GB300)
- Fix Glazed thumbnail
- Make all NES ROMs use FCEUmm for better compatibility
- Clear favorites, history and key map

**Multicore**
- Edit core configuration
- Pick your favorite core by extension
- View, pick and palettes of Gambatte, Gearboy, PokeMini, Potator and My emulator doesn't need a frickin' excellent name Cygne

**Keys**
- Edit first and second player keys independently
- Shows SMS and GG mapping for MD, as well as many multicore cores' for GBA
- Knows about all the bugs in the official key map editor, so you assign the actual mapping to the actual buttons (I'm talking about you, shoulder buttons!)
- Import and export key map backups
- Reset one console's or all key mappings to default

**UI Editor**
- Export and replace all images
- View slices of images that aren't used as a whole
- Preview images in 66 pixel-perfect simulated scenes
- Edit general UI settings in `Foldername.ini`

I hope that people will be sharing the themes they made, so we can have a theme gallery with downloads like the SF2000 has.


**Limitations**
- There was a plan to get you suggested GG2SMS hacks when you add GG games where those hacks exist and can be played without an external gamepad. Except for the absolute best hacks that use the entire screen, there is no need for this with multicore. You can find a list of hacks that work on the GB300 stock Picodrive [here](https://nummacway.github.io/gb300/#sega-game-gear).
- Files with bad thumbnails are not supported. Use the two fixes in the BIOS tab before doing anything else with the 45 glitched MD files and _Pokemon - Glazed Version (CN)_.
- There are no plans for sound-related features. Use [Kerokero](https://github.com/Dteyn/SF2000_BGM_Tool) instead.

There are no plans to add any new features to the tool because I cannot think of any that are missing. Databases inside the tool might get updated.

### Onboarding

This is the small box that is displayed on startup. Enter your drive letter here. You can also enter a local folder.

**Note:** You are welcome to eject the TF card from your computer while GB 300 Tool is running as long as you do not interact with the tool while the card is missing. However, do not swap between _different_ cards while GB300 Tool is running, as favorites use cached versions of the current static ROM lists.

When you hit _Start_, GB300 Tool makes sure that `Foldername.ini` exists and you made no unsupported modifications to it (ones that would break your console anyway). GB300 Tool will also create all required folders.


### ROMs

**Note:** GB300 Tool does not use obfuscation in files it writes. This applies to archives with and without thumbnails, as obfuscation is purely optional for both. (It will keep any existing obfuscation if you just change a thumbnail.)

There are the following buttons below the list:

- _Check All_ ("static" lists only) makes sure the list matches the folder content. It checks all files that exist and unchecks all files that don't.
- _Uncheck All_ ("static" lists only) removes all checkmarks.
- _Alphasort_ ("static" lists only) sorts the list alphabetically. This uses your computer locale and is therefore different than the GB300's sorting, which is binary-based.
- _Add..._ adds ROMs. If multicore is enabled, you are asked to choose the core (or stock).
- _Delete_ deletes the selected ROMs. If the file multicore, it also deletes the actual ROM. It does not delete save data.

All actions instantly save the list and update favorites.

If you select a file, a panel appears to the right of the file list. It's header contains the ROM name (the internal name of the actual ROM, which also determines which of the two stock FC emulators is used), the CRC32 and the No-Intro status. If you have a ROM of a that was commercially released during the original console's livespan and it is not matched with No-Intro, that ROM was modified somehow. If you are in a "static" ROM list, you can favorite a ROM that is currently in the list (checked).

Below the No-Intro status, you'll find a lot of features that for the current ROM. The main features have a description inside the tool. Many advanced features can be found in the _Rename..._ button's dropdown menu:

- _Duplicate..._ duplicates the file. Useful before applying an IPS patch. You cannot duplicate multicore files because the _Duplicate as multicore_ feature does the same (see below).
- _Compress_ and _Decompress_ do what they say. Note that _Decompress_ deletes the thumbnail for good.
- If you are viewing a compressed file containing a `.nes` or `.nfc` ROM, you can change the emulator in a submenu called _NES/FC Stock Emulator_ because the GB300 has two. FCEUmm generally has better compatibility, whereas wiseemu/libvrt supports VT02 and VT03. For example, Galaxian suffers from screen tearing in wiseemu, but is fine in FCEUmm. Do not change this VTxx ROMs, as FCEUmm cannot run them. This feature is not available for `.unf` and `.fds` ROMs because wiseemu does not support these.
- _Duplicate as multicore..._ adds the ROM again. Despite the name of the feature, you can also opt to add the ROM for stock emulators. This feature does not work with compressed files because multicore does not support them and for stock emulators, you can use the normal _Duplicate..._ feature.
- _Per-Game Core Config..._ allows you to set multicore options for this ROM. This includes Gambatte's palette. Do note that multicore's per-game configuration feature ignores the extension and path.

By the way: The _Rename..._ feature renames all accompanying files: save states, multicore ROMs, multicore save states.

Below the buttons, you can find screenshots of your save states (should any exist). Rightclick a state for the following features:

- _Save Screenshot..._ saves the screenshot as a PNG or DIB file. You can also doubleclick the state in the list.
- _Copy Screenshot to Clipboard_ copies the screenshot to clipboard.
- The next three items handle the state content. Note that it is quite unlikely that these work, as save states are pretty much guaranteed to be incompatible between different emulators, and might even be incompatible between different CPU architectures. One example where these features are known to work is PokeMini, where you can freely exchange states between multicore and the Windows version.

As a technical side note: The screenshots do not display in the list (but can still be exported and copied) if states do not share screenshot dimensions. This can happen in a very few PC-Engine games where you can select the resolution, e.g. _Burning Angels_. In this case, only screenshots matching the first state's dimensions are displayed. This can also happen with GB300 Tool's _Create Save State from Data..._ feature which uses the last resolution it has successfully displayed after entering the current tab (or 160×120 if no screenshot has been loaded yet).

If you rightclick the file list in one of the first seven tabs, there is an option to mass import images, called _Import All Images..._. This will first show a confirmation message box where you can decide if you want to delete processed images after the import. After that, it checks all files in the currently-displayed list for images with a name pattern described in the message box. Say you used this in the `MD` tab and it's currently processing a list item called `sega;Zero Wing.md.gba`. In this case, it will try to load the following images in the following order, continuing with the next list item after the first one that exists. Note that this feature does not overwrite _other_ files if the new filename conflicted with one (`sega;Zero Wing.md.zgb` in this example).

1. `MD\sega;Zero Wing.md.gba.png`
2. `MD\sega;Zero Wing.md.gba.jpg`
3. `MD\sega;Zero Wing.md.png`
4. `MD\sega;Zero Wing.md.jpg`
5. `ROMS\sega\Zero Wing.md.png` (multicore stubs only)
6. `ROMS\sega\Zero Wing.md.jpg` (multicore stubs only)
7. `ROMS\sega\Zero Wing.png` (multicore stubs only)
8. `ROMS\sega\Zero Wing.jpg` (multicore stubs only)

All your image are now belong to us. For great justice!!


### Favorites

This tab is kinda boring and self-explanatory. One info though: You can reorder items in the list!


### BIOS

***Important:*** Should the boot logo look strange or the screen combo box be empty, you probably have a different BIOS than everyone else's 15 Dec 2023 one. Please contact the author `numma_cway` on Discord. Thank you. GB300 Tool does check if the size mismatches though, and that should be a relatively safe criterion.

This tab is full of features of which that have a good description right inside the tool, so they won't need explanation here. Well, there is one thing I want to emphasize:

***Important:*** It is strongly recommended that you apply the bootloader patch before doing anything else. Checking the checkbox is not enough, though! You then have to put the card in your GB300 and boot to the menu. Now your GB300 is safe for modifications.

I would like to thank Discord user `bnister` (osaka) for his research and making the patches you find here.

But what is this VTxx thing anyway? It's a Famiclone (Famicom clone) with more features. The most important features are way bigger ROMs and more colors (officially 4096 instead of 52, but that's not really true, it's actually just 1703). The GB300's _wiseemu_ can only run [a very few of these ROMs](https://nummacway.github.io/gb300/#vr-technology-vt02vt03).


### multicore

If you don't have multicore yet, GB300 Tool will tell you what to do in order to download it.

If you already have multicore, you can configure it here:
- Configure core settings
  - multicore has a button to enable, view and disable the log. Because disabling and deleting the log is the same to multicore, you can only disable the log by deleting it.
  - Many emulators that handle black-and-white games have a preview for the palette
  - Gambatte even allows custom palettes, so GB300 Tool has a full-featured palette editor
  - You can configure settings, including Gambatte's custom palettes, on a per-game basis! Select a ROM and find the per-game configuration in the _Rename_ button's dropdown menu.
- Check BIOS requirements
- Set default core per extension (this is automatically set to the last core you used when you last added a ROM)
- You can also disable showing the core selection dialog for certain extensions here

Note that for configuration to work, GB300 Tool has to know the core you want to configure and the `.opt` file to use. In the past, there were issues when a core was renamed and there may be more cores to be renamed in the future. Also, the `.opt` file has to be in the correct format with all available options inside comments at the top of the file.


### Keys

This tab is pretty much self-explanatory.

- Use combo boxes to select the key and checkboxes to toggle autofire. Click _Defaults_ to load the defaults.
- Click _Save_ to save.
- Use this button's drop down menu to _Import_ and _Export_ the current mapping. _Undo_ will load the last-saved key map from the device. _Defaults_ will reset all consoles' keys. None of these will automatically save.
- The last column is the multicore column. You can select a core to see its mapping. It depends on your GBA mapping, which therefore affects all multicore cores' mappings as well. A prefixed `T` is for autofire ("turbo").

Note that the device's own "Joystick" editor is completely bugged and unusable for many reasons. Do not file a bug report unless you _physically_ confirmed that GB300 Tool is wrong.


### UI Editor

#### Images

Here you can change all images used by the GB300's UI. Only the boot logo and the search results' selection color are found in the BIOS tab instead because that's where they are stored.

- Select a file from the list on the left.
- Click _Save File_ to save the current file.
  **Technical note:** This will always use PNG because there are different ways to decode/encode RGB565 bitmaps: `shl`-type (higher performance, supports true grays) and full byte range (supports true white, seems to be the more common one). Because RGB565 isn't natively supported by most image editors, they must decode RGB565 first to convert it to RGB888. Should your image editor use a different algorithm than GB300 Tool (full byte range), importing an edited file will cause rounding errors. This means that if you made changes based on the original image, any untouched areas will also be altered. PNG however is unambiguous (as long as gamma is unset, which is the case for GB300), because encoding and decoding depend on the implementation in GB300 Tool.
- Use this button's drop down menu to _Copy Current Image to Clipboard_. This applies to whatever is currently displayed, whereas _Save File_ saves the image from the selected files, even if something else is currently displayed here. Copying BGRA8888 images doesn't make sense because Windows clipboard cannot realy handle transparency.
- Click _Replace..._ to load a new image. This overwrites the current file. GB300 Tool makes sure your image has the correct dimensions. You cannot overwrite BGRA8888 with an image that does not feature alpha.
- The left combo box is for selecting the mode.
  - _Image / Slices_
    - _(full image)_ will show the original image file.
    - If the GB300 doesn't use the image as a whole, you can also select any of the used parts, called slices. The selected and pressed keyboard images are unique, because there are unused areas in the image. Changes made to these parts will not have any effect.
  - _Live Previews_ are 66 predefined scenes that simulate how your theme will look on the device (bottom image) and TV screen (top image). These scenes were created based on NTSC output captured using an analog frame grabber (Astrometa DVB-T2hybrid). NTSC output from the GB300 is vertically pixel-perfect and horizontally alright, so these images are supposed to be pixel-perfect. There is one exception to this: Text is rendered by Windows, which uses a slightly different font rendering algorithm. This affects primarily the character spacing. In addition to that, the spacing for the horizontal ellipsis (...) is much smaller on the device (it looks almost like a underscore), and descenders (parts of letters below the baseline) are partially clipped, so the previews use neither of these two where possible.
- Click on the previews to randomize the background color (meant to proof transparent images).


#### Foldername

If you select the file called _Foldername_ (there wasn't enough space to fit ".ini" in) at the very end of the file list, you will have a completely different interface. Here you can edit general UI settings. A few input boxes are locked because changes to them would break (freeze) your device. You can find more information [here](https://nummacway.github.io/gb300/#foldernameini).

- Click _Reload File_ if you made any changes to the file using anyother software.
- Click _Undo_ to discard all changes made after selecting this file or pressing any of the other buttons.
- Click _Defaults_ to load the defaults.
- Click save to save the settings.

Selecting another file or leaving the _UI Editor_ tab without saving will discard any changes made since you last saved. Changing folders does not move but create them upon saving. You can move the files in Windows Explorer if you want.


## Dev Mode

Launch with `-dev` switch for the following features:

- In the _Rename_ menu of the ROM details, there will be an option to convert NoIntro DATs into the format this tool uses for space and performance reasons (DATs are XML files with more checksums and lots of redundant information and overhead). The result will have No-Intro's platform ID with a `.bin` extension as its name. Make sure to use the headerless NES DAT, BIN DAT for Atari 7800, remove duplicate _Galaxian (USA)_ entry for Atari 5200. The existing No-Intro databases in GB300 Tool do not include BIOS.
- In the _Save_ menu of the UI editor, you can load `preview.xml` from the tool's directory. You can grab the current file from the repository (`Data` folder). If you didn't reorder, add or delete `<preview>`s, this will reload the currently-viewed preview.
- In the _Keys_ tab, keys are shown with hex values. The original values are 16-bit LE, but only 1 byte is shown because the other is always 0.

The User ROMs tab has a context menu for the list where you can save the list file created by the GB300 on the last boot. It's meant for developers only, but is accessible even outside of dev mode.


## Trivia

There are 22879 entries in the tool's initial No-Intro database. The chance that all of these have different hashes ("birthday paradox") is around 94.1% <!--(2^32)!/((2^32)^22879*(2^32-22879)!)--> There is actually one duplicate game, but that one is an SMS game released for the MD with just a physical adapter, but still exactly the same ROM. In A5200, one identical file is listed twice inside only one game.

Fun Facts about making the live previews:
- To not promote even more downloading of commercial games, the sample screenshot for "Download ROMs" contains one free homebrew ROM for each of the 8 supported systems. All ROMs were considered the best on their respective systems according to various sources. I took considerable time to create this list, leading to delays in publishing this tool. You should give all of these ROMs a try.
- The three screenshots used in the samples are the most memorable situations (or memes) I recalled when thinking about ROMs.

The BPS support was added because I wanted to patch Pokémon Crystal into Pokémon Prism myself. When I finished my work, I noticed that the patch was in BSP format rather than BPS. BSP seems way more advanced than BPS as it can even upgrade battery saves.

v1.0-rc2's title bar reads "v1.0", so the actual v1.0 is called "v1.0-final".


## Changelog

### v1.0b (22 Aug 2024)

- Updated the BIOS features' tab order
- Fixed a bug that prevented _Import All Images..._ from finding images located in multicore actual ROMs path
- Fixed a bug that prevented _Import All Images..._ from working with `.zip` files
- Fixed memory leak when importing or creating a multicore state, that also caused the target file to be locked for reading and writing
- Changed hotkey for adding/removing checkmarks to <kbd>+</kbd> (NUM) and <kbd>-</kbd> (NUM) because you often press space when you search in a list
- Per-game core configuration can now configure multicore itself<br>Note: This feature does not affect existing per-game core configurations. In that case, click _Delete_ and configure again to make this feature appear.<br>Note: This is supposed to be overhauled again in the next version, allowing you to choose the options to override. This is then set to support overriding multicore (`sf2000_*`) options in core configuration, e.g. you can set your preferred tearing fix on per-core basis.
- Added support for DoubleCherryGB multicore core
- If configuring an unknown core, option comboboxes (of the previously-selected core) are now hidden
- Added support for Geolith multicore core<br>Note: Despite this core needing one of two BIOS files to work, no BIOS checker was implemented because the core is waaaay too slow (around 12 FPS), the BIOS is a ZIP file (so it can be different even with the same data inside) and MAME 2000 can run 114 of the 155 games – at full speed.
- Updated description of second-player gamepad in key editor, as these have become available now
- Added message saying that "GB300 v2" (the firmware that looks like SF2000) is not yet supported
- Made the two "links" on the onboarding page clickable
- Added arcade icon (which is being used for `m2k` core and `.geo` files)
- Fixed renaming related files failing because it tried to rename the new name into the new name
- Added _Find_ (<kbd>Ctrl</kbd>+<kbd>F</kbd>) and _Find Next_ (<kbd>F3</kbd>), only accessible by these shortcuts
- This is likely the last version to support "GB300 v1" (the one without MAME where you navigate the menu using shoulder buttons)


### v1.0-final (13 Jul 2024)

- Added enabling FDS support
- Added support for the FDS key mappings
- BIOS check now checks if stock FDS and VTxx support has been enabled in GB300 Tool
- Fixed BIOS status for Gambatte and TGB always assuming multicore 0.1.x (it can now detect if the cores have been swapped)
- _Check All_ button in stock ROM tabs now unchecks (removes) missing files
- _Duplicate as multicore..._ can now duplicate multicore for use with another emulator (note that you can select stock emulators too)
- Added save state data support (save state list context menu)<br>Note: This feature is likely to not work because you will need the same emulator and probably even the same CPU architecture. One instance where these features do work is multicore core `pokem` and PokeMini on Windows.
- Incorporated osaka's most recent VTxx patch and removed his previous workarounds<br>Note: If you previously had his patches enabled, enabling the new patch will overwrite the old one.
- Removed old VT02/VT03 workarounds, as these are no longer necessary with osaka's new patch. Just make sure your VTxx ROM has the `.nfc` extension and your ROM will work right away. You can even play headerless VT03.
- Renaming files no longer writes `favorites.bin` and `history.bin` for no reason
- Added mass importing ROM thumbnail images (context menu)
- Added changing the extension between `.nfc` (wiseemu/libvrt) and `.nes` (FCEUmm) for ROMs inside compressed files<br>Note: `.nes` has better compatibility for actual FC/NES, whereas wiseemu/libvrt has a little support for Famiclones. You can swap process all `.zfc` files in `FC` at ones (BIOS tab; `.nfc` to `.nes` only) or any qualifying file individually (ROM details' Rename menu; both directions)
- Added beat support (BPS)
- Added one more No-Intro database:<br>&#8199;(31) Nintendo - Famicom Disk System<br>Note: I'm not sure if the checksums match the commonly-used ROMs' format, as my examples are listed as Third Party Modification and therefore not included in the file.


### v1.0-rc2 (15 Jun 2024)

- Fixed a few lesser bugs, e.g. with empty user ROM list `tsmfk.tax`
- Fixed UI preview glitch with some fonts
- Added one more No-Intro database that didn't make it in the last release due to a lack of time to find the reason why it contains a duplicate that caused trouble.<br>&#8199;&#8199;(1) Atari - 5200<br>Note that (250) Amstrad - CPC and (242) NEC - PC-88 do exist on No-Intro, but data for these platforms is very little, odd and does not match the ROMs I know.
- Fixed the UI file description for the pause menu labels in Spanish/Portuguese, which were errorneously swapped
- Fixed `.gb` not being recognized as a stock core extension
- Added config filenames for `c64fc` (`Frodo.opt`, shared with `c64f`) and `gbb` (Gambatte)
- Fixed some duplicate extensions in core data (probably didn't have a big impact)
- Added support for multicore 0.2.x which caused issues by randomly swapping core names (`gb` and `gbb`); GB300 Tool will try to recognize them by file size<br>Note: GB300 Tool does this automatically when you hit _Start_ on the onboarding screen. Do not update multicore while GB300 Tool is running.
- `.dmg` will always be attributed to the classic Game Boy (the actual name of which is Dot Matrix Game, hence the `.dmg`)
- Input files are now automatically scaled when adding/replacing a thumbnail image (keeps aspect ratio)
- Fixed a bug that prevented updating the image when _replacing_ thumbnails (adding was not affected)
- Added around 400 Gambatte palette previews converted from their source<br>Note: At the time of originally writing this, TWB64 278 was a duplicate of TWB64 277 in Gambatte's palette data source, so it is also the case for your GB300 multicore. I submitted a pull request (PR 268) with a fix, which was accepted by Libretro in under a day's time, but that needs to get merged into the multicore repository and then built. This will take some time. If you want to use TWB 278, select TWB 278 in GB300 Tool, click any color in the preview and then click _OK_ to save it as a custom palette.
- Added Gambatte full palette customization
- Added support for per-game OPT files (and per-game Gambatte custom color palettes)<br>Note for per-game Gambatte custom color palettes: Gambatte accept two file names for custom palettes, internal ROM name and file name, with the latter taking precedence. Even though GB300 Tool even looks up the ROM's internal name (it uses it to preview the palette in `auto`, `SGB` and `GBC` mode), it uses the file name for identifying the palette to use, because multicore requires the file name to be used for per-game OPT files, so this is consistent.
  Note: Palettes and OPT both ignore the path. This makes sense since one core can only have one file of the same name. No matter in which tab on the device you chose to put the file (stub) for that game – the actual ROM always goes into `ROMS`.
- Added Gearboy palette previews (there are only six predefined ones with no further customization)
- Added enabling VT02/03 support for `.nfc` files (must contain an iNES header with mapper 12)<br>Note: There is a ROM size limit of 2&thinsp;MiB in iNES prior to v2.0, so this applies to Archaic iNES as well. `bnister` (osaka) made a patch but that broke all stock ROMs internally named `.nfc`. This patch is not in GB300 Tool.
- Added editing the search results' selection color (BIOS tab)<br>Note: That's hardcoded in the BIOS file, so you cannot ship that with your theme
- Removed `.zfb` thumbnail support as this does not exist on the GB300<br>Note: There was a bug in GB300 Tool caused by insufficient (weak) critieria for identifying `.zfb` files. I first fixed that bug but then decided to remove support alltogether because there is no support on the GB300 anyway.
- Stopped the tool from attempting to hash disc images and multicore ZIP files, as well as any file over 100&thinsp;MB
- Drew more platform (file) icons
- Fixed a bug that mixed up GBA and GB BIOS files in the core BIOS checker
- Added VT02/03 iNES header creation for the GB300's hidden `.nfc` emulator (requires enabling VTxx in BIOS tab to make this feature show up in the ROMS tab as a drop down menu to the _Add_ button)
- Added two low battery screen previews (main menu and pause)<br>Note: The text, which is always in English, contains descenders (parts below the baseline) that Windows cannot render properly for the default font.
- Improved support for high DPI screens<br>There are considerations to render all images from an SVG source using my own SVG library, RedeemerSVG, but I don't want to have it initially released as part of another project and don't want to release it stand-alone either
- Added patching VT03 LUT (can also restore the original LUT, as the patched LUT is calculated on-the-fly from the original LUT that ships with the tool)
- Added a context menu to the user ROM list, allowing you to export the current `tsmfk.tax` as a text file
- In dev mode, the _Keys_ tab now shows the first byte of the value (as a hex string)
- Removed _Duplicate as multicore_ from compressed ROMs' _Rename_ menu because it does not work
- Fixed _Delete_ button not deleting the actual multicore ROMs
- Fixed file extensions with capital letters not showing up
- Renaming ROMs now moves all related files:
  - thumbnailed states
  - GBA: `.sav` in the same folder (but not the one that might exist in `ROMS` because the GB300 randomly put it there instead)
  - If old and new name are both multicore: actual multicore ROM (creates new folder if required), actual multicore states
- Because many people seem to be running this thing on a screen with the resolution of roughly that of the GB300, I added a message saying this is not supported. I want people to stop buying e-waste laptops.
- If you set keys to undocumented values, the _Keys_ tab will now show these values
  Note: This is big endian (in case you ever use values over 255), whereas the actual file is little endian.
- For some of multicore's cores, GB300 Tool can now show the key mapping resulting of your current GBA mapping
- Added multicore log support
- Fixed tab order of multicore selection screen
- Made `sega` a recommended core for SG-1000 and Game Gear (both unofficial)
- Added icons for the BIOS check results
- Fixed blueMSX ColecoVision BIOS checker giving an incorrect file name for `czz50-2.rom`
- Removed `lnxb` and `retro8` from recommended cores
- Added editing Chinese/Pinyin names (double-click)
- Added copying state screenshots to clipboard
- Added palette previews for Potator (`wsv`), PokeMini (`pokem`) and Beetle Cygne (`wswan`).
- Added the remaining previews (no further updates on these are currently planned, but let me know if you are missing something)
- Config is now stored in `%APPDATA%\GB300Tool` unless there's a `gb300tool.ini` where the `.exe` is
- In stock ROM lists, new items added using GB300 Tool are now checked by default (when duplicating non-multicore ROMs, they instead inherit the checked status from their parent)
- Added multicore thumbnail support
- Made _Export Thumb_ button actually work


### v1.0-rc1b (04 May 2024)

- Fixed two bugs that both prevented you from picking stock emulators when multicore was present
- Added a few previews
- Note: With the exception of "Empty battery screen" (`jccatm.kbp`) which I haven't seen so far, all images now have live previews, but three images do not have all slices used in previews yet: "Bottom tabs, selected state" (`nvinf.hsp`), "Top left screen logos" (`exaxz.hsp`) and "Button names in selection popup menu" (`ztrba.nec`). This will be fixed in the future.
- Added a feature to export themes (in the drop down menu of the _Save_ button
- Added No-Intro databases for all platforms that run reasonably well on the GB300 and do not require disc images (because they are difficult to handle):<br>&#8199;(88) Atari - 2600<br>&#8199;(74) Atari - 7800<br>&#8199;(30) Atari - Lynx<br>&#8199;(50) Bandai - WonderSwan<br>&#8199;(51) Bandai - WonderSwan Color<br>&#8199;(87) Benesse - Pocket Challenge v2<br>&#8199;&#8199;(3) Coleco - ColecoVision<br>&#8199;&#8199;(6) Fairchild - Channel F<br>&#8199;&#8199;(7) GCE - Vectrex<br>(105) Mattel - IntelliVision<br>&#8199;(14) Nintendo - Pokémon mini<br>&#8199;(17) Sega - 32X<br>&#8199;(18) Sega - Kids Computer Pico _(also available on stock)_<br>&#8199;(19) Sega - SG-1000<br>&#8199;(73) Sinclair - ZX Spectrum<br>&#8199;(35) SNK - NeoGeo Pocket<br>&#8199;836) SNK - NeoGeo Pocket Color<br>&#8199;(22) Watara - SuperVision<br>Note: In theory, you could use this to identify files with generic extensions like `.bin`. This not currently planned because those extensions are rare.


### v1.0-rc1 (04 May 2024)

- Added full multicore support
- Fixed some bugs


### v1.0-pre1 vanilla-only (28 Apr 2024)

- This is the first release.
- No-Intro databases included:<br>&#8199;(12) NEC - PC Engine<br>&#8199;(46) Nintendo - Game Boy<br>&#8199;(23) Nintendo - Game Boy Advance<br>&#8199;(47) Nintendo - Game Boy Color<br>&#8199;(45) Nintendo - Nintendo Entertainment System<br>&#8199;(49) Nintendo - Super Nintendo Entertainment System<br>&#8199;(25) Sega - Game Gear<br>&#8199;(26) Sega - Master System<br>&#8199;(32) Sega - Mega Drive