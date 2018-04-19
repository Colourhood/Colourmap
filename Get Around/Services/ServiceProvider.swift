class ServiceProvider {
    let search: SearchService

    init(store: DataStore) {
        search = SearchService(store: store)
    }
}
