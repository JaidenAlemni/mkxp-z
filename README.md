# mkxp-z Astravia fork
This is a modified fork of the modified fork of mkxp: mkxp-z. Specifically tailored for use in [Legends of Astravia](https://s.team/a/1233680). Changes are often made out of exclusivity and are not designed to be compatible. **As a result, I highly discourage forking this branch directly.**

That said, feel free to cherry pick potentially useful things. Keep in mind that I (Jaiden) have absolutely no C++ background and am flying off the seat of my pants with any edits or changes, so I doubt anything is remotely stable or good.

Refer to the [mkxp-z wiki](https://github.com/mkxp-z/mkxp-z/wiki) for building and additional information.

## Some changes made so far:

- **Overridden to support XP's Tilemap with VX's Window class.** This means everything will break unless you happen to be coming from [KK20's XP Ace](https://forum.chaos-project.com/index.php?topic=12899.0), or you reverse this change in [binding-mri](/binding/binding-mri.cpp) before building.
- Tilemap has received quite a few edits, including:
    - Set to a minimum 1280x720 resolution
    - Accepts zoom_x / zoom_y similar to a Sprite, which may be useful for a RGSS-side camera script
    - Behaves more like the original mkxp branch, utilizing the more tightly packed tile atlas. This will likely nuke any support for "infinite length" autotiles as a result, sorry.
    - Has a tilesize constant, though it needs work and still needs to be changed in a couple of places. It is currently set to use 16x16 tiles
- Added a totally not functional multiply blending, and renamed "Substract" to "Subtract" because it drove me absolutely nuts, sorry Ancurio
- Added an extra "Input::Pause", including to the Windows keybinding menu, so you can bind your start buttons.
- Add Input#key_mapping / Input::Controller#key_mapping to attempt to get current keybinds Ruby-side (thanks Eblo). Needs a little work, though.

### Build Notes, Etc.

Successfully built on the following platforms:
- Windows 10 21H2
    - AMD Ryzen 7 5800X, NVidia 980 Ti
- macOS Monterey 12.6.1
    - Macbook Air (13-inch 2017) Intel i5, Intel HD Graphics 6000
    - Xcode 14.1
- Ubuntu 20.04 LTS
    - VM via Parallels on the above Mac

**Windows Build Notes**
- Installed Ruby 2.7.6 x64 using [RubyInstaller](https://rubyinstaller.org/downloads/)
- Largely followed the mkxp-z build guide, however, I used the MSYS2 toolchain from RubyInstaller instead of installing it separately since it gave me a lot of hassle.
- Built happily otherwise
- Adding Steam was a little weird since it demands an absolute path
- Created a couple of .sh's in the root build dir for quickly doing a couple different kind of builds (Steam, Debug, Standalone), for convienience 

**macOS Build Notes**
- Followed the wiki guide mostly. Homebrew was first.
- Issues largely arose with Ruby not behaving. Installed it following the Rails guide [here](https://gorails.com/setup/macos/12-monterey) (stopping at ruby -v, obviously we don't want to install Rails)
- Dependency building got hung up on Ripper, so I excluded it. See [this commit](https://github.com/mkxp-z/mkxp-z/commit/a0f1cf0bb934cf5d6329e85a49836fdbb2e5f363).
- Seemed to happily build Universal on my Intel machine otherwise

**Linux Build Notes**
- I need a drink before I fill this list in


---

*- Original mkxp-z Readme starts here -*

# mkxp-z

<p align="center"><b>
  <a href="https://github.com/mkxp-z/mkxp-z/releases">Releases</a>
  ・
  <a href="https://github.com/mkxp-z/mkxp-z/actions/workflows/autobuild.yml">Automatic Builds</a>
  ・
  <a href="https://github.com/mkxp-z/mkxp-z/wiki">Documentation</a>
</b></p>

Automated builds are retained for 60 days and require logging in to access.

I'm usually *very* slow with responding to things on Github, so if you have something you want to say and you want a faster response, you're probably better off asking in [Ancurio's Discord server](https://discord.gg/b2qg8QbV). I don't have my own.
The place is basically a ghost town haunted by myself and a few others, so expect me to say something if no one else does.

-----------

This is a fork of mkxp intended to be a little more than just a barebones recreation of RPG Maker. The original goal was successfully running games based on Pokemon Essentials, which is notoriously dependent on Windows APIs. I'd consider that mission accomplished.

Despite the fact that it was made with Essentials games in mind, there is nothing connected to it contained in this repository, and it should still be compatible with anything that runs in the upstream version of MKXP. You can think of it as MKXP but a bit supercharged --  it should be able to run all but the most demanding of RGSS projects, given a bit of porting work.

It supports Windows, Linux and both Intel and Apple Silicon versions of macOS.

## Bindings
Bindings provide the glue code for an interpreted language environment to run game scripts in. mkxp-z focuses on MRI and as such the mruby and null bindings are not included.

## Midi music

mkxp doesn't come with a soundfont by default, so you will have to supply it yourself (set its path in the config). Playback has been tested and should work reasonably well with all RTP assets.

You can use this public domain soundfont: [GMGSx.sf2](https://www.dropbox.com/s/qxdvoxxcexsvn43/GMGSx.sf2?dl=0)

## macOS Controller Support

Binding controller buttons on macOS is slightly different depending on which version you are running. Binding specific buttons requires different versions of the operating system:

+ **Thumbstick Button (L3/R3, LS/RS, L↓/R↓)**: macOS Mojave 10.14.1+
+ **Start/Select (Options/Share, Menu/Back, Plus/Minus)**: macOS Catalina 10.15+
+ **Home (Guide, PS)**: macOS Big Sur 11.0+

Technically, while SDL itself might support these buttons, the keybinding menu had to be rewritten in Cocoa in a hurry, as switching away from native OpenGL broke the original keybinding menu. (ANGLE is used instead, to prevent crashing on Apple Silicon releases of macOS, and to help mkxp switch to Metal)

## Fonts

In the RMXP version of RGSS, fonts are loaded directly from system specific search paths (meaning they must be installed to be available to games). Because this whole thing is a giant platform-dependent headache, Ancurio decided to implement the behavior Enterbrain thankfully added in VX Ace: loading fonts will automatically search a folder called "Fonts", which obeys the default searchpath behavior (ie. it can be located directly in the game folder, or an RTP).

If a requested font is not found, no error is generated. Instead, a built-in font is used. By default, this font is Liberation Sans.

## What doesn't work
* wma audio files
* Creating Bitmaps with sizes greater than your hardware's texture size limit (around 16384 on modern cards).
  * There is an exception to this, called *mega surface*. When a Bitmap bigger than the texture limit is created from a file, it is not stored in VRAM, but regular RAM. Its sole purpose is to be used as a tileset bitmap. Any other operation to it (besides blitting to a regular Bitmap) will result in an error.
