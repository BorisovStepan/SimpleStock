import UIKit
import SafariServices

final class NewsController: UIViewController {
    
    @IBOutlet weak private var tableNews: UITableView!
    @IBOutlet weak private  var xsxs: UILabel!
    private var newsModel = NewsPresenter()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
        tableNews.estimatedRowHeight = 68.0
        stopAnimation()
        tableNews.dataSource = self
        tableNews.delegate = self
    }
    
    private func animation() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func stopAnimation() {
        newsModel.load()
        newsModel.newsDidChange = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableNews.reloadData()
            }
        }
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = newsModel.news[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCell, for: indexPath) as? NewsCell else { return .init() }
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
