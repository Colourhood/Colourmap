import UIKit

final class MainContext: Context {
    private(set) var store = DataStore()
    private(set) var service: ServiceProvider?
    private(set) var stateManager: StateManager?
    internal var controller: UIViewController?

    init(mainController: MainController) {
        self.controller = mainController
        self.service = ServiceProvider(store: store)
        self.stateManager = StateManager(context: self)
    }

    var mainController: MainController? {
        return controller as? MainController
    }
}
