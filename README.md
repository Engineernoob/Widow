# 🕷️ Widow

**Widow** is a distributed, high-performance **Rust-based web crawler and vector indexing engine** — designed to crawl the open web, extract meaningful text, embed it into vector representations, and index it into **Qdrant** for AI-native search and retrieval systems.

> ⚡ “Basically build Google-scale crawling — but open and modular.”

---

## 🚀 Overview

Widow is built from the ground up to serve **AI infrastructure and search applications**.  
It’s designed for **massive throughput**, **politeness control**, and **intelligent crawl scheduling**.

This project draws inspiration from [Exa.ai](https://exa.ai)’s mission:  
to build the web’s data layer for the next generation of AI models.

---

## 🧠 Core Architecture

Crawl → Extract → Embed → Index

Each phase is modular, written in pure Rust, and can scale horizontally via containers.

| Module              | Description                                    | Language / Stack               |
| ------------------- | ---------------------------------------------- | ------------------------------ |
| **widow-core**      | Shared structs, config, and type system        | Rust                           |
| **widow-worker**    | Main crawling engine — fetches, parses, embeds | Rust (Tokio, Reqwest, Scraper) |
| **widow-extractor** | HTML & metadata extraction utilities           | Rust                           |
| **widow-embedder**  | Embedding and text vectorization               | Rust / HTTP                    |
| **Qdrant**          | Vector search and similarity backend           | Rust + Docker                  |
| **widow-dashboard** | _(Phase 3)_ Next.js control UI + analytics     | Next.js + Supabase (planned)   |

---

## 🧩 Features

- 🌐 **Massively parallel crawling**

  - Asynchronous networking via **Tokio**
  - Configurable concurrency and rate limits

- 🧠 **Text extraction & embedding**

  - HTML parsing via **Scraper**
  - Future integration with **local LLM / embedding models**

- 🧱 **Vector indexing with Qdrant**

  - Semantic search and document recall
  - Dockerized deployment for local or cloud setups

- ⚙️ **Configurable via `.env`**

  - Crawl scope, rate limits, storage path, API endpoints

- 🕸️ **Designed for distributed systems**
  - Scheduler and job queues planned for multi-node scale

---

## 🧰 Tech Stack

| Layer              | Technology                                                        |
| ------------------ | ----------------------------------------------------------------- |
| Language           | Rust (2021 Edition)                                               |
| Core Crates        | `tokio`, `reqwest`, `scraper`, `serde`, `anyhow`, `qdrant-client` |
| Database           | [Qdrant VectorDB](https://qdrant.tech)                            |
| Containerization   | Docker + Compose                                                  |
| Frontend (Phase 3) | Next.js 15 + Tailwind + Supabase                                  |
| Visualization      | Graphviz (for architecture diagrams)                              |

---

## 🧱 Run Locally

### 1. Clone the Repo

```bash
git clone https://github.com/Engineernoob/widow.git
cd widow

2. Run with Cargo
cargo run -p widow-worker

3. Or with Docker Compose
docker compose up --build


This starts:

🧠 widow-worker → Rust crawler

💾 widow-qdrant → Vector database (HTTP: 6333, gRPC: 6334)

Once running, you can access the Qdrant UI at:

http://localhost:6333/dashboard

🕸️ Architecture Diagrams
Diagram	Description
🧱 docs/widow-architecture.png	Core system (crawler + Qdrant)
💻 docs/widow-dashboard.png	Future dashboard + API design

Preview:

🧑‍💻 Development
Format & Lint
cargo fmt --all
cargo clippy --all-targets -- -D warnings

Test
cargo test --workspace

Logs
RUST_LOG=info cargo run -p widow-worker

```

```
🧠 Vision Roadmap
Phase	Focus	Status
1. Core Crawler	Fetch → Parse → Embed → Index	✅ Complete
2. Dockerized System	Qdrant integration + CI	✅ Complete
3. Widow Dashboard	Frontend visualization + API controls	🔄 In progress
4. Scheduler	Distributed queue + politeness manager	🧩 Planned
5. Multi-Node Scaling	Raft-based worker clustering	🧩 Planned
📘 Documentation

All developer documentation lives in /docs :

README.md
 — developer index

CONTRIBUTING.md
 — contribution guide

.dot Graphviz diagrams for visual architecture
```

```🪶 License

Released under the MIT License

© 2025 Taahirah Denmark

⭐ Acknowledgments

Built with inspiration from:

Exa

Qdrant

Rustlings

Hugging Face Open Source Stack
```

> “The web is our collective memory. Widow helps AI remember it.”
