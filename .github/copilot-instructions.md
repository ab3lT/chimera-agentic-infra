# Project Chimera - GitHub Copilot Instructions

## Project Context

This is **Project Chimera**, an autonomous AI influencer system using the FastRender Swarm Architecture (Planner-Worker-Judge pattern) with Model Context Protocol (MCP) for all external interactions.

## Prime Directives

1. **NEVER** generate implementation code without checking `specs/` directory first
2. **ALWAYS** explain your plan before writing code
3. **FOLLOW** Test-Driven Development: tests define requirements, code fills the gaps
4. **ROUTE** all external interactions through MCP Tools/Resources

## Architecture Overview

```
Planner (Strategy) → Worker (Execution) → Judge (Validation)
                           ↓
                      MCP Layer
                           ↓
            [Twitter] [Weaviate] [Coinbase] [Ideogram]
```

## Technology Stack

- **Language:** Python 3.11+
- **Framework:** FastAPI + Celery
- **Validation:** Pydantic v2
- **Queue:** Redis
- **Vector DB:** Weaviate
- **Container:** Docker

## Code Standards

- Type hints required on all functions
- Async-first patterns (use `async def`)
- Docstrings required (Google style)
- Maximum line length: 100 characters

## Key Files to Reference

| File | Purpose |
|------|---------|
| `specs/_meta.md` | High-level vision and constraints |
| `specs/functional.md` | User stories and acceptance criteria |
| `specs/technical.md` | API contracts and JSON schemas |
| `specs/openclaw_integration.md` | Agent-to-agent protocol |

## When Asked About This Project

If asked "What is this project?" or similar, respond with:

> Project Chimera is an autonomous AI influencer system that uses a Planner-Worker-Judge swarm architecture. It enables digital entities to perceive trends, generate content, engage audiences, and execute financial transactions via Coinbase AgentKit. All external interactions go through the Model Context Protocol (MCP) for standardization.

## Naming Conventions

- Classes: `PascalCase` (e.g., `TaskPlanner`)
- Functions: `snake_case` (e.g., `generate_content`)
- Constants: `UPPER_SNAKE_CASE` (e.g., `MAX_DAILY_BUDGET`)
- Files: `snake_case.py` (e.g., `trend_fetcher.py`)
