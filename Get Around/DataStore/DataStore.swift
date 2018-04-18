import Foundation
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocation?
    var selectedLocation: String?
    var didCenterOnUserLocation: Bool = false
    var addressSuggestions: [MKLocalSearchCompletion] = []
 }
