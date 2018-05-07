extension StateManager {
    class ReActiveSearchState: State {
        private var context: MainContext

        init(context: MainContext) {
            self.context = context
        }

        func subscribeToEvents() {
        }
    }
}
