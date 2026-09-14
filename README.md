# Omarchy Dotfiles & Configuration

Personal Omarchy initialization repository with Hyprland configurations, shell setup, and system customizations.

## Overview

This repository contains a complete Omarchy/Hyprland configuration setup with:
- **Hyprland window manager** configuration (keybindings, input mapping)
- **Shell & terminal** customizations
- **System initialization** scripts and dotfiles

## Directory Structure

```
omarchy/
├── .config/hypr/           # Hyprland window manager configuration
│   ├── bindings.lua        # Custom keybindings (vim-inspired navigation + workspace management)
│   ├── input.lua           # Keyboard configuration (Caps Lock → Hyper key)
│   ├── autostart.lua       # Applications to launch on startup
│   └── hyprland.lua        # Main Hyprland config with window positioning rules
├── .local/bin/             # Custom user scripts
│   └── reopen-workspace-windows  # Launches claude, btop, cliamp with proper tiling
├── .dotfiles/              # Shell and environment setup
│   └── bash-config         # Bash configuration and aliases
└── README.md               # This file
```

## Quick Setup

### 1. Clone & Install

```bash
# Clone this repository into your home directory or a project folder
git clone <repo-url> ~/omarchy
cd ~/omarchy

# Or copy files directly to your config
cp -r .config/* ~/.config/
cp -r .dotfiles/* ~/ 2>/dev/null || true
```

### 2. Apply Hyprland Configuration

```bash
# Reload Hyprland to apply keybindings and input config
hyprctl reload
```

### 3. Apply Shell Configuration

```bash
# Source bash config in your ~/.bashrc
echo "source ~/omarchy/.dotfiles/bash-config" >> ~/.bashrc
source ~/.bashrc
```

## Features

### Hyprland Configuration

#### Vim-Style Terminal Navigation (Caps Lock + hjkl)
Navigate the cursor in your terminal using Caps Lock as a modifier:

**Arrow Navigation:**
```
Caps + H  → cursor left
Caps + J  → cursor down
Caps + K  → cursor up
Caps + L  → cursor right
```

**Line & Page Navigation:**
```
Caps + U  → page up
Caps + D  → page down
Caps + I  → home (beginning of line)
Caps + N  → end (end of line)
Caps + X  → delete character
```

**Text Selection (with Shift):**
```
Caps + Shift + I  → select to beginning of line (Shift+Home)
Caps + Shift + N  → select to end of line (Shift+End)
```

#### Window Focus Navigation (Super + Caps Lock + hjkl)
Move focus between windows with vim-like keybindings:

```
Super + Caps + H  → focus left window
Super + Caps + J  → focus window below
Super + Caps + K  → focus window above
Super + Caps + L  → focus right window
```

#### Workspace Window Layout (Autostart + Tiling)
Automatically open three workspace windows on boot in a tiled layout:
- **claude**: Main window (initially on left, full height)
- **btop** (top): System monitoring
- **cliamp** (bottom): CLI amplifier

**Reopen closed windows:**
```
Super + Caps + Q  → Relaunch all three workspace windows
```

**To arrange in your preferred layout** (btop top-left, cliamp bottom-left, claude right):
```
1. Launch windows with Super + Caps + Q
2. Grab claude window with Super + Left Mouse drag
3. Drag to the right side to swap layout
```

This creates the desired layout:
- **Left column:** btop (top) and cliamp (bottom) split vertically
- **Right column:** claude full height

#### Keyboard Features
- **Caps Lock** remapped to Hyper modifier (MOD3) — no conflicts with existing bindings
- **Both-Shift together** still toggles real Caps Lock for typing
- Isolated from Super/Alt/Ctrl keybindings

### Shell Configuration

Custom bash configuration in `.dotfiles/bash-config` includes:
- Environment variables
- Aliases and functions
- Shell prompt customization
- Development tool integration

## Configuration Details

### Hyprland Input (`input.lua`)

Maps keyboard layout and modifiers:
- **Caps Lock** → Hyper modifier (via XKB `caps:hyper`)
- **Both-Shift** → Real Caps Lock toggle (via XKB `shift:both_capslock_cancel`)
- Works at kernel/driver level — applies system-wide

### Hyprland Autostart (`autostart.lua`)

Launches applications automatically when Hyprland starts:
```lua
o.launch_on_start("/home/mkeh/.local/bin/reopen-workspace-windows")
```

This calls the custom script that manages workspace window layout.

### Workspace Window Script (`.local/bin/reopen-workspace-windows`)

Custom bash script that launches and arranges three workspace windows with proper delays:

**Location:** `~/.local/bin/reopen-workspace-windows`

**What it does:**
1. Launches `claude` in a foot terminal (main window)
2. Waits 300ms for proper tiling
3. Launches `btop` system monitor (top-left position)
4. Waits 300ms
5. Launches `cliamp` CLI tool (bottom-left position)

**Why delays matter:**
- Hyprland needs time to process window rules after each launch
- Without delays, windows may stack incorrectly
- 300ms ensures reliable tiling order

**Setup:**
```bash
# The script is provided in .local/bin/ and automatically:
# 1. Runs on Hyprland startup (via autostart.lua)
# 2. Runs when you press Super + Caps + Q to reopen windows
```

### Hyprland Window Positioning (`hyprland.lua`)

Defines window rules to position applications with fixed sizes and locations:
```lua
o.window({ title = "^btop$" }, {
  float = true,
  size = "720 450",
  move = "0 0"
})
```

Windows are set to `float = true` and assigned specific dimensions and coordinates to create the tiled layout without using traditional tiling.

### Hyprland Bindings (`bindings.lua`)

Defines keybindings using Hyprland's Lua API:
- Terminal navigation via `hl.dsp.send_key_state()`
- Window focus via `hl.dsp.focus()`
- 50ms timer prevents key-state sticking
- Workspace window management via `os.execute()` for relaunching windows

## Customization

### Add More Keybindings

Edit `~/.config/hypr/bindings.lua` to add custom keybindings:

```lua
o.bind("SUPER + E", "Open file manager", hl.dsp.exec("nautilus"))
o.bind("SUPER + T", "Open terminal", hl.dsp.exec("ghostty"))
```

### Change Keyboard Options

Edit `~/.config/hypr/input.lua` to adjust modifier behavior:

```lua
kb_options = "caps:hyper,shift:both_capslock_cancel",
```

Disable the both-Shift toggle:

```lua
kb_options = "caps:hyper",
```

### Extend Shell Config

Add aliases and functions to `.dotfiles/bash-config`:

```bash
alias ll="ls -lah"
alias gs="git status"
```

## Verification

### Check Hyprland Configuration

```bash
# Verify Caps Lock is mapped to Hyper
hyprctl getoption input:kb_options
# Should output: caps:hyper,shift:both_capslock_cancel

# List all keybindings
hyprctl binds | head -20

# Check for configuration errors
hyprctl configerrors
```

### Test Keybindings

1. Open a terminal and hold **Caps Lock**
2. Press **H/J/K/L** — cursor should move left/down/up/right
3. Press **X** — character under cursor should delete
4. Press **U/D** — page up/page down in terminal or text editor
5. Press **I/N** — move to beginning/end of line
6. Press **Shift + I** or **Shift + N** — select from cursor to beginning/end of line
7. Hold **Super + Caps Lock** and press **H/J/K/L** — window focus should change
8. Press **Both Shift keys** — Caps Lock should toggle

### Test Workspace Layout

1. **On Login:** Three windows should open automatically after login:
   - Windows launch via `/home/mkeh/.local/bin/reopen-workspace-windows`
   - They tile in a consistent order

2. **Close & Reopen:** Close any or all three windows, then press **Super + Caps + Q** to relaunch them

3. **Manual Arrangement** (if desired):
   - After launch, grab claude window with **Super + Left Mouse drag**
   - Drag to the right side to move it from main column to secondary column
   - Windows will automatically resize to create the preferred layout

4. **Verify:**
   ```bash
   hyprctl clients
   # Should show btop, cliamp, and claude windows
   ```

## Troubleshooting

### Bindings Not Working

```bash
# Check Lua syntax errors
hyprctl configerrors

# Verify keybindings are registered
hyprctl binds | grep "arrow"

# Reload Hyprland
hyprctl reload
```

### Caps Lock Not Acting as Hyper

```bash
# Check keyboard layout options
setxkbmap -query | grep caps

# Reload input configuration
hyprctl reload
```

### Shell Config Not Sourcing

```bash
# Ensure .bashrc sources the config
cat ~/.bashrc | grep "bash-config"

# Manually source it
source ~/omarchy/.dotfiles/bash-config
```

## System Requirements

- **OS:** Arch Linux / Omarchy
- **Compositor:** Hyprland (Wayland)
- **Shell:** Bash (or compatible)
- **Keyboard:** Standard QWERTY layout

## Performance

- **CPU:** Negligible (event-driven keybindings)
- **Memory:** None (configuration-only)
- **Battery:** None (hardware remapping, no polling)

## Updates

To update this configuration:

```bash
cd ~/omarchy
git pull origin main
# Re-apply configuration as needed
hyprctl reload
source ~/.bashrc
```

## License

Personal dotfiles — modify and use freely.

## Resources

- [Hyprland Wiki](https://wiki.hyprland.org)
- [Omarchy Documentation](https://omarchy.org)
- [XKB Options](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration)

---

**Last Updated:** 2026-09-13  
**Status:** Active ✅  
**Features:** Vim-style navigation, workspace auto-layout with btop/cliamp/claude, quick-reopen with Caps+Q
