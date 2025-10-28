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
