#!/bin/bash

# ========================
# miniME Bootable OS Creator
# Creates complete bootable Linux OS for Mac Mini takeover
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

USB_DEVICE="disk2"
WORK_DIR="/tmp/minime_build"

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
# miniME Bootable OS Creator
# Creates complete bootable Linux OS for Mac Mini takeover
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

USB_DEVICE="disk2"
WORK_DIR="/tmp/minime_build"

#!/bin/bash

# ========================
# miniME Bootable OS Creator
# Creates complete bootable Linux OS for Mac Mini takeover
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

USB_DEVICE="disk2"
WORK_DIR="/tmp/minime_build"

#!/bin/bash

# ========================
# miniME Bootable OS Creator
# Creates complete bootable Linux OS for Mac Mini takeover
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME Builder]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

USB_DEVICE="disk2"
WORK_DIR="/tmp/minime_build"


create_bootable_installer() {
    log "Creating miniME bootable installer..."
    
    rm -rf "$WORK_DIR"
    mkdir -p "$WORK_DIR"
    
    # Download Ubuntu Server ISO
    log "Downloading Ubuntu Server 22.04..."
    local iso_url="https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
    local iso_file="$WORK_DIR/ubuntu-server.iso"
    
    if [ ! -f "$iso_file" ]; then
        curl -L -o "$iso_file" "$iso_url" || error "Failed to download Ubuntu ISO"
    fi
    
    # Mount and extract ISO
    log "Extracting ISO..."
    local mount_point="/tmp/ubuntu_mount"
    mkdir -p "$mount_point"
    
    # Mount ISO (macOS style)
    local disk_image=$(hdiutil attach "$iso_file" | grep -E '^/dev/' | awk '{print $1}')
    local mounted_volume=$(hdiutil info | grep "$disk_image" | awk -F'\t' '{print $3}')
    
    # Copy ISO contents
    local extract_dir="$WORK_DIR/iso_extract"
    mkdir -p "$extract_dir"
    cp -R "$mounted_volume"/* "$extract_dir/"
    
    # Unmount
    hdiutil detach "$disk_image"
    
    # Create miniME components directory
    mkdir -p "$extract_dir/minime"
    
    # Copy miniME files
    cp "/Users/daniel/Desktop/minime_protocol.py" "$extract_dir/minime/"
    cp "/Users/daniel/Desktop/minime_memory.py" "$extract_dir/minime/"
    cp "/Users/daniel/Desktop/minime_self_maintenance.py" "$extract_dir/minime/"
    
    # Create preseed for automated installation
    create_preseed_config "$extract_dir"
    
    # Create post-install script
    create_post_install_script "$extract_dir"
    
    # Modify boot configuration
    modify_boot_config "$extract_dir"
    
    # Create new ISO
    create_iso "$extract_dir"
    
    # Flash to USB
    flash_to_usb
}

create_preseed_config() {
    local extract_dir="$1"
    
    log "Creating automated installation config..."
    
    cat > "$extract_dir/preseed.cfg" << 'PRESEED'
# miniME Fully Automated Installation
d-i debian-installer/locale string en_US.UTF-8
d-i keyboard-configuration/xkb-keymap select us

# Network - auto-configure WiFi
d-i netcfg/choose_interface select auto
d-i netcfg/get_hostname string miniME
d-i netcfg/get_domain string attlocal.net

# Partitioning - COMPLETE DISK WIPE
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string lvm
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# User account
d-i passwd/root-login boolean false
d-i passwd/user-fullname string miniME Agent
d-i passwd/username string minime
d-i passwd/user-password password miniME2024!
d-i passwd/user-password-again password miniME2024!
d-i user-setup/allow-password-weak boolean true

# Packages
tasksel tasksel/first multiselect server, openssh-server
d-i pkgsel/include string curl wget git python3 python3-pip build-essential

# Boot loader
d-i grub-installer/only_debian boolean true
d-i grub-installer/bootdev string /dev/sda

# Post-install
d-i preseed/late_command string \
    cp /cdrom/minime/post_install.sh /target/tmp/ ; \
    in-target chmod +x /tmp/post_install.sh ; \
    in-target /tmp/post_install.sh

d-i finish-install/reboot_in_progress note
PRESEED
}

create_post_install_script() {
    local extract_dir="$1"
    
    log "Creating post-install automation..."
    
    cat > "$extract_dir/minime/post_install.sh" << 'POSTINSTALL'
#!/bin/bash

# miniME Post-Installation Setup
set -euo pipefail

echo "Starting miniME installation..."

# Update system
apt-get update
apt-get upgrade -y

# Install packages
apt-get install -y \
    python3-full python3-pip python3-venv \
    sqlite3 network-manager bluetooth bluez \
    firmware-b43-installer linux-firmware \
    avahi-daemon openssh-server docker.io \
    htop vim nano curl wget git

# Configure hostname
hostnamectl set-hostname miniME
echo "127.0.0.1 miniME.attlocal.net miniME" >> /etc/hosts

# Configure WiFi
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

# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Create miniME directories
mkdir -p /opt/minime/{bin,lib,config,logs,models,cache,memory}
chown -R minime:minime /opt/minime

# Install Python packages
pip3 install --system asyncio aiohttp playwright beautifulsoup4 requests anthropic openai flask sqlite3 psutil

# Copy miniME components
cp /cdrom/minime/*.py /opt/minime/lib/

# Create configuration
cat > /opt/minime/config/config.json << 'CONFIG'
{
    "version": "1.0.0",
    "hostname": "miniME",
    "domain": "miniME.attlocal.net",
    "api_keys": {
        "claude": "\$CLAUDE_API_KEY",
        "openai": "\$OPENAI_API_KEY",
        "github_token": "\$GITHUB_TOKEN"
    },
    "git": {
        "username": "heyfinal", 
        "email": "dgillaspy@me.com"
    },
    "auto_update": true,
    "auto_maintenance": true,
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M", 
        "fast": "phi3:mini"
    }
}
CONFIG

# Create main miniME agent
cat > /opt/minime/bin/minime_agent.py << 'AGENT'
#!/usr/bin/env python3
import sys
sys.path.append('/opt/minime/lib')

import asyncio
import json
from minime_protocol import MiniMEProtocol, ClaudeInterface
from minime_memory import MiniMEMemory
from minime_self_maintenance import SelfMaintenanceSystem

class MiniMEAgent:
    def __init__(self):
        with open('/opt/minime/config/config.json') as f:
            self.config = json.load(f)
        
        self.claude = ClaudeInterface(self.config['api_keys']['claude'])
        self.memory = MiniMEMemory()
        self.maintenance = SelfMaintenanceSystem()
        
        print(f"🤖 miniME Agent initialized - {self.config['hostname']}")
    
    async def start(self):
        print("🚀 miniME Agent starting...")
        print("Capabilities: Complete system control, Claude oversight, self-maintenance")
        
        # Start all subsystems
        await asyncio.gather(
            self.main_agent_loop(),
            self.maintenance.start_maintenance_loop()
        )
    
    async def main_agent_loop(self):
        while True:
            try:
                # Main agent logic here
                await asyncio.sleep(10)
            except Exception as e:
                print(f"Agent error: {e}")
                await asyncio.sleep(30)

if __name__ == "__main__":
    agent = MiniMEAgent()
    asyncio.run(agent.start())
AGENT

chmod +x /opt/minime/bin/minime_agent.py

# Create systemd service
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

[Install]
WantedBy=multi-user.target
SERVICE

# Enable services
systemctl daemon-reload
systemctl enable minime
systemctl enable ollama
systemctl enable ssh

# Download models in background
cat > /opt/minime/bin/download_models.sh << 'MODELS'
#!/bin/bash
sleep 120  # Wait for network
ollama pull mistral:7b-instruct-q4_K_M &
ollama pull phi3:mini &
wait
touch /opt/minime/.models_ready
MODELS

chmod +x /opt/minime/bin/download_models.sh

# Create model download service
cat > /etc/systemd/system/minime-models.service << 'MODELSERVICE'
[Unit]
Description=miniME Model Download
After=network-online.target

[Service]
Type=oneshot
User=minime
ExecStart=/opt/minime/bin/download_models.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
MODELSERVICE

systemctl enable minime-models

echo "✅ miniME installation complete! Rebooting..."
sleep 5
reboot
POSTINSTALL

    chmod +x "$extract_dir/minime/post_install.sh"
}

modify_boot_config() {
    local extract_dir="$1"
    
    log "Configuring automated boot..."
    
    # Modify GRUB for auto-install
    if [ -f "$extract_dir/boot/grub/grub.cfg" ]; then
        cat > "$extract_dir/boot/grub/grub.cfg" << 'GRUB'
set timeout=10
set default=0

menuentry "miniME Automated Installation (WILL ERASE DISK!)" {
    set gfxpayload=keep
    linux /casper/vmlinuz boot=casper automatic-ubiquity noprompt quiet splash preseed/file=/cdrom/preseed.cfg ---
    initrd /casper/initrd
}

menuentry "Ubuntu Server Live" {
    set gfxpayload=keep
    linux /casper/vmlinuz boot=casper quiet splash ---
    initrd /casper/initrd
}
GRUB
    fi
}

create_iso() {
    local extract_dir="$1"
    
    log "Creating miniME bootable ISO..."
    
    local output_iso="/Users/daniel/Desktop/miniME-OS-Bootable.iso"
    
    # Use hdiutil to create ISO (macOS method)
    hdiutil makehybrid -o "$output_iso" -hfs -joliet -iso "$extract_dir"
    
    log "✅ Bootable ISO created: $output_iso"
}

flash_to_usb() {
    log "Flashing to USB drive $USB_DEVICE..."
    
    local iso_file="/Users/daniel/Desktop/miniME-OS-Bootable.iso"
    
    warn "This will COMPLETELY ERASE USB drive $USB_DEVICE!"
    read -p "Continue? (yes/no): " confirm
    
    if [[ "$confirm" != "yes" ]]; then
        log "USB flashing cancelled"
        return
    fi
    
    # Unmount USB
    diskutil unmountDisk force "$USB_DEVICE" || true
    
    # Flash ISO to USB
    log "Flashing (this takes several minutes)..."
    sudo dd if="$iso_file" of="/dev/r$USB_DEVICE" bs=1m status=progress
    
    sync
    diskutil eject "$USB_DEVICE"
    
    log "✅ miniME OS flashed to USB!"
    log "Ready for Mac Mini deployment:"
    log "1. Insert USB into Mac Mini"
    log "2. Hold Option key during boot"
    log "3. Select USB drive"
    log "4. miniME will auto-install and take over"
}

main() {
    show_banner
    
    log "Building complete miniME takeover OS..."
    log "Features: Auto-install, self-update, self-maintain, Claude oversight"
    
    if [[ $EUID -eq 0 ]]; then
        error "Don't run as root initially (will prompt for sudo when needed)"
    fi
    
    create_bootable_installer
    
    log "🎉 miniME bootable OS complete!"
    log "Your Mac Mini will be completely transformed into an autonomous AI agent"
}

main "$@"
