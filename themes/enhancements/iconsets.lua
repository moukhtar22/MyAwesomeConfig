-- MyAwesomeConfig Icon Set Enhancement Library
-- Provides enhanced icon systems, coloring, and icon variants for better visual appeal

local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- Icon Style Variants
M.icon_styles = {
    -- Different visual styles for the same icon concept
    outline = {
        suffix = "-outline",
        prefix = "o-",
        description = "Thin outline style"
    },
    filled = {
        suffix = "",
        prefix = "f-",
        description = "Solid filled style"
    },
    dual = {
        suffix = "-dual",
        prefix = "d-",
        description = "Outline with filled center"
    },
    sharp = {
        suffix = "-sharp",
        prefix = "s-",
        description = "Sharp, angular style"
    },
    rounded = {
        suffix = "-rounded",
        prefix = "r-",
        description = "Rounded corners style"
    },
    bold = {
        suffix = "-bold",
        prefix = "b-",
        description = "Bold, heavy weight"
    },
    light = {
        suffix = "-light",
        prefix = "l-",
        description = "Light, thin weight"
    }
}

-- Icon Color States
M.icon_states = {
    -- Different colors for different widget states
    default = {
        color = nil, -- use theme default
        description = "Normal state"
    },
    active = {
        color = nil, -- use theme accent/focus color
        description = "Active/selected state"
    },
    inactive = {
        color = nil, -- use muted/fg_normal color
        description = "Inactive/unselected state"
    },
    warning = {
        color = nil, -- use warning/error color
        description = "Warning/alert state"
    },
    success = {
        color = nil, -- use success color
        description = "Success/positive state"
    },
    disabled = {
        color = nil, -- use disabled color
        description = "Disabled state"
    },
    hover = {
        color = nil, -- use hover color
        description = "Hover state"
    }
}

-- Icon Enhancement Functions
function M.enhance_icon(base_icon, style, state, theme)
    -- base_icon: the base icon name (e.g., "volume-up", "battery-charging")
    -- style: icon style from M.icon_styles
    -- state: icon state from M.icon_states
    -- theme: theme table for color lookup
    
    local result = base_icon
    
    -- Apply style modifier
    if style and M.icon_styles[style] then
        local style_info = M.icon_styles[style]
        if style_info.prefix then
            result = style_info.prefix .. result
        end
        if style_info.suffix then
            result = result .. style_info.suffix
        end
    end
    
    -- Note: Actual coloring would be done in the widget using theme colors
    -- This function returns the icon name; coloring is handled separately
    
    return result
end

function M.get_icon_color(state, theme, default_color)
    -- Get the appropriate color for an icon based on its state
    
    if not state or not M.icon_states[state] then
        state = "default"
    end
    
    local state_info = M.icon_states[state]
    
    if state_info.color then
        return state_info.color
    elseif state == "default" then
        return default_color or theme.fg_normal or "#ffffff"
    elseif state == "active" then
        return theme.fg_focus or theme.accent or "#ffffff"
    elseif state == "inactive" then
        return gears.color.ensure_hex_color(theme.fg_normal or "#ffffff"):darken(0.4)
    elseif state == "warning" then
        return theme.bg_urgent or "#ff0000"
    elseif state == "success" then
        -- Could use a success color from theme, fallback to greenish
        return "#4caf50"
    elseif state == "disabled" then
        return gears.color.ensure_hex_color(theme.fg_normal or "#ffffff"):darken(0.6)
    elseif state == "hover" then
        return gears.color.ensure_hex_color(theme.fg_normal or "#ffffff"):lighten(0.2)
    else
        return default_color or theme.fg_normal or "#ffffff"
    end
end

-- Icon Decoration Functions
function M.create_icon_background(size, shape, color, intensity)
    -- size: background size
    -- shape: "circle", "square", "rounded-square", "diamond"
    -- color: background color
    -- intensity: opacity/intensity of background
    
    return {
        type = "icon_background",
        size = size or dpi(20),
        shape = shape or "circle",
        color = color or "#00000022",
        intensity = intensity or 0.8,
        padding = dpi(2)
    }
end

function M.create_icon_border(width, color, radius, style)
    -- width: border width
    -- color: border color
    -- radius: corner radius (for non-circle shapes)
    -- style: "solid", "dashed", "dotted", "gradient"
    
    return {
        type = "icon_border",
        width = width or dpi(1),
        color = color or "#ffffff",
        radius = radius or dpi(4),
        style = style or "solid",
        gap = style == "dashed" and dpi(2) or nil,
        dot_radius = style == "dotted" and dpi(0.5) or nil
    }
end

function M.create_icon_shadow(offset_x, offset_y, blur, color, intensity)
    -- offset_x, offset_y: shadow offset
    -- blur: blur radius
    -- color: shadow color
    -- intensity: shadow intensity
    
    return {
        type = "icon_shadow",
        offset_x = offset_x or dpi(1),
        offset_y = offset_y or dpi(1),
        blur = blur or dpi(2),
        color = color or "#00000044",
        intensity = intensity or 0.6
    }
end

function M.create_icon_glow(radius, color, intensity)
    -- radius: glow radius
    -- color: glow color
    -- intensity: glow intensity
    
    return {
        type = "icon_glow",
        radius = radius or dpi(3),
        color = color or "#ffff0044",
        intensity = intensity or 0.7,
        quality = 2
    }
end

-- Icon Animation Functions
function M.create_icon_pulse(scale_min, scale_max, duration)
    -- scale_min, scale_max: min/max scale factors
    -- duration: animation duration in milliseconds
    
    return {
        type = "icon_pulse",
        scale_min = scale_min or 0.95,
        scale_max = scale_max or 1.05,
        duration = duration or 1500,
        easing = "ease-in-out"
    }
end

function M.create_icon_spin(duration, direction)
    -- duration: time for full rotation
    -- direction: "clockwise" or "counterclockwise"
    
    return {
        type = "icon_spin",
        duration = duration or 2000,
        direction = direction or "clockwise",
        easing = "linear"
    }
end

function M.create_icon_bounce(height, duration)
    -- height: bounce height in pixels
    -- duration: bounce duration
    
    return {
        type = "icon_bounce",
        height = height or dpi(4),
        duration = duration or 800,
        easing = "ease-out-bounce"
    }
end

-- Icon Set Categories
M.icon_sets = {
    -- Weather Icons
    weather = {
        base = "weather-",
        sets = {
            outline = "weather-outline-",
            filled = "weather-",
            dual = "weather-dual-"
        },
        -- Common weather conditions
        conditions = {
            "clear-day", "clear-night",
            "partly-cloudy-day", "partly-cloudy-night",
            "cloudy", "rain", "snow", "sleet", "wind",
            "fog", "hail", "thunderstorm", "tornado"
        }
    },
    
    -- System Icons
    system = {
        base = "system-",
        sets = {
            outline = "system-outline-",
            filled = "system-",
            dual = "system-dual-"
        },
        -- Common system states
        states = {
            "power", "restart", "sleep", "logout",
            "wifi", "ethernet", "bluetooth", "battery",
            "volume", "brightness", "mic", "camera"
        }
    },
    
    -- Action Icons
    action = {
        base = "action-",
        sets = {
            outline = "action-outline-",
            filled = "action-",
            dual = "action-dual-"
        },
        -- Common actions
        actions = {
            "play", "pause", "stop", "next", "previous",
            "volume-up", "volume-down", "mute",
            "brightness-up", "brightness-down",
            "mic-on", "mic-off", "camera-on", "camera-off",
            "expand", "collapse", "menu", "search"
        }
    },
    
    -- Status Icons
    status = {
        base = "status-",
        sets = {
            outline = "status-outline-",
            filled = "status-",
            dual = "status-dual-"
        },
        -- Common status indicators
        statuses = {
            "info", "warning", "error", "success",
            "loading", "offline", "online", "dnd",
            "mute", "private", "secure", "update"
        }
    }
}

-- Icon Coloring Schemes
M.color_schemes = {
    -- Different approaches to icon coloring
    monotone = {
        description = "Single color (uses theme fg/focus colors)",
        function(icon_name, state, theme)
            return M.get_icon_color(state, theme)
        end
    },
    duotone = {
        description = "Two colors (primary + secondary)",
        function(icon_name, state, theme)
            local primary = M.get_icon_color(state, theme)
            local secondary = gears.color.ensure_hex_color(primary):lighten(0.3)
            return {primary = primary, secondary = secondary}
        end
    },
    gradient = {
        description = "Gradient fill",
        function(icon_name, state, theme)
            local base_color = M.get_icon_color(state, theme)
            -- Create a gradient variant
            return {
                type = "gradient",
                color1 = base_color,
                color2 = gears.color.ensure_hex_color(base_color):lighten(0.4),
                angle = 45
            }
        end
    },
    palette = {
        description = "Use predefined color palette",
        palette = {
            {"#ff006e", "#ff6ec7", "#7b2cbfff"},
            {"#00f3ff", "#ff006e", "#ffee00"},
            {"#fdcb6e", "#e17055", "#6c5ce7"},
            {"#a8edea", "#fed6e3", "#d4a5d4"},
            {"#ff9a9e", "#fad0c4", "#fbc2eb"}
        },
        function(icon_name, state, theme, index)
            local palette = M.color_schemes.palette.palette
            local colors = palette[((index or 0) % #palette) + 1]
            local base_color = M.get_icon_color(state, theme)
            -- Blend with palette color for variety
            return gears.color.ensure_hex_color(base_color):mix(
                gears.color.ensure_hex_color(colors[2]), 0.3
            )
        end
    }
}

-- Special Icon Functions
function M.create_state_indicator(base_icon, states, theme)
    -- Creates a set of icons for different states
    -- states: table of state names
    
    local icon_set = {}
    for _, state in ipairs(states) do
        icon_set[state] = {
            icon = M.enhance_icon(base_icon, nil, state, theme),
            color = M.get_icon_color(state, theme)
        }
    end
    return icon_set
end

function M.create_icon_variants(base_icon, styles, theme)
    -- Creates different style variants of the same icon
    
    local variants = {}
    for _, style in ipairs(styles) do
        variants[style] = {
            icon = M.enhance_icon(base_icon, style, nil, theme),
            color = M.get_icon_color("default", theme)
        }
    end
    return variants
end

-- Icon Mutation Functions (for dynamic icons)
function M.create_icon_mutator(base_icons, transition_time)
    -- base_icons: table of icon names to cycle through
    -- transition_time: how long to show each icon
    
    return {
        type = "icon_mutator",
        icons = base_icons,
        current_index = 1,
        transition_time = transition_time or 1000,
        last_change = 0
    }
end

-- Export functions and data
M.icon_styles = M.icon_styles
M.icon_states = M.icon_states
M.icon_sets = M.icon_sets
M.color_schemes = M.color_schemes
M.enhance_icon = M.enhance_icon
M.get_icon_color = M.get_icon_color
M.create_icon_background = M.create_icon_background
M.create_icon_border = M.create_icon_border
M.create_icon_shadow = M.create_icon_shadow
M.create_icon_glow = M.create_icon_glow
M.create_icon_pulse = M.create_icon_pulse
M.create_icon_spin = M.create_icon_spin
M.create_icon_bounce = M.create_icon_bounce
M.create_state_indicator = M.create_state_indicator
M.create_icon_variants = M.create_icon_variants
M.create_icon_mutator = M.create_icon_mutator

return M