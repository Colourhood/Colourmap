extension StateManager {
    final class ActiveSearchState: BaseState {
        private var mainContext: MainContext?

        override init(context: Context) {
            super.init(context: context)
            self.mainContext = context as? MainContext
        }
    }
}
