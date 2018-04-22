import RxSwift
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocationCoordinate2D?
    var destinationLocation: CLLocationCoordinate2D?
    var selectedLocation = Variable<String>("")
    var didCenterOnUserLocation: Bool = false
    var addressSuggestions = Variable<[MKLocalSearchCompletion]>([])

    // Events
    let destinationPress = PublishSubject<Void>()
    let destinationPanelAnimateTop = PublishSubject<Void>()
    let searchResultsPressed = PublishSubject<Void>()
    let searchResultsDismiss = PublishSubject<Void>()
    let mapDragged = PublishSubject<Void>()
 }
