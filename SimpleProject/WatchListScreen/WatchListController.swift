import UIKit

final class WatchListController: UIViewController {
    
    @IBOutlet weak private var watchlistTable: UITableView!
    private var watchlistModel = WatchListViewModel()
    weak var delegate: StockViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        watchlistModel.getStocks()
        watchlistTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let stockVC = UIStoryboard(name: ConstantsVC.stockVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.stockVC.1) as? StockViewController {
            stockVC.delegate = self
            stockVC.stockModel.stock  = stock.stockName
            present(stockVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WatchListController: StockViewControllerDelegate {
    func updateTable() {
        watchlistModel.getStocks()
        watchlistTable.reloadData()
    }
    
}
