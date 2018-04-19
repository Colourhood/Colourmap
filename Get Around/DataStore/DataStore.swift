import Foundation
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocationCoordinate2D?
    var destinationLocation: CLLocationCoordinate2D?
    var selectedLocation: String?
    var didCenterOnUserLocation: Bool = false
    var addressSuggestions: [MKLocalSearchCompletion] = []
 }
