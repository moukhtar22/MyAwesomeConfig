-- MyAwesomeConfig Gradient Enhancement Library
-- Provides vibrant, modern gradient combinations for enhanced visual appeal

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- Helper to create gradient colors (matches existing theme pattern)
function M.create_gradient(params)
    -- params should contain: color1, color2, color3 (optional), from, to, stops1, stops2
    local result = ""
    
    if params.color3 then
        result = string.format(
            "linear_gradient: %d,%d %d,%d %d %s %d %s %d %s",
            params.from[1], params.from[2], 
            params.to[1], params.to[2],
            params.stops1 or 0, params.color1,
            (params.stops2 or 0.5), params.color2,
            params.stops3 or 1.0, params.color3
        )
    else
        result = string.format(
            "linear_gradient: %d,%d %d,%d %d %s %d %s",
            params.from[1], params.from[2], 
            params.to[1], params.to[2],
            params.stops1 or 0, params.color1,
            params.stops2 or 1.0, params.color2
        )
    end
    
    return result
end

-- Vibrant Modern Gradients
function M.vibrant_spectrum()
    return M.create_gradient {
        color1 = "#ff006e",
        color2 = "#ff6ec7", 
        color3 = "#7b2cbfff",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.neon_cycle()
    return M.create_gradient {
        color1 = "#00f3ff",
        color2 = "#ff006e",
        color3 = "#ffee00",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.pastel_dream()
    return M.create_gradient {
        color1 = "#fdcb6e",
        color2 = "#e17055",
        color3 = "#6c5ce7",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.ocean_depths()
    return M.create_gradient {
        color1 = "#a8edea",
        color2 = "#fed6e3",
        color3 = "#d4a5d4",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.sunset_flare()
    return M.create_gradient {
        color1 = "#ff9a9e",
        color2 = "#fad0c4",
        color3 = "#fbc2eb",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.galaxy_swirl()
    return M.create_gradient {
        color1 = "#2c3e50",
        color2 = "#4ca1af",
        color3 = "#a8c0ff",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.fire_embers()
    return M.create_gradient {
        color1 = "#ff7e5f",
        color2 = "#feb47b",
        color3 = "#ff9a9e",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.forest_mist()
    return M.create_gradient {
        color1 = "#a8edea",
        color2 = "#fed6e3",
        color3 = "#d4a5d4",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.candy_dreams()
    return M.create_gradient {
        color1 = "#fbc2eb",
        color2 = "#a6c1ee",
        color3 = "#fbc2eb",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

-- Subtle/Sophisticated Gradients
function M.elegant_monochrome()
    return M.create_gradient {
        color1 = "#2c3e50",
        color2 = "#4a6fa5",
        color3 = "#6c8ebf",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

function M.corporate_slate()
    return M.create_gradient {
        color1 = "#34495e",
        color2 = "#2c3e50",
        color3 = "#1abc9c",
        from = {0, 0},
        to = {100, 100},
        stops1 = 0,
        stops2 = 0.5,
        stops3 = 1.0
    }
end

-- Animated Gradient Concepts (for future implementation)
-- These would require animation framework integration
M.animated_gradients = {
    spectrum_cycle = {
        colors = {"#ff006e", "#ff6ec7", "#7b2cbfff", "#00f3ff", "#ffee00"},
        duration = 8000, -- 8 seconds
        easing = "linear"
    },
    pulse_warm = {
        colors = {"#ff7e5f", "#feb47b", "#ff9a9e"},
        duration = 3000,
        easing = "ease-in-out"
    }
}

-- Export functions
return M