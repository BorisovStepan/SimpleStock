import Foundation

final class MarketNetworkService {
    
    func loadData(completion: @escaping([MarketModel]) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/\(currentDate())?adjusted=true&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error  in
            if let jsonData = data {
                do {
                    let newTickers = try JSONDecoder().decode(Market.self, from: jsonData)
                    let tickers = newTickers.results.map { return MarketModel(stockName: $0.T ?? "Stock", closePrice: $0.c ?? 0.00, openPrice: $0.o ?? 0.00, avvaregePrice: $0.vw ?? 0.00)}
                    completion(tickers)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
