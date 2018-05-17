import RxSwift
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocationCoordinate2D?
    var destinationLocation: CLLocationCoordinate2D?
    var selectedLocation = Variable<String>("")
    var addressSuggestions = Variable<[MKLocalSearchCompletion]>([])
    var didCenterOnUserLocation = false
    var viewDidLoad = PublishSubject<Void>()

    var dsSearchResults = DSSearchResults()
    var dsPin = DSPin()
 }

extension DataStore {
    final class DSSearchResults {
        enum events {
            case press
            case dismiss
        }
        let event = PublishSubject<events>()
    }

    final class DSPin {
        enum events {
            case isHidden(val: Bool)
        }
        let event = PublishSubject<events>()
    }
}
