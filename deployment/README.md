# miniME Autonomous AI Agent OS

**Complete Mac Mini takeover system with unrestricted AI capabilities**

## 🚀 Project Overview

miniME is a bootable Linux OS that completely transforms a Mac Mini into an autonomous AI agent with:
- **Unrestricted web research & automation**
- **Complete system control** 
- **Claude oversight** for safety decisions
- **Self-updating & self-maintaining**
- **Continuous learning** from all interactions
- **Network-wide deployment** capabilities

## 📁 Project Structure

```
miniME-OS/
├── README.md                      # This file
├── minime_protocol.py             # Compressed Claude ↔ miniME communication
├── minime_memory.py               # Conversation logging & learning system
├── minime_self_maintenance.py     # Auto-update & maintenance system
├── minime_installer.sh            # Main OS installer script
├── create_minime_bootable.sh      # Creates bootable ISO
├── create_minime_usb.sh           # USB creation utility
├── build_minime_os.sh             # Complete OS builder
└── quick_usb_create.sh            # Quick USB installer
```

## 🎯 Key Features

### Autonomous Operation
- **Self-installing**: Complete disk wipe and OS installation
- **Self-updating**: Automatic system and model updates
- **Self-maintaining**: Cleanup, optimization, health monitoring
- **Self-learning**: Continuous improvement from interactions

### AI Capabilities
- **Local LLM inference** (Mistral 7B, CodeLlama, Phi-3)
- **Web automation** with Playwright
- **System command execution**
- **Network security monitoring**
- **Research and data collection**

### Claude Integration
- **Compressed communication protocol** (minimal token usage)
- **Oversight for risky operations**
- **Learning from Claude interactions**
- **Escalation for complex decisions**

## ⚙️ Installation Process

### Automated Installation
1. **Boot from USB** (hold Option key on Mac Mini)
2. **Complete disk wipe** (automatic)
3. **Ubuntu Server installation** (unattended)
4. **miniME framework setup** (automatic)
5. **AI model downloads** (background)
6. **Network configuration** (WiFi: Home/tiny2222)
7. **Service startup** (miniME agent launches)

### Hardware Support
- **Mac Mini 2014+** (primary target)
- **WiFi & Bluetooth drivers** (BCM43xx firmware)
- **All Mac hardware** (sensors, thermal, etc.)
- **External storage** (USB 3.0/Thunderbolt optimization)

## 🔧 Configuration

### Embedded Credentials
- **Claude API**: Loaded from credentials file
- **OpenAI API**: Loaded from credentials file  
- **GitHub**: Loaded from credentials file
- **Network**: Home/tiny2222 (auto-configured)
- **Hostname**: miniME.attlocal.net

### Models
- **Primary**: Mistral 7B (4-bit quantized) 
- **Coding**: CodeLlama 7B (4-bit quantized)
- **Fast**: Phi-3 Mini (2.3GB)

## 🚀 Deployment

### Create Bootable USB
```bash
cd ~/Desktop/programming/miniME-OS
chmod +x create_minime_bootable.sh
./create_minime_bootable.sh
```

### Mac Mini Installation
1. Insert USB into Mac Mini
2. Hold Option key during boot
3. Select USB drive
4. Installation runs automatically (30 minutes)
5. miniME agent starts on first boot

## 📡 Network Access

### Local Access
- **SSH**: `ssh minime@miniME.attlocal.net`
- **Web UI**: `http://miniME.attlocal.net:8080`
- **API**: `http://miniME.attlocal.net:8080/api`

### Capabilities
- **Web scraping** any site
- **System administration** 
- **File system access**
- **Network scanning**
- **User simulation** (clicks, forms, etc.)
- **Research automation**

## 🧠 Learning System

### Conversation Logging
- **All AI interactions** logged to SQLite
- **Project organization** by topic
- **Pattern recognition** for optimization
- **Success rate tracking**

### Continuous Improvement
- **User preference learning**
- **Performance optimization** 
- **Model selection optimization**
- **Task success prediction**

## 🔄 Self-Maintenance

### Automatic Updates
- **System packages** (daily)
- **Python packages** (daily)
- **AI models** (weekly)
- **miniME framework** (from GitHub releases)

### Health Monitoring
- **Resource usage** tracking
- **Service health** checks
- **Automatic restarts** on failure
- **Performance optimization**

### Cleanup Tasks
- **Log rotation** (30 days)
- **Cache cleanup** (weekly)
- **Database optimization** (weekly)
- **Disk space management**

## ⚠️ Security Model

### Claude Oversight
- **High-risk operations** require Claude approval
- **Compressed communication** (minimal API usage)
- **Learning from approvals/denials**
- **Escalation protocols**

### Local Autonomy
- **Safe operations** run automatically
- **Research tasks** unrestricted
- **System monitoring** continuous
- **Web automation** unlimited

## 🔧 Development

### Core Components
1. **Communication Protocol** (`minime_protocol.py`)
   - Token-minimized Claude API calls
   - Compressed message format
   - Error handling and retries

2. **Memory System** (`minime_memory.py`)
   - Conversation database
   - Learning engine
   - Project management
   - Pattern analysis

3. **Self-Maintenance** (`minime_self_maintenance.py`)
   - Update management
   - Health monitoring
   - Performance optimization
   - Service management

### Extension Points
- **Custom research modules**
- **Additional AI services**
- **Network service discovery**
- **Hardware integration**

## 📊 System Requirements

### Minimum Hardware
- **RAM**: 8GB (6GB for models, 2GB for system)
- **Storage**: 120GB internal + 1TB external
- **Network**: WiFi or Ethernet
- **Architecture**: x86_64 (Intel/AMD)

### Optimal Performance
- **Mac Mini 2014+** (tested configuration)
- **SSD storage** (internal + external)
- **Stable internet** (for Claude API)
- **Dedicated machine** (autonomous operation)

## 🎯 Use Cases

### Research & Development
- **Autonomous research** on any topic
- **Code analysis** and optimization
- **System administration** tasks
- **Security monitoring**

### Network Services
- **Local AI inference** for other devices
- **Web scraping** service
- **Automation hub** for home/office
- **Security monitoring** node

### Learning Platform
- **AI interaction** logging and analysis
- **Performance optimization** research
- **Edge AI** deployment testing
- **Multi-agent** coordination

## 🚨 Important Notes

### Deployment Warning
- **COMPLETE DISK WIPE**: All data on target machine will be erased
- **Network takeover**: Machine becomes autonomous AI agent
- **Unrestricted access**: Full system control granted to AI
- **Continuous operation**: Runs 24/7 without user interaction

### Operational Considerations
- **Power requirements**: Stable power recommended
- **Network stability**: Internet required for Claude oversight
- **Physical security**: Machine has full network access
- **Monitoring**: Check logs for autonomous activities

## 📞 Support

### Logs & Debugging
- **System logs**: `/opt/minime/logs/minime.log`
- **Maintenance logs**: `/opt/minime/logs/maintenance.log`  
- **Health status**: `/opt/minime/logs/health_status.json`
- **Conversations**: `/opt/minime/memory/conversations.db`

### Configuration
- **Main config**: `/opt/minime/config/config.json`
- **Network**: `/etc/netplan/01-netcfg.yaml`
- **Services**: `/etc/systemd/system/minime*.service`

---

**⚡ Ready to deploy autonomous AI across your network!**