
import Foundation

final class WatchListPresenter {
    var date: String?
    
    var stockPrice: [Stock] = .init() {
        didSet {
            stockPriceDidChange?()
        }
    }
    
    var stockInfo: [StockInfoMoodel] = .init() {
        didSet {
            stockInfoDidChange?()
        }
    }
    
    var stockPriceDidChange: (() -> Void)?
    var stockInfoDidChange: (() -> Void)?
    
    private let network: StockNetworkService
    
    init() {
        self.network = StockNetworkService()
    }
    
    func getStocks() {
        self.stockPrice = CoreDataService.fetchData()
    }
}
