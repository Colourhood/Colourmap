final class StateManager {
    private(set) var state: State?

    init() {}

    func changeState(_ state: State) {
        self.state = state
    }
}
