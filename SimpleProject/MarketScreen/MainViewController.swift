import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableMarket: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    private let network = MarketNetworkService()
    var marketModel = MarketViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        animation()
        marketModel.load()
        marketModel.marketDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableMarket.reloadData()
            }
        }
        tableMarket.delegate = self
        tableMarket.dataSource = self
    }
    
    private func animation () {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketModel.market.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = marketModel.market[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell", for: indexPath) as! MarketTableViewCell
        cell.configure(with: viewModel)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stock = marketModel.market[indexPath.row]
        if let stockVC = UIStoryboard(name: "Stock", bundle: nil).instantiateViewController(withIdentifier: "stock") as? StockViewController {
            stockVC.stockModel.stock  = stock.t
            stockVC.stockModel.date = network.currentDate()
            present(stockVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MainViewController: UISearchBarDelegate {
    
}
