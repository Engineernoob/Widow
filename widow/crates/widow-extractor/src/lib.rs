use scraper::{Html, Selector};

pub fn extract_text(html: &str) -> String {
    let doc = Html::parse_document(html);
    let selector = Selector::parse("body").unwrap();
    doc.select(&selector)
        .map(|n| n.text().collect::<Vec<_>>().join(" "))
        .collect::<Vec<_>>()
        .join(" ")
}
