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
        let slice = completer.results.prefix(3)
        let filter = slice.filter { $0.subtitle != "Search Nearby" }

        addressSuggestions.value = filter
    }
}
