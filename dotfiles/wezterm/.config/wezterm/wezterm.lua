local wezterm = require "wezterm"

local config = wezterm.config_builder()

local function move_pane(key, direction)
    return {
        key = key,
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection(direction)
    }
end

local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize { direction, 5 }
    }
end

config = {
    -- Theming
    color_scheme = "Catppuccin Mocha",
    window_frame = {
        active_titlebar_bg = "#1E1E2E"
    },
    font = wezterm.font "JetBrains Mono SemiBold",
    font_size = 16,
    window_decorations = "RESIZE",
    enable_tab_bar = false,

    -- Keymaps
    leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        {
            key = "%",
            mods = "LEADER",
            action = wezterm.action.SplitHorizontal {
                domain = "CurrentPaneDomain"
            },
        },
        {
            key = "\"",
            mods = "LEADER",
            action = wezterm.action.SplitVertical {
                domain = "CurrentPaneDomain"
            },
        },
        move_pane("h", "Left"),
        move_pane("j", "Down"),
        move_pane("k", "Up"),
        move_pane("l", "Right"),
        {
            key = 'r',
            mods = 'LEADER',
            action = wezterm.action.ActivateKeyTable {
                name = 'resize_panes',
                one_shot = false,
                timeout_milliseconds = 1000,
            }
        },
    },

    key_tables = {
        resize_panes = {
            resize_pane("h", "Left"),
            resize_pane("j", "Down"),
            resize_pane("k", "Up"),
            resize_pane("l", "Right"),
        }
    }
}

return config
