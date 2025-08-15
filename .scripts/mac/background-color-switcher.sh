#!/bin/bash

ENABLE_LOGGING=true
LOG_FILE="$HOME/.background-color-switcher.log"

touch "$LOG_FILE"

DESKTOPPR_BIN="/usr/local/bin/desktoppr"

get_appearance() {
    if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
        echo "dark"
    else
        echo "light"
    fi
}

get_current_background() {
    "$DESKTOPPR_BIN" 2>/dev/null | grep -o '".*"' | tr -d '"'
}

log_message() {
    [[ $ENABLE_LOGGING == true ]] && echo "$(date): $1" >> "$LOG_FILE"
}

set_background_color() {
    local appearance
    appearance=$(get_appearance)

    local expected
    if [[ $appearance == "dark" ]]; then
        expected="/System/Library/Desktop Pictures/Solid Colors/Black.png"
    else
        expected="/System/Library/Desktop Pictures/Solid Colors/Silver.png"
    fi
        
    osascript <<EOF
    tell application "System Events"
        tell every desktop
            set picture to "$solid_color_path"
        end tell
    end tell
EOF

    local current
    current=$(get_current_background)

    if [[ "$current" != "$expected" ]]; then
        log_message "Changing background to $expected (was $current) for appearance: $appearance"
        "$DESKTOPPR_BIN" "$expected"
    else
        log_message "Background already matches appearance: $appearance"
    fi
}

set_background_color

if [[ "$1" == "--monitor" ]]; then
    log_message "Starting appearance mode monitor..."
    monitor_appearance
else
    echo "Background color set. Use --monitor flag to continuously monitor for changes."
fi

