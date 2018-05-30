import Foundation
import MapKit

final public class SearchService: NSObject, MKLocalSearchCompleterDelegate {
    private let searchRequest = MKLocalSearchCompleter()

    override init() {
        super.init()
        searchRequest.delegate = self
    }

    public func searchAddress(_ address: String) {
        searchRequest.queryFragment = address
    }

    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let slice = fetchFirstThreeResults(completer)
        let filtered = filterOurSearchNearbySuggestedResults(slice)
//        addressSuggestions.value = filtered
    }

    private func fetchFirstThreeResults(_ search: MKLocalSearchCompleter) -> ArraySlice<MKLocalSearchCompletion> {
        return search.results.prefix(3)
    }

    private func filterOurSearchNearbySuggestedResults(_ results: ArraySlice<MKLocalSearchCompletion>) -> [MKLocalSearchCompletion] {
        return results.filter { $0.subtitle != "Search Nearby" }
    }
}
