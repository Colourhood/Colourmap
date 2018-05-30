final public class ServiceProvider {
    public let search = SearchService()
    public let location = LocationService()
    public let stateManager = StateManager()

    public init() {}
}
