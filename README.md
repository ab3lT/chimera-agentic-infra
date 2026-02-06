# Project Chimera: Agentic Infrastructure

[![CI](https://github.com/abeltadesse/chimera-agentic-infra/actions/workflows/main.yml/badge.svg)](https://github.com/abeltadesse/chimera-agentic-infra/actions)

## Overview

Autonomous AI Influencer system using **Swarm Architecture** (Planner-Worker-Judge pattern) with **Model Context Protocol (MCP)** for universal connectivity.

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     ORCHESTRATOR                        │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐            │
│  │ Planner │───▶│ Workers │───▶│  Judge  │            │
│  └─────────┘    └─────────┘    └─────────┘            │
└────────────────────────┬────────────────────────────────┘
                         │
                    MCP LAYER
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
   [Twitter]        [Weaviate]       [Coinbase]
```

## Project Structure

```
chimera-agentic-infra/
├── .github/
│   ├── workflows/main.yml      # CI/CD pipeline
│   └── copilot-instructions.md # IDE agent context
├── specs/
│   ├── _meta.md                # Vision & constraints
│   ├── functional.md           # User stories
│   ├── technical.md            # API contracts
│   └── openclaw_integration.md # Agent social network
├── skills/
│   ├── skill_download_video/   # Video download capability
│   ├── skill_transcribe_audio/ # Speech-to-text
│   └── skill_generate_content/ # Content generation
├── tests/
│   ├── test_trend_fetcher.py   # TDD tests (failing)
│   ├── test_skills_interface.py
│   └── test_task_schema.py
├── src/                        # Implementation (TDD)
├── research/
│   ├── architecture_strategy.md
│   └── tooling_strategy.md
├── Dockerfile
├── Makefile
├── docker-compose.yml
└── pyproject.toml
```

## Quick Start

```bash
# Install dependencies
make setup

# Run tests (will show failing tests - TDD approach)
make test

# Run in Docker
make docker-test
```

## Spec-Driven Development

This project follows **Spec-Driven Development (SDD)**:

1. ✅ Specifications ratified in `specs/`
2. ✅ Failing tests written in `tests/`
3. ⏳ Implementation fills the gaps

> "Ambiguity is the enemy of AI. If your spec is vague, the Agent will hallucinate."

## Key Technologies

| Component | Technology |
|-----------|------------|
| Language | Python 3.11+ |
| Framework | FastAPI + Celery |
| Queue | Redis |
| Vector DB | Weaviate |
| Protocol | Model Context Protocol (MCP) |
| Commerce | Coinbase AgentKit |

## Author

**Abel Tadesse** | 10 Academy TRP 1 | February 2026
