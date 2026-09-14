-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")


-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Position windows on startup: btop (top-left), cliamp (bottom-left), claude (right)
-- Display resolution: 1440x900 logical pixels (at 1.6x scale)
-- Matched to current desktop 1 window layout

-- btop: top-left (tiled, not floating)
o.window({ title = "^btop$" }, {
  size = "701 418",
  move = "12 38"
})

-- cliamp: bottom-left (tiled, not floating)
o.window({ title = "^cliamp$" }, {
  size = "701 418",
  move = "12 470"
})

-- claude: right (tiled, not floating)
o.window({ title = "^claude$" }, {
  size = "695 850",
  move = "727 38"
})
