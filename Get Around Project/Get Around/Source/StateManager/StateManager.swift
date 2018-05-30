final public class StateManager {
    private(set) var state: State?

    public init() {}

    public func changeState(_ state: State) {
        self.state = state
        state.completed?()
    }
}
