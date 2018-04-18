import UIKit

class ComponentManager: UIView {
    public let store: DataStore
    // MARK: Initialization
    init(controller: UIViewController, store: DataStore) {
        self.store = store
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controller.view.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        self.store = DataStore()
        super.init(coder: aDecoder)
    }
}
