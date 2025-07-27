#!/bin/bash

# ========================
# GitHub Repository Setup Script
# Creates and pushes miniME-OS to GitHub
# ========================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[GitHub Setup]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

# Load credentials from secure file
CREDS_FILE="$HOME/Desktop/Programming/.credentials"
if [[ -f "$CREDS_FILE" ]]; then
    source "$CREDS_FILE"
    GITHUB_TOKEN="$GITHUB_TOKEN"
    GITHUB_USER="$GITHUB_USERNAME"
else
    echo "Credentials file not found: $CREDS_FILE"
    exit 1
fi
REPO_NAME="miniME-OS"

show_banner() {
    clear
    echo -e "\033[0;35m"
    cat << 'EOF'
▄▄▄▄  ▄ ▄▄▄▄  ▄ ▗▖  ▗▖▗▄▄▄▖
█ █ █ ▄ █   █ ▄ ▐▛▚▞▜▌▐▌   
█   █ █ █   █ █ ▐▌  ▐▌▐▛▀▀▘
      █       █ ▐▌  ▐▌▐▙▄▄▖
EOF
    echo -e "\033[0m"
    echo
    echo -e "${CYAN}📦 GitHub Repository Setup 📦${NC}"
    echo -e "${CYAN}    miniME Autonomous AI Agent${NC}"
    echo
}

create_github_repo() {
    log "Creating GitHub repository..."
    
    local response=$(curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/user/repos \
        -d "{
            \"name\": \"$REPO_NAME\",
            \"description\": \"🤖 Autonomous AI Agent System - Complete Mac Mini takeover with unrestricted AI capabilities, Claude oversight, and continuous learning. Transform your hardware into an autonomous AI agent.\",
            \"homepage\": \"https://github.com/$GITHUB_USER/$REPO_NAME\",
            \"private\": false,
            \"has_issues\": true,
            \"has_projects\": true,
            \"has_wiki\": true,
            \"has_downloads\": true,
            \"auto_init\": false
        }")
    
    if echo "$response" | grep -q '"full_name"'; then
        log "✅ Repository created successfully"
        local repo_url=$(echo "$response" | grep '"html_url"' | cut -d'"' -f4)
        info "Repository URL: $repo_url"
    else
        error "Failed to create repository"
        echo "Response: $response"
        exit 1
    fi
}

setup_git_remote() {
    log "Setting up Git remote..."
    
    # Remove existing remote if it exists
    git remote remove origin 2>/dev/null || true
    
    # Add new remote with token authentication
    git remote add origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
    
    log "✅ Git remote configured"
}

push_to_github() {
    log "Pushing to GitHub..."
    
    # Push main branch
    git branch -M main
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        log "✅ Successfully pushed to GitHub"
        info "Repository: https://github.com/$GITHUB_USER/$REPO_NAME"
    else
        error "Failed to push to GitHub"
        exit 1
    fi
}

create_release() {
    log "Creating initial release..."
    
    local release_response=$(curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME/releases" \
        -d '{
            "tag_name": "v1.0.0",
            "target_commitish": "main",
            "name": "🚀 miniME v1.0.0 - Initial Release",
            "body": "## 🎉 Initial Release of miniME Autonomous AI Agent System\n\n### ✨ Features\n- **Complete Mac Mini Takeover** - Bootable OS with full system control\n- **Autonomous AI Agent** - Self-installing, self-updating, self-maintaining\n- **Claude Oversight** - Intelligent safety checks and compressed communication\n- **Continuous Learning** - Memory system that logs and learns from all interactions\n- **Unrestricted Capabilities** - Web automation, system commands, network control\n- **Professional UI** - ASCII banners, splash screens, and custom icon\n\n### 🚀 Quick Start\n```bash\ngit clone https://github.com/heyfinal/miniME-OS.git\ncd miniME-OS\n./deploy.sh\n```\n\n### ⚠️ Important\nThis system will **COMPLETELY ERASE** the target machine and transform it into an autonomous AI agent. Use with caution and ensure you have backups.\n\n### 🤝 Credits\n- **AI Architecture**: Claude (Anthropic Sonnet 4) - Complete system design and implementation\n- **Project Vision**: Daniel Gillaspy (@heyfinal) - Concept, requirements, and visual design\n\n---\n**Transform your Mac Mini into an autonomous AI agent today!** 🤖",
            "draft": false,
            "prerelease": false,
            "generate_release_notes": false
        }')
    
    if echo "$release_response" | grep -q '"tag_name"'; then
        log "✅ Release v1.0.0 created successfully"
        local release_url=$(echo "$release_response" | grep '"html_url"' | head -1 | cut -d'"' -f4)
        info "Release URL: $release_url"
    else
        warn "Release creation failed (repository still created successfully)"
    fi
}

show_summary() {
    echo
    echo -e "${GREEN}🎉 GitHub Setup Complete!${NC}"
    echo
    echo -e "${CYAN}📋 Repository Details:${NC}"
    echo "• Name: miniME-OS"
    echo "• Owner: heyfinal"
    echo "• URL: https://github.com/heyfinal/miniME-OS"
    echo "• Type: Public repository"
    echo
    echo -e "${CYAN}✨ Features Enabled:${NC}"
    echo "• Issues tracking"
    echo "• Projects (for roadmap)"
    echo "• Wiki (for documentation)"
    echo "• Releases (v1.0.0 created)"
    echo
    echo -e "${CYAN}📖 Next Steps:${NC}"
    echo "1. Visit repository on GitHub"
    echo "2. Share with community"
    echo "3. Accept contributions"
    echo "4. Deploy autonomous AI agents!"
    echo
}

main() {
    show_banner
    
    log "Setting up miniME-OS GitHub repository"
    log "Repository: $GITHUB_USER/$REPO_NAME"
    
    # Check if we're in a git repository
    if [ ! -d ".git" ]; then
        error "Not in a Git repository. Run from project root."
        exit 1
    fi
    
    # Check if there are commits
    if ! git log --oneline -1 &>/dev/null; then
        error "No commits found. Please commit your changes first."
        exit 1
    fi
    
    create_github_repo
    setup_git_remote
    push_to_github
    create_release
    show_summary
    
    log "🚀 miniME-OS successfully published to GitHub!"
}

# Run if this script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi