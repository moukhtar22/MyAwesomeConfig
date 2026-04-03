#!/bin/bash
# MyAwesomeConfig Installation Script
# Automates the installation and setup process

set -e  # Exit on any error

echo "=== MyAwesomeConfig Installation Script ==="
echo "This script will automate the installation of MyAwesomeConfig"
echo ""

# Check if running as root (we don't want to run the whole script as root)
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script as root. It will use sudo when needed."
    exit 1
fi

# Detect distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VERSION=$VERSION_ID
else
    echo "Cannot detect OS distribution. Assuming Arch-based."
    OS="Arch Linux"
fi

echo "Detected OS: $OS"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies based on distribution
install_dependencies() {
    echo "Checking and installing dependencies..."
    
    if command_exists yay; then
        # Arch-based with yay
        echo "Installing dependencies using yay (AUR helper)..."
        yay -S --needed base-devel clementine brightnessctl light gimp \
            network-manager-applet telegram-desktop awesome-git rofi \
            xorg-xbacklight xorg-xrandr redshift qt5-gsettings lxappearance \
            konsole xfce4-power-manager xfce4-screensaver blueman \
            xorg-setxkbmap picom-git ark dolphin ffmpegthumbs playerctl \
            lightly-qt kvantum polkit-kde-agent ttf-font-awesome-5 conky-lua \
            jq xcolor light-git xclip gufw qt5ct xfce4-clipman tar curl
    elif command_exists pacman; then
        # Arch-based without yay (using pacman and makepkg)
        echo "Installing dependencies using pacman..."
        sudo pacman -S --needed base-devel clementine brightnessctl light gimp \
            network-manager-applet telegram-desktop awesome-git rofi \
            xorg-xbacklight xorg-xrandr redshift qt5-gsettings lxappearance \
            konsole xfce4-power-manager xfce4-screensaver blueman \
            xorg-setxkbmap picom ark dolphin ffmpegthumbs playerctl \
            lightly-qt kvantum polkit-kde-agent ttf-font-awesome-5 conky \
            jq xcolor light xclip gufw qt5ct xfce4-clipman tar curl
        
        # Install yay for AUR packages
        echo "Installing yay for AUR packages..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
        
        # Install AUR packages
        yay -S --needed picom-git light-git
    else
        echo "Unsupported package manager. Please install dependencies manually:"
        echo "- awesome-git"
        echo "- picom (recommend pijulius fork for animations)"
        echo "- rofi"
        echo "- network-manager-applet"
        echo "- xfce4-power-manager"
        echo "- xfce4-screensaver"
        echo "- brightnessctl"
        echo "- light"
        echo "- redshift"
        echo "- playerctl"
        echo "- polkit-kde-agent"
        echo "- ttf-font-awesome-5"
        echo "- xfce4-clipman"
        echo "- qt5ct"
        echo "- bandwhich"
        echo "- jq"
        echo "- dolphin"
        echo "- xorg-setxkbmap"
        echo "- lightly-qt"
        echo "- kvantum"
        echo "- clementine"
        echo "- qt5-gsettings"
        echo "- lxappearance"
        echo "- konsole"
        echo "- gimp"
        echo "- telegram-desktop"
        echo "- blueman"
        echo "- conky"
        echo "- xcolor"
        echo "- gufw"
        echo "- curl"
        echo ""
        echo "Then re-run this script."
        exit 1
    fi
}

# Setup bandwhich capabilities
setup_bandwhich() {
    echo "Setting up bandwhich to run without root..."
    if command_exists bandwhich; then
        sudo setcap cap_sys_ptrace,cap_dac_read_search,cap_net_raw,cap_net_admin+ep /usr/bin/bandwhich
        echo "bandwhich configured successfully."
    else
        echo "bandwhich not found. Skipping capability setup."
    fi
}

# Copy configuration files
copy_config() {
    echo "Copying configuration files..."
    
    # Backup existing awesome config
    if [ -d "$HOME/.config/awesome" ]; then
        echo "Backing up existing awesome config to $HOME/.config/awesome-old"
        mv "$HOME/.config/awesome" "$HOME/.config/awesome-old"
    fi
    
    # Copy awesome config
    cp -r "$(pwd)" "$HOME/.config/awesome"
    
    # Setup rofi
    mkdir -p "$HOME/.config/rofi"
    cp "$HOME/.config/awesome/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
    
    # Copy Qt5ct themes
    cp -r "$HOME/.config/awesome/themes/qt5/"* "$HOME/.config/qt5ct/" 2>/dev/null || true
    
    # Copy plasma color schemes
    mkdir -p "$HOME/.local/share/color-schemes"
    cp -r "$HOME/.config/awesome/themes/plasma-colors/"* "$HOME/.local/share/color-schemes/" 2>/dev/null || true
    
    # Copy konsole schemes
    mkdir -p "$HOME/.local/share/konsole"
    cp -r "$HOME/.config/awesome/themes/konsole/"* "$HOME/.local/share/konsole/" 2>/dev/null || true
    
    # Copy kvantum themes
    mkdir -p "$HOME/.config/Kvantum"
    cp -r "$HOME/.config/awesome/themes/kvantum-themes/"* "$HOME/.config/Kvantum/" 2>/dev/null || true
    
    # Copy fonts
    cp -r "$HOME/.config/awesome/.fonts/"* "$HOME/.local/share/fonts/" 2>/dev/null || true
    fc-cache -f -v
    
    # Setup environment variable
    if ! grep -q "QT_QPA_PLATFORMTHEME=qt5ct" /etc/environment; then
        echo "Setting QT_QPA_PLATFORMTHEME in /etc/environment..."
        sudo cp /etc/environment /etc/environment.backup
        echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment
    fi
    
    # Setup icons
    mkdir -p "$HOME/.local/share/icons"
    for icon_pack in Calm neon-icons-master NeonIcons Oreo-black-circle We10X; do
        if [ -f "$HOME/.config/awesome/themes/sys-icons/${icon_pack}.tar.gz" ]; then
            tar xvf "$HOME/.config/awesome/themes/sys-icons/${icon_pack}.tar.gz" -C "$HOME/.local/share/icons/"
        fi
    done
    
    # Setup glava
    glava --copy-config || echo "glava not installed, skipping config copy"
    cp -r "$HOME/.config/awesome/themes/glava/"* "$HOME/.config/glava/" 2>/dev/null || true
    
    # Copy qt5ct.conf
    cp "$HOME/.config/awesome/qt5ct.conf" "$HOME/.config/qt5ct/qt5ct.conf" 2>/dev/null || true
    
    echo "Configuration files copied successfully."
}

# Main installation process
main() {
    echo "Starting MyAwesomeConfig installation..."
    echo ""
    
    # Install dependencies
    install_dependencies
    echo ""
    
    # Setup bandwhich
    setup_bandwhich
    echo ""
    
    # Copy configuration
    copy_config
    echo ""
    
    echo "=== Installation Complete ==="
    echo ""
    echo "Next steps:"
    echo "1. Log out and log back in (or restart your display manager)"
    echo "2. Select AwesomeWM as your session"
    echo "3. Enjoy your new desktop!"
    echo ""
    echo "Important notes:"
    echo "- For weather widgets, set your OpenWeatherMap API key:"
    echo "  export OPENWEATHER_API_KEY='your_api_key_here'"
    echo "- For lockscreen fallback password, set:"
    echo "  export LOCKSCREEN_FALLBACK_PASSWORD='your_password_here'"
    echo "- Add these to your ~/.bashrc or ~/.zshrc for persistence"
    echo ""
    echo "To customize further, edit files in ~/.config/awesome/"
}

# Run main function
main "$@"