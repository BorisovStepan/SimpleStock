import UIKit
import SafariServices

class NewsController: UIViewController {
    
    @IBOutlet weak var tableNews: UITableView!
    @IBOutlet weak var xsxs: UILabel!
    private var newsModel = NewsViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
        tableNews.estimatedRowHeight = 68.0
        newsModel.load()
        newsModel.newsDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableNews.reloadData()
            }
        }
        tableNews.dataSource = self
        tableNews.delegate = self
    }
    
    private func animation () {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = newsModel.news[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        cell.configure(with: viewModel)
        return cell
    }
}

extension NewsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = newsModel.news[indexPath.row]
        guard let url = URL(string: post.url) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
