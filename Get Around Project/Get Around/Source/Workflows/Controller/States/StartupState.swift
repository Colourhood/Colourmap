extension StateManager {
    final class StartupState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var locationService: LocationService?
        private var stateManager: StateManager?

        // MARK: Parent Methods
        override func bindContext() {
            mainContext = super.context as? MainContext
            locationService = mainContext?.service?.location
            stateManager = mainContext?.stateManager
        }
        
        override func stateEntry() {
            subscribeToLocationService()
            locationService?.getLocationPermission()
        }

        // MARK: Private Methods
        private func subscribeToLocationService() {
            locationService?.authStatus
                .subscribe(onNext: { [weak self] authStatus in
                    switch authStatus {
                    case .authorized:
                        self?.changeStateToInitialState()
                    case .unauthorized:
                        print("User chose to not authorize use of location service")
                    }
                }).disposed(by: disposeBag)
        }

        // MARK: State Changes
        private func changeStateToInitialState() {
            stateManager?.changeState(InitialState(context: super.context))
        }
    }
}
