import UIKit

final class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.unselectedItemTintColor = .white
    }
    
    private func setupTabs() {
        guard let home = UIStoryboard(name: ConstantsVC.mainVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.mainVC.1) as? MainViewController else { return }
        guard let news = UIStoryboard(name: ConstantsVC.newsVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.newsVC.1) as? NewsController else { return }
        guard let watchlist = UIStoryboard(name: ConstantsVC.watchlistVC.0, bundle: nil).instantiateViewController(withIdentifier: ConstantsVC.watchlistVC.1) as? WatchListController else { return }
        self.setViewControllers([home, news, watchlist], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
