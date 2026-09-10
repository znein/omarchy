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
│   ├── bindings.lua        # Custom keybindings (vim-inspired navigation)
│   └── input.lua           # Keyboard configuration (Caps Lock → Hyper key)
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

```
Caps + H  → cursor left
Caps + J  → cursor down
Caps + K  → cursor up
Caps + L  → cursor right
Caps + X  → delete character
```

#### Window Focus Navigation (Super + Caps Lock + hjkl)
Move focus between windows with vim-like keybindings:

```
Super + Caps + H  → focus left window
Super + Caps + J  → focus window below
Super + Caps + K  → focus window above
Super + Caps + L  → focus right window
```

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

### Hyprland Bindings (`bindings.lua`)

Defines keybindings using Hyprland's Lua API:
- Terminal navigation via `hl.dsp.send_key_state()`
- Window focus via `hl.dsp.focus()`
- 50ms timer prevents key-state sticking

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
4. Hold **Super + Caps Lock** and press **H/J/K/L** — window focus should change
5. Press **Both Shift keys** — Caps Lock should toggle

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

**Last Updated:** 2026-09-10  
**Status:** Active ✅
