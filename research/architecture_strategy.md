# Architecture Strategy Document

## 1. Executive Summary

Project Chimera adopts a **Hierarchical Multi-Agent Swarm** architecture using the FastRender pattern (Planner-Worker-Judge) to build autonomous AI influencers capable of perception, reasoning, creative expression, and economic agency.

## 2. Agent Pattern Selection

### Chosen Pattern: Hierarchical Multi-Agent Swarm

#### Why This Pattern?

| Criteria | Score | Justification |
|----------|-------|---------------|
| Task Decomposition | ★★★★★ | Planner breaks complex goals into atomic tasks |
| Parallelization | ★★★★★ | Stateless Workers execute concurrently |
| Quality Control | ★★★★★ | Judge validates every output |
| Error Recovery | ★★★★☆ | Failed tasks re-queued with refined instructions |
| Scalability | ★★★★★ | Horizontal scaling of Worker pool |

#### Alternatives Considered

| Pattern | Pros | Cons | Decision |
|---------|------|------|----------|
| ReAct | Simple loop | Single-threaded, no parallelism | ❌ Rejected |
| Tool-Using Agent | Direct tool access | No governance layer | ❌ Rejected |
| RAG-Only | Good retrieval | No action orchestration | ❌ Rejected |
| **Swarm (FastRender)** | Full governance, parallel, scalable | Higher complexity | ✅ Selected |

## 3. Architecture Components

### 3.1 The Planner (Strategist)
- Maintains campaign "Big Picture" state
- Decomposes goals into DAG of tasks
- Dynamic re-planning on context changes
- Can spawn Sub-Planners for complex domains

### 3.2 The Worker (Executor)
- Stateless, ephemeral agents
- Executes single atomic task
- Primary consumer of MCP Tools
- Shared-nothing architecture (no Worker-to-Worker communication)

### 3.3 The Judge (Gatekeeper)
- Quality assurance and governance
- Validates against acceptance criteria
- Authority to Approve/Reject/Escalate
- Implements Optimistic Concurrency Control (OCC)

## 4. Human-in-the-Loop (HITL) Strategy

### Confidence-Based Escalation

| Confidence Score | Action | Human Involvement |
|------------------|--------|-------------------|
| > 0.90 | Auto-Approve | None |
| 0.70 - 0.90 | Async Approval | Review queue |
| < 0.70 | Reject/Retry | None (auto-retry) |
| Sensitive Topic | Mandatory Review | Always |

## 5. Technology Stack

### Infrastructure
- **Compute:** Kubernetes (K8s) on AWS/GCP
- **Queue:** Redis + Celery
- **Database:** PostgreSQL (transactional), Weaviate (vector)

### AI Models
| Task Type | Model | Rationale |
|-----------|-------|-----------|
| Planning & Judging | Claude Opus 4.5 / Gemini 3 Pro | High reasoning |
| Routine Tasks | Claude Haiku / Gemini Flash | Low latency |
| Vision | GPT-4o / Gemini Vision | Image validation |

### Protocol
- **MCP (Model Context Protocol):** Universal interface for all external interactions

## 6. Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      ORCHESTRATOR                           │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐                │
│  │ Planner │───▶│ Workers │───▶│  Judge  │                │
│  └────┬────┘    └────┬────┘    └────┬────┘                │
│       │              │              │                       │
│       ▼              ▼              ▼                       │
│  GlobalState    TaskQueue      ReviewQueue                  │
└───────┬──────────────┬──────────────┬───────────────────────┘
        │              │              │
        ▼              ▼              ▼
┌───────────────────────────────────────────────────────────┐
│                    MCP LAYER                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │ Twitter  │  │ Weaviate │  │ Coinbase │  │ Ideogram │  │
│  │  Server  │  │  Server  │  │  Server  │  │  Server  │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
└───────────────────────────────────────────────────────────┘
```

## 7. Security Considerations

- Non-custodial wallets via Coinbase AgentKit
- Secrets in AWS Secrets Manager / HashiCorp Vault
- Budget Governor ("CFO" Judge) for transaction limits
- EU AI Act compliance (auto-disclosure)

## 8. Conclusion

The Hierarchical Multi-Agent Swarm architecture provides the optimal balance of autonomy, governance, and scalability for Project Chimera's autonomous influencer network.
