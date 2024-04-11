import UIKit
import CoreData

protocol StockViewControllerDelegate: AnyObject {
    func updateTable()
}

final class StockViewController: UIViewController {
    @IBOutlet weak private var tickerLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var addStockButton: UIButton!
    @IBOutlet weak private var differencePrice: UILabel!
    @IBOutlet weak private var closePrice: UILabel!
    @IBOutlet weak private var openPrice: UILabel!
    let stockModel = StockViewModel()
    private var state: WatchlistToDo?
    weak var delegate: StockViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockModel.loadPrice()
        stockModel.loadInfo()
        updateInfo()
    }
    
    private func configureStockInfo() {
        tickerLabel.text = stockModel.stockInfo.first?.ticker
        nameLabel.text = stockModel.stockInfo.first?.name
        descriptionLabel.text = stockModel.stockInfo.first?.description
    }
    
    private func updateInfo() {
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
    
    private func checkCoreData() {
        if stockModel.checkCoreData() {
            state = .delete
            addStockButton.setImage(Icons.heartFill, for: .normal)
        } else {
            state = .add
            addStockButton.setImage(Icons.heart, for: .normal)
        }
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
    
    @IBAction private func pressAddStockButton(_ sender: Any) {
        switch state {
        case .delete :
            stockModel.deleteData()
            delegate?.updateTable()
            state = .add
            addStockButton.setImage(Icons.heart, for: .normal)
        case .add :
            stockModel.addDataToCore()
            delegate?.updateTable()
            state = .delete
            addStockButton.setImage(Icons.heartFill, for: .normal)
        case .none:
            break
        }
    }
}


