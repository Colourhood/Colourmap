import UIKit

final class MainContext: Context {
    public private(set) var controller: UIViewController?
    public private(set) var store = DataStore()
    public private(set) var service: ServiceProvider?
    public private(set) var stateManager: StateManager?

    init(controller: UIViewController) {
        self.controller = controller
        self.service = ServiceProvider(store: store)
        self.stateManager = StateManager(context: self)
    }
}
