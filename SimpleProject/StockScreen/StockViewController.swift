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
    let stockPresenter = StockPresenter()
    private var state: WatchlistToDo?
    weak var delegate: StockViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockPresenter.loadPrice()
        stockPresenter.loadInfo()
        updateInfo()
    }
    
    private func configureStockInfo() {
        tickerLabel.text = stockPresenter.stockInfo.first?.ticker
        nameLabel.text = stockPresenter.stockInfo.first?.name
        descriptionLabel.text = stockPresenter.stockInfo.first?.description
    }
    
    private func updateInfo() {
        stockPresenter.stockInfoDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.configureStockInfo()
            }
        }
        stockPresenter.stockPriceDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.configurePriceInfo()
            }
        }
    }
    
    private func checkCoreData() {
        if stockPresenter.checkCoreData() {
            state = .delete
            addStockButton.setImage(Icons.heartFill, for: .normal)
        } else {
            state = .add
            addStockButton.setImage(Icons.heart, for: .normal)
        }
    }
    
    private func configurePriceInfo() {
        closePrice.text = stockPresenter.configurePrice(value: self.stockPresenter
            .stockPrice.first?.close)
        openPrice.text = stockPresenter.configurePrice(value: self.stockPresenter
            .stockPrice.first?.open)
        differencePrice.text = stockPresenter.calcDifference().0
        differencePrice.textColor = stockPresenter.calcDifference().1
    }
    
    @IBAction private func pressAddStockButton(_ sender: Any) {
        switch state {
        case .delete :
            stockPresenter.deleteData()
            delegate?.updateTable()
            state = .add
            addStockButton.setImage(Icons.heart, for: .normal)
        case .add :
            stockPresenter.addDataToCore()
            delegate?.updateTable()
            state = .delete
            addStockButton.setImage(Icons.heartFill, for: .normal)
        case .none:
            break
        }
    }
}


