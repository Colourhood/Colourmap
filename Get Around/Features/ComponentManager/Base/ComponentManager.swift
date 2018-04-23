import UIKit
import RxSwift

class ComponentManager: UIView {
    public let controller: UIViewController
    public let store: DataStore
    public let service: ServiceProvider
    public let disposeBag = DisposeBag()
    
    // MARK: Initialization
    init(controller: UIViewController, store: DataStore, service: ServiceProvider) {
        self.controller = controller
        self.store = store
        self.service = service
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controller.view.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        self.controller = UIViewController()
        self.store = DataStore()
        self.service = ServiceProvider(store: store)
        super.init(coder: aDecoder)
    }
}
