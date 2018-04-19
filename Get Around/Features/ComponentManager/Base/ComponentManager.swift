import UIKit

class ComponentManager: UIView {
    public let store: DataStore
    public let service: ServiceProvider
    // MARK: Initialization
    init(controller: UIViewController, store: DataStore, service: ServiceProvider) {
        self.store = store
        self.service = service
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controller.view.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        self.store = DataStore()
        self.service = ServiceProvider(store: store)
        super.init(coder: aDecoder)
    }
}
