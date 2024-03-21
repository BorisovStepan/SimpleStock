
import Foundation

struct NewsArticle: Decodable {
    let count: Int
    let results: [Results]
}

struct Results: Decodable {
    let title: String
    let author: String
    let id: String
    let article_url: String
}
