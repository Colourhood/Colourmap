protocol State {
}

class StateManager {
    var state: State

    init(context: MainContext) {
        state = ReInitialState(context: context)
    }

    func changeState(_ state: State) {
        self.state = state
    }
}
