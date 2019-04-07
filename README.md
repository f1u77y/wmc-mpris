# MPRIS proxy for Web Media Controller

## Installation
### Dependencies
- `glib2`
- `json-glib`
- Corresponding header packages for building from source if your distro uses them (eg. Debian/Ubuntu)
### Building from source
```
$ git clone https://github.com/f1u77y/wmc-mpris.git
$ cd wmc-mpris
$ mkdir build
$ cd build
$ cmake -DCMAKE_BUILD_TYPE=Release ..
$ make
```
Now you can install this with `sudo make install` and uninstall with
`cat install_manifest.txt | sudo xargs rm` (both commands should be run from `build/`).
No other actions required.

### Packages
- [AUR](https://aur.archlinux.org/packages/web-media-controller-mpris-git/)
- Feel free to create packages for other distros and add them to this list

## Usage
You need to install this program and
[an extension](https://github.com/f1u77y/web-media-controller/releases) for you browser.
It will interact with this program in the background, so you should go to one of supported websites and listen to
some music.

Now you can interact with music player in your browser via different tools:
- [playerctl](https://github.com/acrisci/playerctl)
- Default Plasma player widget
- [playbar2](https://github.com/audoban/PlayBar2)
- [GNOME Shell extension](https://extensions.gnome.org/extension/1379/mpris-indicator-button/)
- Many other tools (just search for "<my DE/statusbar/etc> mpris widget")

Some of these tools supports controlling the player via media keys, which is initial goal of the project.
