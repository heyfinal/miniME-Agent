#!/bin/bash

# ========================
# Apply Main miniME Banner
# Uses the specified ASCII art for all executables
# ========================

set -euo pipefail

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[Main Banner]${NC} $1"; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

# The main ASCII art you specified
get_main_ascii() {
cat << 'EOF'

                   o8o               o8o  ooo        ooooo oooooooooooo 
                   `"'               `"'  `88.       .888' `888'     `8 
ooo. .oo.  .oo.   oooo  ooo. .oo.   oooo   888b     d'888   888         
`888P"Y88bP"Y88b  `888  `888P"Y88b  `888   8 Y88. .P  888   888oooo8    
 888   888   888   888   888   888   888   8  `888'   888   888    "    
 888   888   888   888   888   888   888   8    Y     888   888       o 
o888o o888o o888o o888o o888o o888o o888o o8o        o888o o888ooooood8
EOF
}

# Function to update banner in a script file
update_banner_in_file() {
    local file="$1"
    
    if [ ! -f "$file" ]; then
        info "File not found: $file - skipping"
        return
    fi
    
    log "Updating banner in: $file"
    
    # Create backup
    cp "$file" "${file}.bak"
    
    # Create temporary file
    local temp_file=$(mktemp)
    
    # Extract everything before show_banner function
    awk '
        /^show_banner\(\)/ { exit }
        { print }
    ' "$file" > "$temp_file"
    
    # Add the new show_banner function with main ASCII
    cat >> "$temp_file" << 'BANNER_START'
show_banner() {
    clear
    echo -e "${PURPLE:-\033[0;35m}"
    cat << 'EOF'
                   o8o               o8o  ooo        ooooo oooooooooooo 
                   `"'               `"'  `88.       .888' `888'     `8 
ooo. .oo.  .oo.   oooo  ooo. .oo.   oooo   888b     d'888   888         
`888P"Y88bP"Y88b  `888  `888P"Y88b  `888   8 Y88. .P  888   888oooo8    
 888   888   888   888   888   888   888   8  `888'   888   888    "    
 888   888   888   888   888   888   888   8    Y     888   888       o 
o888o o888o o888o o888o o888o o888o o888o o8o        o888o o888ooooood8

EOF
    echo -e "${NC:-\033[0m}"
    echo
    echo -e "${CYAN:-\033[0;36m}🤖 miniME Autonomous AI Agent System 🤖${NC:-\033[0m}"
    echo -e "${CYAN:-\033[0;36m}        Complete Mac Mini Takeover${NC:-\033[0m}"
    echo
}
BANNER_START
    
    # Extract everything after the show_banner function
    awk '
        in_function && /^}/ { in_function=0; next }
        in_function { next }
        /^show_banner\(\)/ { in_function=1; next }
        !in_function { print }
    ' "$file" >> "$temp_file"
    
    # Replace the original file
    mv "$temp_file" "$file"
    
    info "✅ Updated: $file"
}

main() {
    log "Applying main miniME ASCII banner to all executables"
    log "Working directory: $(pwd)"
    
    # Show preview
    echo -e "\n${CYAN}Main ASCII Banner Preview:${NC}"
    echo -e "\033[0;35m"
    get_main_ascii
    echo -e "\033[0m"
    echo -e "${CYAN}🤖 miniME Autonomous AI Agent System 🤖${NC}"
    echo -e "${CYAN}        Complete Mac Mini Takeover${NC}"
    echo
    
    read -p "Apply this main banner to all executables? (y/n): " confirm
    
    if [[ "$confirm" == "y" ]]; then
        # Files to update
        local files=(
            "deploy.sh"
            "build_minime_os.sh" 
            "create_minime_bootable.sh"
            "create_minime_usb.sh"
            "quick_usb_create.sh"
            "minime_installer.sh"
        )
        
        for file in "${files[@]}"; do
            update_banner_in_file "$file"
        done
        
        log "✅ All banners updated with main ASCII art!"
        log "Updated ${#files[@]} executable files"
        
        # Cleanup backups
        read -p "Remove backup files? (y/n): " cleanup
        if [[ "$cleanup" == "y" ]]; then
            rm -f *.bak
            info "Backup files removed"
        fi
        
    else
        log "Banner update cancelled"
    fi
}

main "$@"