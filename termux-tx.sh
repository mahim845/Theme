#!/data/data/com.termux/files/usr/bin/bash

# ✅ Termux-OS Big Banner Edition by Tx Cmd

BASHRC="$HOME/.bashrc"
TERMUX_DIR="$HOME/.termux"
BANNER_FILE="$TERMUX_DIR/banner.txt"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf"

function big_banner() {
    read -p "📝 Enter your OS name (e.g., TX CMD OS): " banner
    echo "$banner" > "$BANNER_FILE"
    
    # Remove old banner block
    sed -i '/# >>> BIG BANNER START/,/# <<< BIG BANNER END/d' $BASHRC

    # Add new bold colorful banner block
    cat <<EOF >> $BASHRC

# >>> BIG BANNER START
clear
toilet -f big "$banner" | lolcat
echo -e "\033[1;36m╔════════════════════════════════╗"
echo -e "║    Welcome to $banner    ║"
echo -e "╚════════════════════════════════╝\033[0m"
# <<< BIG BANNER END
EOF

    echo "[✓] Big Banner with rainbow effect applied!"
}

function color_theme() {
    mkdir -p $TERMUX_DIR
    cat <<EOF > $TERMUX_DIR/colors.properties
background=#0f0f0f
foreground=#00ffcc
color0=#000000
color1=#FF5F5F
color2=#00FF87
color3=#FFFF00
color4=#00AAFF
color5=#BB00FF
color6=#00FFFF
color7=#FFFFFF
EOF
    termux-reload-settings
    echo "[✓] Theme applied."
}

function font_setup() {
    curl -L -o "$TERMUX_DIR/font.ttf" "$FONT_URL"
    termux-reload-settings
    echo "[✓] Nerd Font installed."
}

function reset_all() {
    sed -i '/# >>> BIG BANNER START/,/# <<< BIG BANNER END/d' "$BASHRC"
    rm -rf $TERMUX_DIR
    termux-reload-settings
    echo "[✓] Reset complete."
}

function menu() {
    while true; do
        clear
        echo "╔══════════════════════════════════════╗"
        echo "║      Termux Tx Cmd Big Banner Menu       ║"
        echo "╠══════════════════════════════════════╣"
        echo "║ 1) Set Big Banner                    ║"
        echo "║ 2) Apply Color Theme                 ║"
        echo "║ 3) Install Nerd Font                 ║"
        echo "║ 4) Reset Everything                  ║"
        echo "║ 5) Exit                              ║"
        echo "╚══════════════════════════════════════╝"
        echi "Follow Our Page: Termux Tx Cmd"
        read -p "Choose [1-5]: " opt
        case $opt in
            1) big_banner ;;
            2) color_theme ;;
            3) font_setup ;;
            4) reset_all ;;
            5) exit 0 ;;
            *) echo "❌ Invalid choice." ;;
        esac
        read -p "Press ENTER to return to menu..."
    done
}

# Apply theme every launch
color_theme
menu
