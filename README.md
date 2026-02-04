# Project Chimera: Agentic Infrastructure

## Overview
Autonomous AI Influencer system using Swarm Architecture (Planner-Worker-Judge pattern) with Model Context Protocol (MCP) for universal connectivity.

## Project Structure
```
chimera-agentic-infra/
├── specs/           # Project specifications
├── skills/          # Agent runtime skills
├── tests/           # TDD test suite
├── src/             # Implementation (TDD - empty until tests pass)
├── research/        # Architecture and tooling strategy
├── .github/         # CI/CD and Copilot instructions
└── docs/            # Documentation
```

## Architecture
- **Pattern:** Hierarchical Multi-Agent Swarm (Planner-Worker-Judge)
- **Protocol:** Model Context Protocol (MCP)
- **Memory:** Redis (short-term) + Weaviate (long-term)
- **Commerce:** Coinbase AgentKit for financial transactions

## Author
Abel Tadesse | 10 Academy TRP 1 | February 2026
