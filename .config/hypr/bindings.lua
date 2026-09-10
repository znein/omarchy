-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Touchpad toggle keybinding - press Super+Shift+T to toggle touchpad on/off
o.bind("SUPER + SHIFT + t", "Toggle touchpad on/off", "omarchy toggle touchpad")

-- Vim-style arrow key navigation on a dedicated Hyper modifier (Caps Lock)
-- Hyper + hjkl sends arrow keys to the active application
local function send_key_once(key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = "", key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = "", key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

-- Terminal navigation (send arrow keys to focused app)
o.bind("MOD3 + H", "Left arrow", send_key_once("Left"))
o.bind("MOD3 + J", "Down arrow", send_key_once("Down"))
o.bind("MOD3 + K", "Up arrow", send_key_once("Up"))
o.bind("MOD3 + L", "Right arrow", send_key_once("Right"))
o.bind("MOD3 + X", "Delete character", send_key_once("Delete"))

-- Hyprland window focus navigation (SUPER+MOD3+hjkl)
o.bind("SUPER + MOD3 + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + MOD3 + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + MOD3 + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + MOD3 + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
