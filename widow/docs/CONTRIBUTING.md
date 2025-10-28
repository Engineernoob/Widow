# 🤝 Contributing to Widow

Welcome, and thank you for your interest in contributing to **Widow** 🕷️ —  
a high-performance, Rust-based web crawler and vector indexing system built for the AI era.

This guide explains how to set up your environment, follow coding conventions, and submit contributions.

---

## 🧭 Table of Contents

1. [Project Overview](#project-overview)
2. [Local Development Setup](#local-development-setup)
3. [Build & Run Commands](#build--run-commands)
4. [Testing & Debugging](#testing--debugging)
5. [Coding Guidelines](#coding-guidelines)
6. [Commit Message Convention](#commit-message-convention)
7. [Pull Request Process](#pull-request-process)
8. [Documentation](#documentation)
9. [License](#license)

---

## 🕸️ Project Overview

Widow is a modular system composed of several Rust crates:

| Crate               | Purpose                                           |
| ------------------- | ------------------------------------------------- |
| **widow-core**      | Shared structs, configuration, and utilities      |
| **widow-worker**    | Core crawler logic (fetch, extract, embed, index) |
| **widow-extractor** | HTML + metadata parsing (Scraper + Reqwest)       |
| **widow-embedder**  | Text vectorization (stubbed or model-powered)     |
| **widow-scheduler** | Future task and rate-limiting subsystem           |
| **Qdrant VectorDB** | External dependency for vector indexing           |

The project currently runs via Docker Compose and can scale horizontally.

---

## ⚙️ Local Development Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Engineernoob/widow.git
cd widow
2. Install Rust and Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


Confirm it works:

rustc --version
cargo --version

3. (Optional) Install Container Tools

If you don’t use Docker Desktop, install Colima or Podman:

brew install colima
colima start --cpu 4 --memory 8


Then verify Docker CLI works:

docker info

🧱 Build & Run Commands
Run Locally (no Docker)
cargo run -p widow-worker

Build Release
cargo build --release -p widow-worker

Run via Docker Compose
docker compose up --build


This will:

Start widow-worker (Rust crawler)

Start qdrant/qdrant:v1.12.0

Index crawled embeddings into Qdrant

🧪 Testing & Debugging
Run All Tests
cargo test --workspace

Run a Specific Test
cargo test --package widow-core test_name

Enable Verbose Logs
RUST_LOG=debug cargo run -p widow-worker

Attach to Running Containers
docker compose logs -f widow-worker
docker exec -it widow-worker bash

🧩 Coding Guidelines

Language: Rust 2021 edition.

Formatting: Run cargo fmt --all before committing.

Linting: Use cargo clippy --all-targets -- -D warnings.

Error Handling: Prefer anyhow for app-level errors, thiserror for typed crates.

Logging: Use tracing or log macros for structured output.

Async: All network I/O should use tokio async tasks.

Architecture: Keep new features modular under crates/ with individual Cargo.toml.

🪶 Commit Message Convention

Follow the Conventional Commits spec to keep a clean history and generate changelogs automatically.

Type	Purpose
feat:	New feature (crawler, extractor, API, etc.)
fix:	Bug fix or performance improvement
docs:	Documentation, README, or diagram updates
chore:	Dependency or build script updates
refactor:	Code cleanup or reorganization
test:	Adding or improving tests

Examples:

git commit -m "feat: add HTML extraction and title parsing to widow-extractor"
git commit -m "docs: update architecture diagram for Widow phase 2"
git commit -m "chore: bump reqwest to 0.12.3 and enable native-tls"

🔄 Pull Request Process

Create a feature branch:

git checkout -b feat/add-crawl-scheduler


Implement your feature and commit with clear messages.

Push your branch:

git push origin feat/add-crawl-scheduler


Submit a pull request describing:

What was added or changed

How it was tested

Any dependencies or configuration changes

All PRs should pass:

cargo fmt

cargo clippy

cargo test --workspace

📘 Documentation

All internal developer docs live under /docs.

File	Description
README.md
	Developer documentation index
widow-architecture.dot
	Core system Graphviz diagram
widow-dashboard.dot
	Phase 3 dashboard Graphviz diagram

Generate updated diagrams with:

dot -Tpng docs/widow-architecture.dot -o docs/widow-architecture.png
dot -Tpng docs/widow-dashboard.dot -o docs/widow-dashboard.png

⚖️ License

Widow is released under the MIT License
.

© 2025 Taahirah Denmark
```
