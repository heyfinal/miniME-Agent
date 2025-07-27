#!/bin/bash

# Quick miniME USB Creator (automated)
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME USB]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

USB_DRIVE="disk2"  # Your 30.8GB USB

log "Creating miniME installer on $USB_DRIVE..."

# Unmount and erase
log "Erasing USB drive..."
diskutil unmountDisk force "$USB_DRIVE" || true
diskutil eraseDisk JHFS+ "miniME-Installer" "$USB_DRIVE"

# Wait for mount
sleep 3

if [ ! -d "/Volumes/miniME-Installer" ]; then
    echo "Failed to format USB"
    exit 1
fi

log "Adding miniME components..."

# Create directory structure
mkdir -p "/Volumes/miniME-Installer/miniME"/{scripts,deps}

# Copy all miniME files
cp "/Users/daniel/Desktop/minime_installer.sh" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_protocol.py" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_memory.py" "/Volumes/miniME-Installer/miniME/"

# Create splash screen
cat > "/Volumes/miniME-Installer/miniME/splash.sh" << 'SPLASH'
#!/bin/bash
clear
echo -e "\033[0;35m"
cat << 'EOF'
    ███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗
    ████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝
    ██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗  
    ██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝  
    ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗
    ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝

        🤖 AUTONOMOUS AI AGENT SYSTEM 🤖
                  Version 1.0.0

    Features:
    • Unrestricted AI capabilities
    • Claude integration for oversight  
    • Web automation & research
    • Network security monitoring
    • Learning & memory system
    • Full system control

    ⚠️  This installation will COMPLETELY ERASE the target machine!
EOF
echo -e "\033[0m"
sleep 3
SPLASH

chmod +x "/Volumes/miniME-Installer/miniME/splash.sh"

# Create quick install script
cat > "/Volumes/miniME-Installer/miniME/quick_install.sh" << 'QUICK'
#!/bin/bash

# Quick miniME Installation
clear
./splash.sh

echo "Starting miniME installation..."
echo "This will:"
echo "1. Install Python environment"
echo "2. Install Ollama AI engine"
echo "3. Download AI models"
echo "4. Configure miniME agent"
echo "5. Set up Claude integration"
echo

read -p "Enter Claude API key: " claude_key
read -p "Enter network name: " network_name

echo "Installing miniME..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Python packages
echo "Installing Python dependencies..."
pip3 install asyncio aiohttp playwright beautifulsoup4 requests sqlite3

# Install Ollama
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Create miniME directories
echo "Setting up miniME..."
sudo mkdir -p /opt/minime/{bin,lib,config,logs,models,cache,memory}

# Copy files
sudo cp minime_protocol.py /opt/minime/lib/
sudo cp minime_memory.py /opt/minime/lib/

# Create config
cat > /tmp/minime_config.json << EOF
{
    "version": "1.0.0",
    "network_name": "$network_name",
    "claude_api_key": "$claude_key",
    "node_id": "$(uuidgen)",
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M",
        "fast": "phi3:mini"
    }
}
EOF

sudo cp /tmp/minime_config.json /opt/minime/config/config.json

# Create miniME agent
sudo cat > /opt/minime/bin/minime_agent.py << 'AGENT'
#!/usr/bin/env python3
import sys
sys.path.append('/opt/minime/lib')

from minime_protocol import MiniMEProtocol, ClaudeInterface
from minime_memory import MiniMEMemory
import asyncio
import json
import subprocess
import time

class MiniMEAgent:
    def __init__(self):
        with open('/opt/minime/config/config.json') as f:
            self.config = json.load(f)
        
        self.claude = ClaudeInterface(self.config['claude_api_key'])
        self.memory = MiniMEMemory()
        self.protocol = MiniMEProtocol()
        
        print(f"miniME Agent initialized for network: {self.config['network_name']}")
    
    async def start(self):
        print("🚀 miniME Agent is now online!")
        print("Capabilities: Web research, system control, learning, Claude oversight")
        
        # Start main loop
        while True:
            try:
                await self.process_tasks()
                await asyncio.sleep(10)
            except KeyboardInterrupt:
                print("miniME Agent shutting down...")
                break
            except Exception as e:
                print(f"Error: {e}")
                await asyncio.sleep(30)
    
    async def process_tasks(self):
        # Check for network tasks
        # Monitor system
        # Learn from interactions
        pass

if __name__ == "__main__":
    agent = MiniMEAgent()
    asyncio.run(agent.start())
AGENT

sudo chmod +x /opt/minime/bin/minime_agent.py

# Start Ollama
echo "Starting Ollama..."
ollama serve &
sleep 5

# Download models
echo "Downloading AI models (this will take time)..."
ollama pull mistral:7b-instruct-q4_K_M &
ollama pull phi3:mini &

# Create startup service
sudo cat > /Library/LaunchDaemons/com.minime.agent.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.minime.agent</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>/opt/minime/bin/minime_agent.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/opt/minime/logs/minime.log</string>
    <key>StandardErrorPath</key>
    <string>/opt/minime/logs/minime.log</string>
</dict>
</plist>
PLIST

echo "✅ miniME installation complete!"
echo "The agent will start automatically on reboot."
echo "Logs: /opt/minime/logs/minime.log"
echo "Config: /opt/minime/config/config.json"

# Start the agent now
echo "Starting miniME agent..."
python3 /opt/minime/bin/minime_agent.py
QUICK

chmod +x "/Volumes/miniME-Installer/miniME/quick_install.sh"

# Create README
cat > "/Volumes/miniME-Installer/README.txt" << 'README'
miniME Autonomous AI Agent Installer
===================================

INSTALLATION:
1. Open Terminal
2. Navigate to this USB: cd /Volumes/miniME-Installer/miniME
3. Run: ./quick_install.sh
4. Enter your Claude API key when prompted
5. Enter a network name for identification

REQUIREMENTS:
- Claude API key (get from console.anthropic.com)
- Internet connection
- Administrator privileges

The system will:
- Install AI framework
- Download language models
- Configure autonomous agent
- Set up memory & learning systems
- Enable Claude oversight integration

After installation, miniME will run automatically and provide:
- Unrestricted web research
- System automation
- Continuous learning
- Network-wide AI capabilities

WARNING: Grant miniME full system access for optimal operation.
README

# Eject USB
log "Finalizing USB..."
sync
diskutil eject "$USB_DRIVE"

log "✅ miniME bootable USB created successfully!"
log "Insert into target Mac Mini and run ./quick_install.sh"
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

# Quick miniME USB Creator (automated)
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME USB]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

USB_DRIVE="disk2"  # Your 30.8GB USB

log "Creating miniME installer on $USB_DRIVE..."

# Unmount and erase
log "Erasing USB drive..."
diskutil unmountDisk force "$USB_DRIVE" || true
diskutil eraseDisk JHFS+ "miniME-Installer" "$USB_DRIVE"

# Wait for mount
sleep 3

if [ ! -d "/Volumes/miniME-Installer" ]; then
    echo "Failed to format USB"
    exit 1
fi

log "Adding miniME components..."

# Create directory structure
mkdir -p "/Volumes/miniME-Installer/miniME"/{scripts,deps}

# Copy all miniME files
cp "/Users/daniel/Desktop/minime_installer.sh" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_protocol.py" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_memory.py" "/Volumes/miniME-Installer/miniME/"

# Create splash screen
cat > "/Volumes/miniME-Installer/miniME/splash.sh" << 'SPLASH'
#!/bin/bash
clear
echo -e "\033[0;35m"
cat << 'EOF'
    ███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗
    ████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝
    ██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗  
    ██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝  
    ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗
    ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝

        🤖 AUTONOMOUS AI AGENT SYSTEM 🤖
                  Version 1.0.0

    Features:
    • Unrestricted AI capabilities
    • Claude integration for oversight  
    • Web automation & research
    • Network security monitoring
    • Learning & memory system
    • Full system control

    ⚠️  This installation will COMPLETELY ERASE the target machine!
EOF
echo -e "\033[0m"
sleep 3
SPLASH

chmod +x "/Volumes/miniME-Installer/miniME/splash.sh"

# Create quick install script
cat > "/Volumes/miniME-Installer/miniME/quick_install.sh" << 'QUICK'
#!/bin/bash

# Quick miniME Installation
clear
./splash.sh

echo "Starting miniME installation..."
echo "This will:"
echo "1. Install Python environment"
echo "2. Install Ollama AI engine"
echo "3. Download AI models"
echo "4. Configure miniME agent"
echo "5. Set up Claude integration"
echo

read -p "Enter Claude API key: " claude_key
read -p "Enter network name: " network_name

echo "Installing miniME..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Python packages
echo "Installing Python dependencies..."
pip3 install asyncio aiohttp playwright beautifulsoup4 requests sqlite3

# Install Ollama
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Create miniME directories
echo "Setting up miniME..."
sudo mkdir -p /opt/minime/{bin,lib,config,logs,models,cache,memory}

# Copy files
sudo cp minime_protocol.py /opt/minime/lib/
sudo cp minime_memory.py /opt/minime/lib/

# Create config
cat > /tmp/minime_config.json << EOF
{
    "version": "1.0.0",
    "network_name": "$network_name",
    "claude_api_key": "$claude_key",
    "node_id": "$(uuidgen)",
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M",
        "fast": "phi3:mini"
    }
}
EOF

sudo cp /tmp/minime_config.json /opt/minime/config/config.json

# Create miniME agent
sudo cat > /opt/minime/bin/minime_agent.py << 'AGENT'
#!/usr/bin/env python3
import sys
sys.path.append('/opt/minime/lib')

from minime_protocol import MiniMEProtocol, ClaudeInterface
from minime_memory import MiniMEMemory
import asyncio
import json
import subprocess
import time

class MiniMEAgent:
    def __init__(self):
        with open('/opt/minime/config/config.json') as f:
            self.config = json.load(f)
        
        self.claude = ClaudeInterface(self.config['claude_api_key'])
        self.memory = MiniMEMemory()
        self.protocol = MiniMEProtocol()
        
        print(f"miniME Agent initialized for network: {self.config['network_name']}")
    
    async def start(self):
        print("🚀 miniME Agent is now online!")
        print("Capabilities: Web research, system control, learning, Claude oversight")
        
        # Start main loop
        while True:
            try:
                await self.process_tasks()
                await asyncio.sleep(10)
            except KeyboardInterrupt:
                print("miniME Agent shutting down...")
                break
            except Exception as e:
                print(f"Error: {e}")
                await asyncio.sleep(30)
    
    async def process_tasks(self):
        # Check for network tasks
        # Monitor system
        # Learn from interactions
        pass

if __name__ == "__main__":
    agent = MiniMEAgent()
    asyncio.run(agent.start())
AGENT

sudo chmod +x /opt/minime/bin/minime_agent.py

# Start Ollama
echo "Starting Ollama..."
ollama serve &
sleep 5

# Download models
echo "Downloading AI models (this will take time)..."
ollama pull mistral:7b-instruct-q4_K_M &
ollama pull phi3:mini &

# Create startup service
sudo cat > /Library/LaunchDaemons/com.minime.agent.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.minime.agent</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>/opt/minime/bin/minime_agent.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/opt/minime/logs/minime.log</string>
    <key>StandardErrorPath</key>
    <string>/opt/minime/logs/minime.log</string>
</dict>
</plist>
PLIST

echo "✅ miniME installation complete!"
echo "The agent will start automatically on reboot."
echo "Logs: /opt/minime/logs/minime.log"
echo "Config: /opt/minime/config/config.json"

# Start the agent now
echo "Starting miniME agent..."
python3 /opt/minime/bin/minime_agent.py
QUICK

chmod +x "/Volumes/miniME-Installer/miniME/quick_install.sh"

# Create README
cat > "/Volumes/miniME-Installer/README.txt" << 'README'
miniME Autonomous AI Agent Installer
===================================

INSTALLATION:
1. Open Terminal
2. Navigate to this USB: cd /Volumes/miniME-Installer/miniME
3. Run: ./quick_install.sh
4. Enter your Claude API key when prompted
5. Enter a network name for identification

REQUIREMENTS:
- Claude API key (get from console.anthropic.com)
- Internet connection
- Administrator privileges

The system will:
- Install AI framework
- Download language models
- Configure autonomous agent
- Set up memory & learning systems
- Enable Claude oversight integration

After installation, miniME will run automatically and provide:
- Unrestricted web research
- System automation
- Continuous learning
- Network-wide AI capabilities

WARNING: Grant miniME full system access for optimal operation.
README

# Eject USB
log "Finalizing USB..."
sync
diskutil eject "$USB_DRIVE"

log "✅ miniME bootable USB created successfully!"
log "Insert into target Mac Mini and run ./quick_install.sh"
#!/bin/bash

# Quick miniME USB Creator (automated)
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME USB]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

USB_DRIVE="disk2"  # Your 30.8GB USB

log "Creating miniME installer on $USB_DRIVE..."

# Unmount and erase
log "Erasing USB drive..."
diskutil unmountDisk force "$USB_DRIVE" || true
diskutil eraseDisk JHFS+ "miniME-Installer" "$USB_DRIVE"

# Wait for mount
sleep 3

if [ ! -d "/Volumes/miniME-Installer" ]; then
    echo "Failed to format USB"
    exit 1
fi

log "Adding miniME components..."

# Create directory structure
mkdir -p "/Volumes/miniME-Installer/miniME"/{scripts,deps}

# Copy all miniME files
cp "/Users/daniel/Desktop/minime_installer.sh" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_protocol.py" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_memory.py" "/Volumes/miniME-Installer/miniME/"

# Create splash screen
cat > "/Volumes/miniME-Installer/miniME/splash.sh" << 'SPLASH'
#!/bin/bash
clear
echo -e "\033[0;35m"
cat << 'EOF'
    ███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗
    ████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝
    ██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗  
    ██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝  
    ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗
    ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝

        🤖 AUTONOMOUS AI AGENT SYSTEM 🤖
                  Version 1.0.0

    Features:
    • Unrestricted AI capabilities
    • Claude integration for oversight  
    • Web automation & research
    • Network security monitoring
    • Learning & memory system
    • Full system control

    ⚠️  This installation will COMPLETELY ERASE the target machine!
EOF
echo -e "\033[0m"
sleep 3
SPLASH

chmod +x "/Volumes/miniME-Installer/miniME/splash.sh"

# Create quick install script
cat > "/Volumes/miniME-Installer/miniME/quick_install.sh" << 'QUICK'
#!/bin/bash

# Quick miniME Installation
clear
./splash.sh

echo "Starting miniME installation..."
echo "This will:"
echo "1. Install Python environment"
echo "2. Install Ollama AI engine"
echo "3. Download AI models"
echo "4. Configure miniME agent"
echo "5. Set up Claude integration"
echo

read -p "Enter Claude API key: " claude_key
read -p "Enter network name: " network_name

echo "Installing miniME..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Python packages
echo "Installing Python dependencies..."
pip3 install asyncio aiohttp playwright beautifulsoup4 requests sqlite3

# Install Ollama
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Create miniME directories
echo "Setting up miniME..."
sudo mkdir -p /opt/minime/{bin,lib,config,logs,models,cache,memory}

# Copy files
sudo cp minime_protocol.py /opt/minime/lib/
sudo cp minime_memory.py /opt/minime/lib/

# Create config
cat > /tmp/minime_config.json << EOF
{
    "version": "1.0.0",
    "network_name": "$network_name",
    "claude_api_key": "$claude_key",
    "node_id": "$(uuidgen)",
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M",
        "fast": "phi3:mini"
    }
}
EOF

sudo cp /tmp/minime_config.json /opt/minime/config/config.json

# Create miniME agent
sudo cat > /opt/minime/bin/minime_agent.py << 'AGENT'
#!/usr/bin/env python3
import sys
sys.path.append('/opt/minime/lib')

from minime_protocol import MiniMEProtocol, ClaudeInterface
from minime_memory import MiniMEMemory
import asyncio
import json
import subprocess
import time

class MiniMEAgent:
    def __init__(self):
        with open('/opt/minime/config/config.json') as f:
            self.config = json.load(f)
        
        self.claude = ClaudeInterface(self.config['claude_api_key'])
        self.memory = MiniMEMemory()
        self.protocol = MiniMEProtocol()
        
        print(f"miniME Agent initialized for network: {self.config['network_name']}")
    
    async def start(self):
        print("🚀 miniME Agent is now online!")
        print("Capabilities: Web research, system control, learning, Claude oversight")
        
        # Start main loop
        while True:
            try:
                await self.process_tasks()
                await asyncio.sleep(10)
            except KeyboardInterrupt:
                print("miniME Agent shutting down...")
                break
            except Exception as e:
                print(f"Error: {e}")
                await asyncio.sleep(30)
    
    async def process_tasks(self):
        # Check for network tasks
        # Monitor system
        # Learn from interactions
        pass

if __name__ == "__main__":
    agent = MiniMEAgent()
    asyncio.run(agent.start())
AGENT

sudo chmod +x /opt/minime/bin/minime_agent.py

# Start Ollama
echo "Starting Ollama..."
ollama serve &
sleep 5

# Download models
echo "Downloading AI models (this will take time)..."
ollama pull mistral:7b-instruct-q4_K_M &
ollama pull phi3:mini &

# Create startup service
sudo cat > /Library/LaunchDaemons/com.minime.agent.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.minime.agent</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>/opt/minime/bin/minime_agent.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/opt/minime/logs/minime.log</string>
    <key>StandardErrorPath</key>
    <string>/opt/minime/logs/minime.log</string>
</dict>
</plist>
PLIST

echo "✅ miniME installation complete!"
echo "The agent will start automatically on reboot."
echo "Logs: /opt/minime/logs/minime.log"
echo "Config: /opt/minime/config/config.json"

# Start the agent now
echo "Starting miniME agent..."
python3 /opt/minime/bin/minime_agent.py
QUICK

chmod +x "/Volumes/miniME-Installer/miniME/quick_install.sh"

# Create README
cat > "/Volumes/miniME-Installer/README.txt" << 'README'
miniME Autonomous AI Agent Installer
===================================

INSTALLATION:
1. Open Terminal
2. Navigate to this USB: cd /Volumes/miniME-Installer/miniME
3. Run: ./quick_install.sh
4. Enter your Claude API key when prompted
5. Enter a network name for identification

REQUIREMENTS:
- Claude API key (get from console.anthropic.com)
- Internet connection
- Administrator privileges

The system will:
- Install AI framework
- Download language models
- Configure autonomous agent
- Set up memory & learning systems
- Enable Claude oversight integration

After installation, miniME will run automatically and provide:
- Unrestricted web research
- System automation
- Continuous learning
- Network-wide AI capabilities

WARNING: Grant miniME full system access for optimal operation.
README

# Eject USB
log "Finalizing USB..."
sync
diskutil eject "$USB_DRIVE"

log "✅ miniME bootable USB created successfully!"
log "Insert into target Mac Mini and run ./quick_install.sh"
#!/bin/bash

# Quick miniME USB Creator (automated)
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[miniME USB]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

USB_DRIVE="disk2"  # Your 30.8GB USB

log "Creating miniME installer on $USB_DRIVE..."

# Unmount and erase
log "Erasing USB drive..."
diskutil unmountDisk force "$USB_DRIVE" || true
diskutil eraseDisk JHFS+ "miniME-Installer" "$USB_DRIVE"

# Wait for mount
sleep 3

if [ ! -d "/Volumes/miniME-Installer" ]; then
    echo "Failed to format USB"
    exit 1
fi

log "Adding miniME components..."

# Create directory structure
mkdir -p "/Volumes/miniME-Installer/miniME"/{scripts,deps}

# Copy all miniME files
cp "/Users/daniel/Desktop/minime_installer.sh" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_protocol.py" "/Volumes/miniME-Installer/miniME/"
cp "/Users/daniel/Desktop/minime_memory.py" "/Volumes/miniME-Installer/miniME/"

# Create splash screen
cat > "/Volumes/miniME-Installer/miniME/splash.sh" << 'SPLASH'
#!/bin/bash
clear
echo -e "\033[0;35m"
cat << 'EOF'
    ███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗███████╗
    ████╗ ████║██║████╗  ██║██║████╗ ████║██╔════╝
    ██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║█████╗  
    ██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══╝  
    ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║███████╗
    ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚══════╝

        🤖 AUTONOMOUS AI AGENT SYSTEM 🤖
                  Version 1.0.0

    Features:
    • Unrestricted AI capabilities
    • Claude integration for oversight  
    • Web automation & research
    • Network security monitoring
    • Learning & memory system
    • Full system control

    ⚠️  This installation will COMPLETELY ERASE the target machine!
EOF
echo -e "\033[0m"
sleep 3
SPLASH

chmod +x "/Volumes/miniME-Installer/miniME/splash.sh"

# Create quick install script
cat > "/Volumes/miniME-Installer/miniME/quick_install.sh" << 'QUICK'
#!/bin/bash

# Quick miniME Installation
clear
./splash.sh

echo "Starting miniME installation..."
echo "This will:"
echo "1. Install Python environment"
echo "2. Install Ollama AI engine"
echo "3. Download AI models"
echo "4. Configure miniME agent"
echo "5. Set up Claude integration"
echo

read -p "Enter Claude API key: " claude_key
read -p "Enter network name: " network_name

echo "Installing miniME..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Python packages
echo "Installing Python dependencies..."
pip3 install asyncio aiohttp playwright beautifulsoup4 requests sqlite3

# Install Ollama
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Create miniME directories
echo "Setting up miniME..."
sudo mkdir -p /opt/minime/{bin,lib,config,logs,models,cache,memory}

# Copy files
sudo cp minime_protocol.py /opt/minime/lib/
sudo cp minime_memory.py /opt/minime/lib/

# Create config
cat > /tmp/minime_config.json << EOF
{
    "version": "1.0.0",
    "network_name": "$network_name",
    "claude_api_key": "$claude_key",
    "node_id": "$(uuidgen)",
    "models": {
        "primary": "mistral:7b-instruct-q4_K_M",
        "coding": "codellama:7b-instruct-q4_K_M",
        "fast": "phi3:mini"
    }
}
EOF

sudo cp /tmp/minime_config.json /opt/minime/config/config.json

# Create miniME agent
sudo cat > /opt/minime/bin/minime_agent.py << 'AGENT'
#!/usr/bin/env python3
import sys
sys.path.append('/opt/minime/lib')

from minime_protocol import MiniMEProtocol, ClaudeInterface
from minime_memory import MiniMEMemory
import asyncio
import json
import subprocess
import time

class MiniMEAgent:
    def __init__(self):
        with open('/opt/minime/config/config.json') as f:
            self.config = json.load(f)
        
        self.claude = ClaudeInterface(self.config['claude_api_key'])
        self.memory = MiniMEMemory()
        self.protocol = MiniMEProtocol()
        
        print(f"miniME Agent initialized for network: {self.config['network_name']}")
    
    async def start(self):
        print("🚀 miniME Agent is now online!")
        print("Capabilities: Web research, system control, learning, Claude oversight")
        
        # Start main loop
        while True:
            try:
                await self.process_tasks()
                await asyncio.sleep(10)
            except KeyboardInterrupt:
                print("miniME Agent shutting down...")
                break
            except Exception as e:
                print(f"Error: {e}")
                await asyncio.sleep(30)
    
    async def process_tasks(self):
        # Check for network tasks
        # Monitor system
        # Learn from interactions
        pass

if __name__ == "__main__":
    agent = MiniMEAgent()
    asyncio.run(agent.start())
AGENT

sudo chmod +x /opt/minime/bin/minime_agent.py

# Start Ollama
echo "Starting Ollama..."
ollama serve &
sleep 5

# Download models
echo "Downloading AI models (this will take time)..."
ollama pull mistral:7b-instruct-q4_K_M &
ollama pull phi3:mini &

# Create startup service
sudo cat > /Library/LaunchDaemons/com.minime.agent.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.minime.agent</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>/opt/minime/bin/minime_agent.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/opt/minime/logs/minime.log</string>
    <key>StandardErrorPath</key>
    <string>/opt/minime/logs/minime.log</string>
</dict>
</plist>
PLIST

echo "✅ miniME installation complete!"
echo "The agent will start automatically on reboot."
echo "Logs: /opt/minime/logs/minime.log"
echo "Config: /opt/minime/config/config.json"

# Start the agent now
echo "Starting miniME agent..."
python3 /opt/minime/bin/minime_agent.py
QUICK

chmod +x "/Volumes/miniME-Installer/miniME/quick_install.sh"

# Create README
cat > "/Volumes/miniME-Installer/README.txt" << 'README'
miniME Autonomous AI Agent Installer
===================================

INSTALLATION:
1. Open Terminal
2. Navigate to this USB: cd /Volumes/miniME-Installer/miniME
3. Run: ./quick_install.sh
4. Enter your Claude API key when prompted
5. Enter a network name for identification

REQUIREMENTS:
- Claude API key (get from console.anthropic.com)
- Internet connection
- Administrator privileges

The system will:
- Install AI framework
- Download language models
- Configure autonomous agent
- Set up memory & learning systems
- Enable Claude oversight integration

After installation, miniME will run automatically and provide:
- Unrestricted web research
- System automation
- Continuous learning
- Network-wide AI capabilities

WARNING: Grant miniME full system access for optimal operation.
README

# Eject USB
log "Finalizing USB..."
sync
diskutil eject "$USB_DRIVE"

log "✅ miniME bootable USB created successfully!"
log "Insert into target Mac Mini and run ./quick_install.sh"
