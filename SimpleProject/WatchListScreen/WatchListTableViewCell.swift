
import UIKit

class WatchListTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var openPrice: UILabel!
    
    func configure(with price: Stock) {
        if price.differencePrice < 0 {
            differenceLabel.textColor = .red
            differenceLabel.text = String(format: "%.2f", price.differencePrice)
        } else {
            differenceLabel.textColor = .systemGreen
            differenceLabel.text = "+" + String(format: "%.2f", price.differencePrice)
        }
        name.text = price.stockName
        openPrice.text = String(format: "%.2f", price.openPrice)
    } 
}
