#!/bin/bash

# ========================
# miniME Deployment Script
# One-command deployment of miniME OS
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Deploy]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

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
# miniME Deployment Script
# One-command deployment of miniME OS
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Deploy]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

#!/bin/bash

# ========================
# miniME Deployment Script
# One-command deployment of miniME OS
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Deploy]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

#!/bin/bash

# ========================
# miniME Deployment Script
# One-command deployment of miniME OS
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Deploy]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }


show_deployment_options() {
    echo -e "${CYAN}Deployment Options:${NC}"
    echo "1. 🔥 Quick USB Creation (recommended)"
    echo "2. 📀 Full Bootable ISO Build"  
    echo "3. 🛠️  Advanced OS Builder"
    echo "4. 📊 System Status Check"
    echo "5. 📖 View Documentation"
    echo
}

quick_usb_deployment() {
    log "Starting quick USB deployment..."
    
    if [ ! -f "./quick_usb_create.sh" ]; then
        error "Quick USB script not found"
    fi
    
    chmod +x ./quick_usb_create.sh
    ./quick_usb_create.sh
}

full_iso_build() {
    log "Starting full ISO build..."
    
    if [ ! -f "./create_minime_bootable.sh" ]; then
        error "Bootable creator script not found"
    fi
    
    chmod +x ./create_minime_bootable.sh
    ./create_minime_bootable.sh
}

advanced_build() {
    log "Starting advanced OS build..."
    
    if [ ! -f "./build_minime_os.sh" ]; then
        error "Advanced builder script not found"
    fi
    
    chmod +x ./build_minime_os.sh
    ./build_minime_os.sh
}

check_system_status() {
    log "Checking system status..."
    
    echo -e "${CYAN}Project Files:${NC}"
    ls -la *.py *.sh 2>/dev/null || echo "No project files found"
    
    echo -e "\n${CYAN}USB Drives:${NC}"
    diskutil list external
    
    echo -e "\n${CYAN}Available Space:${NC}"
    df -h . | tail -1
    
    echo -e "\n${CYAN}Network Status:${NC}"
    ping -c 1 google.com >/dev/null 2>&1 && echo "✅ Internet connected" || echo "❌ No internet"
}

view_documentation() {
    if [ -f "./README.md" ]; then
        if command -v less >/dev/null; then
            less ./README.md
        else
            cat ./README.md
        fi
    else
        echo "README.md not found"
    fi
}

show_post_deployment_info() {
    echo -e "\n${GREEN}🎉 Deployment Complete!${NC}"
    echo
    echo -e "${CYAN}Next Steps:${NC}"
    echo "1. Insert USB into Mac Mini"
    echo "2. Hold Option key during boot"
    echo "3. Select USB drive"
    echo "4. Installation runs automatically (~30 minutes)"
    echo "5. miniME agent starts on first boot"
    echo
    echo -e "${CYAN}Access Information:${NC}"
    echo "• SSH: ssh minime@miniME.attlocal.net"
    echo "• Web: http://miniME.attlocal.net:8080"
    echo "• Logs: /opt/minime/logs/"
    echo
    echo -e "${YELLOW}⚠️  Warning: This will COMPLETELY ERASE the target machine!${NC}"
}

main() {
    show_banner
    
    log "miniME Autonomous AI Agent Deployment System"
    log "Ready to transform your Mac Mini into an AI agent"
    echo
    
    show_deployment_options
    
    read -p "Select option (1-5): " choice
    
    case "$choice" in
        1)
            quick_usb_deployment
            show_post_deployment_info
            ;;
        2)
            full_iso_build
            show_post_deployment_info
            ;;
        3)
            advanced_build
            show_post_deployment_info
            ;;
        4)
            check_system_status
            ;;
        5)
            view_documentation
            ;;
        *)
            error "Invalid selection"
            ;;
    esac
}

# Run deployment
main "$@"
