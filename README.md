# SkyPulse AI

SkyPulse is a grounded Sky support assistant built as a four-part portfolio project. Parts 1 and 2 implement the content/RAG foundation plus typed agent capabilities, deterministic routing, tool authorization, and MCP discovery. Part 3 adds a tested Next.js support console with unified SSE turns, local predictive input, and browser voice interaction.

## Current status

- FastAPI `POST /api/chat` and `POST /api/chat/stream`
- Public-only hybrid retrieval with lexical and vector ranks fused by RRF
- Explicit refusal for unsupported and account-specific questions
- Robots-aware, host-allowlisted crawler with authenticated-path blocking
- Repeatable JSON development index and Supabase pgvector migration
- Golden-dataset gates for Recall@5, MRR, citation precision, answerability, and p95 latency
- Versioned capability contracts covering support, commerce, coverage, content, account, and smart-home/protect
- Rule-first turn routing for RAG, tools, parallel tools, clarification, and escalation
- Exact `Decimal` calculations over clearly marked synthetic commerce offers
- Server-side scope checks and an injected synthetic account repository
- Official FastMCP server with typed tools over Streamable HTTP
- Independently runnable smart-home/Protect FastMCP service with public-data boundaries
- Next.js App Router support console with SSE responses, citations, cancellation, retry, local predictive input, tap-to-talk transcription, selectable speech playback, and responsive layouts
- Grounded follow-up suggestions generated from successful capabilities
- PII-redaction and explicit action-confirmation policy foundations

Start with [Local Development](docs/local-development.md), review [Architecture](docs/architecture.md), and see the [MCP Tool Catalog](docs/mcp-tool-catalog.md).

This repository is an independent educational prototype based only on public information. It is not affiliated with Sky, and it has no access to Sky customer systems.
