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

If you don't have `sudo` privilidges, replace the last 2 commands with the following:

```
cmake -DCMAKE_BUILD_TYPE=Release -DINSTALL_FOR_CURRENT_USER=On ..
make
```

And then `make install` won't need `sudo`.

### Packages
- [AUR](https://aur.archlinux.org/packages/web-media-controller-mpris-git/)
- [Nix Packages Collection](https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/misc/web-media-controller)
- Feel free to create packages for other distros and add them to this list

## Usage

In addition to installing/building the web-media-controller, you will need to install [this browser extension](https://github.com/f1u77y/web-media-controller/releases). When both the extension and this program installed, the extension will interact with it in the background and you should be able to go to one of the [supported websites](https://github.com/f1u77y/web-media-controller#supported-websites) and be able to control it with every MPRIS client. Here are a few examples:

- [playerctl](https://github.com/acrisci/playerctl)
- Default Plasma player widget
- [playbar2](https://github.com/audoban/PlayBar2)
- [GNOME Shell extension](https://extensions.gnome.org/extension/1379/mpris-indicator-button/)
- Many other tools (just search for "<my DE/statusbar/etc> mpris widget")

Some of these tools supports controlling the player via media keys, which is the initial goal of the project.
