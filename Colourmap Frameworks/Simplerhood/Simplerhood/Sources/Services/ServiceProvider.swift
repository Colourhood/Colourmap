import CoreLocation.CLGeocoder

final public class ServiceProvider {
    public let search = SearchService()
    public let location = LocationService()
    public let geocoder = CLGeocoder()
    public let stateManager = StateManager()

    public init() {}
}
