-- MyAwesomeConfig Typography Enhancement Library
-- Provides advanced typography options, text effects, and font enhancements

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- Enhanced Font Properties
M.font_families = {
    -- UI Fonts (clean, readable)
    ui = {
        default = "JF Flat",
        bold = "JF Flat Bold",
        light = "JF Flat Light",
        medium = "JF Flat Medium"
    },
    
    -- Display Fonts (for headers, titles)
    display = {
        elegant = "Playfair Display",
        modern = "Montserrat",
        tech = "JetBrains Mono",
        creative = "Poppins",
        classic = "Libre Franklin"
    },
    
    -- Monospace Fonts (for code, terminals)
    mono = {
        default = "JetBrains Mono",
        ligatures = "Fira Code",
        retro = "IBM Plex Mono",
        clean = "Source Code Pro"
    },
    
    -- Decorative Fonts (for special elements)
    decorative = {
        script = "Pacifico",
        handwritten = "Dancing Script",
        bold = "Bangers",
        retro = "Press Start 2P"
    }
}

-- Font Weight Mapping
M.font_weights = {
    thin = 100,
    extra_light = 200,
    light = 300,
    normal = 400,
    medium = 500,
    semi_bold = 600,
    bold = 700,
    extra_bold = 800,
    black = 900
}

-- Text Effects
function M.create_text_shadow(offset_x, offset_y, blur_radius, color, intensity)
    -- offset_x, offset_y: shadow offset in pixels
    -- blur_radius: blur radius (0 for sharp shadow)
    -- color: shadow color
    -- intensity: 0.0 to 1.0
    
    return {
        type = "text_shadow",
        offset_x = offset_x or dpi(1),
        offset_y = offset_y or dpi(1),
        blur_radius = blur_radius or dpi(1),
        color = color or "#00000099",
        intensity = intensity or 0.8
    }
end

function M.create_text_outline(width, color, intensity)
    -- width: outline width in pixels
    -- color: outline color
    -- intensity: 0.0 to 1.0
    
    return {
        type = "text_outline",
        width = width or dpi(1),
        color = color or "#000000",
        intensity = intensity or 0.8
    }
end

function M.create_text_gradient(color1, color2, color3, direction)
    -- color1, color2, color3: gradient colors
    -- direction: "horizontal", "vertical", "diagonal", "radial"
    
    return {
        type = "text_gradient",
        color1 = color1 or "#ffffff",
        color2 = color2 or "#ff006e",
        color3 = color3 or "#00f3ff",
        direction = direction or "horizontal",
        smoothness = 4 -- gradient smoothness level
    }
end

function M.create_text_glow(radius, color, intensity)
    -- radius: glow radius
    -- color: glow color
    -- intensity: 0.0 to 1.0
    
    return {
        type = "text_glow",
        radius = radius or dpi(2),
        color = color or "#ffff0044",
        intensity = intensity or 0.6,
        quality = 2
    }
end

function M.create_text_stroke(width, color, intensity)
    -- Similar to outline but can be inner/outer
    
    return {
        type = "text_stroke",
        width = width or dpi(1),
        color = color or "#000000",
        intensity = intensity or 0.8,
        position = "center" -- or "inside", "outside"
    }
end

-- Advanced Typography Features
function M.create_drop_cap(lines, size, color, font)
    -- lines: how many lines the drop cap should span
    -- size: size multiplier for the drop cap
    -- color: drop cap color
    -- font: font family for drop cap
    
    return {
        type = "drop_cap",
        lines = lines or 2,
        size = size or 2.5,
        color = color or "#ff006e",
        font = font or "Playfair Display Bold",
        padding = dpi(2)
    }
end

function M.create_text_background(padding, color, radius, style)
    -- padding: internal padding
    -- color: background color
    -- radius: corner radius
    -- style: "solid", "gradient", "textured"
    
    return {
        type = "text_background",
        padding = padding or dpi(4),
        color = color or "#00000022",
        radius = radius or dpi(4),
        style = style or "solid",
        gradient = style == "gradient" and {
            color1 = "#00000022",
            color2 = "#ffffff11"
        } or nil
    }
end

function M.create_underline_thickness(thickness, color, style, offset)
    -- thickness: line thickness
    -- color: line color
    -- style: "solid", "dashed", "dotted", "double", "wave"
    -- offset: distance from text baseline
    
    return {
        type = "underline",
        thickness = thickness or dpi(1),
        color = color or "#ff006e",
        style = style or "solid",
        offset = offset or dpi(2),
        gap = style == "dashed" and dpi(2) or nil,
        dot_radius = style == "dotted" and dpi(0.5) or nil
    }
end

function M.create_strikethrough(thickness, color, style, offset)
    -- Similar to underline but for strikethrough
    
    return {
        type = "strikethrough",
        thickness = thickness or dpi(1),
        color = color or "#ff006e",
        style = style or "solid",
        offset = offset or dpi(0),
        gap = style == "dashed" and dpi(2) or nil
    }
end

-- Font Pairing Suggestions
M.font_pairs = {
    -- Header / Body combinations
    elegant = {
        header = "Playfair Display Bold",
        body = "Lato Regular",
        mono = "JetBrains Mono"
    },
    modern = {
        header = "Montserrat Bold",
        body = "Open Sans Regular",
        mono = "Fira Code"
    },
    friendly = {
        header = "Poppins Bold",
        body = "Nunito Regular",
        mono = "Source Code Pro"
    },
    classic = {
        header = "Libre Franklin Bold",
        body = "Merriweather Regular",
        mono = "IBM Plex Mono"
    },
    tech = {
        header = "JetBrains Mono Bold",
        body = "Source Sans Pro Regular",
        mono = "JetBrains Mono"
    },
    creative = {
        header = "Poppins Bold",
        body = "Quicksand Regular",
        mono = "Comic Code"
    }
}

-- Text Transformation Helpers
function M.apply_text_transform(text, transform)
    -- transform options: "uppercase", "lowercase", "capitalize", "smallcaps"
    
    if transform == "uppercase" then
        return string.upper(text)
    elseif transform == "lowercase" then
        return string.lower(text)
    elseif transform == "capitalize" then
        return string.gsub(text, "(%l)(%w*)", function(first, rest)
            return string.upper(first) .. string.lower(rest)
        end)
    elseif transform == "smallcaps" then
        -- Small caps approximation (uppercase with smaller size)
        return string.upper(text)
    else
        return text
    end
end

-- Dynamic Font Sizing
function M.create_responsive_font(base_size, min_size, max_size, breakpoints)
    -- base_size: base font size
    -- min_size: minimum font size
    -- max_size: maximum font size
    -- breakpoints: {width = size} table for responsive sizing
    
    return {
        type = "responsive_font",
        base_size = base_size or dpi(11),
        min_size = min_size or dpi(9),
        max_size = max_size or dpi(14),
        breakpoints = breakpoints or {
            [1024] = dpi(12),
            [1440] = dpi(13),
            [1920] = dpi(14)
        },
        current_size = base_size or dpi(11)
    }
end

-- Export functions and data
M.font_families = M.font_families
M.font_weights = M.font_weights
M.font_pairs = M.font_pairs
M.create_text_shadow = M.create_text_shadow
M.create_text_outline = M.create_text_outline
M.create_text_gradient = M.create_text_gradient
M.create_text_glow = M.create_text_glow
M.create_text_stroke = M.create_text_stroke
M.create_drop_cap = M.create_drop_cap
M.create_text_background = M.create_text_background
M.create_underline_thickness = M.create_underline_thickness
M.create_strikethrough = M.create_strikethrough
M.apply_text_transform = M.apply_text_transform
M.create_responsive_font = M.create_responsive_font

return M