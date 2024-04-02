//
//  WatchListController.swift
//  SimpleProject
//
//  Created by Stepan Borisov on 10.03.24.
//

import UIKit

class WatchListController: UIViewController {
    
    @IBOutlet weak var watchlistTable: UITableView!
    private let network = MarketNetworkService()
    var watchlistModel = WatchListViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.watchlistTable.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
        watchlistModel.date = network.currentDate()
        watchlistModel.loadPrice()
        watchlistModel.stockPriceDidChange = {
            DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.watchlistTable.reloadData()
            }
        }
        self.watchlistTable.dataSource = self
        self.watchlistTable.delegate = self
    }
    
    private func animation () {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
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
        let stock = watchlistModel.stockPrice[indexPath.row]
        if let stockVC = UIStoryboard(name: "Stock", bundle: nil).instantiateViewController(withIdentifier: "stock") as? StockViewController {
            stockVC.stockModel.stock  = stock.name
            stockVC.stockModel.date = network.currentDate()
            present(stockVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
