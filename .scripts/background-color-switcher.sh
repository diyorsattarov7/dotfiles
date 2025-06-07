#!/bin/bash
ENABLE_LOGGING=true
LOG_FILE="$HOME/.background-color-switcher.log"
touch "$LOG_FILE"

get_appearance() {
    appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
    if [[ $? -eq 0 && $appearance == "Dark" ]]; then
        echo "dark"
    else
        echo "light"
    fi
}

log_message() {
    if [[ $ENABLE_LOGGING == true ]]; then
        echo "$(date): $1" >> "$LOG_FILE"
    fi
}

set_background_color() {
    appearance=$(get_appearance)
    
    if [[ $appearance == "dark" ]]; then
        solid_color_path="/System/Library/Desktop Pictures/Solid Colors/Black.png"
        log_message "Changed to black background (dark mode)"
    else
        solid_color_path="/System/Library/Desktop Pictures/Solid Colors/Silver.png"
        log_message "Changed to silver background (light mode)"
    fi
        
    osascript <<EOF
    tell application "System Events"
        tell every desktop
            set picture to "$solid_color_path"
        end tell
    end tell
EOF
}

monitor_appearance() {
    last_appearance=$(get_appearance)
    log_message "Starting monitor with initial appearance: $last_appearance"
    
    while true; do
        current_appearance=$(get_appearance)
        
        if [[ $current_appearance != $last_appearance ]]; then
            log_message "Appearance changed from $last_appearance to $current_appearance"
            set_background_color
            last_appearance=$current_appearance
        fi
        
        sleep 2  
    done
}

current_mode=$(get_appearance)
log_message "Script started. Current appearance mode: $current_mode"

set_background_color

if [[ "$1" == "--once" ]]; then
    echo "Background color set once. Script exiting."
    log_message "Script executed once and exiting."
else
    log_message "Starting continuous appearance monitoring..."
    monitor_appearance
fi
