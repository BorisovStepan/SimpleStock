
import UIKit

class MarketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tickerLavbel: UILabel!
    
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var avaragePrice: UILabel!
    
    func configure(with ticker: MarketModel) {
        var difference: Double
        difference = ticker.c - ticker.o
        if difference < 0 {
            differenceLabel.textColor = .red
            differenceLabel.text = String(format: "%.2f", difference)
        } else {
            differenceLabel.textColor = .systemGreen
            differenceLabel.text = "+" + String(format: "%.2f", difference)
        }
        tickerLavbel.text = ticker.t
        avaragePrice.text = String(format: "%.2f", ticker.vw)
    }
}



