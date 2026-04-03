#!/bin/bash
# MyAwesomeConfig Configuration Wizard
# Helps users set up environment variables and basic preferences

set -e

echo "=== MyAwesomeConfig Configuration Wizard ==="
echo "This wizard will help you set up essential configuration options"
echo ""

# Detect shell
SHELL_NAME=$(basename "$SHELL")
RC_FILE="$HOME/.bashrc"
if [[ "$SHELL_NAME" == "zsh" ]]; then
    RC_FILE="$HOME/.zshrc"
elif [[ "$SHELL_NAME" == "fish" ]]; then
    RC_FILE="$HOME/.config/fish/config.fish"
fi

echo "Detected shell: $SHELL_NAME"
echo "Configuration will be added to: $RC_FILE"
echo ""

# Function to add environment variable to shell rc
add_env_var() {
    local var_name="$1"
    local var_value="$2"
    local comment="$3"
    
    if [[ "$SHELL_NAME" == "fish" ]]; then
        # For fish shell
        if ! grep -q "set -x $var_name" "$RC_FILE"; then
            echo -e "\n# $comment" >> "$RC_FILE"
            echo "set -x $var_name '$var_value'" >> "$RC_FILE"
        fi
    else
        # For bash/zsh
        if ! grep -q "export $var_name=" "$RC_FILE"; then
            echo -e "\n# $comment" >> "$RC_FILE"
            echo "export $var_name='$var_value'" >> "$RC_FILE"
        fi
    fi
}

# Ask for OpenWeatherMap API key
echo "=== Weather Configuration ==="
echo "To use the weather widgets, you need an OpenWeatherMap API key."
echo "Get one for free at: https://openweathermap.org/api"
read -p "Enter your OpenWeatherMap API key (or leave blank to skip): " OW_API_KEY

if [ -n "$OW_API_KEY" ]; then
    add_env_var "OPENWEATHER_API_KEY" "$OW_API_KEY" "OpenWeatherMap API Key for weather widgets"
    echo "✓ OpenWeatherMap API key saved"
else
    echo "⚠ Skipping OpenWeatherMap API key configuration"
fi
echo ""

# Ask for lockscreen fallback password
echo "=== Lockscreen Configuration ==="
echo "Set a fallback password for the lockscreen (used when PAM is not available)"
read -p "Enter lockscreen fallback password (or leave blank to disable): " LS_PASSWORD

if [ -n "$LS_PASSWORD" ]; then
    add_env_var "LOCKSCREEN_FALLBACK_PASSWORD" "$LS_PASSWORD" "Lockscreen fallback password"
    echo "✓ Lockscreen fallback password set"
else
    echo "✓ Lockscreen fallback password disabled (no password required)"
fi
echo ""

# Ask for preferred theme
echo "=== Theme Selection ==="
echo "Available themes: batman, blue, circles, colors, dark, islamic, light, win20, cosmic"
CURRENT_THEME=$(ls -la "$HOME/.config/awesome/themes/" 2>/dev/null | grep "_theme.lua" | head -1 | sed 's/_theme.lua//' | sed 's/.* //' || echo "colors")
echo "Current theme appears to be: $CURRENT_THEME"
read -p "Enter preferred theme name (or leave blank to keep current): " PREF_THEME

if [ -n "$PREF_THEME" ]; then
    # Create a simple theme selector widget config or just note it
    echo "✓ Theme preference noted: $PREF_THEME"
    echo "  To change theme manually, edit ~/.config/awesome/configuration/config.lua"
    echo "  or use the theme switcher widget in your AwesomeWM menu"
else
    echo "✓ Keeping current theme: $CURRENT_THEME"
fi
echo ""

# Ask for interface names (for network widget)
echo "=== Network Configuration ==="
echo "To properly display network information, we need your interface names."
echo "Common names: wlp2s0, wlan0 (wireless); enp3s0, eth0 (wired)"
echo "Run 'ip link show' to see your interfaces"
read -p "Enter wireless interface name (or leave blank for auto-detection): " WIRELESS_IF
read -p "Enter wired interface name (or leave blank for auto-detection): " WIRED_IF

# Update config.lua with interface names if provided
CONFIG_FILE="$HOME/.config/awesome/configuration/config.lua"
if [ -f "$CONFIG_FILE" ]; then
    if [ -n "$WIRELESS_IF" ]; then
        sed -i "s/wireless_interface = \".*\"/wireless_interface = \"$WIRELESS_IF\"/" "$CONFIG_FILE"
        echo "✓ Wireless interface set to: $WIRELESS_IF"
    fi
    if [ -n "$WIRED_IF" ]; then
        sed -i "s/wired_interface = \".*\"/wired_interface = \"$WIRED_IF\"/" "$CONFIG_FILE"
        echo "✓ Wired interface set to: $WIRED_IF"
    fi
else
    echo "⚠ Could not find config.lua to update interface names"
fi
echo ""

# Summary
echo "=== Configuration Summary ==="
echo "Shell: $SHELL_NAME"
echo "RC file: $RC_FILE"
[ -n "$OW_API_KEY" ] && echo "✓ OpenWeatherMap API key: configured" || echo "⚠ OpenWeatherMap API key: not set"
[ -n "$LS_PASSWORD" ] && echo "✓ Lockscreen password: set" || echo "✓ Lockscreen password: disabled"
[ -n "$PREF_THEME" ] && echo "✓ Preferred theme: $PREF_THEME" || echo "✓ Theme: unchanged"
[ -n "$WIRELESS_IF" ] && echo "✓ Wireless interface: $WIRELESS_IF" || echo "⚠ Wireless interface: auto-detect"
[ -n "$WIRED_IF" ] && echo "✓ Wired interface: $WIRED_IF" || echo "⚠ Wired interface: auto-detect"
echo ""
echo "Next steps:"
echo "1. Source your shell config to apply environment variables:"
echo "   source $RC_FILE"
echo "2. Restart AwesomeWM (Mod+Shift+r or awesome.restart())"
echo "3. Verify widgets are working correctly"
echo ""
echo "Configuration wizard complete!"