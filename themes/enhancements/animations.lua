-- MyAwesomeConfig Animation Enhancement Library
-- Provides smooth transitions, micro-interactions, and animated effects

local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- Animation Configuration
M.config = {
    default_duration = 250, -- milliseconds
    fast_duration = 150,
    slow_duration = 400,
    easing_default = "ease-in-out",
    easing_in = "ease-in",
    easing_out = "ease-out",
    easing_linear = "linear"
}

-- Animation Presets
M.presets = {
    -- Widget appearance/disappearance
    fade = {
        duration = M.config.fast_duration,
        easing = M.config.easing_out,
        property = "opacity",
        from = 0,
        to = 1
    },
    slide_up = {
        duration = M.config.default_duration,
        easing = M.config.easing_out,
        property = "y_offset",
        from = dpi(20),
        to = 0
    },
    slide_down = {
        duration = M.config.default_duration,
        easing = M.config.easing_out,
        property = "y_offset",
        from = -dpi(20),
        to = 0
    },
    slide_left = {
        duration = M.config.default_duration,
        easing = M.config.easing_out,
        property = "x_offset",
        from = dpi(20),
        to = 0
    },
    slide_right = {
        duration = M.config.default_duration,
        easing = M.config.easing_out,
        property = "x_offset",
        from = -dpi(20),
        to = 0
    },
    scale_in = {
        duration = M.config.default_duration,
        easing = "ease-back-out",
        property = "scale",
        from = 0.9,
        to = 1.0
    },
    scale_out = {
        duration = M.config.fast_duration,
        easing = "ease-in-back",
        property = "scale",
        from = 1.0,
        to = 0.9
    },
    -- Button interactions
    button_press = {
        duration = M.config.fast_duration / 2,
        easing = M.config.easing_out,
        property = "scale",
        from = 1.0,
        to = 0.95
    },
    button_release = {
        duration = M.config.fast_duration / 2,
        easing = M.config.easing_in,
        property = "scale",
        from = 0.95,
        to = 1.0
    },
    -- Notification animations
    notification_slide_in = {
        duration = M.config.slow_duration,
        easing = M.config.easing_out,
        property = "x_offset",
        from = dpi(100), -- start off-screen right
        to = 0
    },
    notification_slide_out = {
        duration = M.config.slow_duration,
        easing = M.config.easing_in,
        property = "x_offset",
        from = 0,
        to = dpi(100) -- end off-screen right
    },
    -- Menu animations
    menu_fade_in = {
        duration = M.config.default_duration,
        easing = M.config.easing_out,
        property = "opacity",
        from = 0,
        to = 1
    },
    menu_scale_in = {
        duration = M.config.default_duration,
        easing = "ease-back-out",
        property = "scale",
        from = 0.95,
        to = 1.0
    }
}

-- Animation Helper Functions
function M.create_animation(preset_name, custom_params)
    local preset = M.presets[preset_name] or {}
    local anim = {}
    
    -- Copy preset properties
    for k, v in pairs(preset) do
        anim[k] = v
    end
    
    -- Override with custom parameters
    if custom_params then
        for k, v in pairs(custom_params) do
            anim[k] = v
        end
    end
    
    return anim
end

function M.animate_property(object, property_name, from_value, to_value, duration, easing, callback)
    -- Simple animation helper
    -- In practice, this would integrate with Awesome's animation system or use timers
    
    local start_time = os.clock() * 1000 -- milliseconds
    local end_time = start_time + (duration or M.config.default_duration)
    easing = easing or M.config.easing_default
    
    -- This is a conceptual implementation - actual implementation would depend
    -- on Awesome's available animation APIs or using gears.timer
    
    return {
        start_time = start_time,
        end_time = end_time,
        property = property_name,
        from = from_value,
        to = to_value,
        duration = duration,
        easing = easing,
        callback = callback,
        active = true
    }
end

-- Micro-interaction Effects
function M.create_hover_effect(widget, options)
    -- Adds hover animation to a widget
    options = options or {}
    
    local scale_amount = options.scale or 1.05
    local duration = options.duration or M.config.fast_duration
    local easing = options.easing or "ease-in-out"
    local color_shift = options.color_shift -- optional color to shift to
    
    return {
        type = "hover_effect",
        widget = widget,
        scale_amount = scale_amount,
        duration = duration,
        easing = easing,
        color_shift = color_shift,
        enter_animation = M.create_animation("scale_in", {
            duration = duration,
            easing = easing,
            from = 1.0,
            to = scale_amount
        }),
        leave_animation = M.create_animation("scale_out", {
            duration = duration,
            easing = easing,
            from = scale_amount,
            to = 1.0
        })
    }
end

function M.create_click_feedback(widget, options)
    -- Adds click/press feedback animation
    options = options or {}
    
    local scale_amount = options.scale or 0.95
    local duration = options.duration or (M.config.fast_duration / 2)
    local easing = options.easing or "ease-in-out"
    
    return {
        type = "click_feedback",
        widget = widget,
        scale_amount = scale_amount,
        duration = duration,
        easing = easing,
        press_animation = M.create_animation("button_press", {
            duration = duration,
            easing = easing,
            from = 1.0,
            to = scale_amount
        }),
        release_animation = M.create_animation("button_release", {
            duration = duration,
            easing = easing,
            from = scale_amount,
            to = 1.0
        })
    }
end

-- Loading and Progress Animations
function M.create_loading_spinner(size, options)
    options = options or {}
    
    return {
        type = "loading_spinner",
        size = size or dpi(20),
        color = options.color or "#ffffff",
        thickness = options.thickness or dpi(2),
        duration = options.duration or 1200, -- full rotation time
        easing = options.easing or "linear",
        segments = options.segments or 8,
        gap = options.gap or 0.2 -- gap between segments
    }
end

function M.create_progress_bar_animation(options)
    options = options or {}
    
    return {
        type = "progress_bar",
        width = options.width or dpi(200),
        height = options.height or dpi(4),
        duration = options.duration or 1000,
        easing = options.easing or "ease-in-out",
        gradient_animation = options.gradient_animation or true,
        gradient_colors = options.gradient_colors or {
            "#ff006e", "#ff6ec7", "#7b2cbfff", "#00f3ff", "#ffee00"
        },
        border_radius = options.border_radius or dpi(2)
    }
end

-- Transition Helpers for Widget State Changes
function M.create_state_transition(from_state, to_state, options)
    options = options or {}
    
    local duration = options.duration or M.config.default_duration
    local easing = options.easing or "ease-in-out"
    
    return {
        type = "state_transition",
        from_state = from_state,
        to_state = to_state,
        duration = duration,
        easing = easing,
        properties = options.properties or {}, -- list of properties to animate
        animation = M.create_animation("fade", {
            duration = duration,
            easing = easing
        })
    }
end

-- Export functions and presets
M.create_animation = M.create_animation
M.animate_property = M.animate_property
M.create_hover_effect = M.create_hover_effect
M.create_click_feedback = M.create_click_feedback
M.create_loading_spinner = M.create_loading_spinner
M.create_progress_bar_animation = M.create_progress_bar_animation
M.create_state_transition = M.create_state_transition

return M