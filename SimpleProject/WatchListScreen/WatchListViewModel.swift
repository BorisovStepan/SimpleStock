
import Foundation

final class WatchListViewModel {
    var date: String?
    
    var stockPrice = [PriceModel]() {
        didSet {
            stockPriceDidChange?()
        }
    }
    
    var stockInfo = [StockInfoMoodel]() {
        didSet {
            stockInfoDidChange?()
        }
    }
    
    var stockPriceDidChange: (() -> Void)?
    var stockInfoDidChange: (() -> Void)?
    
    private let network = StockNetworkService()
    
    func getStocks() -> [Stock]? {
        let request = Stock.fetchRequest()
        let stocks = try? CoreDataService.context.fetch(request)
        return stocks
    }
    
    func loadPrice() {
        if let stocks = getStocks() {
            for stock in stocks {
                network.date = date
                network.stock = stock.stockName
                network.loadStockPrice() { [weak self] newData in
                    self?.stockPrice.append(newData)
                }
            }
        }
    }
}
