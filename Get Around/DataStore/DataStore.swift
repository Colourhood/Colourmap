import Foundation
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocation?
    var didCenterOnUserLocation: Bool = false
    var addressSuggestions: [MKLocalSearchCompletion] = []
 }
