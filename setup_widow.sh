#!/bin/bash
set -e

# ===========================
# Widow Workspace Setup Script
# ===========================

# Detect and confirm base path
BASE_DIR="$(pwd)/widow"
echo "📁 Creating Widow workspace at: $BASE_DIR"

# Create directory structure
mkdir -p "$BASE_DIR"/crates/{widow-core,widow-scheduler,widow-worker,widow-embedder,widow-extractor}/src
mkdir -p "$BASE_DIR/scripts"
touch "$BASE_DIR/.gitignore"

# ---------------------------
# Root Cargo.toml
# ---------------------------
cat > "$BASE_DIR/Cargo.toml" <<'EOF'
[workspace]
members = [
    "crates/widow-core",
    "crates/widow-scheduler",
    "crates/widow-worker",
    "crates/widow-embedder",
    "crates/widow-extractor"
]
resolver = "2"

[workspace.package]
edition = "2021"
license = "MIT"
authors = ["Taahirah Denmark <taahirah.engineer@proton.me>"]
repository = "https://github.com/Engineernoob/widow"
homepage = "https://widow.dev"
EOF

# ---------------------------
# widow-core
# ---------------------------
cat > "$BASE_DIR/crates/widow-core/Cargo.toml" <<'EOF'
[package]
name = "widow-core"
version = "0.1.0"
edition = "2021"

[dependencies]
reqwest = { version = "0.12", features = ["json", "gzip", "brotli", "deflate", "rustls-tls"] }
tokio = { version = "1", features = ["full"] }
anyhow = "1.0"
EOF

cat > "$BASE_DIR/crates/widow-core/src/lib.rs" <<'EOF'
use reqwest::Client;
use tokio::time::{sleep, Duration};

pub struct WidowCore {
    client: Client,
}

impl WidowCore {
    pub fn new() -> Self {
        Self {
            client: Client::builder()
                .user_agent("WidowBot/0.1 (+https://widow.dev)")
                .build()
                .unwrap(),
        }
    }

    pub async fn fetch(&self, url: &str) -> anyhow::Result<String> {
        let res = self.client.get(url).send().await?;
        Ok(res.text().await?)
    }

    pub async fn polite_delay() {
        sleep(Duration::from_millis(500)).await;
    }
}
EOF

# ---------------------------
# widow-scheduler
# ---------------------------
cat > "$BASE_DIR/crates/widow-scheduler/Cargo.toml" <<'EOF'
[package]
name = "widow-scheduler"
version = "0.1.0"
edition = "2021"

[dependencies]
tokio = { version = "1", features = ["full"] }
anyhow = "1.0"
EOF

cat > "$BASE_DIR/crates/widow-scheduler/src/lib.rs" <<'EOF'
use std::collections::VecDeque;
use tokio::sync::Mutex;
use std::sync::Arc;

#[derive(Clone)]
pub struct JobQueue {
    inner: Arc<Mutex<VecDeque<String>>>,
}

impl JobQueue {
    pub fn new(seed_urls: Vec<String>) -> Self {
        Self {
            inner: Arc::new(Mutex::new(VecDeque::from(seed_urls))),
        }
    }

    pub async fn pop(&self) -> Option<String> {
        let mut queue = self.inner.lock().await;
        queue.pop_front()
    }

    pub async fn push(&self, url: String) {
        let mut queue = self.inner.lock().await;
        queue.push_back(url);
    }
}
EOF

# ---------------------------
# widow-extractor
# ---------------------------
cat > "$BASE_DIR/crates/widow-extractor/Cargo.toml" <<'EOF'
[package]
name = "widow-extractor"
version = "0.1.0"
edition = "2021"

[dependencies]
scraper = "0.18"
EOF

cat > "$BASE_DIR/crates/widow-extractor/src/lib.rs" <<'EOF'
use scraper::{Html, Selector};

pub fn extract_text(html: &str) -> String {
    let doc = Html::parse_document(html);
    let selector = Selector::parse("body").unwrap();
    doc.select(&selector)
        .map(|n| n.text().collect::<Vec<_>>().join(" "))
        .collect::<Vec<_>>()
        .join(" ")
}
EOF

# ---------------------------
# widow-embedder
# ---------------------------
cat > "$BASE_DIR/crates/widow-embedder/Cargo.toml" <<'EOF'
[package]
name = "widow-embedder"
version = "0.1.0"
edition = "2021"

[dependencies]
anyhow = "1.0"
EOF

cat > "$BASE_DIR/crates/widow-embedder/src/lib.rs" <<'EOF'
pub async fn embed_and_store(_url: &str, text: &str) -> anyhow::Result<()> {
    println!("🧠 (stub) Embedding {} chars", text.len());
    Ok(())
}
EOF

# ---------------------------
# widow-worker
# ---------------------------
cat > "$BASE_DIR/crates/widow-worker/Cargo.toml" <<'EOF'
[package]
name = "widow-worker"
version = "0.1.0"
edition = "2021"

[dependencies]
widow-core = { path = "../widow-core" }
widow-scheduler = { path = "../widow-scheduler" }
widow-extractor = { path = "../widow-extractor" }
widow-embedder = { path = "../widow-embedder" }

tokio = { version = "1", features = ["full"] }
anyhow = "1.0"
EOF

cat > "$BASE_DIR/crates/widow-worker/src/main.rs" <<'EOF'
use widow_core::WidowCore;
use widow_scheduler::JobQueue;
use widow_extractor::extract_text;
use widow_embedder::embed_and_store;

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let crawler = WidowCore::new();
    let queue = JobQueue::new(vec![
        "https://example.com".to_string(),
        "https://httpbin.org/html".to_string()
    ]);

    while let Some(url) = queue.pop().await {
        println!("🕷️ Crawling: {}", url);
        match crawler.fetch(&url).await {
            Ok(html) => {
                let text = extract_text(&html);
                embed_and_store(&url, &text).await?;
                WidowCore::polite_delay().await;
            }
            Err(e) => eprintln!("❌ Failed {}: {}", url, e),
        }
    }

    Ok(())
}
EOF

# ---------------------------
# README + Script
# ---------------------------
cat > "$BASE_DIR/README.md" <<'EOF'
# 🕷️ Widow — Distributed Web Crawler & Knowledge Indexer

Widow is a Rust-based, high-performance web crawler designed to crawl, extract, and embed the world’s knowledge for AI systems.

## Run Locally
```bash
cargo run -p widow-worker
