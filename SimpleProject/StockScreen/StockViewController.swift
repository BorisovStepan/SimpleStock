

import UIKit

class StockViewController: UIViewController {
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var dateLAbel: UILabel!
    private let network = StockNetworkService()
    var stock: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickerLabel.text = stock
        dateLAbel.text = date
        
    }
    private func loadInfo() {
        network.date = date
        network.stock = stock
        
    }
}
