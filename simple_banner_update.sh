#!/bin/bash

# ========================
# Simple Banner Update Script
# Manually extracts ASCII art and updates all executables
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}[Banner Update]${NC} $1"; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

# Pick a random ASCII art (1-17)
RANDOM_NUM=$((1 + RANDOM % 17))

log "Randomly selected ASCII art #${RANDOM_NUM}"

# Manually define the ASCII arts (easier than parsing the complex JSON)
get_ascii_art() {
    case "$1" in
        1)
cat << 'EOF'
░▒▓██████████████▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓██████████████▓▒░░▒▓████████▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░   
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░
EOF
            ;;
        2)
cat << 'EOF'
▄▄▄▄  ▄ ▄▄▄▄  ▄ ▗▖  ▗▖▗▄▄▄▖
█ █ █ ▄ █   █ ▄ ▐▛▚▞▜▌▐▌   
█   █ █ █   █ █ ▐▌  ▐▌▐▛▀▀▘
      █       █ ▐▌  ▐▌▐▙▄▄▖
EOF
            ;;
        3)
cat << 'EOF'
▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖
▐▛▚▞▜▌  █  ▐▛▚▖▐▌  █  ▐▛▚▞▜▌▐▌   
▐▌  ▐▌  █  ▐▌ ▝▜▌  █  ▐▌  ▐▌▐▛▀▀▘
▐▌  ▐▌▗▄█▄▖▐▌  ▐▌▗▄█▄▖▐▌  ▐▌▐▙▄▄▖
EOF
            ;;
        4)
cat << 'EOF'
          ,--.        ,--.,--.   ,--.,------. 
,--,--,--.`--',--,--, `--'|   `.'   ||  .---' 
|        |,--.|      \,--.|  |'.'|  ||  `--,  
|  |  |  ||  ||  ||  ||  ||  |   |  ||  `---. 
`--`--`--'`--'`--''--'`--'`--'   `--'`------'
EOF
            ;;
        5)
cat << 'EOF'
                ░██           ░██░███     ░███ ░██████████ 
                                 ░████   ░████ ░██         
░█████████████  ░██░████████  ░██░██░██ ░██░██ ░██         
░██   ░██   ░██ ░██░██    ░██ ░██░██ ░████ ░██ ░█████████  
░██   ░██   ░██ ░██░██    ░██ ░██░██  ░██  ░██ ░██         
░██   ░██   ░██ ░██░██    ░██ ░██░██       ░██ ░██         
░██   ░██   ░██ ░██░██    ░██ ░██░██       ░██ ░██████████
EOF
            ;;
        6)
cat << 'EOF'
   •  •┳┳┓┏┓
┏┳┓┓┏┓┓┃┃┃┣ 
┛┗┗┗┛┗┗┛ ┗┗┛
EOF
            ;;
        7)
cat << 'EOF'
███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗
████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝
██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗  
██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝  
██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗
╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝
EOF
            ;;
        8)
cat << 'EOF'
 ███▄ ▄███▓ ██▓ ███▄    █  ██▓ ███▄ ▄███▓▓█████ 
▓██▒▀█▀ ██▒▓██▒ ██ ▀█   █ ▓██▒▓██▒▀█▀ ██▒▓█   ▀ 
▓██    ▓██░▒██▒▓██  ▀█ ██▒▒██▒▓██    ▓██░▒███   
▒██    ▒██ ░██░▓██▒  ▐▌██▒░██░▒██    ▒██ ▒▓█  ▄ 
▒██▒   ░██▒░██░▒██░   ▓██░░██░▒██▒   ░██▒░▒████▒
░ ▒░   ░  ░░▓  ░ ▒░   ▒ ▒ ░▓  ░ ▒░   ░  ░░░ ▒░ ░
░  ░      ░ ▒ ░░ ░░   ░ ▒░ ▒ ░░  ░      ░ ░ ░  ░
░      ░    ▒ ░   ░   ░ ░  ▒ ░░      ░      ░   
       ░    ░           ░  ░         ░      ░  ░
EOF
            ;;
        9)
cat << 'EOF'
┌┬┐┬┌┐┌┬╔╦╗╔═╗
││││││││║║║║╣ 
┴ ┴┴┘└┘┴╩ ╩╚═╝
EOF
            ;;
        10)
cat << 'EOF'
              d8b          d8b 888b     d888 8888888888 
              Y8P          Y8P 8888b   d8888 888        
                               88888b.d88888 888        
88888b.d88b.  888 88888b.  888 888Y88888P888 8888888    
888 "888 "88b 888 888 "88b 888 888 Y888P 888 888        
888  888  888 888 888  888 888 888  Y8P  888 888        
888  888  888 888 888  888 888 888   "   888 888        
888  888  888 888 888  888 888 888       888 8888888888
EOF
            ;;
        11)
cat << 'EOF'
          .  ..___
._ _ *._ *|\/|[__ 
[ | )|[ )||  |[___
EOF
            ;;
        12)
cat << 'EOF'
     .   ..  ..--
.-.-...-..|\/||- 
' ' ''' '''  ''--
EOF
            ;;
        13)
cat << 'EOF'
                    ,,                ,,                              
                    db                db  `7MMM.     ,MMF'`7MM"""YMM  
                                            MMMb    dPMM    MM    `7  
`7MMpMMMb.pMMMb.  `7MM  `7MMpMMMb.  `7MM    M YM   ,M MM    MM   d    
  MM    MM    MM    MM    MM    MM    MM    M  Mb  M' MM    MMmmMM    
  MM    MM    MM    MM    MM    MM    MM    M  YM.P'  MM    MM   Y  , 
  MM    MM    MM    MM    MM    MM    MM    M  `YM'   MM    MM     ,M 
.JMML  JMML  JMML..JMML..JMML  JMML..JMML..JML. `'  .JMML..JMMmmmmMMM
EOF
            ;;
        14)
cat << 'EOF'
                   o8o               o8o  ooo        ooooo oooooooooooo 
                   `"'               `"'  `88.       .888' `888'     `8 
ooo. .oo.  .oo.   oooo  ooo. .oo.   oooo   888b     d'888   888         
`888P"Y88bP"Y88b  `888  `888P"Y88b  `888   8 Y88. .P  888   888oooo8    
 888   888   888   888   888   888   888   8  `888'   888   888    "    
 888   888   888   888   888   888   888   8    Y     888   888       o 
o888o o888o o888o o888o o888o o888o o888o o8o        o888o o888ooooood8
EOF
            ;;
        15)
cat << 'EOF'
                       .    ..---.
          o         o  |\  /||    
.--.--.   .  .--.   .  | \/ ||--- 
|  |  |   |  |  |   |  |    ||    
'  '  `--' `-'  `--' `-'    ''---'
EOF
            ;;
        16)
cat << 'EOF'
                    88               88  88b           d88  88888888888  
                    ""               ""  888b         d888  88           
                                         88`8b       d8'88  88           
88,dPYba,,adPYba,   88  8b,dPPYba,   88  88 `8b     d8' 88  88aaaaa      
88P'   "88"    "8a  88  88P'   `"8a  88  88  `8b   d8'  88  88"""""      
88      88      88  88  88       88  88  88   `8b d8'   88  88           
88      88      88  88  88       88  88  88    `888'    88  88           
88      88      88  88  88       88  88  88     `8'     88  88888888888
EOF
            ;;
        17)
cat << 'EOF'
                d8,            d8,                     
               `8P            `8P                      
                                                       
  88bd8b,d88b   88b  88bd88b   88b  88bd8b,d88b  d8888b
  88P'`?8P'?8b  88P  88P' ?8b  88P  88P'`?8P'?8bd8b_,dP
 d88  d88  88P d88  d88   88P d88  d88  d88  88P88b    
d88' d88'  88bd88' d88'   88bd88' d88' d88'  88b`?888P'
EOF
            ;;
        *)
            echo "miniME"
            ;;
    esac
}

# Function to update banner in a script file
update_banner_in_file() {
    local file="$1"
    local ascii_num="$2"
    
    if [ ! -f "$file" ]; then
        info "File not found: $file - skipping"
        return
    fi
    
    log "Updating banner in: $file"
    
    # Create backup
    cp "$file" "${file}.bak"
    
    # Create temporary file with new banner
    local temp_file=$(mktemp)
    
    # Extract everything before show_banner function
    awk '
        /^show_banner\(\)/ { exit }
        { print }
    ' "$file" > "$temp_file"
    
    # Add the new show_banner function
    cat >> "$temp_file" << 'BANNER_START'
show_banner() {
    clear
    echo -e "${PURPLE:-\033[0;35m}"
    cat << 'EOF'
BANNER_START
    
    # Add the selected ASCII art
    get_ascii_art "$ascii_num" >> "$temp_file"
    
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
    
    # Extract everything after the show_banner function
    awk '
        found_end && /^}/ { found_end=0; next }
        found_end { next }
        /^show_banner\(\)/ { found_end=1; next }
        !found_end && /^}/ && prev_line ~ /show_banner/ { next }
        !found_end { print }
        { prev_line = $0 }
    ' "$file" >> "$temp_file"
    
    # Replace the original file
    mv "$temp_file" "$file"
    
    info "✅ Updated: $file"
}

# Create preview script
create_preview() {
    local ascii_num="$1"
    
    cat > "banner_preview.sh" << 'PREVIEW_START'
#!/bin/bash

PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

show_banner() {
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
PREVIEW_START
    
    get_ascii_art "$ascii_num" >> "banner_preview.sh"
    
    cat >> "banner_preview.sh" << 'PREVIEW_END'
EOF
    echo -e "${NC}"
    echo
    echo -e "${CYAN}🤖 miniME Autonomous AI Agent System 🤖${NC}"
    echo -e "${CYAN}        Complete Mac Mini Takeover${NC}"
    echo
}

show_banner
echo "Random ASCII Art Selection #$ascii_num"
PREVIEW_END
    
    chmod +x "banner_preview.sh"
}

main() {
    log "Updating miniME project banners with random ASCII art"
    log "Working directory: $(pwd)"
    
    # Create and show preview
    create_preview "$RANDOM_NUM"
    info "Previewing selected banner:"
    ./banner_preview.sh
    
    echo
    read -p "Apply this banner (#${RANDOM_NUM}) to all executables? (y/n): " confirm
    
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
            update_banner_in_file "$file" "$RANDOM_NUM"
        done
        
        log "✅ All banners updated successfully!"
        log "Applied ASCII art #${RANDOM_NUM} to ${#files[@]} files"
        
        # Cleanup
        rm -f "banner_preview.sh"
        rm -f *.bak
        
    else
        log "Banner update cancelled"
        info "Preview saved as: banner_preview.sh"
    fi
}

main "$@"