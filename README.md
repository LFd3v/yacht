# Y.A.C.H.T - Yet Another Configuration Handler (for) Tmux

Supercharged and customizable [tmux](https://tmux.github.io/) configuration that aims to appeal to power users while still being beginner friendly.

It is vastly based on these projects:
- [Tmux Configuration](https://github.com/samoshkin/tmux-config)
- [Tmux Configuration](https://github.com/arminveres/tmux-config) by @arminveres (initial fork)
- [.tmux](https://github.com/gpakosz/.tmux)
- [tmux-plugins](https://github.com/tmux-plugins)
- [Tmux sysstat plugin](https://github.com/samoshkin/tmux-plugin-sysstat)
- [t - the smart tmux session manager](https://github.com/joshmedeski/t-smart-tmux-session-manager)


Original Tmux Configuration animation for reference:

![intro](https://user-images.githubusercontent.com/768858/33152741-ec5f1270-cfe6-11e7-9570-6d17330a83aa.gif)

## Table of contents

1. [Features](#features)
1. [Installation](#installation)
1. [General settings](#general-settings)
1. [Key bindings](#key-bindings)
1. [Status line](#status-line)
1. [Status menu](#status-menu)
1. [Nested tmux sessions](#nested-tmux-sessions)
1. [Copy mode](#copy-mode)
1. [Clipboard integration](#clipboard-integration)
1. [Themes and customization](#themes-and-customization)
1. [GUI terminal integration](#GUI-terminal-integration)

## Features

- "C-a" `<prefix>` instead of "C-b" (`screen` like, easier to use with one hand)
- follow [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) (with a few minor changes) 
- support for nested tmux sessions (local -> top bar / nested -> bottom bar)
- local vs remote specific session configuration (custom configuration applied to `ssh` sessions)
- scroll and copy mode improvements
- integration with OSX or Linux clipboard (works for local, remote, and local+remote nested session scenario)
- supercharged status line
- renew tmux and shell environment (SSH_AUTH_SOCK, DISPLAY, SSH_TTY) when reattaching back to old session
- newly created windows and panes retain current working directory
- monitor windows for activity/silence
- highlight focused pane, with toggle for pane status
- merge current session with existing one (move all windows)
- configurable visual theme/colors, with some elements borrowed from [Powerline](https://github.com/powerline/powerline)
- integration with 3rd party plugins: [tmux-battery](https://github.com/tmux-plugins/tmux-battery),[tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight), [tmux-online-status](https://github.com/tmux-plugins/tmux-online-status), [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect), [tmux-continuum](https://github.com/tmux-plugins/tmux-continnum), [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat), [tmux-open](https://github.com/tmux-plugins/tmux-open), [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat), [t-smart-tmux-session-manager](https://github.com/joshmedeski/t-smart-tmux-session-manager), [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat)
- all key bindings are listed in the "List key bindings" screen (do not include plugins, please refer to their documentation if needed)
- **Status Menu** with system info and some commonly used commands and toggles
- most stock key bindings still work as default, the most common ones can be used without `<prefix>`
- double-clicking empty area of the status bar creates a new window
- all key bindings can be disabled (OFF mode) when using a nested sessions (`ssh`, ect) or if a key binding conflicts
- Initial window is configured to use `main-vertial` layout with 60% width (`main-horizontal` also set o 60% height), which can be applied to new windows with a key-binding, as well as new panes follow the current layout (this can be overriden with custom key bindings, and the default layout and width/height easily changed in `tmux.conf` as well)
- resurrect and continuum plugins configured properly, save/restore pane buffer enabled, with visble status via **Stautus Menu** and configurable in the main `tmux.conf`
- `tmux.conf` is completely documented, so it should be easy to change the default settings or customize it even further

**Status line widgets**:

- CPU, memory and swap usage (sysstat widgets)
- battery information
- username (`root` aware) and hostname, current date and time
- visual indicator when `<prefix>` is pressed
- visual indicator when `Copy` mode is active
- visual indicator when `Synchronization` mode is active
- visual indicator when pane is zoomed
- visual indicator when main sessions is locked (OFF mode)
- online/offline visual indicator
- toggle visibility of sysstat and battery widgets via **Status Menu**
- toggle visibility of status line via **Status Menu** or key binding

## TODO

- [ ] create a menu/popup with some help information

## Installation

Prerequisites:

- tmux >= "v3.2"
- Linux (tested on Arch Linux)
- macOS (not tested, but should work)


To install tmux-config:

```
$ git clone <repo address> # or download and extract a release
$ ./tmux-config/install.sh
```

`install.sh` script does following:

- copies files to `~/.config/tmux` directory
- existing `~/.tmux.conf` will be moved to '~/.config/tmux/tmux.conf.home`
- existing `~/.config/tmux/tmux.conf` will be renamed to 'tmux.conf.config`
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) will be installed at default location `~/.config/tmux/plugins/tpm`, unless already present
- required tmux plugins will be installed
- fixes the padding of sysstat widgets
- shows a warning if an alias is needed to load the new configuration file (`tmux <= 3.2`)

Finally, you can jump into a new tmux session:

```
$ tmux new
```

## General settings

Most [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) suggestions are followed, with these changes:
- `display-time 2000`               # ststus messages display time duration = 2s
- `status-interval 3`               # status bar update interval = 3s
- `default-terminal tmux-256color`  # instead of screen-256color
- `status-keys` will follow your $EDITOR / $VISUAL environment variable, like stock `tmux`
- reload tmux configuration file is mapped to `<prefix> C-r`

Other default configuration, as suggested by [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) or not:
- Windows and pane indexing starts from `1` rather than `0`
- Scrollback history limit is set to `50000`
- Aggresive resizing is on
- Mouse support in `on`.
- `escape-time` is `0` to avoid problems with programs like vim/neovim that use ESC key
- Focus application events is enabled
- Detach on destroy is disabled (instead of exiting, attach to next session, if available)

256 color palette support is turned on, make sure that your parent terminal is configured propertly. See [here](https://unix.stackexchange.com/questions/1045/getting-256-colors-to-work-in-tmux) and [there](https://github.com/tmux/tmux/wiki/FAQ)


## Key bindings

All new and custom key bindings are listed in the `List key bindings` screen (`<prefix> + ?`).

_Tip_: you can search this screen using common `vim`/`less` commands.

The key bindings were chosen to make it easier to remember them for new users, while still keeping the basic ones for long time `tmux` users. Of course, they can be changed in the `tmux.conf` file if needed.

The most used ones were added as default so the basic funcionality is available without the need to press `<prefix>` first:

<table>
    <tr>
        <td nowrap><b>Key binding</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td nowrap><code>M-t</code></td>
        <td>Create new window</td>
    </tr>
    <tr>
        <td nowrap><code>M-n</code></td>
        <td>Split window, and apply layout</td>
    </tr>
    <tr>
        <td nowrap><code>M-x</code></td>
        <td>Kill pane, with confirmation</td>
    </tr>
    <tr>
        <td nowrap><code>M-arrows</code></td>
        <td>Naviagte panes and windows</td>
    </tr>
    <tr>
        <td nowrap><code>C-Tab</code></td>
        <td>Go to most recent used window</td>
    </tr>
    <tr>
        <td nowrap><code>C-S-Up</code></td>
        <td>Enter Copy mode, PageDown to the very bottom cancels it</td>
    </tr>
</table>

These key bindings can be mapped to your GUI terminal keys of choice, but this needs to be done manually. See [GUI terminal integration](#GUI-terminalintegration) section below.

## Status line

Window tabs use Powerline arrows glyphs, so you need to install Powerline enabled font to make this work. See [Powerline docs](https://powerline.readthedocs.io/en/latest/installation.html#fonts-installation) for instructions and here is the [collection of patched fonts for powerline users](https://github.com/powerline/fonts). Your preferred [Nerd font](https://github.com/ryanoasis/nerd-fonts) should work as well.

Most modes, like Copy, Synchronization and Zoom have visual indicators. You might want to hide the status bar using `<prefix> C-t` keybinding, or use the **Status Menu** to toggle some (somewhat CPU intensive widgets) on/off.

## Status menu

Using `<prefix> Home` will display handy menu with some configurartion options and toggles. This is also available via a click with the secondary mouse button on the right area of the status bar. Some options affect only the [P]ane, [W]indow or the whole [S]ession, and the associated key binding is also visible.

## Nested tmux sessions

When in outer session, simply press `F12` to toggle off all keybindings handling in the outer session. Now work with inner session using the same keybinding scheme and same keyprefix. Press `F12` to turn on outer session back.

You might notice that when key bindings are "OFF", special `[OFF]` visual indicator is shown in the status line, and status line changes its style (colored to gray).

### Local and remote sessions

Remote session is detected by existence of `$SSH_CLIENT` variable. When session is remote, following changes are applied:

- status line is docked to bottom; so it does not stack with status line of local session;
- some widgets are removed from status line.n.

You can apply remote-specific settings by extending `~/.config/tmux/.tmux.remote.conf` file.

## Copy mode

There are some tweaks to copy mode and scrolling behavior, you should be aware of.

There is a root keybinding to enter Copy mode: `C-S-Up`. Once in copy mode, you have several scroll controls:

- scroll by line: `M-Up`, `M-down`
- scroll by half screen: `M-PageUp`, `M-PageDown`
- scroll by whole screen: `PageUp`, `PageDown`
- scroll by mouse wheel, scroll step is changed from `5` lines to `2`

`Space` starts selection, `Enter` copies selection and exits copy mode. List all items in copy buffer using `<prefix> C-b`, and paste most recent item from buffer using `<prefix> p`.

`y` just copies selected text and is equivalent to `Enter`, `Y` copies whole line, and `D` copies by the end of line. Like most modes, pressing `Q` will cancel and exit the mode.

Other features are available via [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) and [tmux-open](https://github.com/tmux-plugins/tmux-open) plugins, please refer to their documentation.

Also, note that when text is copied any trailing new lines are stripped. So, when you paste buffer in a command prompt, it will not be immediately executed.

You can also select text using mouse. Default behavior is to copy text and immediately cancel copy mode on `MouseDragEnd` event. This is annoying, because sometimes I select text just to highlight it, but `tmux` drops me out of copy mode and reset scroll by the end. So this behavior was changed: `MouseDragEnd` does not execute `copy-selection-and-cancel` action. Text is copied, but copy mode is not cancelled and selection is not cleared. You can then reset selection by a single mouse click.

## Clipboard integration

Sharing with the system clipboard was tested on Linux, at least for the local connection. There are some changes applied for macOS users, as explained [here](https://github.com/samoshkin/tmux-config#clipboard-integration), but this was not tested.

## Themes and customization

All colors related to theme are declared as variables. You can change them in `~/.config/tmux/tmux.conf`.

## GUI terminal integration

These guides will help in order to make your preferred GUI terminal keybings work with `tmux`:

- [iTerm2](https://github.com/samoshkin/tmux-config#iterm2-and-tmux-integration)
- [Alacritty, Kitty, WezTerm](https://github.com/joshmedeski/t-smart-tmux-session-manager#bonus-macos-keyboard-shortcut)
- [foot](https://codeberg.org/dnkl/foot/src/commit/ca46edfe6f72816c727e3a37476126904807d0bf/foot.ini#L208) (`text-bindings` in documentation)


Original Tmux Configuration screenshot for reference:

![full screen mode](https://user-images.githubusercontent.com/768858/33185303-54fa0378-d08a-11e7-8fd3-068f0af712c7.png)
