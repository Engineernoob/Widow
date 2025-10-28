# 🧭 Widow Documentation

This folder contains all **developer-focused documentation** for the Widow project — including system architecture diagrams, design notes, and development guides.

---

## 🕷️ Project Overview

**Widow** is a distributed web crawler and embedding pipeline built in **Rust** to index web content into a **vector database (Qdrant)** for AI applications.

It’s designed as a scalable, modular system with the following key components:

| Component                     | Description                                           | Technology                   |
| ----------------------------- | ----------------------------------------------------- | ---------------------------- |
| **widow-core**                | Shared logic, types, and constants                    | Rust                         |
| **widow-worker**              | Main crawler pipeline (fetch → parse → embed → index) | Rust + Reqwest + Tokio       |
| **widow-embedder**            | Converts text into vectors (stubbed for now)          | Rust + HTTP                  |
| **widow-extractor**           | Cleans and extracts raw HTML                          | Rust + Scraper               |
| **widow-scheduler**           | Future job queue + rate limiter                       | Planned                      |
| **Qdrant VectorDB**           | Vector storage and search backend                     | Docker + Qdrant              |
| **Widow Dashboard (Phase 3)** | Frontend visualization and control plane              | Next.js + Supabase (planned) |

---

## 🧩 Architecture Diagrams

| Diagram                          | Description                           | File                                                 |
| -------------------------------- | ------------------------------------- | ---------------------------------------------------- |
| 🕸️ **Core System Architecture**  | Rust crawler + Qdrant data flow       | [`widow-architecture.dot`](./widow-architecture.dot) |
| 💻 **Widow Dashboard (Phase 3)** | Future UI / API / Crawler integration | [`widow-dashboard.dot`](./widow-dashboard.dot)       |

---

## 🧠 Generate Diagrams Locally

### 1. Install Graphviz

You’ll need the `dot` CLI installed.

```bash
brew install graphviz
Confirm it works:

dot -V

2. Generate All Diagrams

From the project root:

# Core architecture
dot -Tpng docs/widow-architecture.dot -o docs/widow-architecture.png

# Dashboard flow (Phase 3)
dot -Tpng docs/widow-dashboard.dot -o docs/widow-dashboard.png


Optional high-quality SVGs:

dot -Tsvg docs/widow-architecture.dot -o docs/widow-architecture.svg
dot -Tsvg docs/widow-dashboard.dot -o docs/widow-dashboard.svg

🧱 Folder Structure
docs/
├── widow-architecture.dot       # Graphviz source for Phase 1–2 architecture
├── widow-architecture.png       # Rendered image (for README)
├── widow-dashboard.dot          # Graphviz source for Phase 3 UI system
├── widow-dashboard.png          # Rendered image
└── README.md                    # This file

🧭 Developer Notes

Regenerate diagrams after architectural changes (dot -Tpng ...).

Update the top-level README.md with any new image paths.

Keep .dot and .png files in sync (both should be committed).

Use Lexend or Geist fonts for text labels if rendering externally.

When adding a new phase (e.g., distributed scheduler), create a new .dot and append to this index.

🧠 Diagram Quick View
🕸️ Widow Core

💻 Widow Dashboard

🪶 License

All documentation and diagrams © 2025 Taahirah Denmark

Released under the MIT License.
```
