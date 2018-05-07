import UIKit

protocol Context {
    var store: DataStore { get }
    var controller: UIViewController? { get }
    var stateManager: StateManager? { get }
    var service: ServiceProvider? { get }
}

final class EmptyContext: Context {
    public private(set) var store = DataStore()
    public private(set) var controller: UIViewController?
    public private(set) var stateManager: StateManager?
    public private(set) var service: ServiceProvider?

    init() {
    }
}
