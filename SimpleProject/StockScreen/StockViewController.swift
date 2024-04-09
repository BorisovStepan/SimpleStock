import UIKit
import CoreData

protocol StockViewControllerDelegate: AnyObject {
    func updateTable()
}

class StockViewController: UIViewController {
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addStockButton: UIButton!
    @IBOutlet weak var differencePrice: UILabel!
    @IBOutlet weak var closePrice: UILabel!
    @IBOutlet weak var openPrice: UILabel!
    let stockModel = StockViewModel()
    var state: WatchlistToDo?
    weak var delegate: StockViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockModel.loadPrice()
        stockModel.loadInfo()
        stockModel.stockInfoDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.configureStockInfo()
            }
        }
        
        stockModel.stockPriceDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.configurePriceInfo()
            }
        }
    }
    
    private func configureStockInfo() {
        tickerLabel.text = stockModel.stockInfo.first?.ticker
        nameLabel.text = stockModel.stockInfo.first?.name
        descriptionLabel.text = stockModel.stockInfo.first?.description
    }
    
    private func configurePriceInfo() {
        closePrice.text = String(self.stockModel
            .stockPrice.first?.close ?? 0.00)
        openPrice.text = String(self.stockModel
            .stockPrice.first?.open ?? 0.00)
        let difference = stockModel.calcDifference()
        if difference > 0 {
            differencePrice.textColor = .green
            differencePrice.text = "+" + String(format: "%.2f", difference)
        } else {
            differencePrice.textColor = .red
            differencePrice.text = String(format: "%.2f", difference)
        }
    }
    
    private func checkCoreData() {
        let request = Stock.fetchRequest()
        if let stocks = try? CoreDataService.context.fetch(request) {
            if stocks.isEmpty {
                state = .add
            } else {
                let stockNames = stocks.map { $0.stockName }
                if stockNames.contains(self.stockModel.stock) {
                    state = .delete
                    addStockButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    state = .add
                    addStockButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func pressAddStockButton(_ sender: Any) {
        switch state {
        case .delete :
            let request = Stock.fetchRequest()
            if let stocks = try? CoreDataService.context.fetch(request) {
                for stock in stocks {
                    if stock.stockName == self.stockModel.stock {
                        CoreDataService.context.delete(stock)
                        CoreDataService.saveContext()
                        addStockButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    }
                }
            }
            delegate?.updateTable()
            state = .add
        case .add :
            let context = CoreDataService.context
            context.perform { [self] in
                let newStock = Stock(context: context)
                newStock.openPrice = self.stockModel
                    .stockPrice.first?.open ?? 0.00
                newStock.differencePrice = self.stockModel.calcDifference()
                newStock.stockName = self.stockModel.stock
                self.addStockButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.delegate?.updateTable()
                state = .delete
                CoreDataService.saveContext()
            }
        case .none:
            break
        }
    }
}


