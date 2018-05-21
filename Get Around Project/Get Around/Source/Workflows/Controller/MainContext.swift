import UIKit

final class MainContext: Context {
    private(set) var store = DataStore()
    private(set) var service: ServiceProvider?
    private(set) var stateManager: StateManager?
    private(set) var controller: UIViewController?

    init(mainController: MainController) {
        self.controller = mainController
        self.service = ServiceProvider(store: store)
        self.stateManager = StateManager()

        initializeStartUpState()
    }

    private func initializeStartUpState() {
        let startUpState = StateManager.StartupState(context: self)
        stateManager?.changeState(startUpState)
    }
}
