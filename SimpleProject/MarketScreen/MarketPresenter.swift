
import Foundation

final class MarketPresenter {
    
    var market = [MarketModel]() {
        didSet {
            marketDidChange?()
        }
    }
    
    var marketDidChange: (() -> Void)?
    
    let network: MarketNetworkService
    
    init() {
        self.network = MarketNetworkService()
    }
    
    func load() {
        network.loadData { [weak self] newData in
            self?.market = newData
        }
    }
}
