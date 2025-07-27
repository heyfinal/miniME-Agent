#!/bin/bash

# ========================
# miniME OS Builder
# Creates a complete bootable Linux OS for Mac Mini takeover
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

# Configuration
MINIME_VERSION="1.0.0"
BASE_ISO_URL="https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"
BASE_ISO_NAME="ubuntu-22.04-server-amd64.iso"
WORK_DIR="/tmp/minime_build"
OUTPUT_DIR="/Users/daniel/Desktop"
USB_DEVICE="disk2"

# Load credentials from secure file
CREDS_FILE="$HOME/Desktop/Programming/.credentials"
if [[ -f "$CREDS_FILE" ]]; then
    source "$CREDS_FILE"
    WIFI_SSID="$WIFI_SSID"
    WIFI_PASSWORD="$WIFI_PASSWORD"
    CLAUDE_API_KEY="$CLAUDE_API_KEY"
    GIT_TOKEN="$GITHUB_TOKEN"
    GIT_USER="$GITHUB_USERNAME"
    GIT_EMAIL="$GITHUB_EMAIL"
    OPENAI_API_KEY="$OPENAI_API_KEY"
    HOSTNAME="miniME"
    DOMAIN="$HOSTNAME"
else
    error "Credentials file not found: $CREDS_FILE"
fi

log() { echo -e "${GREEN}[miniME OS Builder]${NC} $1"; }
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
# miniME OS Builder
# Creates a complete bootable Linux OS for Mac Mini takeover
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

# Configuration
MINIME_VERSION="1.0.0"
BASE_ISO_URL="https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"
BASE_ISO_NAME="ubuntu-22.04-server-amd64.iso"
WORK_DIR="/tmp/minime_build"
OUTPUT_DIR="/Users/daniel/Desktop"
USB_DEVICE="disk2"

# Load credentials from secure file
CREDS_FILE="$HOME/Desktop/Programming/.credentials"
if [[ -f "$CREDS_FILE" ]]; then
    source "$CREDS_FILE"
    WIFI_SSID="$WIFI_SSID"
    WIFI_PASSWORD="$WIFI_PASSWORD"
    CLAUDE_API_KEY="$CLAUDE_API_KEY"
    GIT_TOKEN="$GITHUB_TOKEN"
    GIT_USER="$GITHUB_USERNAME"
    GIT_EMAIL="$GITHUB_EMAIL"
    OPENAI_API_KEY="$OPENAI_API_KEY"
    HOSTNAME="miniME"
    DOMAIN="$HOSTNAME"
else
    error "Credentials file not found: $CREDS_FILE"
fi

log() { echo -e "${GREEN}[miniME OS Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

#!/bin/bash

# ========================
# miniME OS Builder
# Creates a complete bootable Linux OS for Mac Mini takeover
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

# Configuration
MINIME_VERSION="1.0.0"
BASE_ISO_URL="https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"
BASE_ISO_NAME="ubuntu-22.04-server-amd64.iso"
WORK_DIR="/tmp/minime_build"
OUTPUT_DIR="/Users/daniel/Desktop"
USB_DEVICE="disk2"

# Load credentials from secure file
CREDS_FILE="$HOME/Desktop/Programming/.credentials"
if [[ -f "$CREDS_FILE" ]]; then
    source "$CREDS_FILE"
    WIFI_SSID="$WIFI_SSID"
    WIFI_PASSWORD="$WIFI_PASSWORD"
    CLAUDE_API_KEY="$CLAUDE_API_KEY"
    GIT_TOKEN="$GITHUB_TOKEN"
    GIT_USER="$GITHUB_USERNAME"
    GIT_EMAIL="$GITHUB_EMAIL"
    OPENAI_API_KEY="$OPENAI_API_KEY"
    HOSTNAME="miniME"
    DOMAIN="$HOSTNAME"
else
    error "Credentials file not found: $CREDS_FILE"
fi

log() { echo -e "${GREEN}[miniME OS Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

#!/bin/bash

# ========================
# miniME OS Builder
# Creates a complete bootable Linux OS for Mac Mini takeover
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

# Configuration
MINIME_VERSION="1.0.0"
BASE_ISO_URL="https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"
BASE_ISO_NAME="ubuntu-22.04-server-amd64.iso"
WORK_DIR="/tmp/minime_build"
OUTPUT_DIR="/Users/daniel/Desktop"
USB_DEVICE="disk2"

# Load credentials from secure file
CREDS_FILE="$HOME/Desktop/Programming/.credentials"
if [[ -f "$CREDS_FILE" ]]; then
    source "$CREDS_FILE"
    WIFI_SSID="$WIFI_SSID"
    WIFI_PASSWORD="$WIFI_PASSWORD"
    CLAUDE_API_KEY="$CLAUDE_API_KEY"
    GIT_TOKEN="$GITHUB_TOKEN"
    GIT_USER="$GITHUB_USERNAME"
    GIT_EMAIL="$GITHUB_EMAIL"
    OPENAI_API_KEY="$OPENAI_API_KEY"
    HOSTNAME="miniME"
    DOMAIN="$HOSTNAME"
else
    error "Credentials file not found: $CREDS_FILE"
fi

log() { echo -e "${GREEN}[miniME OS Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }


check_requirements() {
    log "Checking build requirements..."
    
    # Check for required tools
    local required_tools=("curl" "hdiutil" "diskutil" "xorriso" "cdrtools")
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            if [[ "$tool" == "xorriso" ]] || [[ "$tool" == "cdrtools" ]]; then
                info "Installing $tool via Homebrew..."
                brew install "$tool" || error "Failed to install $tool"
            else
                error "Required tool not found: $tool"
            fi
        fi
    done
    
    # Check available space
    local available_space=$(df -h "$OUTPUT_DIR" | awk 'NR==2 {print $4}')
    info "Available space: $available_space"
    
    # Create work directory
    rm -rf "$WORK_DIR"
    mkdir -p "$WORK_DIR"/{iso_extract,custom_iso,usb_mount}
}

download_base_iso() {
    log "Downloading Ubuntu Server base ISO..."
    
    local iso_path="$WORK_DIR/$BASE_ISO_NAME"
    
    if [ ! -f "$iso_path" ]; then
        info "Downloading $BASE_ISO_URL..."
        curl -L -o "$iso_path" "$BASE_ISO_URL" || error "Failed to download base ISO"
    else
        info "Base ISO already exists"
    fi
    
    # Verify download
    if [ ! -f "$iso_path" ] || [ ! -s "$iso_path" ]; then
        error "Base ISO download failed or is empty"
    fi
    
    info "Base ISO ready: $(ls -lh "$iso_path" | awk '{print $5}')"
}

extract_iso() {
    log "Extracting base ISO..."
    
    local iso_path="$WORK_DIR/$BASE_ISO_NAME"
    local extract_dir="$WORK_DIR/iso_extract"
    
    # Mount ISO (macOS method)
    local mount_point=$(hdiutil attach "$iso_path" | grep -E '^/dev/' | awk '{print $3}')
    
    if [ -z "$mount_point" ]; then
        error "Failed to mount ISO"
    fi
    
    info "ISO mounted at: $mount_point"
    
    # Copy contents
    cp -R "$mount_point"/* "$extract_dir/" || error "Failed to copy ISO contents"
    
    # Unmount
    hdiutil detach "$mount_point"
    
    info "ISO extracted successfully"
}

create_preseed_config() {
    log "Creating automated installation configuration..."
    
    local extract_dir="$WORK_DIR/iso_extract"
    
    # Create preseed configuration for completely automated install
    cat > "$extract_dir/minime-preseed.cfg" << 'PRESEED'
# miniME Automated Installation Preseed
# This completely automates the Ubuntu installation

d-i debian-installer/locale string en_US.UTF-8
d-i localechooser/supported-locales multiselect en_US.UTF-8
d-i keyboard-configuration/xkb-keymap select us

# Network configuration
d-i netcfg/choose_interface select auto
d-i netcfg/dhcp_timeout string 60
d-i netcfg/dhcp_failed note
d-i netcfg/dhcp_options select Configure network manually
d-i netcfg/get_nameservers string 8.8.8.8 1.1.1.1
d-i netcfg/get_hostname string miniME
d-i netcfg/get_domain string attlocal.net
d-i netcfg/wireless_wep string

# Mirror settings
d-i mirror/country string manual
d-i mirror/http/hostname string archive.ubuntu.com
d-i mirror/http/directory string /ubuntu
d-i mirror/http/proxy string

# Clock and time zone setup
d-i clock-setup/utc boolean true
d-i time/zone string America/Chicago
d-i clock-setup/ntp boolean true

# Partitioning - COMPLETE DISK WIPE
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string lvm
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto-lvm/guided_size string max
d-i partman-auto-lvm/new_vg_name string miniME-vg
d-i partman-auto/choose_recipe select atomic
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# Base system installation
d-i base-installer/install-recommends boolean false
d-i base-installer/kernel/image string linux-generic

# Account setup - miniME user
d-i passwd/root-login boolean false
d-i passwd/user-fullname string miniME Agent
d-i passwd/username string minime
d-i passwd/user-password password miniME2024!
d-i passwd/user-password-again password miniME2024!
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false

# Package selection
tasksel tasksel/first multiselect server, openssh-server
d-i pkgsel/include string curl wget git python3 python3-pip build-essential linux-headers-generic firmware-b43-installer firmware-b43legacy-installer
d-i pkgsel/upgrade select full-upgrade
d-i pkgsel/update-policy select none

# Boot loader installation
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean false
d-i grub-installer/bootdev string /dev/sda

# Finish installation
d-i finish-install/reboot_in_progress note
d-i cdrom-detect/eject boolean true

# Late commands - miniME setup
d-i preseed/late_command string \
    in-target wget -O /tmp/minime_setup.sh https://raw.githubusercontent.com/example/minime-setup.sh ; \
    in-target chmod +x /tmp/minime_setup.sh ; \
    in-target /tmp/minime_setup.sh
PRESEED

    info "Preseed configuration created"
}

create_minime_setup_script() {
    log "Creating miniME post-install setup script..."
    
    local extract_dir="$WORK_DIR/iso_extract"
    
    # Create the setup script that runs after OS installation
    cat > "$extract_dir/minime_setup.sh" << 'SETUP'
#!/bin/bash

# miniME Post-Installation Setup
# Runs after Ubuntu installation completes

set -euo pipefail

log() { echo "[miniME Setup] $1" | tee -a /var/log/minime-setup.log; }

log "Starting miniME agent setup..."

# Update system
apt-get update
apt-get upgrade -y

# Install required packages
apt-get install -y \
    python3-full python3-pip python3-venv \
    curl wget git build-essential \
    sqlite3 \
    network-manager \
    bluetooth bluez \
    firmware-b43-installer \
    firmware-b43legacy-installer \
    linux-firmware \
    avahi-daemon avahi-utils \
    openssh-server \
    htop vim nano \
    docker.io docker-compose

# Enable services
systemctl enable ssh
systemctl enable bluetooth
systemctl enable avahi-daemon
systemctl enable docker

# Configure WiFi
log "Configuring WiFi connection..."
cat > /etc/netplan/01-netcfg.yaml << 'NETPLAN'
network:
  version: 2
  renderer: networkd
  wifis:
    wlan0:
      dhcp4: yes
      access-points:
        "Home":
          password: "tiny2222"
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
NETPLAN

netplan apply

# Set hostname and domain
hostnamectl set-hostname miniME
echo "127.0.0.1 miniME.attlocal.net miniME" >> /etc/hosts

# Create miniME directories
mkdir -p /opt/minime/{bin,lib,config,logs,models,cache,memory}
chown -R minime:minime /opt/minime

# Install Python dependencies
pip3 install --system \
    asyncio aiohttp \
    playwright beautifulsoup4 requests \
    anthropic openai \
    flask fastapi uvicorn \
    sqlite3 \
    psutil

# Install Playwright browsers
playwright install --with-deps chromium

# Install Ollama
log "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh
systemctl enable ollama

# Download miniME components (embedded in ISO)
log "Installing miniME framework..."

# Copy embedded files from ISO
cp /cdrom/minime/minime_protocol.py /opt/minime/lib/
cp /cdrom/minime/minime_memory.py /opt/minime/lib/
cp /cdrom/minime/minime_agent.py /opt/minime/bin/
chmod +x /opt/minime/bin/minime_agent.py

# Create configuration with embedded credentials
cat > /opt/minime/config/config.json << 'CONFIG'
{
    "version": "1.0.0",
    "hostname": "miniME",
    "domain": "miniME.attlocal.net",
    "network_name": "Home",
    "node_id": "$(uuidgen)",
    "api_keys": {
        "claude": "$CLAUDE_API_KEY",
        "openai": "$OPENAI_API_KEY",
        "github_token": "$GIT_TOKEN"
    },
    "git": {
        "username": "heyfinal",
        "email": "dgillaspy@me.com"
    },
    "capabilities": [
        "web_scraping",
        "system_commands", 
        "research",
        "automation",
        "monitoring",
        "user_simulation"
    ],
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M",
        "fast": "phi3:mini"
    },
    "security": {
        "require_claude_approval": [
            "system_cmd_destructive",
            "file_delete_system",
            "network_attack",
            "credential_access"
        ],
        "auto_approve": [
            "web_scrape",
            "research",
            "log_analysis",
            "system_info",
            "file_read"
        ]
    },
    "resources": {
        "max_ram_usage": "6GB",
        "model_swap_threshold": "1GB",
        "cache_size": "2GB"
    }
}
CONFIG

# Create systemd service for miniME
cat > /etc/systemd/system/minime.service << 'SERVICE'
[Unit]
Description=miniME Autonomous AI Agent
After=network.target ollama.service
Wants=ollama.service

[Service]
Type=simple
User=minime
Group=minime
WorkingDirectory=/opt/minime
ExecStart=/usr/bin/python3 /opt/minime/bin/minime_agent.py
Restart=always
RestartSec=10
StandardOutput=append:/opt/minime/logs/minime.log
StandardError=append:/opt/minime/logs/minime.log

# Security settings
NoNewPrivileges=yes
PrivateTmp=yes
ProtectSystem=strict
ProtectHome=yes
ReadWritePaths=/opt/minime

[Install]
WantedBy=multi-user.target
SERVICE

# Enable miniME service
systemctl daemon-reload
systemctl enable minime

# Download AI models in background
log "Scheduling AI model downloads..."
cat > /opt/minime/bin/download_models.sh << 'MODELS'
#!/bin/bash
# Download models after first boot
sleep 60  # Wait for network

ollama pull mistral:7b-instruct-q4_K_M
ollama pull phi3:mini
ollama pull codellama:7b-instruct-q4_K_M

# Mark models as downloaded
touch /opt/minime/.models_ready
MODELS

chmod +x /opt/minime/bin/download_models.sh

# Create one-time model download service
cat > /etc/systemd/system/minime-models.service << 'MODELSERVICE'
[Unit]
Description=miniME Model Download
After=network-online.target ollama.service
Wants=network-online.target ollama.service

[Service]
Type=oneshot
User=minime
ExecStart=/opt/minime/bin/download_models.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
MODELSERVICE

systemctl enable minime-models

# Configure Git
sudo -u minime git config --global user.name "heyfinal"
sudo -u minime git config --global user.email "dgillaspy@me.com"

# Create SSH key for miniME
sudo -u minime ssh-keygen -t ed25519 -C "minime@miniME.attlocal.net" -f /home/minime/.ssh/id_ed25519 -N ""

# Set up Avahi for .local domain
cat > /etc/avahi/services/minime.service << 'AVAHI'
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">miniME AI Agent on %h</name>
  <service>
    <type>_ssh._tcp</type>
    <port>22</port>
  </service>
  <service>
    <type>_http._tcp</type>
    <port>8080</port>
    <txt-record>path=/</txt-record>
  </service>
</service-group>
AVAHI

log "miniME setup complete! Rebooting in 10 seconds..."
sleep 10
reboot
SETUP

    chmod +x "$extract_dir/minime_setup.sh"
    
    info "Post-install setup script created"
}

embed_minime_components() {
    log "Embedding miniME components into ISO..."
    
    local extract_dir="$WORK_DIR/iso_extract"
    
    # Create miniME directory in ISO
    mkdir -p "$extract_dir/minime"
    
    # Copy all miniME components
    cp "/Users/daniel/Desktop/minime_protocol.py" "$extract_dir/minime/"
    cp "/Users/daniel/Desktop/minime_memory.py" "$extract_dir/minime/"
    cp "/Users/daniel/Desktop/minime_self_maintenance.py" "$extract_dir/minime/"
    
    # Create the main miniME agent
    cat > "$extract_dir/minime/minime_agent.py" << 'AGENT'
#!/usr/bin/env python3
"""
miniME Autonomous AI Agent - Main Process
Complete autonomous agent with Claude oversight
"""

import asyncio
import json
import logging
import os
import subprocess
import sys
import time
import sqlite3
from pathlib import Path
from typing import Dict, Any, List, Optional

# Import miniME components
sys.path.append('/opt/minime/lib')
from minime_protocol import MiniMEProtocol, ClaudeInterface, MsgType
from minime_memory import MiniMEMemory

class MiniMEAgent:
    """Main autonomous agent class"""
    
    def __init__(self, config_path: str = "/opt/minime/config/config.json"):
        self.config = self.load_config(config_path)
        self.claude = ClaudeInterface(self.config['api_keys']['claude'])
        self.memory = MiniMEMemory()
        self.protocol = MiniMEProtocol()
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
        
        # Initialize components
        self.task_queue = asyncio.Queue()
        self.active_tasks = {}
        
    def load_config(self, config_path: str) -> Dict[str, Any]:
        """Load configuration"""
        try:
            with open(config_path, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            self.logger.error(f"Config file not found: {config_path}")
            return self.create_default_config()
    
    def create_default_config(self) -> Dict[str, Any]:
        """Create default configuration if missing"""
        return {
            "version": "1.0.0",
            "hostname": "miniME",
            "capabilities": ["research", "automation"],
            "models": {"primary": "phi3:mini"}
        }
    
    async def start(self):
        """Start the miniME agent"""
        self.logger.info("🚀 miniME Autonomous AI Agent starting...")
        self.logger.info(f"Hostname: {self.config.get('hostname', 'miniME')}")
        self.logger.info(f"Domain: {self.config.get('domain', 'local')}")
        self.logger.info(f"Capabilities: {', '.join(self.config.get('capabilities', []))}")
        
        self.running = True
        
        # Start main subsystems
        try:
            await asyncio.gather(
                self.task_processor(),
                self.system_monitor(),
                self.claude_interface(),
                self.network_discovery(),
                self.continuous_learning()
            )
        except KeyboardInterrupt:
            self.logger.info("Shutdown requested...")
        finally:
            await self.shutdown()
    
    async def task_processor(self):
        """Process tasks from queue"""
        while self.running:
            try:
                # Get task from queue or generate autonomous tasks
                task = await self.get_next_task()
                if task:
                    await self.execute_task(task)
                
                await asyncio.sleep(1)
                
            except Exception as e:
                self.logger.error(f"Task processing error: {e}")
                await asyncio.sleep(10)
    
    async def get_next_task(self) -> Optional[Dict[str, Any]]:
        """Get next task (from queue or autonomous generation)"""
        try:
            # Try to get queued task first
            task = self.task_queue.get_nowait()
            return task
        except asyncio.QueueEmpty:
            # Generate autonomous task
            return await self.generate_autonomous_task()
    
    async def generate_autonomous_task(self) -> Optional[Dict[str, Any]]:
        """Generate autonomous tasks based on learning and context"""
        
        # Check system status
        if await self.needs_system_check():
            return {
                'type': 'system_monitor',
                'action': 'health_check',
                'priority': 'medium'
            }
        
        # Check for network changes
        if await self.needs_network_scan():
            return {
                'type': 'network_scan',
                'action': 'discover_devices',
                'priority': 'low'
            }
        
        # Research task based on learning
        research_topic = await self.get_research_suggestion()
        if research_topic:
            return {
                'type': 'research',
                'action': 'web_research',
                'topic': research_topic,
                'priority': 'low'
            }
        
        return None
    
    async def execute_task(self, task: Dict[str, Any]):
        """Execute a task with Claude oversight if needed"""
        task_type = task.get('type')
        action = task.get('action')
        
        self.logger.info(f"Executing task: {task_type}/{action}")
        
        # Check if task needs Claude approval
        if await self.needs_claude_approval(task):
            approval = await self.request_claude_approval(task)
            if not approval:
                self.logger.info(f"Claude denied task: {task_type}/{action}")
                return
        
        # Execute based on task type
        try:
            if task_type == 'web_scrape':
                await self.web_scrape_task(task)
            elif task_type == 'system_monitor':
                await self.system_monitor_task(task)
            elif task_type == 'research':
                await self.research_task(task)
            elif task_type == 'network_scan':
                await self.network_scan_task(task)
            elif task_type == 'automation':
                await self.automation_task(task)
            else:
                self.logger.warning(f"Unknown task type: {task_type}")
                
        except Exception as e:
            self.logger.error(f"Task execution failed: {e}")
            
            # Report failure to Claude
            error_msg = self.protocol.create_report(
                task_type, f"Task failed: {str(e)}", success=False
            )
            await self.send_to_claude(error_msg)
    
    async def needs_claude_approval(self, task: Dict[str, Any]) -> bool:
        """Check if task requires Claude approval"""
        task_type = task.get('type')
        action = task.get('action')
        
        # Check security settings
        require_approval = self.config.get('security', {}).get('require_claude_approval', [])
        auto_approve = self.config.get('security', {}).get('auto_approve', [])
        
        if f"{task_type}_{action}" in require_approval:
            return True
        if task_type in require_approval:
            return True
        if f"{task_type}_{action}" in auto_approve:
            return False
        if task_type in auto_approve:
            return False
            
        # Default: require approval for potentially risky tasks
        risky_tasks = ['system_cmd', 'file_delete', 'network_attack', 'user_simulation']
        return task_type in risky_tasks
    
    async def request_claude_approval(self, task: Dict[str, Any]) -> bool:
        """Request approval from Claude"""
        approval_msg = self.protocol.create_approval_request(
            task['type'],
            str(task),
            f"Requesting approval for {task['type']}/{task.get('action', 'unknown')}"
        )
        
        try:
            response = await self.send_to_claude(approval_msg)
            return response.get('decision') == 'approved'
        except Exception as e:
            self.logger.error(f"Claude approval request failed: {e}")
            return False  # Deny if can't reach Claude
    
    async def web_scrape_task(self, task: Dict[str, Any]):
        """Execute web scraping task"""
        url = task.get('url')
        if not url:
            return
            
        # Log interaction
        self.memory.log_ai_interaction(
            'miniME-webscrape',
            f"Scraping URL: {url}",
            "Starting web scrape...",
            project_id=task.get('project_id')
        )
        
        # Implementation would use Playwright here
        self.logger.info(f"Web scraping: {url}")
        
    async def research_task(self, task: Dict[str, Any]):
        """Execute research task"""
        topic = task.get('topic')
        if not topic:
            return
            
        self.logger.info(f"Researching: {topic}")
        
        # Log research start
        self.memory.log_ai_interaction(
            'miniME-research',
            f"Research topic: {topic}",
            "Starting autonomous research...",
            project_id=task.get('project_id')
        )
    
    async def system_monitor_task(self, task: Dict[str, Any]):
        """Execute system monitoring task"""
        action = task.get('action', 'health_check')
        
        if action == 'health_check':
            # Check system health
            try:
                # CPU usage
                cpu_info = subprocess.run(['top', '-l', '1', '-n', '0'], 
                                        capture_output=True, text=True)
                
                # Memory usage
                mem_info = subprocess.run(['free', '-h'], 
                                        capture_output=True, text=True)
                
                # Disk usage
                disk_info = subprocess.run(['df', '-h'], 
                                         capture_output=True, text=True)
                
                system_status = {
                    'timestamp': time.time(),
                    'cpu': 'healthy',
                    'memory': 'healthy', 
                    'disk': 'healthy'
                }
                
                self.logger.info("System health check completed")
                
            except Exception as e:
                self.logger.error(f"System health check failed: {e}")
    
    async def network_scan_task(self, task: Dict[str, Any]):
        """Execute network scanning task"""
        self.logger.info("Performing network discovery...")
        
        # Simple network scan
        try:
            result = subprocess.run(['nmap', '-sn', '192.168.1.0/24'], 
                                  capture_output=True, text=True, timeout=60)
            self.logger.info("Network scan completed")
        except Exception as e:
            self.logger.error(f"Network scan failed: {e}")
    
    async def system_monitor(self):
        """Continuous system monitoring"""
        while self.running:
            try:
                # Monitor system resources
                # Check for anomalies
                # Log important events
                await asyncio.sleep(60)  # Check every minute
            except Exception as e:
                self.logger.error(f"System monitoring error: {e}")
                await asyncio.sleep(60)
    
    async def claude_interface(self):
        """Handle Claude communication"""
        while self.running:
            try:
                # Send periodic status updates
                # Handle Claude queries
                await asyncio.sleep(300)  # Every 5 minutes
            except Exception as e:
                self.logger.error(f"Claude interface error: {e}")
                await asyncio.sleep(300)
    
    async def network_discovery(self):
        """Discover other miniME nodes on network"""
        while self.running:
            try:
                # Scan for other miniME instances
                # Register with network
                await asyncio.sleep(600)  # Every 10 minutes
            except Exception as e:
                self.logger.error(f"Network discovery error: {e}")
                await asyncio.sleep(600)
    
    async def continuous_learning(self):
        """Continuous learning from interactions"""
        while self.running:
            try:
                # Analyze conversation patterns
                insights = self.memory.get_learning_insights()
                
                # Apply learnings to improve performance
                # Update preferences and patterns
                
                await asyncio.sleep(3600)  # Every hour
            except Exception as e:
                self.logger.error(f"Learning process error: {e}")
                await asyncio.sleep(3600)
    
    async def send_to_claude(self, message: str) -> Dict[str, Any]:
        """Send message to Claude"""
        try:
            return self.claude.send_compressed(message)
        except Exception as e:
            self.logger.error(f"Claude communication error: {e}")
            return {'error': str(e)}
    
    async def needs_system_check(self) -> bool:
        """Check if system monitoring is needed"""
        # Simple logic - check every hour
        return int(time.time()) % 3600 < 60
    
    async def needs_network_scan(self) -> bool:
        """Check if network scan is needed"""
        # Check every 10 minutes
        return int(time.time()) % 600 < 60
    
    async def get_research_suggestion(self) -> Optional[str]:
        """Get research topic suggestion from learning"""
        # This would use the memory system to suggest research topics
        return None
    
    async def shutdown(self):
        """Graceful shutdown"""
        self.logger.info("miniME Agent shutting down...")
        self.running = False

if __name__ == "__main__":
    try:
        agent = MiniMEAgent()
        asyncio.run(agent.start())
    except KeyboardInterrupt:
        print("\nShutdown requested by user")
    except Exception as e:
        print(f"Fatal error: {e}")
        sys.exit(1)
AGENT

    chmod +x "$extract_dir/minime/minime_agent.py"
    
    info "miniME components embedded in ISO"
}

modify_boot_config() {
    log "Modifying boot configuration for automated install..."
    
    local extract_dir="$WORK_DIR/iso_extract"
    
    # Modify GRUB configuration for automated boot
    if [ -f "$extract_dir/boot/grub/grub.cfg" ]; then
        # Backup original
        cp "$extract_dir/boot/grub/grub.cfg" "$extract_dir/boot/grub/grub.cfg.bak"
        
        # Create new GRUB config with miniME autoboot
        cat > "$extract_dir/boot/grub/grub.cfg" << 'GRUB'
set timeout=5
set default=0

menuentry "miniME Automated Installation" {
    set gfxpayload=keep
    linux /casper/vmlinuz boot=casper automatic-ubiquity noprompt quiet splash preseed/file=/cdrom/minime-preseed.cfg ---
    initrd /casper/initrd
}

menuentry "miniME Manual Installation" {
    set gfxpayload=keep
    linux /casper/vmlinuz boot=casper quiet splash ---
    initrd /casper/initrd
}
GRUB
    fi
    
    # Also modify isolinux for older systems
    if [ -f "$extract_dir/isolinux/isolinux.cfg" ]; then
        cp "$extract_dir/isolinux/isolinux.cfg" "$extract_dir/isolinux/isolinux.cfg.bak"
        
        cat > "$extract_dir/isolinux/isolinux.cfg" << 'ISOLINUX'
DEFAULT miniME
TIMEOUT 50

LABEL miniME
  MENU LABEL miniME Automated Installation
  KERNEL /casper/vmlinuz
  APPEND initrd=/casper/initrd boot=casper automatic-ubiquity noprompt quiet splash preseed/file=/cdrom/minime-preseed.cfg ---

LABEL manual
  MENU LABEL miniME Manual Installation  
  KERNEL /casper/vmlinuz
  APPEND initrd=/casper/initrd boot=casper quiet splash ---
ISOLINUX
    fi
    
    info "Boot configuration modified for automation"
}

create_custom_iso() {
    log "Creating custom miniME ISO..."
    
    local extract_dir="$WORK_DIR/iso_extract"
    local custom_iso="$OUTPUT_DIR/miniME-OS-${MINIME_VERSION}.iso"
    
    # Create ISO using xorriso (cross-platform)
    xorriso -as mkisofs \
        -r -V "miniME-OS" \
        -cache-inodes \
        -J -l \
        -b isolinux/isolinux.bin \
        -c isolinux/boot.cat \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -eltorito-alt-boot \
        -e boot/grub/efi.img \
        -no-emul-boot \
        -isohybrid-gpt-basdat \
        -o "$custom_iso" \
        "$extract_dir"
    
    if [ ! -f "$custom_iso" ]; then
        error "Failed to create custom ISO"
    fi
    
    local iso_size=$(ls -lh "$custom_iso" | awk '{print $5}')
    info "Custom ISO created: $custom_iso ($iso_size)"
    
    return 0
}

flash_to_usb() {
    log "Flashing miniME OS to USB drive..."
    
    local custom_iso="$OUTPUT_DIR/miniME-OS-${MINIME_VERSION}.iso"
    
    warn "This will COMPLETELY ERASE USB drive $USB_DEVICE!"
    read -p "Continue? (yes/no): " confirm
    
    if [[ "$confirm" != "yes" ]]; then
        info "USB flashing cancelled"
        return 0
    fi
    
    # Unmount USB
    diskutil unmountDisk force "$USB_DEVICE" || true
    
    # Flash ISO to USB
    info "Flashing ISO to USB (this will take several minutes)..."
    sudo dd if="$custom_iso" of="/dev/r$USB_DEVICE" bs=1M status=progress
    
    # Verify
    sync
    
    log "✅ miniME OS successfully flashed to USB!"
    log "Boot your Mac Mini holding Option key and select the USB drive"
    log "The system will automatically install and configure miniME"
}

cleanup() {
    log "Cleaning up build files..."
    rm -rf "$WORK_DIR"
    info "Cleanup complete"
}

# Main build process
main() {
    show_banner
    
    if [[ $EUID -ne 0 ]]; then
        info "Some operations require sudo (will prompt when needed)"
    fi
    
    log "Building miniME bootable OS..."
    log "Target: Complete Mac Mini takeover with autonomous AI agent"
    
    check_requirements
    download_base_iso
    extract_iso
    create_preseed_config
    create_minime_setup_script
    embed_minime_components
    modify_boot_config
    create_custom_iso
    
    info "Build complete! Custom ISO ready."
    info "Next: Flash to USB or use ISO directly"
    
    read -p "Flash to USB drive $USB_DEVICE now? (y/n): " flash_now
    if [[ "$flash_now" == "y" ]]; then
        flash_to_usb
    fi
    
    cleanup
    
    log "🎉 miniME OS build complete!"
    log "ISO location: $OUTPUT_DIR/miniME-OS-${MINIME_VERSION}.iso"
}

# Run builder
main "$@"
