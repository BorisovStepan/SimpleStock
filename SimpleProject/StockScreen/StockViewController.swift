import UIKit

class StockViewController: UIViewController {
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var differencePrice: UILabel!
    @IBOutlet weak var closePrice: UILabel!
    @IBOutlet weak var openPrice: UILabel!
    let stockModel = StockViewModel()
    
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
}
