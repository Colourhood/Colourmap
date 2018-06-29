import Simplerhood
import RxSwift

extension MainContext {
    final class StartupState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var locationService: LocationService?
        private var stateManager: StateManager?
        private var disposeBag = DisposeBag()

        // MARK: Parent Methods
        override func bindContext() {
            mainContext = super.context as? MainContext
            locationService = mainContext?.provider?.location
            stateManager = mainContext?.provider?.stateManager
        }
        
        override func stateEntry() {
            subscribeToLocationService()
            locationService?.getLocationPermission()
        }

        // MARK: Private Methods
        private func subscribeToLocationService() {
            locationService?.authStatus = { [unowned self] authStatus in
                switch authStatus {
                case .authorized:
                    self.changeStateToInitialState()
                case .unauthorized:
                    print("User chose to not authorize use of location service")
                }
            }
        }

        // MARK: State Changes
        private func changeStateToInitialState() {
            stateManager?.changeState(InitialState(context: context))
        }
    }
}
