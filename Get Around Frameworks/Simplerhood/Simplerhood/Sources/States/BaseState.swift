open class BaseState: State {
    // MARK: Class Properties
    public var completed: (() -> Void)?
    public let context: Context

    public init(context: Context) {
        self.context = context
        bindContext()
        completion()
    }

    deinit {
        stateExit()
    }

    // MARK: Open methods
    open func bindContext() {}
    open func stateEntry() {}
    open func stateExit() {}

    // MARK: Private methods
    private func completion() {
        completed = { [weak self] in
            print("State completed")
            self?.stateEntry()
        }
    }
}
