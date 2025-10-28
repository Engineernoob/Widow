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
