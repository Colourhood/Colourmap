import Simplerhood

final class MainContext: Context {
    private(set) var controller: MainController?
    private(set) var provider: ServiceProvider?

    open func bindController(_ controller: UIViewController, _ provider: ServiceProvider) {
        self.controller = controller as? MainController
        self.provider = provider
        initializeStartUpState()
    }
    
    private func initializeStartUpState() {
        provider?.stateManager.changeState(StartupState(context: self))
    }
}
