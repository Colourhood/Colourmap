import UIKit
import MapKit
import RxSwift
import RxCocoa

final class MainController: UIViewController {
    // MARK: ReComponents
    var map: ReMap!
    var searchResults: ReSearchResults!
    var destination: ReDestination!
    var pin: RePin!

    // MARK: Data Store
    var store: DataStore!
    var service: ServiceProvider!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        store = DataStore()
        service = ServiceProvider(store: store)

        map = ReMap(controller: self, store: store, service: service)
        pin = RePin(controller: self, store: store, service: service)
        searchResults = ReSearchResults(controller: self, store: store, service: service)
        destination = ReDestination(controller: self, store: store, service: service)

        destination.animateIntroduction()
//        subscriptions()
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
