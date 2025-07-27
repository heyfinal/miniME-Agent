#!/usr/bin/env python3
"""
miniME ↔ Claude Compressed Communication Protocol
Ultra-minimal token usage for efficient API calls
"""

import json
import base64
import zlib
from typing import Dict, Any, List, Optional
from enum import Enum

class MsgType(Enum):
    """Message types - single char codes"""
    QUERY = 'Q'      # miniME asking Claude
    APPROVE = 'A'    # Request approval 
    REPORT = 'R'     # Status/results report
    ERROR = 'E'      # Error condition
    LEARN = 'L'      # Learning/pattern update

class Priority(Enum):
    """Priority levels"""
    LOW = '0'
    MED = '1' 
    HIGH = '2'
    CRIT = '3'

class MiniMEProtocol:
    """Ultra-compressed communication protocol"""
    
    # Action code mappings (2-char codes)
    ACTIONS = {
        'web_scrape': 'WS',
        'system_cmd': 'SC', 
        'file_ops': 'FO',
        'network_scan': 'NS',
        'install_pkg': 'IP',
        'mod_config': 'MC',
        'user_sim': 'US',  # Simulate user interaction
        'auto_click': 'AC',
        'form_fill': 'FF',
        'download': 'DL',
        'upload': 'UL'
    }
    
    # Response codes
    RESPONSES = {
        'approved': 'OK',
        'denied': 'NO', 
        'modify': 'MD',
        'escalate': 'UP',
        'learn': 'LN'
    }
    
    @staticmethod
    def compress_message(msg_type: MsgType, action: str, context: Dict[str, Any], 
                        priority: Priority = Priority.MED) -> str:
        """Compress message to minimal tokens"""
        
        # Build compressed structure
        compressed = {
            't': msg_type.value,
            'p': priority.value,
            'a': MiniMEProtocol.ACTIONS.get(action, action[:2].upper()),
            'c': context
        }
        
        # Convert to JSON and compress
        json_str = json.dumps(compressed, separators=(',', ':'))
        compressed_bytes = zlib.compress(json_str.encode('utf-8'))
        b64_str = base64.b64encode(compressed_bytes).decode('ascii')
        
        return f"miniME:{b64_str}"
    
    @staticmethod
    def decompress_message(compressed_msg: str) -> Dict[str, Any]:
        """Decompress Claude's response"""
        if not compressed_msg.startswith('miniME:'):
            return {'error': 'Invalid message format'}
            
        try:
            b64_str = compressed_msg[7:]  # Remove 'miniME:' prefix
            compressed_bytes = base64.b64decode(b64_str)
            json_str = zlib.decompress(compressed_bytes).decode('utf-8')
            return json.loads(json_str)
        except Exception as e:
            return {'error': f'Decompression failed: {e}'}
    
    @staticmethod 
    def create_query(action: str, target: str, params: Dict = None, 
                    risk_level: str = 'low') -> str:
        """Create a query message"""
        context = {
            'tgt': target,       # Target (URL, file, command)
            'prm': params or {}, # Parameters
            'rsk': risk_level,   # Risk assessment
            'ts': int(__import__('time').time()) # Timestamp
        }
        
        return MiniMEProtocol.compress_message(
            MsgType.QUERY, action, context, 
            Priority.HIGH if risk_level == 'high' else Priority.MED
        )
    
    @staticmethod
    def create_approval_request(action: str, command: str, reason: str) -> str:
        """Create approval request"""
        context = {
            'cmd': command,
            'rsn': reason,
            'usr': __import__('getpass').getuser()
        }
        
        return MiniMEProtocol.compress_message(
            MsgType.APPROVE, action, context, Priority.HIGH
        )
    
    @staticmethod
    def create_report(action: str, result: Any, success: bool = True) -> str:
        """Create status report"""
        context = {
            'res': str(result)[:200],  # Truncate long results
            'ok': success,
            'sz': len(str(result)) if result else 0
        }
        
        return MiniMEProtocol.compress_message(
            MsgType.REPORT, action, context, Priority.LOW
        )

class ClaudeInterface:
    """Interface for Claude API calls with compressed protocol"""
    
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.conversation_history = []
        
    def send_compressed(self, compressed_msg: str, 
                       system_prompt: str = None) -> Dict[str, Any]:
        """Send compressed message to Claude"""
        
        if not system_prompt:
            system_prompt = (
                "You are miniME's oversight system. Respond with compressed "
                "messages using the miniME: protocol. Parse the compressed "
                "context and respond with approval/guidance. Be concise."
            )
        
        # This would integrate with actual Claude API
        # For now, returning mock structure
        return {
            'response': f"miniME:{compressed_msg}",  # Echo for testing
            'tokens_used': len(compressed_msg.split()),
            'decision': 'approved'
        }

# Example usage and testing
if __name__ == "__main__":
    protocol = MiniMEProtocol()
    
    # Test query
    query_msg = protocol.create_query(
        'web_scrape', 
        'https://suspicious-site.com',
        {'timeout': 30, 'user_agent': 'custom'},
        'medium'
    )
    print(f"Query message: {query_msg}")
    print(f"Length: {len(query_msg)} chars")
    
    # Test decompression
    decompressed = protocol.decompress_message(query_msg)
    print(f"Decompressed: {decompressed}")
    
    # Test approval request
    approval_msg = protocol.create_approval_request(
        'system_cmd',
        'sudo rm -rf /suspicious/files',
        'Removing malware detected by scan'
    )
    print(f"Approval request: {approval_msg}")
    
    # Test report
    report_msg = protocol.create_report(
        'web_scrape',
        {'status': 200, 'title': 'Legitimate site', 'threats': 0},
        True
    )
    print(f"Report: {report_msg}")