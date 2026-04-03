-- MyAwesomeConfig Visual Effects Enhancement Library
-- Provides blur, noise, lighting, and other visual effects for enhanced styling

local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- Blur and Glass Effects
function M.create_frosted_glass(intensity, color)
    -- intensity: 0.0 to 1.0 (how strong the blur/frost effect)
    -- color: base color for the glass effect
    
    return {
        type = "frosted_glass",
        intensity = intensity or 0.3,
        base_color = color or "#ffffff33", -- semi-transparent white by default
        blur_radius = math.floor(intensity * 10),
        noise_level = intensity * 0.1
    }
end

function M.create_background_blur(radius, color)
    -- radius: blur radius in pixels
    -- color: overlay color tint
    
    return {
        type = "background_blur",
        radius = radius or 5,
        overlay_color = color or "#00000011",
        noise_level = 0.05
    }
end

function M.create_glassmorphism(intensity, color)
    -- Modern glassmorphism effect
    
    return {
        type = "glassmorphism",
        intensity = intensity or 0.25,
        base_color = color or "#ffffff44",
        blur_radius = math.floor(intensity * 12),
        border_width = dpi(1),
        border_color = gears.color.ensure_hex_color(color or "#ffffff44"):lighten(0.3),
        shadow = {
            enabled = true,
            radius = dpi(4),
            offset_x = dpi(0),
            offset_y = dpi(2),
            color = "#00000022"
        }
    }
end

-- Noise and Texture Effects
function M.create_subtle_noise(intensity, color1, color2)
    -- intensity: 0.0 to 1.0
    -- color1, color2: noise colors (will be blended)
    
    return {
        type = "subtle_noise",
        intensity = intensity or 0.08,
        color1 = color1 or "#ffffff11",
        color2 = color2 or "#00000011",
        size = dpi(4), -- noise pattern size
        animation = {
            enabled = false, -- could animate noise for TV-static effect
            speed = 0.5
        }
    }
end

function M.create_linen_texture(intensity, color, direction)
    -- intensity: how strong the linen effect
    -- color: base color
    -- direction: "horizontal", "vertical", "both"
    
    return {
        type = "linen_texture",
        intensity = intensity or 0.1,
        base_color = color or "#ffffff",
        line_width = dpi(math.max(1, intensity * 3)),
        line_color = gears.color.ensure_hex_color(color or "#ffffff"):darken(0.1),
        direction = direction or "both",
        spacing = dpi(4)
    }
end

function M.create_paper_texture(intensity, fleck_density)
    -- intensity: overall texture strength
    -- fleck_density: how many flecks per area
    
    return {
        type = "paper_texture",
        intensity = intensity or 0.15,
        fleck_density = fleck_density or 0.02,
        fleck_size = dpi(math.max(1, intensity * 4)),
        fleck_color = "#00000008", -- subtle dark flecks
        background_fleck_color = "#ffffff08" -- subtle light flecks
    }
end

-- Lighting and Glow Effects
function M.create_inner_glow(radius, color, intensity)
    -- radius: glow radius
    -- color: glow color
    -- intensity: 0.0 to 1.0
    
    return {
        type = "inner_glow",
        radius = radius or dpi(4),
        color = color or "#ffffff44",
        intensity = intensity or 0.6,
        quality = 2 -- number of blur passes for smoothness
    }
end

function M.create_outer_glow(radius, color, intensity)
    -- radius: glow radius
    -- color: glow color
    -- intensity: 0.0 to 1.0
    
    return {
        type = "outer_glow",
        radius = radius or dpi(4),
        color = color or "#ffffff44",
        intensity = intensity or 0.6,
        quality = 2
    }
end

function M.create_neon_glow(radius, color, intensity, flicker)
    -- radius: glow radius
    -- color: neon color
    -- intensity: 0.0 to 1.0
    -- flicker: whether to add subtle flicker animation
    
    local glow = {
        type = "neon_glow",
        radius = radius or dpi(6),
        color = color or "#00f3ff",
        intensity = intensity or 0.8,
        quality = 3
    }
    
    if flicker then
        glow.flicker = {
            enabled = true,
            speed = 0.3, -- flicker speed
            amount = 0.1 -- how much intensity varies
        }
    end
    
    return glow
end

function M.create_lens_flare(intensity, color, position)
    -- intensity: flare strength
    -- color: flare color
    -- position: where flare appears (for future implementation)
    
    return {
        type = "lens_flare",
        intensity = intensity or 0.2,
        color = color or "#ffffff",
        size = dpi(20),
        position = position or {0, 0}, -- x, y offset
        rays = 8,
        ray_length = dpi(15),
        ray_width = dpi(2)
    }
end

-- Shadow and Depth Effects
function M.create_drop_shadow(radius, offset_x, offset_y, color, intensity)
    -- radius: blur radius of shadow
    -- offset_x, offset_y: shadow offset
    -- color: shadow color
    -- intensity: 0.0 to 1.0
    
    return {
        type = "drop_shadow",
        radius = radius or dpi(4),
        offset_x = offset_x or dpi(2),
        offset_y = offset_y or dpi(2),
        color = color or "#00000044",
        intensity = intensity or 0.8
    }
end

function M.create_inner_shadow(radius, offset_x, offset_y, color, intensity)
    -- Similar to drop shadow but inset
    
    return {
        type = "inner_shadow",
        radius = radius or dpi(4),
        offset_x = offset_x or dpi(2),
        offset_y = offset_y or dpi(2),
        color = color or "#00000044",
        intensity = intensity or 0.6
    }
end

function M.create_elevation(level)
    -- Material design-style elevation (0-5)
    -- Returns appropriate shadow for the elevation level
    
    local elevations = {
        [0] = { radius = 0, offset_x = 0, offset_y = 0, color = "#00000000", intensity = 0 },
        [1] = { radius = dpi(1), offset_x = 0, offset_y = dpi(1), color = "#0000001a", intensity = 0.6 },
        [2] = { radius = dpi(2), offset_x = 0, offset_y = dpi(2), color = "#00000014", intensity = 0.6 },
        [3] = { radius = dpi(4), offset_x = 0, offset_y = dpi(4), color = "#0000001a", intensity = 0.6 },
        [4] = { radius = dpi(6), offset_x = 0, offset_y = dpi(6), color = "#0000001a", intensity = 0.6 },
        [5] = { radius = dpi(8), offset_x = 0, offset_y = dpi(8), color = "#0000001a", intensity = 0.6 }
    }
    
    local level_data = elevations[level] or elevations[0]
    return {
        type = "drop_shadow",
        radius = level_data.radius,
        offset_x = level_data.offset_x,
        offset_y = level_data.offset_y,
        color = level_data.color,
        intensity = level_data.intensity
    }
end

-- Material and Surface Effects
function M.create_metallic_sheen(intensity, color, direction)
    -- intensity: sheen strength
    -- color: base metal color
    -- direction: "top", "bottom", "left", "right", "radial"
    
    return {
        type = "metallic_sheen",
        intensity = intensity or 0.15,
        base_color = color or "#cccccc",
        direction = direction or "top",
        gradient_size = dpi(4),
        highlight_color = gears.color.ensure_hex_color(color or "#cccccc"):lighten(0.3),
        shadow_color = gears.color.ensure_hex_color(color or "#cccccc"):darken(0.2)
    }
end

function M.create_pearlescent(intensity, base_color, shift_color)
    -- intensity: effect strength
    -- base_color: main color
    -- shift_color: color that appears at angles
    
    return {
        type = "pearlescent",
        intensity = intensity or 0.2,
        base_color = base_color or "#ffffff",
        shift_color = shift_color or "#ff006e",
        shift_angle = 45, -- degrees
        falloff = 0.3 -- how quickly the shift fades
    }
end

-- Performance-conscious effect presets
M.presets = {
    -- Light effects for widgets that update frequently
    widget_subtle = {
        type = "frosted_glass",
        intensity = 0.1,
        base_color = "#ffffff11"
    },
    
    -- Medium effects for panels and popups
    panel_medium = {
        type = "glassmorphism",
        intensity = 0.2,
        base_color = "#ffffff33"
    },
    
    -- Rich effects for static backgrounds and special widgets
    background_rich = {
        type = "glassmorphism",
        intensity = 0.35,
        base_color = "#ffffff44",
        blur_radius = 8
    },
    
    -- Minimal effects for low-power devices
    performance_minimal = {
        type = "subtle_noise",
        intensity = 0.02
    }
}

-- Export functions and presets
M.create_frosted_glass = M.create_frosted_glass
M.create_background_blur = M.create_background_blur
M.create_glassmorphism = M.create_glassmorphism
M.create_subtle_noise = M.create_subtle_noise
M.create_linen_texture = M.create_linen_texture
M.create_paper_texture = M.create_paper_texture
M.create_inner_glow = M.create_inner_glow
M.create_outer_glow = M.create_outer_glow
M.create_neon_glow = M.create_neon_glow
M.create_lens_flare = M.create_lens_flare
M.create_drop_shadow = M.create_drop_shadow
M.create_inner_shadow = M.create_inner_shadow
M.create_elevation = M.create_elevation
M.create_metallic_sheen = M.create_metallic_sheen
M.create_pearlescent = M.create_pearlescent
M.presets = M.presets

return M