import Foundation

struct Market: Decodable {
    let results: [Result]
    let count: Int
}

struct Result: Decodable {
    let T: String?
    let c, o, vw: Double?
}
