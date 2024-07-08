
import Foundation
final class StockNetworkService {
    
    func loadStockInfo(stock: String?, completion: @escaping(StockInfoMoodel) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v3/reference/tickers/\(stock ?? "")?date=\(currentDate())&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error  in
            if let jsonData = data {
                do {
                    let newTickers = try JSONDecoder().decode(StockInfo.self, from: jsonData)
                    let tickers = StockInfoMoodel(ticker: newTickers.results.ticker ?? "", name: newTickers.results.name ?? "", description: newTickers.results.description ?? "")
                    completion(tickers)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func loadStockPrice(stock: String?, completion: @escaping(PriceModel) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v1/open-close/\(stock ?? "")/\(currentDate())?adjusted=true&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error  in
            if let jsonData = data {
                do {
                    let newTickers = try JSONDecoder().decode(Price.self, from: jsonData)
                    let tickers = PriceModel(open: newTickers.open, close: newTickers.close, name: newTickers.symbol)
                    completion(tickers)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

