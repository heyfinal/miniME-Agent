#!/bin/bash

# ========================
# miniME OS Installer
# Complete bootable system for autonomous AI deployment
# ========================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Installation variables
MINIME_VERSION="1.0.0"
TARGET_DISK=""
CLAUDE_API_KEY=""
NETWORK_NAME=""

log() { echo -e "${GREEN}[miniME]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

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
# miniME OS Installer
# Complete bootable system for autonomous AI deployment
# ========================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Installation variables
MINIME_VERSION="1.0.0"
TARGET_DISK=""
CLAUDE_API_KEY=""
NETWORK_NAME=""

log() { echo -e "${GREEN}[miniME]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

#!/bin/bash

# ========================
# miniME OS Installer
# Complete bootable system for autonomous AI deployment
# ========================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Installation variables
MINIME_VERSION="1.0.0"
TARGET_DISK=""
CLAUDE_API_KEY=""
NETWORK_NAME=""

log() { echo -e "${GREEN}[miniME]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

#!/bin/bash

# ========================
# miniME OS Installer
# Complete bootable system for autonomous AI deployment
# ========================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Installation variables
MINIME_VERSION="1.0.0"
TARGET_DISK=""
CLAUDE_API_KEY=""
NETWORK_NAME=""

log() { echo -e "${GREEN}[miniME]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }


detect_hardware() {
    log "Detecting hardware configuration..."
    
    local model=$(sysctl -n hw.model)
    local cpu=$(sysctl -n machdep.cpu.brand_string)
    local ram_gb=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024)}')
    local arch=$(uname -m)
    
    info "Hardware detected:"
    info "  Model: $model"
    info "  CPU: $cpu"
    info "  RAM: ${ram_gb}GB"
    info "  Architecture: $arch"
    
    # Validate minimum requirements
    if [ "$ram_gb" -lt 8 ]; then
        error "Insufficient RAM. miniME requires at least 8GB."
    fi
    
    if [[ "$model" != *"Macmini"* ]] && [[ "$model" != *"iMac"* ]]; then
        warn "Unsupported hardware model. Proceeding anyway..."
    fi
}

select_target_disk() {
    log "Available disks for installation:"
    diskutil list
    
    echo
    warn "WARNING: This will COMPLETELY ERASE the selected disk!"
    echo
    
    while true; do
        read -p "Enter target disk (e.g., disk0): " TARGET_DISK
        
        if diskutil info "$TARGET_DISK" &>/dev/null; then
            local disk_name=$(diskutil info "$TARGET_DISK" | grep "Device / Media Name" | awk -F: '{print $2}' | xargs)
            local disk_size=$(diskutil info "$TARGET_DISK" | grep "Disk Size" | awk -F: '{print $2}' | xargs)
            
            echo
            info "Selected: $disk_name ($disk_size)"
            read -p "Confirm complete erasure of $TARGET_DISK? (yes/no): " confirm
            
            if [[ "$confirm" == "yes" ]]; then
                break
            fi
        else
            error "Invalid disk identifier: $TARGET_DISK"
        fi
    done
}

collect_configuration() {
    log "Collecting miniME configuration..."
    
    echo
    info "Network Configuration:"
    read -p "Network name (for miniME identification): " NETWORK_NAME
    
    echo
    info "Claude API Configuration:"
    echo "Get your API key from: https://console.anthropic.com/"
    read -s -p "Claude API Key: " CLAUDE_API_KEY
    echo
    
    if [[ -z "$CLAUDE_API_KEY" ]]; then
        error "Claude API key is required for miniME operation"
    fi
}

wipe_and_partition() {
    log "Wiping and partitioning disk $TARGET_DISK..."
    
    # Unmount any mounted partitions
    diskutil unmountDisk force "$TARGET_DISK" || true
    
    # Secure erase (if SSD, use crypto erase for speed)
    if diskutil info "$TARGET_DISK" | grep -q "Solid State"; then
        info "SSD detected, performing crypto erase..."
        diskutil secureErase freespace 0 "$TARGET_DISK"
    else
        info "HDD detected, performing secure erase..."
        diskutil secureErase 2 "$TARGET_DISK"
    fi
    
    # Create new partition scheme
    info "Creating partition scheme..."
    diskutil partitionDisk "$TARGET_DISK" GPT \
        "APFS" "miniME-System" 60% \
        "APFS" "miniME-Data" 40%
}

install_base_system() {
    log "Installing base macOS system..."
    
    # Download macOS installer (latest compatible)
    local installer_path="/Applications/Install macOS Monterey.app"
    
    if [ ! -d "$installer_path" ]; then
        info "Downloading macOS installer..."
        # This would typically use Apple's software update catalog
        warn "Please ensure macOS installer is available"
    fi
    
    # Create bootable installer
    info "Creating system installation..."
    "$installer_path/Contents/Resources/createinstallmedia" \
        --volume "/Volumes/miniME-System" \
        --nointeraction
}

install_minime_framework() {
    log "Installing miniME AI framework..."
    
    local mount_point="/Volumes/miniME-System"
    
    # Create miniME directory structure
    mkdir -p "$mount_point/opt/minime"/{bin,lib,models,cache,logs,config}
    
    # Install Python and dependencies
    info "Installing Python environment..."
    
    # Copy miniME core files
    info "Installing miniME core system..."
    
    # Main miniME agent
    cat > "$mount_point/opt/minime/bin/minime.py" << 'MINIME_CORE'
#!/usr/bin/env python3
"""
miniME - Autonomous AI Agent Core
"""

import asyncio
import json
import logging
import os
import subprocess
import sys
import time
from pathlib import Path
from typing import Dict, Any, List, Optional

# Import our compressed protocol
sys.path.append('/opt/minime/lib')
from minime_protocol import MiniMEProtocol, ClaudeInterface, MsgType

class MiniMEAgent:
    """Core autonomous agent"""
    
    def __init__(self, config_path: str = "/opt/minime/config/config.json"):
        self.config = self.load_config(config_path)
        self.claude = ClaudeInterface(self.config['claude_api_key'])
        self.protocol = MiniMEProtocol()
        self.task_queue = asyncio.Queue()
        self.running = False
        
        # Setup logging
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler('/opt/minime/logs/minime.log'),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger('miniME')
        
    def load_config(self, config_path: str) -> Dict[str, Any]:
        """Load configuration from JSON file"""
        try:
            with open(config_path, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            self.logger.error(f"Config file not found: {config_path}")
            return {}
    
    async def start(self):
        """Start the miniME agent"""
        self.logger.info("miniME Agent starting...")
        self.running = True
        
        # Start main loops
        await asyncio.gather(
            self.task_processor(),
            self.system_monitor(),
            self.claude_communicator()
        )
    
    async def task_processor(self):
        """Process tasks from queue"""
        while self.running:
            try:
                task = await self.task_queue.get()
                await self.execute_task(task)
                self.task_queue.task_done()
            except Exception as e:
                self.logger.error(f"Task processing error: {e}")
            
            await asyncio.sleep(0.1)
    
    async def execute_task(self, task: Dict[str, Any]):
        """Execute a single task"""
        task_type = task.get('type')
        
        if task_type == 'web_scrape':
            await self.web_scrape(task)
        elif task_type == 'system_cmd':
            await self.system_command(task)
        elif task_type == 'research':
            await self.research_task(task)
        else:
            self.logger.warning(f"Unknown task type: {task_type}")
    
    async def web_scrape(self, task: Dict[str, Any]):
        """Perform web scraping"""
        url = task.get('url')
        
        # Ask Claude for approval if risky
        if self.is_risky_url(url):
            approval_msg = self.protocol.create_approval_request(
                'web_scrape', url, f"Scraping potentially risky URL: {url}"
            )
            
            response = await self.ask_claude(approval_msg)
            if response.get('decision') != 'approved':
                self.logger.info(f"Claude denied web scraping: {url}")
                return
        
        # Perform scraping (implement with Playwright)
        self.logger.info(f"Scraping: {url}")
        # Implementation would go here
        
    async def system_command(self, task: Dict[str, Any]):
        """Execute system command"""
        command = task.get('command')
        
        # Always ask Claude for system commands
        approval_msg = self.protocol.create_approval_request(
            'system_cmd', command, f"Executing: {command}"
        )
        
        response = await self.ask_claude(approval_msg)
        if response.get('decision') == 'approved':
            try:
                result = subprocess.run(
                    command, shell=True, capture_output=True, text=True
                )
                self.logger.info(f"Command executed: {command}")
                
                # Report back to Claude
                report_msg = self.protocol.create_report(
                    'system_cmd', result.stdout, result.returncode == 0
                )
                await self.send_to_claude(report_msg)
                
            except Exception as e:
                self.logger.error(f"Command failed: {e}")
        else:
            self.logger.info(f"Claude denied command: {command}")
    
    async def ask_claude(self, message: str) -> Dict[str, Any]:
        """Send message to Claude and await response"""
        try:
            response = self.claude.send_compressed(message)
            return response
        except Exception as e:
            self.logger.error(f"Claude communication error: {e}")
            return {'decision': 'denied', 'error': str(e)}
    
    async def send_to_claude(self, message: str):
        """Send message to Claude (no response expected)"""
        try:
            self.claude.send_compressed(message)
        except Exception as e:
            self.logger.error(f"Claude communication error: {e}")
    
    def is_risky_url(self, url: str) -> bool:
        """Determine if URL is potentially risky"""
        risky_indicators = [
            'tor.', 'onion', 'suspicious', 'hack', 'crack',
            'warez', 'pirate', 'malware', 'phishing'
        ]
        return any(indicator in url.lower() for indicator in risky_indicators)
    
    async def system_monitor(self):
        """Monitor system resources and health"""
        while self.running:
            # Monitor CPU, RAM, disk usage
            # Log important events
            # Detect anomalies
            await asyncio.sleep(30)
    
    async def claude_communicator(self):
        """Handle Claude communication loop"""
        while self.running:
            # Check for messages from network
            # Send periodic status updates
            await asyncio.sleep(60)

if __name__ == "__main__":
    agent = MiniMEAgent()
    asyncio.run(agent.start())
MINIME_CORE
    
    # Make executable
    chmod +x "$mount_point/opt/minime/bin/minime.py"
    
    # Copy protocol library
    cp "/Users/daniel/Desktop/minime_protocol.py" "$mount_point/opt/minime/lib/"
}

install_ai_models() {
    log "Installing AI models..."
    
    local mount_point="/Volumes/miniME-System"
    
    # Install Ollama
    info "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
    
    # Download optimized models for 8GB RAM
    info "Downloading AI models (this may take a while)..."
    
    # Create model download script
    cat > "$mount_point/opt/minime/bin/download_models.sh" << 'MODEL_SCRIPT'
#!/bin/bash

# Download essential models for miniME
echo "Downloading Mistral 7B (quantized)..."
ollama pull mistral:7b-instruct-q4_K_M

echo "Downloading Phi-3 Mini..."
ollama pull phi3:mini

echo "Downloading CodeLlama 7B..."
ollama pull codellama:7b-instruct-q4_K_M

echo "Model downloads complete!"
MODEL_SCRIPT

    chmod +x "$mount_point/opt/minime/bin/download_models.sh"
}

create_configuration() {
    log "Creating miniME configuration..."
    
    local mount_point="/Volumes/miniME-System"
    
    # Main configuration file
    cat > "$mount_point/opt/minime/config/config.json" << EOF
{
    "version": "$MINIME_VERSION",
    "network_name": "$NETWORK_NAME",
    "claude_api_key": "$CLAUDE_API_KEY",
    "node_id": "$(uuidgen)",
    "capabilities": [
        "web_scraping",
        "system_commands", 
        "research",
        "automation",
        "monitoring"
    ],
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M",
        "fast": "phi3:mini"
    },
    "security": {
        "require_claude_approval": [
            "system_cmd",
            "file_delete",
            "network_scan",
            "user_simulation"
        ],
        "auto_approve": [
            "web_scrape_safe",
            "research",
            "log_analysis"
        ]
    },
    "resources": {
        "max_ram_usage": "6GB",
        "model_swap_threshold": "1GB",
        "cache_size": "2GB"
    }
}
EOF
}

install_services() {
    log "Installing system services..."
    
    local mount_point="/Volumes/miniME-System"
    
    # Create LaunchDaemon for miniME
    mkdir -p "$mount_point/Library/LaunchDaemons"
    
    cat > "$mount_point/Library/LaunchDaemons/com.minime.agent.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.minime.agent</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/minime/bin/minime.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/opt/minime/logs/stdout.log</string>
    <key>StandardErrorPath</key>
    <string>/opt/minime/logs/stderr.log</string>
    <key>WorkingDirectory</key>
    <string>/opt/minime</string>
</dict>
</plist>
EOF

    # Create startup script
    cat > "$mount_point/opt/minime/bin/startup.sh" << 'STARTUP'
#!/bin/bash

# miniME System Startup
echo "miniME starting up..."

# Start Ollama service
launchctl load /Library/LaunchDaemons/com.ollama.ollama.plist

# Download models if first run
if [ ! -f /opt/minime/.models_downloaded ]; then
    echo "First run - downloading models..."
    /opt/minime/bin/download_models.sh
    touch /opt/minime/.models_downloaded
fi

# Start miniME agent
echo "Starting miniME agent..."
python3 /opt/minime/bin/minime.py &

echo "miniME startup complete!"
STARTUP

    chmod +x "$mount_point/opt/minime/bin/startup.sh"
}

create_network_config() {
    log "Configuring network access..."
    
    local mount_point="/Volumes/miniME-System"
    
    # Network discovery script
    cat > "$mount_point/opt/minime/bin/network_setup.sh" << 'NETWORK'
#!/bin/bash

# Auto-configure network settings
echo "Configuring miniME network access..."

# Get network info
GATEWAY=$(route -n get default | grep gateway | awk '{print $2}')
LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)

echo "Network configured:"
echo "  Local IP: $LOCAL_IP"
echo "  Gateway: $GATEWAY"

# Enable SSH for remote access
sudo systemsetup -setremotelogin on

# Configure firewall for miniME services
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

echo "miniME network setup complete!"
echo "Access via: ssh minime@$LOCAL_IP"
NETWORK

    chmod +x "$mount_point/opt/minime/bin/network_setup.sh"
}

finalize_installation() {
    log "Finalizing miniME installation..."
    
    local mount_point="/Volumes/miniME-System"
    
    # Create completion marker
    echo "$MINIME_VERSION" > "$mount_point/opt/minime/.installation_complete"
    
    # Set permissions
    chown -R root:wheel "$mount_point/opt/minime"
    chmod -R 755 "$mount_point/opt/minime/bin"
    
    # Unmount
    diskutil unmount "$mount_point"
    
    log "miniME installation complete!"
    echo
    info "Next steps:"
    info "1. Remove installation media"  
    info "2. Reboot the system"
    info "3. miniME will auto-configure on first boot"
    info "4. Check logs at /opt/minime/logs/"
    echo
    warn "First boot will take 10-15 minutes for model downloads"
}

# Main installation flow
main() {
    show_banner
    
    # Check if running as root
    if [[ $EUID -ne 0 ]]; then
        error "This installer must be run as root (use sudo)"
    fi
    
    detect_hardware
    select_target_disk
    collect_configuration
    
    echo
    warn "Final confirmation: This will completely erase $TARGET_DISK"
    read -p "Type 'ERASE' to continue: " final_confirm
    
    if [[ "$final_confirm" != "ERASE" ]]; then
        error "Installation cancelled"
    fi
    
    log "Beginning miniME installation..."
    
    wipe_and_partition
    install_base_system
    install_minime_framework
    install_ai_models
    create_configuration
    install_services
    create_network_config
    finalize_installation
    
    log "🎉 miniME deployment complete!"
}

# Run installer
main "$@"
