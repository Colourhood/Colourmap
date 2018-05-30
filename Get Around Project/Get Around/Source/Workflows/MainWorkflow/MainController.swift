import Simplerhood
import UIKit

final class MainController: UIViewController {
    // MARK: ReComponents
    let map = ReMap()
    let searchResults = ReSearchResults()
    let destination = ReDestination()
    let pin = RePin()

    // MARK: Service Provider
    private let provider = ServiceProvider()

    // MARK: Context
    private(set) var mainContext = MainContext()

    // MARK: Superclass Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        map.bindController(self)
        searchResults.bindController(self)
        destination.bindController(self)
        pin.bindController(self)

        mainContext.bindController(self, provider)
    }
    
//    func subscriptions() {
//        // External Subcriptions
//        store.dsSearchResults.event.subscribe(onNext: { [weak self] event in
//            switch event {
//            case .press:
//                self?.getDestinationLocation()
//            default: break
//            }
//        }).disposed(by: disposeBag)
//
//        store.dsMap.event.subscribe(onNext: { [weak self] event in
//            switch event {
//            case .map(let type):
//                self?.map.mapType = type
//            default: break
//            }
//        }).disposed(by: disposeBag)
//    }
}
