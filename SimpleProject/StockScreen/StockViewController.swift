import UIKit
import CoreData

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockModel.loadInfo()
        stockModel.loadPrice()
        stockModel.stockInfoDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.tickerLabel.text = self?.stockModel.stockInfo.first?.ticker
                self?.nameLabel.text = self?.stockModel.stockInfo.first?.name
                self?.descriptionLabel.text = self?.stockModel.stockInfo.first?.description
            }
        }
        stockModel.stockPriceDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.closePrice.text = String(self?.stockModel
                    .stockPrice.first?.close ?? 0.00)
                self?.openPrice.text = String(self?.stockModel
                    .stockPrice.first?.open ?? 0.00)
                let difference = self?.stockModel.calcDifference() ?? 0.00
                if difference > 0 {
                    self?.differencePrice.textColor = .green
                    self?.differencePrice.text = "+" + String(format: "%.2f", difference)
                } else {
                    self?.differencePrice.textColor = .red
                    self?.differencePrice.text = String(format: "%.2f", difference)
                }
            }
        }
    }
    
    private func checkCoreData() {
        
        let request = Stock.fetchRequest()
        if let stocks = try? CoreDataService.context.fetch(request) {
            if stocks.isEmpty {
                state = .add
            } else {
                for stock in stocks {
                    if stock.stockName == self.stockModel.stock {
                        state = .delete
                        addStockButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    } else {
                        state = .add
                        addStockButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    }
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
                    CoreDataService.context.delete(stock)
                    CoreDataService.saveContext()
                    addStockButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        case .add :
            let context = CoreDataService.context
            context.perform {
                let newStock = Stock(context: context)
                newStock.stockName = self.stockModel.stock
                CoreDataService.saveContext()
            }
            addStockButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            
        case .none:
            break
        }
    }
}


