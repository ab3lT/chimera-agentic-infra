# Project Chimera - Meta Specification

## Vision

Build an Autonomous AI Influencer Network where digital entities can perceive trends, generate content, engage audiences, and participate in economic transactions—all with minimal human intervention.

## Architecture Pattern

**Hierarchical Multi-Agent Swarm (FastRender Pattern)**

- **Planner:** Decomposes goals into tasks, maintains campaign state
- **Worker:** Executes atomic tasks, stateless and ephemeral
- **Judge:** Validates outputs, enforces governance, handles escalation

## Protocol

**Model Context Protocol (MCP)** - Universal interface for all external interactions

## Constraints

| Constraint | Value | Rationale |
|------------|-------|-----------|
| Budget per Agent | $50 USD/day | Cost control |
| Interaction Latency | <10 seconds | User experience |
| Concurrent Agents | 1,000+ | Scalability requirement |
| Compliance | EU AI Act | Legal requirement |

## Non-Negotiable Principles

1. **Spec-First:** No implementation without ratified specification
2. **Traceability:** Every decision logged via MCP Sense
3. **Human-in-the-Loop:** Confidence-based escalation for sensitive content
4. **Auto-Disclosure:** Agents must identify as AI when asked

## Technology Stack

| Layer | Technology |
|-------|------------|
| Language | Python 3.11+ |
| Framework | FastAPI + Celery |
| Queue | Redis |
| Vector DB | Weaviate |
| Relational DB | PostgreSQL |
| Container | Docker + K8s |
| CI/CD | GitHub Actions |

## Success Criteria

The repository is "agent-ready" when:
- [ ] All specs are machine-readable (JSON schemas defined)
- [ ] Failing tests exist for all core functionality
- [ ] CI/CD runs tests on every push
- [ ] IDE agent can answer project questions from context
