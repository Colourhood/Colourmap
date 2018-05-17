extension StateManager {
    final class ActiveSearchState: State {
        private var context: MainContext

        init(context: MainContext) {
            self.context = context
        }

        func subscribeToEvents() {
        }
    }
}
