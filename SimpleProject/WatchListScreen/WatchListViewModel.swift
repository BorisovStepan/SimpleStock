
import Foundation

final class WatchListViewModel {
    var date: String?
    
    var stockPrice = [Stock]() {
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
    
    let network = StockNetworkService()
    
    func getStocks() {
        let request = Stock.fetchRequest()
        let stocks = try? CoreDataService.context.fetch(request)
        self.stockPrice = stocks ?? [Stock]()
    }
}
