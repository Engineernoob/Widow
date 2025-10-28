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
