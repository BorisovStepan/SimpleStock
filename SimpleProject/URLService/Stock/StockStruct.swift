import Foundation

struct StockInfo: Decodable {
    let results: ResultsStock
}

struct ResultsStock: Decodable {
    let ticker: String?
    let name: String?
    let description: String?
}

