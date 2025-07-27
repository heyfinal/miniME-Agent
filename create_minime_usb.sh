#!/bin/bash

# ========================
# miniME Bootable USB Creator
# Creates a bootable installation drive
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[USB Creator]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

show_banner() {
    clear
    echo -e "${PURPLE:-\033[0;35m}"
    cat << 'EOF'
▄▄▄▄  ▄ ▄▄▄▄  ▄ ▗▖  ▗▖▗▄▄▄▖
█ █ █ ▄ █   █ ▄ ▐▛▚▞▜▌▐▌   
█   █ █ █   █ █ ▐▌  ▐▌▐▛▀▀▘
      █       █ ▐▌  ▐▌▐▙▄▄▖
EOF
    echo -e "${NC:-\033[0m}"
    echo
    echo -e "${CYAN:-\033[0;36m}🤖 miniME Autonomous AI Agent System 🤖${NC:-\033[0m}"
    echo -e "${CYAN:-\033[0;36m}        Complete Mac Mini Takeover${NC:-\033[0m}"
    echo
}
#!/bin/bash

# ========================
# miniME Bootable USB Creator
# Creates a bootable installation drive
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[USB Creator]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

#!/bin/bash

# ========================
# miniME Bootable USB Creator
# Creates a bootable installation drive
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[USB Creator]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

#!/bin/bash

# ========================
# miniME Bootable USB Creator
# Creates a bootable installation drive
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[USB Creator]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }


create_splash_screen() {
    local mount_point="$1"
    
    log "Creating ASCII splash screen..."
    
    # Create splash screen script
    cat > "$mount_point/miniME/splash.sh" << 'SPLASH'
#!/bin/bash

# miniME Splash Screen Display
clear

# Colors
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Get terminal size
COLUMNS=$(tput cols)
LINES=$(tput lines)

# Center text function
center_text() {
    local text="$1"
    local color="$2"
    local padding=$(( (COLUMNS - ${#text}) / 2 ))
    printf "%*s" $padding ""
    echo -e "${color}${text}${NC}"
}

# Display splash
echo -e "${PURPLE}"
center_text "████████████████████████████████████████████████████████████████" "$PURPLE"
center_text "██                                                            ██" "$PURPLE"
center_text "██  ███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗           ██" "$PURPLE"
center_text "██  ████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝           ██" "$PURPLE"
center_text "██  ██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗             ██" "$PURPLE"
center_text "██  ██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝             ██" "$PURPLE"
center_text "██  ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗           ██" "$PURPLE"
center_text "██  ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝           ██" "$PURPLE"
center_text "██                                                            ██" "$PURPLE"
center_text "██            🤖 AUTONOMOUS AI AGENT SYSTEM 🤖               ██" "$CYAN"
center_text "██                                                            ██" "$PURPLE"
center_text "██                      Version 1.0.0                        ██" "$GREEN"
center_text "██                                                            ██" "$PURPLE"
center_text "████████████████████████████████████████████████████████████████" "$PURPLE"

echo -e "${NC}"
echo
center_text "⚡ Initializing miniME Installation System..." "$YELLOW"
echo
center_text "This system will completely transform your machine into" "$GREEN"
center_text "an autonomous AI agent with unrestricted capabilities." "$GREEN"
echo
center_text "⚠️  WARNING: This will ERASE all data on target drive! ⚠️" "$RED"
echo
echo

# Progress bar animation
echo -e "${CYAN}Loading components:${NC}"
components=("Base System" "AI Models" "Agent Framework" "Network Stack" "Memory System")

for i in "${!components[@]}"; do
    printf "  [%-20s] %s\n" "$(printf "%*s" $((i*4)) "" | tr ' ' '█')" "${components[$i]}"
    sleep 0.5
done

echo
center_text "🚀 Ready for Installation!" "$GREEN"
echo
sleep 2
SPLASH

    chmod +x "$mount_point/miniME/splash.sh"
    
    # Also create a simpler text-based splash for the installer
    cat > "$mount_point/miniME/installer_splash.txt" << 'TXTSPLASH'
    ███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗
    ████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝
    ██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗  
    ██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝  
    ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗
    ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝
                                                   
          🤖 AUTONOMOUS AI AGENT SYSTEM 🤖
                    Version 1.0.0
    
    ────────────────────────────────────────────────────
    
    ⚡ Features:
      • Unrestricted AI capabilities
      • Claude integration for oversight  
      • Web automation & research
      • Network security monitoring
      • Learning & memory system
      • Full system control
    
    ⚠️  This installation will COMPLETELY ERASE the target machine!
    
    ────────────────────────────────────────────────────
TXTSPLASH
}

check_requirements() {
    log "Checking system requirements..."
    
    # Check for required tools
    local required_tools=("diskutil" "hdiutil" "curl")
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            error "Required tool not found: $tool"
        fi
    done
    
    # Check for macOS installer
    local installer_path="/Applications/Install macOS Monterey.app"
    
    if [ ! -d "$installer_path" ]; then
        warn "macOS Monterey installer not found"
        info "Download from App Store or use softwareupdate:"
        info "  softwareupdate --list-full-installers"
        info "  softwareupdate --fetch-full-installer --full-installer-version 12.7.6"
        
        read -p "Continue without macOS installer? (y/n): " continue_without
        if [[ "$continue_without" != "y" ]]; then
            error "macOS installer required for bootable USB"
        fi
    else
        info "Found macOS installer: $installer_path"
    fi
}

select_usb_drive() {
    log "Available USB drives:"
    
    # List external drives
    diskutil list external
    
    echo
    warn "WARNING: Selected drive will be COMPLETELY ERASED!"
    echo
    
    while true; do
        read -p "Enter USB drive identifier (e.g., disk2): " USB_DRIVE
        
        if diskutil info "$USB_DRIVE" &>/dev/null; then
            local drive_name=$(diskutil info "$USB_DRIVE" | grep "Device / Media Name" | awk -F: '{print $2}' | xargs)
            local drive_size=$(diskutil info "$USB_DRIVE" | grep "Disk Size" | awk -F: '{print $2}' | xargs)
            
            # Check if it's external
            if diskutil info "$USB_DRIVE" | grep -q "Internal.*No"; then
                echo
                info "Selected USB drive: $drive_name ($drive_size)"
                read -p "Confirm erasure of $USB_DRIVE? (yes/no): " confirm
                
                if [[ "$confirm" == "yes" ]]; then
                    break
                fi
            else
                error "Drive $USB_DRIVE appears to be internal. Only external drives allowed."
            fi
        else
            warn "Invalid drive identifier: $USB_DRIVE"
        fi
    done
}

prepare_usb_drive() {
    log "Preparing USB drive $USB_DRIVE..."
    
    # Unmount all partitions
    diskutil unmountDisk force "$USB_DRIVE" || true
    
    # Erase and format as Mac OS Extended (Journaled)
    info "Erasing USB drive..."
    diskutil eraseDisk JHFS+ "miniME-Installer" "$USB_DRIVE"
    
    # Wait for mount
    sleep 3
    
    if [ ! -d "/Volumes/miniME-Installer" ]; then
        error "Failed to format USB drive"
    fi
    
    info "USB drive prepared successfully"
}

create_bootable_installer() {
    local installer_path="/Applications/Install macOS Monterey.app"
    
    if [ -d "$installer_path" ]; then
        log "Creating bootable macOS installer..."
        
        # Use Apple's createinstallmedia tool
        sudo "$installer_path/Contents/Resources/createinstallmedia" \
            --volume "/Volumes/miniME-Installer" \
            --nointeraction
        
        # Wait for completion
        sleep 5
        
        # Re-mount the volume (name changes after createinstallmedia)
        local boot_volume=$(diskutil list | grep -E "Install macOS|miniME" | awk '{print $NF}' | tail -1)
        
        if [ -z "$boot_volume" ]; then
            error "Failed to create bootable installer"
        fi
        
        info "Bootable installer created on $boot_volume"
        
        # Add our miniME installer to the boot volume
        local mount_point="/Volumes/$boot_volume"
        
    else
        log "Creating data-only installer (no macOS base)..."
        local mount_point="/Volumes/miniME-Installer"
    fi
    
    # Create miniME installer directory
    mkdir -p "$mount_point/miniME"
    
    # Copy miniME installer script
    info "Adding miniME installer..."
    cp "/Users/daniel/Desktop/minime_installer.sh" "$mount_point/miniME/"
    cp "/Users/daniel/Desktop/minime_protocol.py" "$mount_point/miniME/"
    cp "/Users/daniel/Desktop/minime_memory.py" "$mount_point/miniME/"
    
    # Create splash screen
    create_splash_screen "$mount_point"
    
    # Create autorun script
    cat > "$mount_point/miniME/autorun.sh" << 'AUTORUN'
#!/bin/bash

# miniME Auto-installer
# Runs automatically when USB is mounted

clear
echo "=================================="
echo "    miniME Autonomous AI Agent"
echo "=================================="
echo

echo "This will install miniME on this machine."
echo "WARNING: This will ERASE the primary disk!"
echo

read -p "Continue with installation? (yes/no): " response

if [[ "$response" == "yes" ]]; then
    echo "Starting miniME installation..."
    sudo bash "$(dirname "$0")/minime_installer.sh"
else
    echo "Installation cancelled."
fi
AUTORUN
    
    chmod +x "$mount_point/miniME/autorun.sh"
    
    # Create README
    cat > "$mount_point/miniME/README.txt" << 'README'
miniME Autonomous AI Agent Installer
===================================

This USB drive contains the complete miniME installation system.

INSTALLATION:
1. Boot from this USB drive
2. Run: sudo bash /Volumes/[USB-NAME]/miniME/minime_installer.sh
3. Follow the prompts
4. System will reboot as miniME agent

REQUIREMENTS:
- Mac Mini 2014 or newer
- 8GB+ RAM
- Internet connection for model downloads
- Claude API key

WHAT GETS INSTALLED:
- Custom macOS configuration
- Ollama AI inference engine
- miniME autonomous agent framework
- Web automation tools
- Network monitoring
- Claude integration

WARNING:
This installation will COMPLETELY ERASE the target machine.
Make sure you have backups of any important data.

For support: Check the installation logs at /opt/minime/logs/
README
    
    # Download additional dependencies
    info "Downloading dependencies..."
    
    # Create dependencies directory
    mkdir -p "$mount_point/miniME/deps"
    
    # Download Ollama installer
    curl -fsSL https://ollama.com/install.sh -o "$mount_point/miniME/deps/ollama_install.sh"
    
    # Download Homebrew installer
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$mount_point/miniME/deps/brew_install.sh"
    
    info "Dependencies downloaded"
}

create_boot_scripts() {
    local mount_point="/Volumes/Install macOS Monterey"
    
    if [ ! -d "$mount_point" ]; then
        mount_point="/Volumes/miniME-Installer"
    fi
    
    log "Creating boot automation scripts..."
    
    # Create post-install automation
    cat > "$mount_point/miniME/post_install.sh" << 'POST_INSTALL'
#!/bin/bash

# Post-installation automation
# Runs after macOS installation completes

export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

echo "miniME post-installation starting..."

# Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(cat /miniME/deps/brew_install.sh)"
fi

# Install Python dependencies
echo "Installing Python packages..."
pip3 install asyncio aiohttp playwright beautifulsoup4 requests

# Install Ollama
echo "Installing Ollama..."
bash /miniME/deps/ollama_install.sh

# Start Ollama service
echo "Starting Ollama..."
ollama serve &

# Download initial models
echo "Downloading AI models..."
ollama pull mistral:7b-instruct-q4_K_M
ollama pull phi3:mini

# Install miniME framework
echo "Installing miniME framework..."
mkdir -p /opt/minime/{bin,lib,config,logs,models,cache}

# Copy files
cp /miniME/minime_installer.sh /opt/minime/bin/
cp /miniME/minime_protocol.py /opt/minime/lib/

# Set up services
echo "Configuring services..."
# Service setup would go here

echo "miniME installation complete!"
echo "Rebooting in 10 seconds..."
sleep 10
reboot
POST_INSTALL
    
    chmod +x "$mount_point/miniME/post_install.sh"
    
    # Create launch agent for auto-start
    mkdir -p "$mount_point/miniME/LaunchAgents"
    
    cat > "$mount_point/miniME/LaunchAgents/com.minime.installer.plist" << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.minime.installer</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/miniME/post_install.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/minime_install.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/minime_install.log</string>
</dict>
</plist>
PLIST
}

finalize_usb() {
    log "Finalizing bootable USB..."
    
    # Sync all writes
    sync
    
    # Unmount cleanly
    diskutil unmount "/Volumes/Install macOS Monterey" 2>/dev/null || \
    diskutil unmount "/Volumes/miniME-Installer" 2>/dev/null || true
    
    log "✅ miniME bootable USB created successfully!"
    echo
    info "USB Drive: $USB_DRIVE"
    info "Ready for deployment"
    echo
    warn "Usage:"
    warn "1. Insert USB into target Mac Mini"
    warn "2. Hold Option key during boot"
    warn "3. Select USB drive"
    warn "4. Run installer from desktop"
    echo
}

# Main execution
main() {
    show_banner
    
    # Check if running as root for some operations
    if [[ $EUID -eq 0 ]]; then
        error "Don't run this script as root initially. It will ask for sudo when needed."
    fi
    
    check_requirements
    select_usb_drive
    
    # Now we need sudo for disk operations
    log "Requesting administrator privileges for disk operations..."
    sudo -v
    
    prepare_usb_drive
    create_bootable_installer
    create_boot_scripts
    finalize_usb
    
    log "🎉 miniME bootable USB creation complete!"
}

# Run the creator
main "$@"
