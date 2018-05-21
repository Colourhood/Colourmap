extension StateManager {
    final class ActiveSearchState: BaseState {
        private var mainContext: MainContext?

        override func bindContext() {
            mainContext = super.context as? MainContext
        }
    }
}
