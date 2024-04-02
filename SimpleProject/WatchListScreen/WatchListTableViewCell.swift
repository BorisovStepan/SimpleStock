
import UIKit

class WatchListTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var openPrice: UILabel!
    
    func configure(with price: PriceModel) {
        var difference: Double
        difference = price.close - price.open
        if difference < 0 {
            differenceLabel.textColor = .red
            differenceLabel.text = String(format: "%.2f", difference)
        } else {
            differenceLabel.textColor = .systemGreen
            differenceLabel.text = "+" + String(format: "%.2f", difference)
        }
        name.text = price.name
        openPrice.text = String(format: "%.2f", price.open)
    } 
}
