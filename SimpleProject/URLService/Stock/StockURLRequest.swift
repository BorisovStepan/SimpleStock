
import Foundation
final class StockNetworkService {
    var date: String?
    var stock: String?

    
    func loadData(completion: @escaping([MarketModel]) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v3/reference/tickers/\(stock)?date=\(date)&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error  in
            if let jsonData = data {
                do {
                    let newTickers = try JSONDecoder().decode(Market.self, from: jsonData)
                    let tickers = newTickers.results.map { return MarketModel(t: $0.T ?? "Stock", c: $0.c ?? 0.00, o: $0.o ?? 0.00, vw: $0.vw ?? 0.00)}
                    completion(tickers)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
