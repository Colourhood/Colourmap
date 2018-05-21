import Simplerhood
import UIKit

final class MainController: UIViewController {
    // MARK: ReComponents
    private(set) var map: ReMap!
    private(set) var searchResults: ReSearchResults!
    private(set) var destination: ReDestination!
    private(set) var pin: RePin!

    // MARK: Context
    private(set) var mainContext: MainContext!

    // MARK: Superclass Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        map = ReMap(controller: self)
        pin = RePin(controller: self)
        searchResults = ReSearchResults(controller: self)
        destination = ReDestination(controller: self)

        mainContext = MainContext(mainController: self)
        
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
