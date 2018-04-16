import Foundation
import MapKit

final class SearchService: NSObject, MKLocalSearchCompleterDelegate {
    private let searchRequest = MKLocalSearchCompleter()

    override init() {
        super.init()
        searchRequest.delegate = self
    }

    func searchAddress(_ address: String) {
        searchRequest.queryFragment = address
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        store.addressSuggestions = completer.results.prefix(3)
        NotificationCenter.default.post(name: Notification.UpdateSearchResults, object: nil)
    }
}
