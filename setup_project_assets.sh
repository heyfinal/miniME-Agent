#!/bin/bash

# ========================
# miniME Project Assets Setup
# Organize all visual assets and create final deployment package
# ========================

set -euo pipefail

GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}[Assets Setup]${NC} $1"; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

show_banner() {
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
▄▄▄▄  ▄ ▄▄▄▄  ▄ ▗▖  ▗▖▗▄▄▄▖
█ █ █ ▄ █   █ ▄ ▐▛▚▞▜▌▐▌   
█   █ █ █   █ █ ▐▌  ▐▌▐▛▀▀▘
      █       █ ▐▌  ▐▌▐▙▄▄▖
EOF
    echo -e "${NC}"
    echo
    echo -e "${CYAN}🎨 miniME Project Assets Setup 🎨${NC}"
    echo -e "${CYAN}     Final Project Organization${NC}"
    echo
}

organize_assets() {
    log "Organizing project assets..."
    
    # Create assets directory
    mkdir -p assets/{icons,banners,splash}
    
    # Copy icon
    if [ -f "miniME_icon.png" ]; then
        cp miniME_icon.png assets/icons/
        info "✅ Icon copied to assets/icons/"
    fi
    
    # Copy splash screens if they exist
    if [ -f "/Users/daniel/miniME_splash" ]; then
        cp "/Users/daniel/miniME_splash" assets/splash/miniME_splash.txt
        info "✅ Splash screen 1 copied"
    fi
    
    if [ -f "/Users/daniel/miniME_splash2" ]; then
        cp "/Users/daniel/miniME_splash2" assets/splash/miniME_splash2.txt
        info "✅ Splash screen 2 copied"
    fi
    
    # Save current ASCII banner
    cat > assets/banners/current_banner.txt << 'BANNER'
▄▄▄▄  ▄ ▄▄▄▄  ▄ ▗▖  ▗▖▗▄▄▄▖
█ █ █ ▄ █   █ ▄ ▐▛▚▞▜▌▐▌   
█   █ █ █   █ █ ▐▌  ▐▌▐▛▀▀▘
      █       █ ▐▌  ▐▌▐▙▄▄▖
BANNER
    
    info "✅ Current banner saved"
}

create_deployment_package() {
    log "Creating final deployment package..."
    
    # Create deployment directory
    mkdir -p deployment
    
    # Copy all essential files
    local essential_files=(
        "deploy.sh"
        "create_minime_bootable.sh"
        "quick_usb_create.sh"
        "minime_protocol.py"
        "minime_memory.py"
        "minime_self_maintenance.py"
        "README.md"
    )
    
    for file in "${essential_files[@]}"; do
        if [ -f "$file" ]; then
            cp "$file" deployment/
            info "✅ Copied: $file"
        fi
    done
    
    # Copy assets
    cp -r assets deployment/
    
    # Create deployment README
    cat > deployment/DEPLOYMENT_GUIDE.md << 'DEPLOY_README'
# miniME Deployment Guide

## 🚀 Quick Start

1. **Insert USB drive**
2. **Run deployment:**
   ```bash
   ./deploy.sh
   ```
3. **Select option 1** (Quick USB Creation)
4. **Boot Mac Mini from USB**

## 📁 Package Contents

- `deploy.sh` - Main deployment script
- `create_minime_bootable.sh` - Full bootable OS creator
- `quick_usb_create.sh` - Quick USB installer
- `minime_*.py` - Core AI agent components
- `assets/` - Icons, banners, splash screens
- `README.md` - Complete documentation

## ⚡ One-Command Deployment

```bash
./deploy.sh
```

This will:
- Show ASCII banner
- Present deployment options
- Create bootable USB
- Ready for Mac Mini takeover

## 🎯 Result

Your Mac Mini will become an autonomous AI agent with:
- Complete system control
- Claude oversight integration
- Self-updating capabilities
- Continuous learning
- Network-wide access

---
**miniME Autonomous AI Agent System**
*Complete Mac Mini Takeover*
DEPLOY_README
    
    log "✅ Deployment package created"
}

show_project_summary() {
    echo
    echo -e "${CYAN}📊 Project Summary:${NC}"
    echo
    
    # Count files
    local total_files=$(find . -type f -name "*.sh" -o -name "*.py" -o -name "*.md" | wc -l | xargs)
    local python_files=$(find . -name "*.py" | wc -l | xargs)
    local bash_files=$(find . -name "*.sh" | wc -l | xargs)
    
    echo "📁 Total project files: $total_files"
    echo "🐍 Python components: $python_files"
    echo "⚡ Shell scripts: $bash_files"
    echo "🎨 Assets organized: ✅"
    echo "📦 Deployment ready: ✅"
    echo
    
    echo -e "${CYAN}🚀 Core Components:${NC}"
    echo "• miniME Protocol (Claude communication)"
    echo "• Memory & Learning System" 
    echo "• Self-Maintenance Framework"
    echo "• Bootable OS Installer"
    echo "• Network Deployment Tools"
    echo
    
    echo -e "${CYAN}🎯 Capabilities:${NC}"
    echo "• Complete Mac Mini takeover"
    echo "• Autonomous AI agent operation"
    echo "• Claude oversight integration"
    echo "• Self-updating & self-maintaining"
    echo "• Unrestricted web research"
    echo "• System-level automation"
    echo "• Continuous learning"
    echo
    
    echo -e "${GREEN}✅ Ready for deployment!${NC}"
}

main() {
    show_banner
    
    log "Setting up miniME project assets and final deployment package"
    
    organize_assets
    create_deployment_package
    show_project_summary
    
    echo
    read -p "Create final deployment archive? (y/n): " create_archive
    
    if [[ "$create_archive" == "y" ]]; then
        log "Creating deployment archive..."
        tar -czf "miniME-OS-Complete-$(date +%Y%m%d).tar.gz" deployment/
        log "✅ Archive created: miniME-OS-Complete-$(date +%Y%m%d).tar.gz"
        
        echo
        echo -e "${GREEN}🎉 miniME Project Complete!${NC}"
        echo
        echo -e "${CYAN}Next steps:${NC}"
        echo "1. Extract archive on target system"
        echo "2. Run ./deploy.sh"
        echo "3. Insert USB into Mac Mini"
        echo "4. Boot and watch autonomous AI takeover"
        echo
    fi
}

main "$@"