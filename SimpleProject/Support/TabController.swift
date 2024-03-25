import UIKit

final class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.unselectedItemTintColor = .white
    }
    
    private func setupTabs() {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let news = UIStoryboard(name: "NewsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "NewsController") as! NewsController
        let watchlist = UIStoryboard(name: "Watchlist", bundle: nil).instantiateViewController(withIdentifier: "WatchListController") as! WatchListController
        self.setViewControllers([home, news, watchlist], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
