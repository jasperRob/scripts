# Scripts

A collection of personal shell scripts for macOS/Linux workflow automation.

## Installation

Run `install.sh` to symlink all scripts (including `install-script` itself) into `~/bin`:

```sh
./install.sh
```

Ensure `~/bin` is on your `$PATH`. The script skips scripts that are already
linked and won't overwrite mismatched symlinks without re-running.

### `install-script`

The core install logic lives in `install-script`, a standalone utility that can
be used by other projects to consolidate their install logic.

```sh
# Install scripts from another project after install-script is in ~/bin
install-script /path/to/other/project/scripts
```

Other projects can use it in their own `install.sh`:

```sh
#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
install-script "$SCRIPT_DIR"
```

`install-script` links all executables in the given directory into `~/bin`,
skipping `install.sh` and `README.md`. It links itself when run from this repo.

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
open-tmux-session notes
open-tmux-session 1        # first registered session
```

**Built-in sessions:**

| Key              | Session | Working Dir             | Status Bar |
| ---------------- | ------- | ----------------------- | ---------- |
| `1` / `notes`    | notes   | `~/src/jasperRob/notes` | Magenta    |
| `2` / `config`   | config  | `~/`                    | Orange     |
| `3` / `misc`     | misc    | `~/misc`                | Green      |

If the session already exists, attaches to it (or switches client if already
inside tmux).

**Local addon sessions:**

Machine-specific sessions (e.g. work projects) can be added without touching
this repo. Drop a `.sh` file into `~/.config/open-tmux-sessions/` — it will be
sourced automatically on startup.

Each file defines a setup function and calls `register_session`:

```sh
# ~/.config/open-tmux-sessions/myproject.sh

_setup_myproject() {
  tmux new-session -d -s "$SESSION" -n 'main' -c ~/src/myproject/
  set_style "$SESSION" colour4 colour0
  tmux send-keys -t "$SESSION:1.0" 'npm run dev' C-m
}

register_session "myproject" "My Project" "_setup_myproject"
```

The setup function has access to `$SESSION`, `set_style`, and
`attach_or_switch`. Registered sessions appear in the interactive menu in the
order they were loaded (built-ins first, then addons sorted by filename).

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
