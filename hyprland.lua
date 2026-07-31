-- #######################################################################################
-- Converted from hyprlang (hyprland.conf) to the Lua config (0.55+).
-- Source of truth used for every hl.* call below: the official example at
-- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua
-- and the current wiki at https://wiki.hypr.land/Configuring/
-- Items I could NOT verify against those sources are marked "-- ⚠ VERIFY:" — see chat.
-- #######################################################################################

------------------
---- MONITORS ----
------------------
-- ⚠ VERIFY: mode string format for an explicit resolution+refresh combo.
-- The wiki's own examples only show plain "1920x1080" (no @refresh) for hl.monitor,
-- even though the surrounding text talks about 144Hz monitors. I'm following the same
-- "resolution@refresh" convention hyprlang used, since nothing suggests it changed —
-- but please check https://wiki.hypr.land/Configuring/Basics/Monitors/ if this doesn't apply cleanly.
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60.01",
    position = "0x0",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager  = "nautilus"
local menu         = "wofi --show drun"

-------------------
---- AUTOSTART ----
-------------------
-- Autostart moved into the "hyprland.start" event (confirmed in both the official
-- example and the wiki: this event fires once at startup, separate from reloads).
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper & waybar & hypridle")
    hl.exec_cmd("snappy-switcher --daemon")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "16")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_STYLE_OVERRIDE", "")
hl.env("QT_SCALE_FACTOR", "")
hl.env("GDK_SCALE", "")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        rounding_power = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a, -- same value as rgba(1a1a1aee); official example uses this numeric form for shadow color specifically
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})

-- Bezier curves (identical points to your original — and to the official example, which
-- ships these same five curve definitions verbatim).
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

-- Animations — kept as plain bezier curves exactly like your original (the official
-- example switches some of these to "spring" curves by default now, but I didn't
-- introduce that since your file didn't use springs).
hl.animation({ leaf = "global",        enabled = true, speed = 10,    bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,   bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49,  bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73,  bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46,  bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03,  bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81,  bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,     bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,   bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79,  bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39,  bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94,  bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21,  bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94,  bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,     bezier = "quick" })

-- "Smart gaps" block — left commented, exactly as it was in your original.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

-------------
---- INPUT ----
-------------
hl.config({
    input = {
        kb_layout = "fr",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- NOTE: "epic-mouse-v1" is Hyprland's own placeholder example device name — it was
-- already in your original file untouched. Carried over as-is; you probably want to
-- replace or remove this one.
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name = "elan050a:01-04f3:3158-mouse",
    enabled = true,
})

-- ⚠ VERIFY: "tap-to-click" → tap_to_click. I could not find this in the official docs
-- directly; I'm inferring the underscore form because every other hyphenated hyprlang
-- key (col.active_border, etc.) becomes underscored in Lua, and a third-party
-- converter's docs explicitly state Hyprland's Lua config registry maps "-" to "_"
-- and rejects the hyphenated spelling. Worth a quick confirm on the wiki's Devices page.
hl.device({
    name = "elan050a:01-04f3:3158-touchpad",
    enabled = true,
    tap_to_click = true,
    natural_scroll = true,
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + N", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch / move-to workspace (keys 10-19 preserved exactly as your original —
-- these look like the raw X11 keycodes for digits 1-0, presumably to dodge the
-- AZERTY shift-for-numbers issue given kb_layout = fr; left untouched)
for i = 1, 10 do
    local key = i + 9
    hl.bind(mainMod .. " + code:" .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + code:" .. key, hl.dsp.window.move({ workspace = i }))
end

-- Exchange active window
-- ⚠ VERIFY: your original shelled out to `hyprctl dispatch swapwindow l/r/u/d`.
-- Under a Lua-rooted config, hyprctl dispatch NO LONGER accepts that classic
-- "dispatcher arg" form — it expects a Lua expression instead, so these four exec
-- calls WILL BREAK as written. I could not find a confirmed hl.dsp equivalent for
-- "swapwindow" in the sources I checked (window.move/resize/close/kill/fullscreen/tag
-- are confirmed, but not swap). Please check
-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/ for the current swap
-- dispatcher name, then either call it natively via hl.bind(..., hl.dsp.window.XXX())
-- or, if you keep the exec route, update the string to the new form, e.g.:
-- hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.window.XXX(...)'")
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("hyprctl dispatch swapwindow l")) -- ⚠ likely broken, see note above
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprctl dispatch swapwindow r")) -- ⚠ likely broken, see note above
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("hyprctl dispatch swapwindow u")) -- ⚠ likely broken, see note above
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("hyprctl dispatch swapwindow d")) -- ⚠ likely broken, see note above

-- Screenshots
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("hyprshot -m region"))

-- Hyprlock
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("hyprlock"))

-- Toggle waybar
-- NOTE: haven't seen the contents of toggle_waybar.sh — if it shells out to
-- `hyprctl dispatch <classic form>` internally, that call will break too. Worth a check.
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/toggle_waybar.sh"))

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Useful applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("keepassxc"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("beeper"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("libreoffice"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("steam"))

-- System shutdown
hl.bind(mainMod .. " + code:20", hl.dsp.exec_cmd([[bash -c 'echo -e "No\nYes" | wofi --dmenu --prompt "Shutdown?" | grep -q Yes && systemctl poweroff']]))

hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod super --linear"))
hl.bind(mainMod .. " + SHIFT + code:23", hl.dsp.exec_cmd("snappy-switcher prev --mod super --linear"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "no-focus-xwayland",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
    },
    no_focus = true,
})
