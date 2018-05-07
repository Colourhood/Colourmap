import UIKit

final class MainController: UIViewController {
    // MARK: ReComponents
    public private(set) var map: ReMap!
    public private(set) var searchResults: ReSearchResults!
    public private(set) var destination: ReDestination!
    public private(set) var pin: RePin!

    // MARK: Context
    public private(set) var mainContext: Context!
    
    override func viewDidLoad() {
        mainContext = MainContext(controller: self)
        
        map = ReMap(context: mainContext)
        pin = RePin(context: mainContext)
        searchResults = ReSearchResults(context: mainContext)
        destination = ReDestination(context: mainContext)
    }

    override func viewWillAppear(_ animated: Bool) {
        mainContext.store.viewDidLoad.onNext(())
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
