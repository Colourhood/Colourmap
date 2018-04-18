import Foundation
import MapKit

final class SearchService: NSObject, MKLocalSearchCompleterDelegate {
    private let searchRequest = MKLocalSearchCompleter()
    private let store: DataStore

    init(store: DataStore) {
        self.store = store
        super.init()
        searchRequest.delegate = self
    }

    func searchAddress(_ address: String) {
        searchRequest.queryFragment = address
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let filteredResults = completer.results.prefix(3).filter { $0.subtitle != "Search Nearby" }
        store.addressSuggestions = filteredResults
        NotificationCenter.default.post(name: Notification.UpdateSearchResults, object: nil)
    }
}
