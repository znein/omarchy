-- Main Hyprland configuration with window positioning rules
-- Workspace window rules for claude, btop, and cliamp

-- Claude window: main workspace window
o.window({ title = "^claude$" }, {
  float = false,
  focus = true
})

-- Btop system monitor: floating window
o.window({ title = "^btop$" }, {
  float = true,
  size = "720 450",
  move = "0 0"
})

-- Cliamp CLI amplifier: floating window
o.window({ title = "^cliamp$" }, {
  float = true,
  size = "720 450",
  move = "0 450"
})
