import RxSwift
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocationCoordinate2D?
    var destinationLocation: CLLocationCoordinate2D?
    var selectedLocation = Variable<String>("")
    var addressSuggestions = Variable<[MKLocalSearchCompletion]>([])
    var didCenterOnUserLocation = false
    var viewDidLoad = PublishSubject<Void>()
 }
