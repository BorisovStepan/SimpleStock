import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak private var tableMarket: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    private var marketPresenter = MarketPresenter()
    private var filteredData = [MarketModel]()
    private var isSearching = false
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        animation()
        marketPresenter.load()
        stopAnimation()
        tableMarket.delegate = self
        tableMarket.dataSource = self
    }
    
    private func animation () {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func stopAnimation() {
        marketPresenter.marketDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableMarket.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        } else {
            return marketPresenter.market.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.marketCell, for: indexPath) as! MarketTableViewCell
        if isSearching {
            let viewModel = filteredData[indexPath.row]
            cell.configure(with: viewModel)
        } else {
            let viewModel = marketPresenter.market[indexPath.row]
            cell.configure(with: viewModel)
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isSearching {
            let stock = filteredData[indexPath.row]
            if let stockVC = UIStoryboard(name: ConstantsVC.stockVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.stockVC.1) as? StockViewController {
                stockVC.stockPresenter.stock = stock.stockName
                self.present(stockVC, animated: true)
            }
        } else {
            let stock = marketPresenter.market[indexPath.row]
            if let stockVC = UIStoryboard(name: ConstantsVC.stockVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.stockVC.1) as? StockViewController {
                stockVC.stockPresenter.stock = stock.stockName
                self.present(stockVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData.removeAll()
        if searchBar.text == "" {
            isSearching = false
            tableMarket.reloadData()
        } else {
            isSearching = true
            filteredData = marketPresenter.market.filter({$0.stockName.contains(searchBar.text ?? "")})
            tableMarket.reloadData()
        }
    }
}
