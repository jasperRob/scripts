# Scripts

A collection of personal shell scripts for macOS/Linux workflow automation.

## Installation

Run `install.sh` to symlink all scripts into `~/bin`:

```sh
./install.sh
```

Ensure `~/bin` is on your `$PATH`. The script skips scripts that are already
linked and won't overwrite mismatched symlinks without re-running.

## Usage

### `aerospace-close-ghost-windows`

Closes AeroSpace windows with an empty title (ghost windows).

```sh
# Close all ghost windows
aerospace-close-ghost-windows

# Close ghost windows for a specific app
aerospace-close-ghost-windows "App Name"
```

Requires [AeroSpace](https://github.com/nikitabobko/AeroSpace) and `jq`.

---

### `open-tmux-session`

Creates or attaches to a named tmux session with pre-configured layouts and
colour-coded status bars.

```sh
# Interactive prompt
open-tmux-session

# Direct session name or number
open-tmux-session k3
open-tmux-session 2        # notes
```

**Sessions:**

| Key            | Session | Working Dir             | Status Bar |
| -------------- | ------- | ----------------------- | ---------- |
| `1` / `k3`     | k3      | `~/src/kogan/K3`        | Blue       |
| `1` / `kowhai` | kowhai  | `~/src/kogan/Kowhai`    | Lavender   |
| `2` / `notes`  | notes   | `~/src/jasperRob/notes` | Magenta    |
| `3` / `config` | config  | `~/`                    | Orange     |
| `4` / `misc`   | misc    | `~/misc`                | Green      |

If the session already exists, attaches to it (or switches client if already
inside tmux).

---

### `printscr`

Takes a screenshot using ImageMagick's `import` and saves it to
`~/Pictures/screenshots/` with a timestamp filename. Sends a desktop
notification on save.

```sh
# Interactive region/window selection
printscr

# Full screen capture
printscr -window
```

Requires `imagemagick` and `libnotify` (`notify-send`).

---

### `dmenu_runc`

Launches `dmenu_run` styled with colours from the active Xresources theme
(`.color2` / `.color7`).

```sh
dmenu_runc
```

Requires `dmenu` and `xrdb` (X11 only).
