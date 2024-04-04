import Foundation

final class StockViewModel {
    var date: String?
    var stock: String?
    
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

    
    func loadPrice() {
        network.date = date
        network.stock = stock
        network.loadStockPrice() { [weak self] newData in
            self?.stockPrice.append(newData)
        }
    }
    
    func reloadTableWatchlist() {
        
    }
    
    func loadInfo() {
        network.date = date
        network.stock = stock
        network.loadStockInfo() { [weak self] newData in
            self?.stockInfo.append(newData)
        }
    }
    
    func calcDifference() -> Double {
        let openPrice = stockPrice.first?.open ?? 0.00
        let closePrice = stockPrice.first?.close ?? 0.00
        let difference = closePrice - openPrice
        return difference
    }
}
