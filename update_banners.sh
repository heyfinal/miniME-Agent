#!/bin/bash

# ========================
# Banner Update Script
# Randomly selects ASCII art and updates all executables
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[Banner Update]${NC} $1"; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

# Random number between 1-17 for ASCII art selection
RANDOM_NUM=$((1 + RANDOM % 17))
ASCII_KEY="minime${RANDOM_NUM}"

log "Selected ASCII art: $ASCII_KEY"

# Extract the selected ASCII art from the JSON file
extract_ascii_art() {
    local ascii_file="/Users/daniel/miniME_acsii_macros.txt"
    local key="$1"
    
    # Use Python to properly parse the JSON and extract the ASCII art
    python3 << EOF
import json
import sys

with open('${ascii_file}', 'r') as f:
    data = json.load(f)

if '${key}' in data:
    print(data['${key}'])
else:
    print("ASCII art not found")
    sys.exit(1)
EOF
}

# Get the selected ASCII art
ASCII_ART=$(extract_ascii_art "$ASCII_KEY")

if [ -z "$ASCII_ART" ]; then
    echo "Failed to extract ASCII art"
    exit 1
fi

info "ASCII art extracted successfully"

# Function to update banner in a script file
update_banner_in_file() {
    local file="$1"
    local temp_file=$(mktemp)
    
    log "Updating banner in: $file"
    
    # Create the new banner function
    cat > "$temp_file" << 'BANNER_START'
show_banner() {
    clear
    echo -e "${PURPLE:-\033[0;35m}"
    cat << 'EOF'
BANNER_START
    
    # Add the ASCII art
    echo "$ASCII_ART" >> "$temp_file"
    
    # Close the banner function
    cat >> "$temp_file" << 'BANNER_END'
EOF
    echo -e "${NC:-\033[0m}"
    echo
    echo -e "${CYAN:-\033[0;36m}🤖 miniME Autonomous AI Agent System 🤖${NC:-\033[0m}"
    echo -e "${CYAN:-\033[0;36m}        Complete Mac Mini Takeover${NC:-\033[0m}"
    echo
}
BANNER_END
    
    # Replace the show_banner function in the original file
    if grep -q "show_banner()" "$file"; then
        # Extract everything before the first show_banner function
        awk '/^show_banner\(\)/{exit} {print}' "$file" > "${temp_file}.pre"
        
        # Extract everything after the show_banner function ends
        awk '/^show_banner\(\)/,/^}/ {if (/^}/ && !in_func) in_func=1; next} in_func {print}' "$file" > "${temp_file}.post"
        
        # Combine: pre + new banner + post
        cat "${temp_file}.pre" "$temp_file" "${temp_file}.post" > "$file"
        
        # Cleanup temp files
        rm -f "${temp_file}.pre" "${temp_file}.post"
    else
        info "No show_banner() function found in $file - skipping"
    fi
    
    rm -f "$temp_file"
}

# Update all executable files in the project
update_all_banners() {
    local files=(
        "deploy.sh"
        "build_minime_os.sh"
        "create_minime_bootable.sh"
        "create_minime_usb.sh"
        "quick_usb_create.sh"
        "minime_installer.sh"
    )
    
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            update_banner_in_file "$file"
        else
            info "File not found: $file - skipping"
        fi
    done
}

# Create a banner preview function for testing
create_banner_preview() {
    cat > "banner_preview.sh" << 'PREVIEW_START'
#!/bin/bash

# Colors
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

show_banner() {
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
PREVIEW_START
    
    echo "$ASCII_ART" >> "banner_preview.sh"
    
    cat >> "banner_preview.sh" << 'PREVIEW_END'
EOF
    echo -e "${NC}"
    echo
    echo -e "${CYAN}🤖 miniME Autonomous AI Agent System 🤖${NC}"
    echo -e "${CYAN}        Complete Mac Mini Takeover${NC}"
    echo
}

show_banner
echo "Banner preview for: $ASCII_KEY"
PREVIEW_END
    
    chmod +x "banner_preview.sh"
    log "Created banner_preview.sh for testing"
}

main() {
    log "Updating miniME project banners with random ASCII art"
    log "Working directory: $(pwd)"
    
    # Create preview first
    create_banner_preview
    
    # Show the preview
    info "Previewing selected banner:"
    ./banner_preview.sh
    
    echo
    read -p "Apply this banner to all executables? (y/n): " confirm
    
    if [[ "$confirm" == "y" ]]; then
        update_all_banners
        log "✅ All banners updated successfully!"
        log "Selected ASCII: $ASCII_KEY"
        
        # Cleanup preview
        rm -f "banner_preview.sh"
    else
        log "Banner update cancelled"
        info "Preview file saved as: banner_preview.sh"
    fi
}

main "$@"