# Tooling Strategy Document

## Overview

This document defines the two categories of tools in Project Chimera:
1. **Developer Tools (MCP)** - Help developers build the system
2. **Agent Skills (Runtime)** - Capabilities agents use at runtime

## 1. Developer MCP Tools

These tools assist during development and are NOT used by agents at runtime.

### 1.1 Required Tools

| Tool | Purpose | Configuration |
|------|---------|---------------|
| **Tenx MCP Sense** | Flight recorder for agent decisions | Required - always connected |
| **git-mcp** | Version control from IDE agent | GitHub integration |
| **filesystem-mcp** | File read/write operations | Local project scope |

### 1.2 Optional Tools

| Tool | Purpose | When to Use |
|------|---------|-------------|
| **database-mcp** | PostgreSQL/Redis testing | Local development |
| **docker-mcp** | Container management | CI/CD debugging |

## 2. Agent Runtime Skills

Skills are reusable capability packages that Chimera agents invoke at runtime.

### 2.1 Skill Architecture

```
skills/
├── skill_download_video/
│   ├── README.md          # Contract definition
│   ├── __init__.py        # Skill implementation
│   └── tests/             # Skill-specific tests
├── skill_transcribe_audio/
│   ├── README.md
│   ├── __init__.py
│   └── tests/
└── skill_generate_content/
    ├── README.md
    ├── __init__.py
    └── tests/
```

### 2.2 Skill Contract Template

Every skill MUST define:
- **Input Schema:** JSON schema for parameters
- **Output Schema:** JSON schema for return value
- **Error Schema:** Standardized error format
- **Dependencies:** External services/APIs required

### 2.3 Core Skills Identified

| Skill | Priority | MCP Tools Used |
|-------|----------|----------------|
| `skill_download_video` | P0 | filesystem, http |
| `skill_transcribe_audio` | P0 | whisper-api |
| `skill_generate_content` | P0 | llm-api, image-api |
| `skill_publish_social` | P1 | twitter-mcp, instagram-mcp |
| `skill_analyze_trends` | P1 | news-mcp, search-mcp |

## 3. MCP Server Configuration

### 3.1 Development Environment

```json
{
  "mcpServers": {
    "tenx-sense": {
      "command": "tenx-mcp-sense",
      "args": ["--project", "chimera"]
    },
    "filesystem": {
      "command": "mcp-server-filesystem",
      "args": ["--root", "./"]
    }
  }
}
```

### 3.2 Production Environment

```json
{
  "mcpServers": {
    "twitter": {
      "url": "https://mcp.chimera.io/twitter",
      "transport": "sse"
    },
    "weaviate": {
      "url": "https://mcp.chimera.io/weaviate",
      "transport": "sse"
    },
    "coinbase": {
      "url": "https://mcp.chimera.io/coinbase",
      "transport": "sse"
    }
  }
}
```

## 4. Distinction Summary

| Aspect | Developer Tools | Agent Skills |
|--------|-----------------|--------------|
| **User** | Human developers | AI agents |
| **When** | Development time | Runtime |
| **Purpose** | Build & debug | Execute tasks |
| **Examples** | git-mcp, filesystem-mcp | skill_download_video |
| **Configuration** | IDE settings | Agent context |
