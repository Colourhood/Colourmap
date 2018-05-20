final class StateManager {
    var state: State

    init(context: MainContext) {
        state = InitialState(context: context)
    }

    func changeState(_ state: State) {
        self.state = state
    }
}
