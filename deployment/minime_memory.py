#!/usr/bin/env python3
"""
miniME Memory & Learning System
Logs, analyzes, and learns from all AI conversations
"""

import json
import sqlite3
import hashlib
import time
import os
from datetime import datetime, timedelta
from typing import Dict, Any, List, Optional, Tuple
from pathlib import Path
import threading
import asyncio

class ConversationLogger:
    """Logs all AI conversations for learning and analysis"""
    
    def __init__(self, db_path: str = "/opt/minime/memory/conversations.db"):
        self.db_path = db_path
        self.setup_database()
        self.lock = threading.Lock()
        
    def setup_database(self):
        """Initialize conversation database"""
        os.makedirs(os.path.dirname(self.db_path), exist_ok=True)
        
        with sqlite3.connect(self.db_path) as conn:
            conn.execute('''
                CREATE TABLE IF NOT EXISTS conversations (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    timestamp TEXT NOT NULL,
                    session_id TEXT NOT NULL,
                    ai_service TEXT NOT NULL,
                    user_message TEXT NOT NULL,
                    ai_response TEXT NOT NULL,
                    message_hash TEXT UNIQUE NOT NULL,
                    tokens_used INTEGER DEFAULT 0,
                    response_time_ms INTEGER DEFAULT 0,
                    success BOOLEAN DEFAULT TRUE,
                    context_tags TEXT,
                    project_id TEXT,
                    sentiment_score REAL DEFAULT 0.0
                )
            ''')
            
            conn.execute('''
                CREATE TABLE IF NOT EXISTS projects (
                    id TEXT PRIMARY KEY,
                    name TEXT NOT NULL,
                    description TEXT,
                    created_at TEXT NOT NULL,
                    updated_at TEXT NOT NULL,
                    status TEXT DEFAULT 'active',
                    tags TEXT,
                    conversation_count INTEGER DEFAULT 0
                )
            ''')
            
            conn.execute('''
                CREATE TABLE IF NOT EXISTS learning_patterns (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    pattern_type TEXT NOT NULL,
                    pattern_data TEXT NOT NULL,
                    frequency INTEGER DEFAULT 1,
                    success_rate REAL DEFAULT 0.0,
                    last_seen TEXT NOT NULL,
                    created_at TEXT NOT NULL
                )
            ''')
            
            conn.execute('''
                CREATE TABLE IF NOT EXISTS user_preferences (
                    key TEXT PRIMARY KEY,
                    value TEXT NOT NULL,
                    confidence REAL DEFAULT 0.0,
                    last_updated TEXT NOT NULL
                )
            ''')
    
    def log_conversation(self, 
                        session_id: str,
                        ai_service: str,
                        user_message: str,
                        ai_response: str,
                        tokens_used: int = 0,
                        response_time_ms: int = 0,
                        success: bool = True,
                        context_tags: List[str] = None,
                        project_id: str = None) -> str:
        """Log a conversation exchange"""
        
        timestamp = datetime.now().isoformat()
        message_hash = hashlib.sha256(
            f"{user_message}{ai_response}{timestamp}".encode()
        ).hexdigest()[:16]
        
        context_tags_str = json.dumps(context_tags or [])
        
        with self.lock:
            with sqlite3.connect(self.db_path) as conn:
                try:
                    conn.execute('''
                        INSERT INTO conversations 
                        (timestamp, session_id, ai_service, user_message, ai_response,
                         message_hash, tokens_used, response_time_ms, success, 
                         context_tags, project_id)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''', (timestamp, session_id, ai_service, user_message, ai_response,
                          message_hash, tokens_used, response_time_ms, success,
                          context_tags_str, project_id))
                    
                    # Update project conversation count
                    if project_id:
                        conn.execute('''
                            UPDATE projects 
                            SET conversation_count = conversation_count + 1,
                                updated_at = ?
                            WHERE id = ?
                        ''', (timestamp, project_id))
                    
                except sqlite3.IntegrityError:
                    pass  # Duplicate hash, skip
        
        return message_hash
    
    def create_project(self, name: str, description: str = "", 
                      tags: List[str] = None) -> str:
        """Create a new project for organizing conversations"""
        
        project_id = hashlib.sha256(f"{name}{time.time()}".encode()).hexdigest()[:12]
        timestamp = datetime.now().isoformat()
        tags_str = json.dumps(tags or [])
        
        with sqlite3.connect(self.db_path) as conn:
            conn.execute('''
                INSERT INTO projects (id, name, description, created_at, updated_at, tags)
                VALUES (?, ?, ?, ?, ?, ?)
            ''', (project_id, name, description, timestamp, timestamp, tags_str))
        
        return project_id
    
    def get_project_conversations(self, project_id: str) -> List[Dict[str, Any]]:
        """Get all conversations for a project"""
        
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.execute('''
                SELECT * FROM conversations 
                WHERE project_id = ? 
                ORDER BY timestamp DESC
            ''', (project_id,))
            
            columns = [description[0] for description in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]
    
    def search_conversations(self, query: str, limit: int = 50) -> List[Dict[str, Any]]:
        """Search conversations by content"""
        
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.execute('''
                SELECT * FROM conversations 
                WHERE user_message LIKE ? OR ai_response LIKE ?
                ORDER BY timestamp DESC 
                LIMIT ?
            ''', (f'%{query}%', f'%{query}%', limit))
            
            columns = [description[0] for description in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]

class LearningEngine:
    """Analyzes conversations to learn patterns and preferences"""
    
    def __init__(self, logger: ConversationLogger):
        self.logger = logger
        self.db_path = logger.db_path
        
    def analyze_user_patterns(self) -> Dict[str, Any]:
        """Analyze user behavior patterns"""
        
        with sqlite3.connect(self.db_path) as conn:
            # Most used AI services
            cursor = conn.execute('''
                SELECT ai_service, COUNT(*) as usage_count
                FROM conversations
                GROUP BY ai_service
                ORDER BY usage_count DESC
            ''')
            ai_services = dict(cursor.fetchall())
            
            # Most common time patterns
            cursor = conn.execute('''
                SELECT strftime('%H', timestamp) as hour, COUNT(*) as count
                FROM conversations
                GROUP BY hour
                ORDER BY count DESC
            ''')
            time_patterns = dict(cursor.fetchall())
            
            # Average session length
            cursor = conn.execute('''
                SELECT session_id, COUNT(*) as message_count
                FROM conversations
                GROUP BY session_id
            ''')
            session_lengths = [row[1] for row in cursor.fetchall()]
            avg_session_length = sum(session_lengths) / len(session_lengths) if session_lengths else 0
            
            # Most common topics (from context tags)
            cursor = conn.execute('''
                SELECT context_tags FROM conversations
                WHERE context_tags != '[]' AND context_tags IS NOT NULL
            ''')
            
            all_tags = []
            for row in cursor.fetchall():
                try:
                    tags = json.loads(row[0])
                    all_tags.extend(tags)
                except:
                    continue
            
            tag_counts = {}
            for tag in all_tags:
                tag_counts[tag] = tag_counts.get(tag, 0) + 1
            
            return {
                'preferred_ai_services': ai_services,
                'active_hours': time_patterns,
                'avg_session_length': avg_session_length,
                'common_topics': dict(sorted(tag_counts.items(), 
                                           key=lambda x: x[1], reverse=True)[:10])
            }
    
    def identify_successful_patterns(self) -> List[Dict[str, Any]]:
        """Identify conversation patterns that lead to success"""
        
        patterns = []
        
        with sqlite3.connect(self.db_path) as conn:
            # Successful prompt patterns
            cursor = conn.execute('''
                SELECT user_message, ai_service, success, COUNT(*) as frequency
                FROM conversations
                WHERE LENGTH(user_message) > 10
                GROUP BY SUBSTR(user_message, 1, 50), ai_service, success
                HAVING frequency > 2
                ORDER BY frequency DESC, success DESC
            ''')
            
            for row in cursor.fetchall():
                message_start, service, success, frequency = row
                patterns.append({
                    'pattern_type': 'prompt_start',
                    'pattern': message_start,
                    'service': service,
                    'success_rate': success,
                    'frequency': frequency
                })
        
        return patterns[:20]  # Top 20 patterns
    
    def learn_user_preferences(self) -> Dict[str, Any]:
        """Learn user preferences from conversation history"""
        
        preferences = {}
        
        with sqlite3.connect(self.db_path) as conn:
            # Preferred response length
            cursor = conn.execute('''
                SELECT AVG(LENGTH(ai_response)) as avg_length
                FROM conversations
                WHERE success = 1
            ''')
            avg_response_length = cursor.fetchone()[0] or 500
            
            # Preferred AI services by success rate
            cursor = conn.execute('''
                SELECT ai_service, 
                       COUNT(*) as total,
                       SUM(CASE WHEN success THEN 1 ELSE 0 END) as successful
                FROM conversations
                GROUP BY ai_service
                HAVING total > 5
            ''')
            
            service_preferences = {}
            for service, total, successful in cursor.fetchall():
                success_rate = successful / total
                service_preferences[service] = {
                    'usage_count': total,
                    'success_rate': success_rate,
                    'preference_score': success_rate * min(total / 10, 1.0)
                }
            
            preferences = {
                'preferred_response_length': avg_response_length,
                'ai_service_preferences': service_preferences,
                'last_updated': datetime.now().isoformat()
            }
            
            # Store in database
            for key, value in preferences.items():
                conn.execute('''
                    INSERT OR REPLACE INTO user_preferences (key, value, last_updated)
                    VALUES (?, ?, ?)
                ''', (key, json.dumps(value), datetime.now().isoformat()))
        
        return preferences
    
    def suggest_improvements(self) -> List[Dict[str, Any]]:
        """Suggest improvements based on analysis"""
        
        suggestions = []
        patterns = self.analyze_user_patterns()
        
        # Suggest optimal usage times
        if patterns['active_hours']:
            peak_hour = max(patterns['active_hours'].items(), key=lambda x: x[1])[0]
            suggestions.append({
                'type': 'timing',
                'message': f"You're most productive at {peak_hour}:00. Consider scheduling important AI sessions then.",
                'confidence': 0.8
            })
        
        # Suggest underutilized AI services
        if len(patterns['preferred_ai_services']) > 1:
            least_used = min(patterns['preferred_ai_services'].items(), key=lambda x: x[1])
            suggestions.append({
                'type': 'service_diversity',
                'message': f"You rarely use {least_used[0]}. It might be good for different types of tasks.",
                'confidence': 0.6
            })
        
        # Suggest session optimization
        if patterns['avg_session_length'] > 20:
            suggestions.append({
                'type': 'efficiency',
                'message': "Your sessions are quite long. Consider breaking complex tasks into smaller chunks.",
                'confidence': 0.7
            })
        
        return suggestions

class ProjectManager:
    """Manages AI projects and their associated conversations"""
    
    def __init__(self, logger: ConversationLogger):
        self.logger = logger
        
    def auto_create_project(self, conversation_context: Dict[str, Any]) -> Optional[str]:
        """Automatically create project based on conversation context"""
        
        # Look for project indicators in conversation
        user_message = conversation_context.get('user_message', '').lower()
        
        project_keywords = [
            'project', 'build', 'create', 'develop', 'implement',
            'design', 'system', 'application', 'website', 'app'
        ]
        
        if any(keyword in user_message for keyword in project_keywords):
            # Extract potential project name
            words = user_message.split()
            name_candidates = []
            
            for i, word in enumerate(words):
                if word in project_keywords and i + 1 < len(words):
                    name_candidates.append(' '.join(words[i:i+3]))
            
            if name_candidates:
                project_name = name_candidates[0].title()
                return self.logger.create_project(
                    name=project_name,
                    description=f"Auto-created from conversation: {user_message[:100]}...",
                    tags=['auto-created', 'development']
                )
        
        return None
    
    def get_project_summary(self, project_id: str) -> Dict[str, Any]:
        """Get comprehensive project summary"""
        
        conversations = self.logger.get_project_conversations(project_id)
        
        if not conversations:
            return {}
        
        # Calculate metrics
        total_conversations = len(conversations)
        total_tokens = sum(conv.get('tokens_used', 0) for conv in conversations)
        avg_response_time = sum(conv.get('response_time_ms', 0) for conv in conversations) / total_conversations
        
        # Extract key topics
        all_text = ' '.join([conv['user_message'] + ' ' + conv['ai_response'] 
                            for conv in conversations])
        
        # Simple keyword extraction (could be enhanced with NLP)
        words = all_text.lower().split()
        word_freq = {}
        for word in words:
            if len(word) > 4:  # Filter short words
                word_freq[word] = word_freq.get(word, 0) + 1
        
        top_keywords = sorted(word_freq.items(), key=lambda x: x[1], reverse=True)[:10]
        
        return {
            'project_id': project_id,
            'total_conversations': total_conversations,
            'total_tokens_used': total_tokens,
            'avg_response_time_ms': avg_response_time,
            'date_range': {
                'start': conversations[-1]['timestamp'],
                'end': conversations[0]['timestamp']
            },
            'top_keywords': [kw[0] for kw in top_keywords],
            'ai_services_used': list(set(conv['ai_service'] for conv in conversations)),
            'success_rate': sum(1 for conv in conversations if conv.get('success', True)) / total_conversations
        }

# Integration with miniME agent
class MiniMEMemory:
    """Main memory interface for miniME agent"""
    
    def __init__(self):
        self.logger = ConversationLogger()
        self.learning_engine = LearningEngine(self.logger)
        self.project_manager = ProjectManager(self.logger)
        self.current_session_id = self.generate_session_id()
        self.current_project_id = None
        
    def generate_session_id(self) -> str:
        """Generate unique session ID"""
        return hashlib.sha256(f"{time.time()}{os.getpid()}".encode()).hexdigest()[:12]
    
    def log_ai_interaction(self, 
                          ai_service: str,
                          user_message: str,
                          ai_response: str,
                          **kwargs) -> str:
        """Log any AI interaction (miniME, Claude, web AIs, etc.)"""
        
        # Auto-detect project context
        if not self.current_project_id:
            self.current_project_id = self.project_manager.auto_create_project({
                'user_message': user_message,
                'ai_service': ai_service
            })
        
        return self.logger.log_conversation(
            session_id=self.current_session_id,
            ai_service=ai_service,
            user_message=user_message,
            ai_response=ai_response,
            project_id=self.current_project_id,
            **kwargs
        )
    
    def get_context_for_ai(self, query: str, max_results: int = 5) -> List[Dict[str, Any]]:
        """Get relevant conversation history for AI context"""
        
        similar_conversations = self.logger.search_conversations(query, max_results)
        
        # Format for AI consumption
        context = []
        for conv in similar_conversations:
            context.append({
                'previous_query': conv['user_message'][:200],
                'previous_response': conv['ai_response'][:300],
                'success': conv.get('success', True),
                'timestamp': conv['timestamp']
            })
        
        return context
    
    def get_learning_insights(self) -> Dict[str, Any]:
        """Get insights for improving AI interactions"""
        
        return {
            'user_patterns': self.learning_engine.analyze_user_patterns(),
            'successful_patterns': self.learning_engine.identify_successful_patterns(),
            'preferences': self.learning_engine.learn_user_preferences(),
            'suggestions': self.learning_engine.suggest_improvements()
        }
    
    def start_new_session(self, project_name: str = None):
        """Start a new conversation session"""
        
        self.current_session_id = self.generate_session_id()
        
        if project_name:
            self.current_project_id = self.logger.create_project(
                name=project_name,
                description=f"Session started: {datetime.now().isoformat()}"
            )
        else:
            self.current_project_id = None

# Export for use in miniME agent
__all__ = ['MiniMEMemory', 'ConversationLogger', 'LearningEngine', 'ProjectManager']