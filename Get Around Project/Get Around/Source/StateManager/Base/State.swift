public protocol State {
    var completed: (() -> Void)? { get set }
}
