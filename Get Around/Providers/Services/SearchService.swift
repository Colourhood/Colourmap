import Foundation
import MapKit
import RxSwift

final class SearchService: NSObject, MKLocalSearchCompleterDelegate {
    private let searchRequest = MKLocalSearchCompleter()
    private(set) var addressSuggestions = Variable<[MKLocalSearchCompletion]>([])

    override init() {
        super.init()
        searchRequest.delegate = self
    }

    func searchAddress(_ address: String) {
        searchRequest.queryFragment = address
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let slice = fetchFirstThreeResults(completer)
        let filtered = filterOurSearchNearbySuggestedResults(slice)
        addressSuggestions.value = filtered
    }

    private func fetchFirstThreeResults(_ search: MKLocalSearchCompleter) -> ArraySlice<MKLocalSearchCompletion> {
        return search.results.prefix(3)
    }

    private func filterOurSearchNearbySuggestedResults(_ results: ArraySlice<MKLocalSearchCompletion>) -> [MKLocalSearchCompletion] {
        return results.filter { $0.subtitle != "Search Nearby" }
    }
}
