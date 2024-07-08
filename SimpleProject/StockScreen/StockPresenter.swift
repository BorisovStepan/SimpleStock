import Foundation

final class StockPresenter {
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
        network.loadStockPrice(stock: stock) { [weak self] newData in
            self?.stockPrice.append(newData)
        }
    }
    
    func deleteData() {
        let request = Stock.fetchRequest()
        if let stocks = try? CoreDataService.context.fetch(request) {
            for stockName in stocks {
                if stockName.stockName == stock {
                    CoreDataService.context.delete(stockName)
                    CoreDataService.saveContext()
                }
            }
        }
    }
    
    func addDataToCore() {
        let context = CoreDataService.context
        context.perform { [self] in
            let newStock = Stock(context: context)
            newStock.openPrice = stockPrice.first?.open ?? 0.00
            newStock.differencePrice = calcDifference()
            newStock.stockName = stock
            CoreDataService.saveContext()
        }
    }
    
    func checkCoreData() -> Bool{
        var isStockinCoreData = false
        let request = Stock.fetchRequest()
        if let stocks = try? CoreDataService.context.fetch(request) {
            if stocks.isEmpty {
                isStockinCoreData = false
            } else {
                let stockNames = stocks.map { $0.stockName }
                if stockNames.contains(stock) {
                    isStockinCoreData = true
                } else {
                    isStockinCoreData = false
                }
            }
        }
        return isStockinCoreData
    }
    
    func loadInfo() {
        network.loadStockInfo(stock: stock) { [weak self] newData in
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
