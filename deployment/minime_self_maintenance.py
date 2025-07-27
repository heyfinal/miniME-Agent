#!/usr/bin/env python3
"""
miniME Self-Maintenance System
Handles automatic updates, upgrades, model management, and system optimization
"""

import asyncio
import json
import logging
import os
import subprocess
import sys
import time
import hashlib
import requests
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, Any, List, Optional, Tuple

class SelfMaintenanceSystem:
    """Complete autonomous maintenance for miniME"""
    
    def __init__(self, config_path: str = "/opt/minime/config/config.json"):
        self.config_path = config_path
        self.config = self.load_config()
        self.logger = self.setup_logging()
        
        # Maintenance settings
        self.update_check_interval = 3600  # 1 hour
        self.model_update_interval = 86400  # 24 hours
        self.system_cleanup_interval = 604800  # 7 days
        self.health_check_interval = 300  # 5 minutes
        
        # Maintenance state
        self.last_update_check = 0
        self.last_model_update = 0
        self.last_cleanup = 0
        self.last_health_check = 0
        
        # Version tracking
        self.current_version = self.config.get('version', '1.0.0')
        self.github_repo = "heyfinal/minime-os"  # Your repo
        
    def setup_logging(self) -> logging.Logger:
        """Setup maintenance logging"""
        logger = logging.getLogger('miniME-Maintenance')
        logger.setLevel(logging.INFO)
        
        handler = logging.FileHandler('/opt/minime/logs/maintenance.log')
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        
        return logger
    
    def load_config(self) -> Dict[str, Any]:
        """Load configuration"""
        try:
            with open(self.config_path, 'r') as f:
                return json.load(f)
        except Exception as e:
            return {}
    
    def save_config(self):
        """Save updated configuration"""
        try:
            with open(self.config_path, 'w') as f:
                json.dump(self.config, f, indent=2)
        except Exception as e:
            self.logger.error(f"Failed to save config: {e}")
    
    async def start_maintenance_loop(self):
        """Start the main maintenance loop"""
        self.logger.info("🔧 miniME Self-Maintenance System starting...")
        
        while True:
            try:
                current_time = time.time()
                
                # Check for system updates
                if current_time - self.last_update_check > self.update_check_interval:
                    await self.check_and_apply_updates()
                    self.last_update_check = current_time
                
                # Update AI models
                if current_time - self.last_model_update > self.model_update_interval:
                    await self.update_ai_models()
                    self.last_model_update = current_time
                
                # System cleanup
                if current_time - self.last_cleanup > self.system_cleanup_interval:
                    await self.perform_system_cleanup()
                    self.last_cleanup = current_time
                
                # Health check
                if current_time - self.last_health_check > self.health_check_interval:
                    await self.perform_health_check()
                    self.last_health_check = current_time
                
                # Sleep before next cycle
                await asyncio.sleep(60)  # Check every minute
                
            except Exception as e:
                self.logger.error(f"Maintenance loop error: {e}")
                await asyncio.sleep(300)  # Wait 5 minutes on error
    
    async def check_and_apply_updates(self):
        """Check for and apply system updates"""
        self.logger.info("Checking for system updates...")
        
        try:
            # Check miniME updates from GitHub
            await self.check_minime_updates()
            
            # Check OS package updates
            await self.update_system_packages()
            
            # Check Python package updates
            await self.update_python_packages()
            
            # Check Ollama updates
            await self.update_ollama()
            
        except Exception as e:
            self.logger.error(f"Update check failed: {e}")
    
    async def check_minime_updates(self):
        """Check for miniME framework updates"""
        try:
            # Get latest release from GitHub
            api_url = f"https://api.github.com/repos/{self.github_repo}/releases/latest"
            
            headers = {}
            if self.config.get('api_keys', {}).get('github_token'):
                headers['Authorization'] = f"token {self.config['api_keys']['github_token']}"
            
            response = requests.get(api_url, headers=headers, timeout=30)
            
            if response.status_code == 200:
                release_data = response.json()
                latest_version = release_data['tag_name'].lstrip('v')
                
                if self.is_newer_version(latest_version, self.current_version):
                    self.logger.info(f"New miniME version available: {latest_version}")
                    await self.update_minime_framework(release_data)
                else:
                    self.logger.info("miniME framework is up to date")
            
        except Exception as e:
            self.logger.error(f"Failed to check miniME updates: {e}")
    
    async def update_minime_framework(self, release_data: Dict[str, Any]):
        """Update miniME framework to latest version"""
        try:
            self.logger.info("Updating miniME framework...")
            
            # Download update package
            download_url = None
            for asset in release_data.get('assets', []):
                if asset['name'].endswith('.tar.gz'):
                    download_url = asset['browser_download_url']
                    break
            
            if not download_url:
                self.logger.error("No update package found")
                return
            
            # Download and extract update
            update_dir = "/tmp/minime_update"
            os.makedirs(update_dir, exist_ok=True)
            
            # Download
            response = requests.get(download_url, stream=True)
            update_file = f"{update_dir}/minime_update.tar.gz"
            
            with open(update_file, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            
            # Extract and install
            subprocess.run(['tar', '-xzf', update_file, '-C', update_dir], check=True)
            
            # Stop miniME service
            subprocess.run(['systemctl', 'stop', 'minime'], check=True)
            
            # Backup current installation
            backup_dir = f"/opt/minime/backup_{int(time.time())}"
            subprocess.run(['cp', '-r', '/opt/minime/bin', backup_dir], check=True)
            
            # Install update
            if os.path.exists(f"{update_dir}/minime/bin"):
                subprocess.run(['cp', '-r', f'{update_dir}/minime/bin/*', '/opt/minime/bin/'], 
                             shell=True, check=True)
            
            if os.path.exists(f"{update_dir}/minime/lib"):
                subprocess.run(['cp', '-r', f'{update_dir}/minime/lib/*', '/opt/minime/lib/'], 
                             shell=True, check=True)
            
            # Update version in config
            self.config['version'] = release_data['tag_name'].lstrip('v')
            self.current_version = self.config['version']
            self.save_config()
            
            # Restart miniME service
            subprocess.run(['systemctl', 'start', 'minime'], check=True)
            
            self.logger.info(f"miniME updated to version {self.current_version}")
            
            # Cleanup
            subprocess.run(['rm', '-rf', update_dir], check=True)
            
        except Exception as e:
            self.logger.error(f"miniME update failed: {e}")
            # Attempt to restart service even if update failed
            try:
                subprocess.run(['systemctl', 'start', 'minime'], check=True)
            except:
                pass
    
    async def update_system_packages(self):
        """Update system packages"""
        try:
            self.logger.info("Updating system packages...")
            
            # Update package list
            result = subprocess.run(['apt', 'update'], 
                                  capture_output=True, text=True, check=True)
            
            # List upgradeable packages
            result = subprocess.run(['apt', 'list', '--upgradeable'], 
                                  capture_output=True, text=True)
            
            if "Listing..." not in result.stdout or len(result.stdout.strip().split('\n')) <= 1:
                self.logger.info("No system package updates available")
                return
            
            # Perform upgrade
            self.logger.info("Installing system package updates...")
            subprocess.run(['apt', 'upgrade', '-y'], check=True)
            
            # Auto-remove unnecessary packages
            subprocess.run(['apt', 'autoremove', '-y'], check=True)
            
            self.logger.info("System packages updated successfully")
            
        except Exception as e:
            self.logger.error(f"System package update failed: {e}")
    
    async def update_python_packages(self):
        """Update Python packages"""
        try:
            self.logger.info("Checking Python package updates...")
            
            # Get list of outdated packages
            result = subprocess.run(['pip3', 'list', '--outdated', '--format=json'], 
                                  capture_output=True, text=True)
            
            if result.returncode == 0:
                outdated = json.loads(result.stdout)
                
                if not outdated:
                    self.logger.info("Python packages are up to date")
                    return
                
                # Update packages
                package_names = [pkg['name'] for pkg in outdated]
                self.logger.info(f"Updating Python packages: {', '.join(package_names)}")
                
                subprocess.run(['pip3', 'install', '--upgrade'] + package_names, 
                             check=True)
                
                self.logger.info("Python packages updated successfully")
            
        except Exception as e:
            self.logger.error(f"Python package update failed: {e}")
    
    async def update_ollama(self):
        """Update Ollama to latest version"""
        try:
            self.logger.info("Checking Ollama updates...")
            
            # Get current version
            result = subprocess.run(['ollama', '--version'], 
                                  capture_output=True, text=True)
            
            if result.returncode == 0:
                # Update Ollama
                self.logger.info("Updating Ollama...")
                subprocess.run(['curl', '-fsSL', 'https://ollama.com/install.sh'], 
                             stdout=subprocess.PIPE, check=True)
                
                # Restart Ollama service
                subprocess.run(['systemctl', 'restart', 'ollama'], check=True)
                
                self.logger.info("Ollama updated successfully")
            
        except Exception as e:
            self.logger.error(f"Ollama update failed: {e}")
    
    async def update_ai_models(self):
        """Update AI models to latest versions"""
        try:
            self.logger.info("Checking AI model updates...")
            
            models = self.config.get('models', {})
            
            for model_type, model_name in models.items():
                try:
                    self.logger.info(f"Updating {model_type} model: {model_name}")
                    
                    # Pull latest version
                    result = subprocess.run(['ollama', 'pull', model_name], 
                                          capture_output=True, text=True, timeout=3600)
                    
                    if result.returncode == 0:
                        self.logger.info(f"Model {model_name} updated successfully")
                    else:
                        self.logger.error(f"Failed to update model {model_name}: {result.stderr}")
                
                except subprocess.TimeoutExpired:
                    self.logger.warning(f"Model update timeout for {model_name}")
                except Exception as e:
                    self.logger.error(f"Model update error for {model_name}: {e}")
            
            # Clean up old model versions
            await self.cleanup_old_models()
            
        except Exception as e:
            self.logger.error(f"AI model update failed: {e}")
    
    async def cleanup_old_models(self):
        """Remove old model versions to save space"""
        try:
            self.logger.info("Cleaning up old model versions...")
            
            # Get list of models
            result = subprocess.run(['ollama', 'list'], 
                                  capture_output=True, text=True)
            
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')[1:]  # Skip header
                
                model_versions = {}
                for line in lines:
                    if line.strip():
                        parts = line.split()
                        if len(parts) >= 2:
                            name = parts[0]
                            base_name = name.split(':')[0]
                            
                            if base_name not in model_versions:
                                model_versions[base_name] = []
                            model_versions[base_name].append(name)
                
                # Keep only the latest version of each model
                for base_name, versions in model_versions.items():
                    if len(versions) > 1:
                        # Sort versions and keep the latest
                        versions.sort()
                        for old_version in versions[:-1]:
                            try:
                                self.logger.info(f"Removing old model version: {old_version}")
                                subprocess.run(['ollama', 'rm', old_version], 
                                             check=True, capture_output=True)
                            except Exception as e:
                                self.logger.error(f"Failed to remove {old_version}: {e}")
            
        except Exception as e:
            self.logger.error(f"Model cleanup failed: {e}")
    
    async def perform_system_cleanup(self):
        """Perform comprehensive system cleanup"""
        try:
            self.logger.info("Performing system cleanup...")
            
            # Clean package cache
            subprocess.run(['apt', 'clean'], check=True)
            subprocess.run(['apt', 'autoclean'], check=True)
            
            # Clean logs older than 30 days
            log_dirs = ['/var/log', '/opt/minime/logs']
            for log_dir in log_dirs:
                if os.path.exists(log_dir):
                    subprocess.run([
                        'find', log_dir, '-name', '*.log*', 
                        '-mtime', '+30', '-delete'
                    ], check=False)  # Don't fail if some files can't be deleted
            
            # Clean temporary files
            temp_dirs = ['/tmp', '/var/tmp']
            for temp_dir in temp_dirs:
                subprocess.run([
                    'find', temp_dir, '-type', 'f', 
                    '-atime', '+7', '-delete'
                ], check=False)
            
            # Clean miniME cache
            cache_dir = '/opt/minime/cache'
            if os.path.exists(cache_dir):
                # Remove cache files older than 7 days
                subprocess.run([
                    'find', cache_dir, '-type', 'f', 
                    '-mtime', '+7', '-delete'
                ], check=False)
            
            # Optimize databases
            await self.optimize_databases()
            
            self.logger.info("System cleanup completed")
            
        except Exception as e:
            self.logger.error(f"System cleanup failed: {e}")
    
    async def optimize_databases(self):
        """Optimize miniME databases"""
        try:
            db_files = [
                '/opt/minime/memory/conversations.db',
                '/opt/minime/memory/learning.db'
            ]
            
            for db_file in db_files:
                if os.path.exists(db_file):
                    self.logger.info(f"Optimizing database: {db_file}")
                    
                    # SQLite vacuum and analyze
                    subprocess.run([
                        'sqlite3', db_file, 'VACUUM; ANALYZE;'
                    ], check=True)
            
        except Exception as e:
            self.logger.error(f"Database optimization failed: {e}")
    
    async def perform_health_check(self):
        """Perform system health check"""
        try:
            health_status = {
                'timestamp': datetime.now().isoformat(),
                'status': 'healthy',
                'issues': []
            }
            
            # Check disk space
            result = subprocess.run(['df', '-h', '/'], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')
                if len(lines) > 1:
                    usage = lines[1].split()[4].rstrip('%')
                    if int(usage) > 90:
                        health_status['issues'].append(f"Disk usage high: {usage}%")
            
            # Check memory usage
            result = subprocess.run(['free'], capture_output=True, text=True)
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')
                if len(lines) > 1:
                    mem_line = lines[1].split()
                    total_mem = int(mem_line[1])
                    used_mem = int(mem_line[2])
                    mem_usage = (used_mem / total_mem) * 100
                    
                    if mem_usage > 90:
                        health_status['issues'].append(f"Memory usage high: {mem_usage:.1f}%")
            
            # Check if miniME service is running
            result = subprocess.run(['systemctl', 'is-active', 'minime'], 
                                  capture_output=True, text=True)
            if result.returncode != 0:
                health_status['issues'].append("miniME service not running")
                # Attempt to restart
                try:
                    subprocess.run(['systemctl', 'restart', 'minime'], check=True)
                    self.logger.info("Restarted miniME service")
                except Exception as e:
                    self.logger.error(f"Failed to restart miniME service: {e}")
            
            # Check if Ollama is running
            result = subprocess.run(['systemctl', 'is-active', 'ollama'], 
                                  capture_output=True, text=True)
            if result.returncode != 0:
                health_status['issues'].append("Ollama service not running")
                try:
                    subprocess.run(['systemctl', 'restart', 'ollama'], check=True)
                    self.logger.info("Restarted Ollama service")
                except Exception as e:
                    self.logger.error(f"Failed to restart Ollama service: {e}")
            
            # Update health status
            if health_status['issues']:
                health_status['status'] = 'degraded'
                self.logger.warning(f"Health check issues: {', '.join(health_status['issues'])}")
            
            # Save health status
            health_file = '/opt/minime/logs/health_status.json'
            with open(health_file, 'w') as f:
                json.dump(health_status, f, indent=2)
            
        except Exception as e:
            self.logger.error(f"Health check failed: {e}")
    
    def is_newer_version(self, version1: str, version2: str) -> bool:
        """Compare version numbers"""
        try:
            v1_parts = [int(x) for x in version1.split('.')]
            v2_parts = [int(x) for x in version2.split('.')]
            
            # Pad shorter version with zeros
            max_len = max(len(v1_parts), len(v2_parts))
            v1_parts.extend([0] * (max_len - len(v1_parts)))
            v2_parts.extend([0] * (max_len - len(v2_parts)))
            
            return v1_parts > v2_parts
        except Exception:
            return False

class SelfInstallingUpdater:
    """Handles self-installation and bootstrapping of updates"""
    
    def __init__(self):
        self.logger = logging.getLogger('miniME-SelfInstaller')
        
    async def bootstrap_installation(self):
        """Bootstrap initial installation if needed"""
        if not os.path.exists('/opt/minime/config/config.json'):
            await self.perform_initial_setup()
    
    async def perform_initial_setup(self):
        """Perform initial setup on first boot"""
        try:
            self.logger.info("Performing initial miniME setup...")
            
            # Create directory structure
            os.makedirs('/opt/minime/config', exist_ok=True)
            os.makedirs('/opt/minime/logs', exist_ok=True)
            os.makedirs('/opt/minime/memory', exist_ok=True)
            
            # Create initial config
            initial_config = {
                "version": "1.0.0",
                "hostname": "miniME",
                "domain": "miniME.attlocal.net",
                "first_boot": True,
                "auto_update": True,
                "auto_maintenance": True
            }
            
            with open('/opt/minime/config/config.json', 'w') as f:
                json.dump(initial_config, f, indent=2)
            
            self.logger.info("Initial setup completed")
            
        except Exception as e:
            self.logger.error(f"Initial setup failed: {e}")

# Main maintenance service
async def main():
    """Main maintenance service entry point"""
    
    # Setup logging
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler('/opt/minime/logs/maintenance.log'),
            logging.StreamHandler()
        ]
    )
    
    # Bootstrap if needed
    installer = SelfInstallingUpdater()
    await installer.bootstrap_installation()
    
    # Start maintenance system
    maintenance = SelfMaintenanceSystem()
    await maintenance.start_maintenance_loop()

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("Maintenance system shutdown requested")
    except Exception as e:
        print(f"Maintenance system fatal error: {e}")
        sys.exit(1)