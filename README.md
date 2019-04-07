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

If you don't have `sudo` privilidges you can still use the executable `web-media-controller` found in the `build` directory but you will need to perform the following steps:

1. In the `build` directory, there is a directory called `manifest` and inside it there is a directory corresponding every supported browser.
2. According to the browser you use, open the `.json` file inside it with your preferred text editor.
3. Find the `path:` key with the value of where the `web-media-controller` would have been installed if you had ran `sudo make install`.
4. Change the value of that path (keep the quotes and the comma after them) to the value of where the executable is located right now. For example:
```json
    "path": "/home/f1u77y/repos/wmc-mpris/build/web-media-controller",
```
5. Save and quit the editor.
6. Copy the file you've just edited to the following directory (depending on your browser):
  - Firefox: `~/.mozilla/native-messaging hosts/`
  - Chrome: `~/.config/google-chrome/NativeMessagingHosts/`
  - Chromium: `~/.config/chromium/NativeMessagingHosts/`

### Packages
- [AUR](https://aur.archlinux.org/packages/web-media-controller-mpris-git/)
- Feel free to create packages for other distros and add them to this list

## Usage

In addition to installing/building the web-media-controller, you will need to install [this browser extension](https://github.com/f1u77y/web-media-controller/releases). It will interact with `web-media-controller` in the background. While it is running, and the extension installed, you should be able to go to one of the [supported websites](https://github.com/f1u77y/web-media-controller#supported-websites) and be able to control it with every MPRIS client. Here are a few examples:

- [playerctl](https://github.com/acrisci/playerctl)
- Default Plasma player widget
- [playbar2](https://github.com/audoban/PlayBar2)
- [GNOME Shell extension](https://extensions.gnome.org/extension/1379/mpris-indicator-button/)
- Many other tools (just search for "<my DE/statusbar/etc> mpris widget")

Some of these tools supports controlling the player via media keys, which is the initial goal of the project.
