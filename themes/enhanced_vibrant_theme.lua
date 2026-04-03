-- Enhanced Vibrant Theme for MyAwesomeConfig
-- Demonstrates usage of all enhancement libraries: gradients, decorations, animations, effects, typography, iconsets

-- Import the base beautiful library and helpers
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local shape = require("gears.shape")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gears = require("gears")

-- Import enhancement libraries
local gradients = require("themes.enhancements.gradients")
local decorations = require("themes.enhancements.decorations")
local animations = require("themes.enhancements.animations")
local effects = require("themes.enhancements.effects")
local typography = require("themes.enhancements.typography")
local iconsets = require("themes.enhancements.iconsets")

-- Import helpers and controllers (assuming they exist)
local helpers = require("themes.helpers")
local controllers = require("themes.controllers")

-- Create theme table
local theme = {}

-- -------------------------------
-- ------------ Fonts ------------
-- -------------------------------
-- Use enhanced typography
theme.font = typography.font_families.ui.default .. " 11"
theme.uifont = typography.font_families.ui.default .. " 11"
theme.font_n = typography.font_families.ui.default
theme.appname_font = typography.font_families.ui.bold .. " 12"
theme.title_font = typography.font_families.display.elegant .. " Bold 12"
theme.message_font = theme.uifont
theme.hotkeys_font = theme.uifont
theme.widget_font = theme.uifont
theme.iconfont = "Font Awesome 5 Free Solid 11"

-- Add text effects for headers
theme.title_text_effect = {
    type = "combined",
    shadow = typography.create_text_shadow(dpi(1), dpi(1), dpi(1), "#00000099", 0.8),
    outline = typography.create_text_outline(dpi(1), "#000000", 0.7)
}

-- -------------------------------
-- ------------ Colors -----------
-- -------------------------------
-- Use enhanced gradients for vibrant colors
theme.accent = gradients.vibrant_spectrum() -- Main vibrant accent

-- Create complementary colors using the gradient system
local bar_color = gradients.create_gradient {
    color1 = "#4f1745",
    color2 = "#03363d",
    from = {0, 0},
    to = {100, 100}
}

local bar_active_color = theme.accent

-- Enhanced background colors with subtle effects
theme.bg_normal = "#352558"
theme.widget_bg = "#1f1635"
theme.bg_focus = "#1f1635"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"

-- Enhanced foreground colors
theme.fg_normal = "#c8ccd4"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- Spacing and borders
theme.useless_gap = dpi(5)
theme.border_width = controllers.border_width
theme.border_normal = "#00000000"
theme.border_focus = gradients.neon_cycle() -- Animated neon border focus
theme.border_marked = "#00000000"

-- Enhanced widget colors with gradients and effects
theme.power_button_color = gradients.sunset_flare()
theme.taglist_color = gradients.pastel_dream()

-- Enhanced keyboard colors
theme.keyboard_layout_color = gradients.create_gradient {
    color1 = "#ee5161",
    color2 = "#8965ea",
    from = {80, 10},
    to = {10, 10}
}
theme.keyboard_icon_bg_color = "#a160ca"
theme.keyboard_icon_fg_color = theme.bg_normal
theme.keyboard_text_color = theme.keyboard_icon_fg_color

-- Enhanced CPU colors with gradients
theme.cpu_color = gradients.fire_embers()
theme.cpu_icon_bg_color = theme.cpu_color

-- Enhanced temperature colors
theme.cpu_temp_color = "#00000000"
theme.cpu_temp_whole_color = gradients.create_gradient {
    color1 = "#ee5161",
    color2 = "#fecca4",
    from = {50, 10},
    to = {-10, 10}
}
theme.cpu_temp_icon_bg_color = theme.cpu_temp_color
theme.cpu_temp_icon_fg_color = theme.bg_normal
theme.cpu_temp_text_color = theme.cpu_temp_icon_fg_color

-- Enhanced network speed colors
theme.net_speed_color = "#00000000"
theme.net_speed_whole_color = gradients.create_gradient {
    color1 = "#478dd7",
    color2 = "#a1ffd0",
    from = {110, 10},
    to = {-100, 10}
}
theme.net_speed_icon_bg_color = gradients.create_gradient {
    color1 = "#55aaff",
    color2 = "#366da3",
    from = {80, 10},
    to = {-30, 10}
}
theme.net_speed_icon_fg_color = theme.bg_normal
theme.net_speed_text_color = theme.net_speed_icon_fg_color

-- Enhanced brightness colors
theme.brightness_cr_color = "#00000000"
theme.brightness_cr_whole_color = gradients.create_gradient {
    color1 = "#9e4fc6",
    color2 = "#a1ffd0",
    from = {80, 5},
    to = {10, 3}
}
theme.brightness_icon_bg_color = theme.brightness_cr_color
theme.brightness_icon_fg_color = theme.bg_normal
theme.brightness_cr_text_color = theme.brightness_icon_fg_color

-- Enhanced volume widget colors
theme.volume_widget_color = "#00000000"
theme.volume_widget_whole_color = gradients.create_gradient {
    color1 = "#e5c07b",
    color2 = "#245684",
    from = {50, 10},
    to = {-10, 10}
}
theme.volume_icon_bg_color = theme.volume_widget_color
theme.volume_icon_fg_color = theme.bg_normal
theme.volume_widget_text_color = theme.volume_icon_fg_color

-- Enhanced battery colors with gradient
theme.battery_color = "#00000000"
theme.battery_whole_color = gradients.create_gradient {
    color1 = "#3498fd",
    color2 = "#393c89",
    from = {50, 0},
    to = {0, 50}
}
theme.battery_icon_bg_color = theme.battery_color
theme.battery_icon_fg_color = theme.bg_normal
theme.battery_text_color = theme.battery_icon_fg_color
theme.battery_hover_color = gradients.create_gradient {
    color1 = "#446a95",
    color2 = "#944688",
    from = {50, 10},
    to = {0, 10}
}

-- Enhanced weather colors with multiple gradients
theme.weather_color = "#00000000"
theme.weather_color_whole_color = gradients.create_gradient {
    color1 = "#71f1e8",
    color2 = "#b461bb",
    from = {180, 10},
    to = {-60, 10}
}
theme.weather_cold_color = gradients.create_gradient {
    color1 = "#71f1e8",
    color2 = "#b461bb",
    from = {180, 10},
    to = {-30, 10}
}
theme.weather_nice_color = gradients.create_gradient {
    color1 = "#ffc9a0",
    color2 = "#00ffed",
    from = {180, 10},
    to = {-30, 10}
}
theme.weather_hot_color = gradients.create_gradient {
    color1 = "#ffcda5",
    color2 = "#ae4a9e",
    from = {180, 10},
    to = {-30, 10}
}
theme.weather_widget_bg_color = theme.weather_color_whole_color
theme.weather_widget_text_color = theme.bg_normal
theme.weather_icon_bg_color = theme.weather_color
theme.weather_icon_fg_color = theme.bg_normal
theme.weather_text_color = theme.weather_icon_fg_color

-- Enhanced prayer times colors
theme.prayer_times_color = gradients.create_gradient {
    color1 = "#1ad6fd",
    color2 = "#a938a6",
    from = {100, 0},
    to = {-100, 00}
}
theme.prayer_times_icon_bg_color = "#1ad6fd"
theme.prayer_times_icon_fg_color = theme.widget_bg
theme.prayer_times_text_color = theme.widget_bg
theme.prayer_times_inner_bg_color = theme.prayer_times_color
theme.prayer_times_inner_text_color = theme.widget_bg

-- Enhanced clock colors
theme.clock_color = theme.accent
theme.clock_whole_color = theme.clock_color
theme.clock_icon_bg_color = gradients.create_gradient {
    color2 = "#d13db8",
    color1 = "#ff4be1",
    from = {50, 0},
    to = {-10, 0}
}
theme.clock_icon_fg_color = theme.bg_normal
theme.clock_text_color = theme.clock_icon_fg_color

-- Enhanced dashboard colors
theme.dashboard_box_bg = theme.widget_bg
theme.dashboard_box_fg = theme.fg_normal
theme.xcolor2 = theme.fg_normal
theme.xforeground = theme.fg_normal

-- Enhanced tooltip colors
theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

-- Allow desktop music widget
theme.color_theme = true

-- -------------------------------
-- ------------ Taglist -----------
-- -------------------------------
theme.taglist_fg_focus = gradients.neon_cycle() -- Use animated neon for focus
theme.taglist_bg_focus = theme.widget_bg

theme.taglist_fg_urgent = "#e06c75"
theme.taglist_bg_urgent = theme.widget_bg

theme.taglist_fg_occupied = "#3497fb"
theme.taglist_bg_occupied = theme.widget_bg

theme.taglist_fg_empty = "#545862"
theme.taglist_bg_empty = theme.widget_bg

-- Enhanced taglist shape with fancy corners
theme.taglist_shape = decorations.create_fancy_corners(dpi(3), "mixed")
theme.taglist_font = theme.iconfont

-- Sys tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = controllers.systray_icon_spacing
theme.systray_max_rows = controllers.systray_max_rows

-- Panal
theme.panal_hight = controllers.panal_hight
theme.panal_border_width = controllers.panal_border_width

-- Enhanced border radius for groups
theme.groups_radius = controllers.groups_radius

-- Control Panal
theme.control_panal_hight = controllers.control_panal_hight
theme.control_border_width = controllers.control_border_width
theme.control_border_color = theme.border_focus

-- Enhanced slider borders
theme.slider_inner_border_color = theme.border_focus
theme.slider_inner_border_width = controllers.slider_inner_border_width

-- Enhanced groups background
theme.groups_title_bg = theme.widget_bg
theme.groups_bg = theme.widget_bg
theme.background = theme.bg_normal

theme.transparent = "#00000000"

theme.media_button_color = theme.accent

-- Enhanced widget decorations
theme.widgets_corner_radius = theme.groups_radius

-- Enhanced volume and brightness bars in notifications
theme.bar_active_color = gradients.neon_cycle() -- Animated gradient
theme.bar_color = "#4f1745"
theme.bar_handle_color = theme.accent
theme.bar_handle_border_color = theme.accent
theme.bar_height = controllers.bar_height
theme.bar_handle_width = controllers.bar_handle_width
theme.bar_handle_border_width = controllers.bar_handle_border_width
theme.bar_shape = controllers.bar_shape

-- Enhanced sliders for CPU/RAM in notifications
theme.slider_color = gradients.neon_cycle() -- Animated gradient
theme.slider_background_color = "#4f1745"
theme.slider_forced_height = controllers.slider_forced_height
theme.slider_shape = controllers.slider_shape
theme.slider_bar_shape = controllers.slider_bar_shape

-- Enhanced Volume & Brightness widget
theme.vol_bar_active_color = gradients.neon_cycle() -- Animated gradient
theme.vol_bar_color = "#4f1745"
theme.vol_handle_color = theme.accent
theme.vol_handle_border_color = theme.accent
theme.vol_bar_height = controllers.vol_bar_height
theme.vol_handle_width = controllers.vol_handle_width
theme.vol_handle_border_width = controllers.vol_handle_border_width
theme.vol_bar_shape = theme.bar_shape

-- Enhanced OSD dimensions
theme.osd_height = controllers.osd_height
theme.osd_width = controllers.osd_width
theme.osd_margin = controllers.osd_margin
theme.osd_handle_shape = controllers.osd_handle_shape

-- Enhanced widget height
theme.widget_height = controllers.widget_height

-- Generate taglist squares:
local taglist_square_size = controllers.taglist_square_size

-- Enhanced decorations for UI elements
theme.client_shape_rectangle = controllers.client_shape_rectangle
theme.client_shape_rounded = decorations.create_fancy_corners(dpi(4), "mixed")

theme.power_button_shape = decorations.create_fancy_corners(dpi(4), "ornamental")

-- Variables set for theming notifications:
theme.notification_title_margin = controllers.notification_title_margin
theme.notification_body_left_margin = controllers.notification_body_left_margin
theme.notification_body_right_margin = controllers.notification_body_right_margin
theme.notification_body_top_margin = controllers.notification_body_top_margin
theme.notification_body_bottom_margin = controllers.notification_body_bottom_margin
theme.notification_body_margins = controllers.notification_body_margins

-- Enhanced notification styling with effects
theme.critical_notification_bg = "#ff5558"
theme.critical_notification_fg = "#011426"

-- Enhanced notification background with glassmorphism effect
theme.notification_bg = effects.create_glassmorphism(0.25, "#ffffff44")

-- Enhanced notification borders
theme.notification_border_focus = theme.border_focus
theme.osd_border_width = controllers.osd_border_width
theme.notification_spacing = controllers.notification_spacing

theme.center_notification_border_focus = theme.border_focus
theme.center_notification_border_width = controllers.center_notification_border_width

-- Enhanced lockscreen background with effects
theme.lock_bg = theme.bg_normal .. "77"

-- Enhanced power button background
theme.power_button_bg = theme.widget_bg .. "aa"

-- Enhanced header backgrounds
theme.header_bg = theme.widget_bg
theme.inner_bg = theme.widget_bg

theme.notification_center_header_bg = theme.header_bg
theme.notification_center_inner_bg = theme.inner_bg

-- Menu styling
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = controllers.menu_height
theme.menu_width = controllers.menu_width

-- Enhanced layout icons with potential for decorative versions
theme.layout_fairh = "~/.config/awesome/themes/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/layouts/fairvw.png"
theme.layout_floating = "~/.config/awesome/themes/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/layouts/tilebottomw.png"
theme.layout_tileleft = "~/.config/awesome/themes/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/layouts/tiletopw.png"
theme.layout_spiral = "~/.config/awesome/themes/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/layouts/dwindlew.png"
theme.layout_cornernw = "~/.config/awesome/themes/layouts/cornernww.png"
theme.layout_cornerne = "~/.config/awesome/themes/layouts/cornernew.png"
theme.layout_cornersw = "~/.config/awesome/themes/layouts/cornersww.png"
theme.layout_cornerse = "~/.config/awesome/themes/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Enhanced wallpaper with potential for effects
theme.wallpaper = "~/.config/awesome/themes/wallpapers/zdtvq4gd6wc91.png"

theme.music_back = "~/.config/awesome/themes/assets/no_music.png"

-- Define the icon theme for application icons
theme.icon_theme = nil
theme.icons = require("themes.icons-colors")
theme.dynamic_wallpaper_dir = "themes/wallpapers//"
theme.conky_script = "/themes/conky/conky-colors.sh"

-- Enhanced KDE/Qt integration
theme.kvantum_theme = "a-color" -- Could be enhanced to use gradients
theme.konsole_profile = "--profile Aesthetic"
theme.qt_icon_theme = "NeonIcons"
theme.qt_style_theme = "Breeze"--"kvantum"

# Enhanced GTK theme
theme.gtk_theme = "Kimi-dark" --"Kimi"

# Enhanced plasma cursors and colors
theme.plasma_cursors = "GoogleDot-Black"
theme.plasma_color = "AColors"

# Enhanced animations for UI interactions (conceptual - would need integration)
# These would be used in widget creation to add smooth transitions
theme.ui_animations = {
    button_press = animations.presets.button_press,
    button_release = animations.presets.button_release,
    widget_appear = animations.presets.fade,
    widget_disappear = animations.create_animation("fade", {
        duration = 150,
        easing = "ease-in",
        from = 1,
        to = 0
    }),
    popup_slide_in = animations.presets.slide_in,
    popup_slide_out = animations.presets.slide_out,
    menu_appear = animations.presets.menu_fade_in,
    menu_disappear = animations.create_animation("fade", {
        duration = 200,
        easing = "ease-in",
        from = 1,
        to = 0
    })
}

# Enhanced effects for UI elements (conceptual - would need integration)
# These demonstrate how effects could be applied to various UI elements
theme.ui_effects = {
    notification_bg = effects.create_glassmorphism(0.2, "#ffffff33"),
    popup_bg = effects.create_frosted_glass(0.15, "#ffffff22"),
    panel_bg = effects.create_background_blur(4, "#00000011"),
    widget_bg = effects.create_subtle_noise(0.05),
    button_hover = effects.create_inner_glow(dpi(2), "#ffffff33", 0.4),
    active_widget = effects.create_outer_glow(dpi(3), "#00f3ff44", 0.6),
    warning_indicator = effects.create_neon_glow(dpi(4), "#ff006e", 0.8, true)
}

# Enhanced icon styling (conceptual - would need integration in widget creation)
theme.icon_enhancements = {
    default_style = "filled",
    default_state = "default",
    use_state_colors = true,
    use_style_variants = true,
    # Example of how icons could be enhanced:
    # volume_up = iconsets.enhance_icon("volume-up", "filled", "active", theme),
    # battery_charging = iconsets.enhance_icon("battery", "dual", "charging", theme),
    # wifi_strong = iconsets.enhance_icon("wifi", "outline", "default", theme)
}

# Enhanced typography usage (conceptual - would need integration in text widgets)
theme.text_enhancements = {
    title_effect = typography.create_text_shadow(dpi(1), dpi(1), dpi(1), "#00000099", 0.8),
    subtitle_effect = typography.create_text_outline(dpi(1), "#000000", 0.5),
    body_effect = typography.create_text_gradient("#ffffff", "#ff006e", "#00f3ff", "horizontal"),
    notification_title = {
        font = typography.font_families.display.elegant .. " Bold 13",
        effect = typography.create_text_shadow(dpi(1), dpi(1), dpi(1), "#00000099", 0.7)
    }
}

return theme