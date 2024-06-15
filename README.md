This is a tool for managing your [Sup+ GB300 (Game Box) console](https://nummacway.github.io/gb300/).

It is supposed to be the GB300's counterpart to what Tadpole is for the similar Data Frog SF2000, even though the interface is completely different. GB300 Tool does not work with the SF2000 and prevents you from even trying to do so.


## Requirements

The tool works on any Windows machine. There are no dependencies. It might run on Linux via Wine, but note that the _Live Previews_ feature makes heavy use of an undocumented Windows API feature.

Once source is available, you can also use Embarcadero Delphi to compile it yourself. It should compile with no to minimal changes starting from Delphi XE2. GB300 Tools makes heavy use of negative Zlib window sizes (aka headerless deflate streams) which are not possible in earlier versions (maybe XE, I don't know). There is a way newer free Community Edition that will do the job.


## Features

General features:

- Fast startup times
- Works quite smooth (performance depends on Windows GDI and TF card performance)
- Clean interface with all icons handcrafted just for this software, according to the OpenMoji style guide
- Many explanations right inside the tool (more details on this page)
- Supports drag and drop and multi-select (actions in the ROM details still apply to displayed single file only)


Features in detail:

- ROMs
  - Add, remove and in the seven "static" lists and user ROMs
  - Manually reorder and alphabetically sort ROMs in the "static" lists
  - Identify ROMs using No-Intro (includes No-Intro game ID, name and verification status; ignores NES header if one is present)
  - Rename, compress and decompress ROM files
  - Import (replace) and export ROM files
  - Apply IPS (International Patching System) patches (RLE and truncate extensions supported)
  - Import, export and add thumbnails
  - Import and export save states
  - Export save state images
  - Delete save states
- Favorites
  - Remove favorites
  - Manually reorder or alphabetically sort favorites
- BIOS & Device
  - Patch bootloader
  - Work around bootloader issues
  - Enable GBA BIOS
  - Fix BIOS CRC
  - Change boot logo
  - Patch BIOS after swapping in the SF2000's screen
  - Fix broken MD thumbnails (45 of these exist on the GB300)
  - Fix Glazed thumbnail
  - Clear favorites, history and key map
- Keys
  - Edit first and second player keys independently
  - Shows SMS and GG mapping for MD
  - Knows about all the bugs in the official key map editor, so you assign the actual mapping to the actual buttons (I'm talking about you, shoulder buttons!)
  - Import and export key map backups
  - Reset one console's or all key mappings to default
- UI Editor
  - Export and replace all images
  - View slices of images that aren't used as a whole
  - Preview images in around 100 pixel-perfect simulated scenes
  - Edit general UI settings in `Foldername.ini`

I hope that people will be sharing the themes they made, so we can have a theme gallery with downloads like the SF2000 has.

#### Limitations

- A few preview scenes are missing. They would be related to key editing and more ROM lists.
- There was a plan to get you suggested GG2SMS hacks when you add GG games where those hacks exist and can be played without an external gamepad. This is not yet implemented. Except for the absolute best hacks that use the entire screen, there is no need for this with multicore.
- Does not support multicore yet. This is planned to be released very soon.
- Files with bad thumbnails are not supported right now. Use the two fixes in the BIOS tab before doing anything else with the 45 glitched MD files and Pokemon Glazed.
- Does not currently automatically rescale images.
- There are no plans for sound-related features right now. Use [Kerokero](https://github.com/Dteyn/SF2000_BGM_Tool) instead.


### Onboarding

This is the small box that is displayed on startup. Enter your drive letter here. You can also enter a local folder.

When you hit _Start_, GB300 Tool makes sure that `Foldername.ini` exists and you made no unsupported modifications to it (ones that would break your console anyway).


### ROMs

Note: GB300 Tool does not use obfuscation in files it writes. This applies to archives with an without thumbnails, as obfuscation is purely optional. (It will keep any existing obfuscation if you just change a thumbnail.)


### BIOS

***Important:*** Should the boot logo look strange or the screen combo box be empty, you probably have a different BIOS than everyone else's 15 Dec 2023 one. Please contact the author `numma_cway` on Discord. Thank you. GB300 Tool does check if the size mismatches though, and that should be a relatively safe criterion.


### Keys

This tab is pretty much self-explanatory.

* Use combo boxes to select the key and checkboxes to toggle autofire. Click _Defaults_ to load the defaults (which make no sense, though).
* Click _Save_ to save.
* Use this button's drop down menu to _Import_ and _Export_ the current mapping. Note that importing does not automatically save. _Undo_ will load the last-saved key map from the device. _Defaults_ will reset all consoles' keys.

Note that the device's own "Joystick" editor is completely bugged and unusable for many reasons. Do not file a bug report unless you _physically_ confirmed that GB300 Tool is wrong.


### UI Editor

#### Images

Here you can change all images used by the UI. Only the boot logo is found in the BIOS tab instead.

- Select a file from the list on the left.
- Click _Save File_ to save the current file.
  **Technical note:** This will always use PNG because there are different ways to decode/encode RGB565 bitmaps: `shl`-type (higher performance, supports true grays) and full byte range (supports true white, seems to be the more common one). Because RGB565 isn't natively supported by most image editors, they must decode RGB565 first to convert it to RGB888. Should your image editor use a different algorithm than GB300 Tool (full byte range), importing an edited file will cause rounding errors. This means that if you made changes based on the original image, any untouched areas will also be altered. PNG however is unambiguous (as long as gamma is unset, which is the case for GB300), because encoding and decoding depend on the implementation in GB300 Tool.
- Use this button's the drop down menu to _Copy Current Image to Clipboard_. This applies to whatever is currently displayed, whereas _Save File_ saves the image from the selected files, even if something else is currently displayed here. Copying BGRA8888 images doesn't make sense because Windows clipboard cannot realy handle transparency.
- Click _Replace..._ to load a new image. This overwrites the current file. GB300 Tool makes sure your image has the correct dimensions. You cannot overwrite BGRA8888 with an image that does not feature alpha.
- The left combo box is for selecting the mode.
  - _Image / Slices_
    - _(full image)_ will show the original image file.
    - If the GB300 doesn't use the image as a whole, you can also select any of the used parts, called slices. The selected and pressed keyboard images are unique, because there are unused areas in the image. Changes made to these parts will not have any effect.
  - _Live Previews_ are around 100 predefined scenes that simulate how your theme will look on the device (bottom image) and TV screen (top image). These scenes were created based on NTSC output captured using an analog frame grabber (Astrometa DVB-T2hybrid). NTSC output from the GB300 is vertically pixel-perfect and horizontally alright, so these images are supposed to be pixel-perfect. There is one exception to this: Text is rendered by Windows, which uses a slightly different font rendering algorithm. This affects primarily the character spacing. In addition to that, the spacing for the horizontal ellipsis (...) is much smaller on the device (it looks almost like a underscore), and descenders (parts of letters below the baseline) are partially clipped, so the previews use neither of these two.


#### Foldername

If you select the file called _Foldername_ (there wasn't enough space to fit ".ini" in) at the very end of the file list, you will have a completely different interface. Here you can edit general UI settings. A few input boxes are locked because changes to them would break (freeze) your device. You can find more information [here](https://nummacway.github.io/gb300/#foldernameini).

- Click _Reload File_ if you made any changes to the file using anyother software.
- Click _Undo_ to discard all changes made after selecting this file or pressing any of the other buttons.
- Click _Defaults_ to load the defaults.
- Click save to save the settings.

Selecting another file or leaving the _UI Editor_ tab without saving will discard any changes made since you last saved.


## Dev Mode

Launch with `-dev` switch to show two menu items:

* In the _Rename_ menu of the ROM details, there will be an option to convert NoIntro DATs into the format this tool uses for space and performance reasons (DATs are XML files with more checksums and lots of redundant information and overhead). The result will have the name of the original file but with a `.bin` extension. Make sure to use the headerless NES DAT.
* In the _Save_ menu of the UI editor, you can load `preview.xml` from the tool's directory. If you didn't reorder, add or delete `<preview>`s, this will reload the currently-viewed preview.


## Trivia

There are 19013 entries in the tool's No-Intro database. The chance that all of these have different hashes ("birthday paradox") is: $(2^32)!/((2^32)^19013*(2^32-19013)!)$ There is actually one duplicate game, but that one is an SMS game released for the MD with just a physical adapter, but still exactly the same ROM.

Fun Facts about making the live previews:
* To not promote even more downloading of commercial games, the sample screenshot for "Download ROMs" contains one free homebrew ROM for each of the 8 supported systems. All ROMs were considered the best on their respective systems according to various sources. I took considerable time to create this list, leading to delays in publishing thsi tool. You should give all of these ROMs a try.
* The three screenshots used in the samples are the most memorable situations (or memes) I recalled when thinking about ROMs.