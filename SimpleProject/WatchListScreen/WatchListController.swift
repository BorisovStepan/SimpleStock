import UIKit

class WatchListController: UIViewController {
    
    @IBOutlet weak var watchlistTable: UITableView!
    private let network = MarketNetworkService()
    var watchlistModel = WatchListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        watchlistModel.getStocks()
        watchlistTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchlistModel.date = network.currentDate()
        self.watchlistTable.reloadData()
        self.watchlistTable.dataSource = self
        self.watchlistTable.delegate = self
    }
}

extension WatchListController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlistModel.stockPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let priceModel = watchlistModel.stockPrice[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchlistCell", for: indexPath) as! WatchListTableViewCell
        cell.configure(with: priceModel)
        return cell
    }
}

extension WatchListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        watchlistTable.deselectRow(at: indexPath, animated: true)
        let stock = watchlistModel.stockPrice[indexPath.row]
        if let stockVC = UIStoryboard(name: "Stock", bundle: nil).instantiateViewController(withIdentifier: "stock") as? StockViewController {
            stockVC.stockModel.stock  = stock.stockName
            stockVC.stockModel.date = network.currentDate()
            present(stockVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
