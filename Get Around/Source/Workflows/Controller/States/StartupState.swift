extension StateManager {
    final class StartupState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?

        // MARK: Parent Methods
        override func bindContext() {
            mainContext = super.context as? MainContext
        }
        
        override func stateEntry() {
            mainContext = context as? MainContext
        }
    }
}
