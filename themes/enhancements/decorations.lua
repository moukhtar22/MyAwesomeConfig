-- MyAwesomeConfig Decoration Enhancement Library
-- Provides decorative elements, borders, and visual flourishes for enhanced styling

local gears = require("gears")
local shape = require("gears.shape")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- Enhanced Border Styles
function M.create_fancy_border(width, color1, color2, style)
    -- Returns a border specification for use in beautiful theme
    -- style options: "gradient", "dashed", "dotted", "double", "ornamental"
    
    if style == "gradient" then
        -- This would need to be implemented in the actual widget drawing
        -- For now, return a structure that themes can interpret
        return {
            width = width,
            color = color1,
            gradient_color = color2,
            style = style
        }
    elseif style == "dashed" then
        return {
            width = width,
            color = color1,
            style = style,
            dash_length = width * 2,
            gap_length = width
        }
    elseif style == "dotted" then
        return {
            width = width,
            color = color1,
            style = style,
            dot_radius = width / 2,
            dot_spacing = width * 1.5
        }
    else
        -- Default solid border
        return {
            width = width,
            color = color1,
            style = "solid"
        }
    end
end

-- Enhanced Corner Styles
function M.create_fancy_corners(radius, style)
    -- style options: "rounded", "mixed", "ornamental", "inverted", "cut"
    
    if style == "mixed" then
        -- Different radius for each corner: top-left, top-right, bottom-right, bottom-left
        return {
            top_left = radius,
            top_right = radius * 0.5,
            bottom_right = radius * 1.5,
            bottom_left = radius
        }
    elseif style == "ornamental" then
        return {
            style = style,
            radius = radius,
            ornament_size = radius * 0.3,
            ornament_type = "floral" -- or "geometric"
        }
    elseif style == "inverted" then
        return {
            style = style,
            radius = radius,
            invert = true
        }
    elseif style == "cut" then
        return {
            style = style,
            radius = radius,
            cut_size = radius * 0.4
        }
    else
        -- Default uniform radius
        return {
            top_left = radius,
            top_right = radius,
            bottom_right = radius,
            bottom_left = radius
        }
    end
end

-- Decorative Separators
function M.create_separator(length, thickness, style, color)
    -- style options: "solid", "dashed", "dotted", "gradient", "ornamental", "double"
    
    local sep = {
        type = "separator",
        length = length,
        thickness = thickness,
        color = color,
        style = style
    }
    
    if style == "gradient" then
        sep.gradient = true
        sep.color2 = gears.color.ensure_hex_color(color):lighten(0.3) or "#ffffff"
    elseif style == "dashed" then
        sep.dash_length = thickness * 3
        sep.gap_length = thickness * 2
    elseif style == "dotted" then
        sep.dot_radius = thickness / 2
        sep.dot_spacing = thickness * 1.5
    elseif style == "double" then
        sep.double_gap = thickness
        sep.thickness2 = thickness * 0.6
    elseif style == "ornamental" then
        sep.ornament_size = thickness * 2
        sep.ornament_spacing = length / 5
        sep.ornament_type = "geometric" -- or "floral", "minimal"
    end
    
    return sep
end

-- Ornamental Elements
function M.create_corner_flourish(size, style, color)
    -- style options: "floral", "geometric", "minimal", "artistic"
    
    return {
        type = "corner_flourish",
        size = size,
        style = style,
        color = color,
        complexity = style == "artistic" and 3 or 1
    }
end

function M.create_decorative_bullet(size, style, color1, color2)
    -- For use in lists, menus, etc.
    
    return {
        type = "decorative_bullet",
        size = size,
        style = style, -- "circle", "diamond", "star", "ornamental"
        primary_color = color1,
        secondary_color = color2 or color1,
        rotation = style == "dynamic" and true or false
    }
end

-- Background Enhancements
function M.create_textured_background(base_color, texture_type, intensity)
    -- texture_type options: "subtle_noise", "linen", "paper", "metal", "subtle_gradient"
    
    local bg = {
        type = "textured_background",
        base_color = base_color,
        texture = texture_type,
        intensity = intensity or 0.1 -- subtle by default
    }
    
    if texture_type == "subtle_noise" then
        bg.noise_level = intensity
        bg.noise_color = gears.color.ensure_hex_color(base_color):darken(0.1)
    elseif texture_type == "linen" then
        bg.line_width = intensity * 2
        bg.line_color = gears.color.ensure_hex_color(base_color):lighten(0.05)
    elseif texture_type == "paper" then
        bg.fleck_size = intensity * 3
        bg.fleck_count = math.ceil(5 * intensity * 10)
    elseif texture_type == "subtle_gradient" then
        bg.gradient_color = gears.color.ensure_hex_color(base_color):lighten(0.2)
        bg.gradient_angle = 45
    end
    
    return bg
end

-- Frame and Container Enhancements
function M.create_fancy_frame(width, color, radius, style)
    -- style options: "simple", "double", "ornamental", "inset", "outset"
    
    local frame = {
        type = "fancy_frame",
        width = width,
        color = color,
        radius = radius,
        style = style
    }
    
    if style == "double" then
        frame.inner_width = width * 0.6
        frame.inner_color = gears.color.ensure_hex_color(color):lighten(0.2)
        frame.gap = width * 0.2
    elseif style == "ornamental" then
        frame.ornament_size = width * 1.5
        frame.ornament_spacing = width * 3
        frame.ornament_type = "geometric"
    elseif style == "inset" then
        frame.depth = width * 0.5
        frame.shadow_color = "#00000040"
    elseif style == "outset" then
        frame.elevation = width * 0.7
        frame.highlight_color = gears.color.ensure_hex_color(color):lighten(0.3)
    end
    
    return frame
end

-- Export functions
return M