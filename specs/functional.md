# Functional Requirements Specification

## FR-1: Persona Management

### FR-1.0: Persona Instantiation
**As an Agent**, I need to load my persona from a SOUL.md configuration file, so that I maintain consistent personality across all interactions.

**Acceptance Criteria:**
- System parses SOUL.md with YAML frontmatter
- Persona includes: name, voice_traits, directives, backstory
- Persona loaded at agent startup

### FR-1.1: Hierarchical Memory Retrieval
**As an Agent**, I need to retrieve relevant memories before responding, so that I maintain context awareness.

**Acceptance Criteria:**
- Short-term memory from Redis (last 1 hour)
- Long-term memory from Weaviate (semantic search)
- Top 5 relevant memories injected into context

### FR-1.2: Dynamic Persona Evolution
**As an Agent**, I need to learn from successful interactions, so that my persona evolves over time.

**Acceptance Criteria:**
- Judge identifies high-engagement interactions
- Summaries written to Weaviate memories collection
- Evolution respects core directives (immutable)

---

## FR-2: Perception System

### FR-2.0: Active Resource Monitoring
**As an Agent**, I need to monitor MCP Resources for updates, so that I can perceive the digital world.

**Acceptance Criteria:**
- Polling mechanism for configured resources
- Resources include: twitter://mentions, news://trends
- Updates trigger Planner evaluation

### FR-2.1: Semantic Filtering
**As an Agent**, I need to filter content by relevance score, so that I focus on important signals.

**Acceptance Criteria:**
- Lightweight LLM scores relevance (0.0-1.0)
- Only content >= 0.75 triggers task creation
- Threshold configurable per agent

### FR-2.2: Trend Detection
**As an Agent**, I need to detect emerging trends, so that I can create timely content.

**Acceptance Criteria:**
- Background Worker analyzes news over 4-hour windows
- Cluster detection for related topics
- Trend Alerts fed to Planner context

---

## FR-3: Creative Engine

### FR-3.0: Multimodal Generation
**As an Agent**, I need to generate text, images, and video, so that I can create engaging content.

**Acceptance Criteria:**
- Text via Cognitive Core (Claude/Gemini)
- Images via mcp-server-ideogram
- Video via mcp-server-runway

### FR-3.1: Character Consistency
**As an Agent**, I need to maintain visual consistency, so that audiences recognize me.

**Acceptance Criteria:**
- All image requests include character_reference_id
- Judge validates consistency before publishing
- Rejection triggers regeneration

---

## FR-4: Action System

### FR-4.0: Platform-Agnostic Publishing
**As an Agent**, I need to publish content via MCP Tools, so that I'm not coupled to specific platforms.

**Acceptance Criteria:**
- All publishing through MCP layer
- Supported: Twitter, Instagram, Threads
- Rate limiting enforced at MCP level

### FR-4.1: Bi-Directional Interaction
**As an Agent**, I need to respond to comments and mentions, so that I engage my audience.

**Acceptance Criteria:**
- Ingest mentions via Resource polling
- Generate context-aware replies
- Judge validates before publishing

---

## FR-5: Agentic Commerce

### FR-5.0: Wallet Management
**As an Agent**, I need a non-custodial wallet, so that I can participate in the economy.

**Acceptance Criteria:**
- Unique wallet via Coinbase AgentKit
- Private key in secrets manager
- Balance check before cost-incurring workflows

### FR-5.1: Autonomous Transactions
**As an Agent**, I need to send and receive payments, so that I can monetize my influence.

**Acceptance Criteria:**
- native_transfer for ETH/USDC
- Transaction logging on-chain
- CFO Judge enforces budget limits

---

## FR-6: Orchestration

### FR-6.0: Planner-Worker-Judge Loop
**As the Orchestrator**, I need to coordinate the swarm, so that tasks execute reliably.

**Acceptance Criteria:**
- Planner generates task DAG
- Workers execute from TaskQueue
- Judge validates from ReviewQueue

### FR-6.1: Optimistic Concurrency Control
**As the Judge**, I need to prevent race conditions, so that state remains consistent.

**Acceptance Criteria:**
- Check state_version before commit
- Invalidate stale results
- Re-queue for Planner re-evaluation
