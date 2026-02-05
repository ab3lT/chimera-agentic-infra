# Technical Specification

## 1. API Contracts

### 1.1 Task Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "AgentTask",
  "type": "object",
  "required": ["task_id", "task_type", "priority", "context", "status"],
  "properties": {
    "task_id": {
      "type": "string",
      "format": "uuid",
      "description": "Unique identifier for the task"
    },
    "task_type": {
      "type": "string",
      "enum": ["generate_content", "reply_comment", "execute_transaction", "analyze_trend"]
    },
    "priority": {
      "type": "string",
      "enum": ["high", "medium", "low"]
    },
    "context": {
      "type": "object",
      "properties": {
        "goal_description": {"type": "string"},
        "persona_constraints": {"type": "array", "items": {"type": "string"}},
        "required_resources": {"type": "array", "items": {"type": "string"}}
      }
    },
    "assigned_worker_id": {"type": ["string", "null"]},
    "created_at": {"type": "string", "format": "date-time"},
    "status": {
      "type": "string",
      "enum": ["pending", "in_progress", "review", "complete", "failed"]
    }
  }
}
```

### 1.2 Task Result Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "TaskResult",
  "type": "object",
  "required": ["task_id", "worker_id", "status", "confidence_score"],
  "properties": {
    "task_id": {"type": "string", "format": "uuid"},
    "worker_id": {"type": "string"},
    "status": {"type": "string", "enum": ["success", "failure"]},
    "confidence_score": {"type": "number", "minimum": 0, "maximum": 1},
    "artifact": {
      "type": "object",
      "properties": {
        "content_type": {"type": "string"},
        "content": {"type": "string"},
        "metadata": {"type": "object"}
      }
    },
    "error": {
      "type": ["object", "null"],
      "properties": {
        "code": {"type": "string"},
        "message": {"type": "string"}
      }
    },
    "completed_at": {"type": "string", "format": "date-time"}
  }
}
```

### 1.3 Trend Data Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "TrendData",
  "type": "object",
  "required": ["topic", "relevance_score", "source", "timestamp"],
  "properties": {
    "topic": {"type": "string", "minLength": 1},
    "relevance_score": {"type": "number", "minimum": 0, "maximum": 1},
    "source": {"type": "string"},
    "timestamp": {"type": "string", "format": "date-time"},
    "related_topics": {"type": "array", "items": {"type": "string"}},
    "sentiment": {"type": "string", "enum": ["positive", "negative", "neutral"]}
  }
}
```

---

## 2. Database Schema

### 2.1 Entity Relationship Diagram

```
┌─────────────────┐       ┌─────────────────┐
│     agents      │       │    campaigns    │
├─────────────────┤       ├─────────────────┤
│ id (PK)         │       │ id (PK)         │
│ name            │       │ name            │
│ persona_path    │       │ goal_description│
│ wallet_address  │       │ budget          │
│ status          │       │ start_date      │
│ created_at      │       │ end_date        │
└────────┬────────┘       └────────┬────────┘
         │                         │
         │    ┌─────────────────┐  │
         └───▶│     tasks       │◀─┘
              ├─────────────────┤
              │ id (PK)         │
              │ agent_id (FK)   │
              │ campaign_id (FK)│
              │ type            │
              │ status          │
              │ priority        │
              │ context_json    │
              │ created_at      │
              └────────┬────────┘
                       │
         ┌─────────────┴─────────────┐
         ▼                           ▼
┌─────────────────┐       ┌─────────────────┐
│   memories      │       │  transactions   │
├─────────────────┤       ├─────────────────┤
│ id (PK)         │       │ id (PK)         │
│ agent_id (FK)   │       │ agent_id (FK)   │
│ content         │       │ amount          │
│ embedding       │       │ currency        │
│ timestamp       │       │ to_address      │
└─────────────────┘       │ tx_hash         │
                          │ status          │
                          └─────────────────┘
```

### 2.2 Table Definitions

```sql
-- Agents table
CREATE TABLE agents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    persona_path VARCHAR(500) NOT NULL,
    wallet_address VARCHAR(42),
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tasks table
CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agent_id UUID REFERENCES agents(id),
    campaign_id UUID REFERENCES campaigns(id),
    type VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    priority VARCHAR(10) DEFAULT 'medium',
    context_json JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transactions table
CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agent_id UUID REFERENCES agents(id),
    amount DECIMAL(18, 8) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    to_address VARCHAR(42) NOT NULL,
    tx_hash VARCHAR(66),
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 3. MCP Tool Definitions

### 3.1 Social Post Tool

```json
{
  "name": "post_content",
  "description": "Publishes text and media to a connected social platform",
  "inputSchema": {
    "type": "object",
    "properties": {
      "platform": {"type": "string", "enum": ["twitter", "instagram", "threads"]},
      "text_content": {"type": "string", "maxLength": 280},
      "media_urls": {"type": "array", "items": {"type": "string"}},
      "disclosure_level": {"type": "string", "enum": ["automated", "assisted", "none"]}
    },
    "required": ["platform", "text_content"]
  }
}
```

### 3.2 Memory Search Tool

```json
{
  "name": "search_memory",
  "description": "Searches agent's long-term memory for relevant context",
  "inputSchema": {
    "type": "object",
    "properties": {
      "agent_id": {"type": "string"},
      "query": {"type": "string"},
      "limit": {"type": "integer", "default": 5}
    },
    "required": ["agent_id", "query"]
  }
}
```
