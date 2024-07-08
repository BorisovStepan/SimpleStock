
import UIKit

final class MarketTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var tickerLavbel: UILabel!
    @IBOutlet weak private var differenceLabel: UILabel!
    @IBOutlet weak private var avaragePrice: UILabel!
    
    func configure(with ticker: MarketModel) {
        var difference: Double
        difference = ticker.closePrice - ticker.openPrice
        if difference < 0 {
            differenceLabel.textColor = .red
            differenceLabel.text = String(format: "%.2f", difference)
        } else {
            differenceLabel.textColor = .systemGreen
            differenceLabel.text = "+" + String(format: "%.2f", difference)
        }
        tickerLavbel.text = ticker.stockName
        avaragePrice.text = String(format: "%.2f", ticker.avvaregePrice)
    }
}



