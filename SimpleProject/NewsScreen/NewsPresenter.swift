import Foundation

final class NewsPresenter {
    
    var news = [NewsModel]() {
        didSet {
            newsDidChange?()
        }
    }
    
    var newsDidChange: (() -> Void)?
    
    private let network = NetworkServiceNews()
    
    func load() {
        network.loadData() { [weak self] newNews in
            self?.news = newNews
        }
    }
}

