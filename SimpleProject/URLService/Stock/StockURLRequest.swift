
import Foundation
class StockNetworkService {
    var date: String?
    var stock: String?
    
    
    func loadStockInfo(completion: @escaping(StockInfoMoodel) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v3/reference/tickers/\(stock ?? "")?date=\(date ?? "")&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
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
        
        func loadStockPrice(completion: @escaping(PriceModel) -> ()) {
            guard let url = URL(string: "https://api.polygon.io/v1/open-close/\(stock ?? "")/\(date ?? "")?adjusted=true&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
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
    
