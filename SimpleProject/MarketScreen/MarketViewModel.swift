
import Foundation

final class MarketViewModel {
    
    var market = [MarketModel]() {
        didSet {
            marketDidChange?()
        }
    }
    
    var marketDidChange: (() -> Void)?
    
    private let network = MarketNetworkService()
    
    func load() {
        network.loadData() { [weak self] newData in
            self?.market = newData
        }
    }
}
