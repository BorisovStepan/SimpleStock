
import Foundation

final class WatchListPresenter {
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
        self.stockPrice = CoreDataService.fetchData()
    }
}
