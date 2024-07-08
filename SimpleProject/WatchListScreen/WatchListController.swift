import UIKit

final class WatchListController: UIViewController {
    
    @IBOutlet weak private var watchlistTable: UITableView!
    private var watchlistPresenter = WatchListPresenter()
    weak var delegate: StockViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        watchlistPresenter.getStocks()
        watchlistTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.watchlistTable.dataSource = self
        self.watchlistTable.delegate = self
    }
}

extension WatchListController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlistPresenter.stockPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let priceModel = watchlistPresenter.stockPrice[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.watchListCell, for: indexPath) as? WatchListTableViewCell else { return .init() }
        cell.configure(with: priceModel)
        return cell
    }
}

extension WatchListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        watchlistTable.deselectRow(at: indexPath, animated: true)
        let stock = watchlistPresenter.stockPrice[indexPath.row]
        if let stockVC = UIStoryboard(name: ConstantsVC.stockVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.stockVC.1) as? StockViewController {
            stockVC.delegate = self
            stockVC.stockPresenter.stock  = stock.stockName
            present(stockVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WatchListController: StockViewControllerDelegate {
    func updateTable() {
        watchlistPresenter.getStocks()
        watchlistTable.reloadData()
    }
}
