final class ServiceProvider {
    let search: SearchService
    let location: LocationService

    init(store: DataStore) {
        search = SearchService()
        location = LocationService()
    }
}
