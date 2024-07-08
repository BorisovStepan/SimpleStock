
import UIKit

final class WatchListTableViewCell: UITableViewCell {
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var differenceLabel: UILabel!
    @IBOutlet weak private var openPrice: UILabel!
    
    func configure(with price: Stock) {
        if price.differencePrice < 0 {
            differenceLabel.textColor = .red
            differenceLabel.viewPrintFormatter()
            differenceLabel.text = String(format: "%.2f", price.differencePrice)
        } else {
            differenceLabel.textColor = .systemGreen
            differenceLabel.text = "+" + String(format: "%.2f", price.differencePrice)
        }
        name.text = price.stockName
        openPrice.text = String(format: "%.2f", price.openPrice)
    } 
}
