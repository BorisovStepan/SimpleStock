import Foundation

import Foundation

final class MarketNetworkService {
    
    func currentDate() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedYesterday = dateFormatter.string(from: yesterday)
            return formattedYesterday
        } else {
            return "Cant recive Date"
        }
    }
    
    func loadData(completion: @escaping([MarketModel]) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/\(currentDate())?adjusted=true&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
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
