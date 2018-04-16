import Foundation
import MapKit

final class DataStore: NSObject {
    var currentLocation: CLLocation?
    var addressSuggestions: ArraySlice<MKLocalSearchCompletion> = ArraySlice([])
 }
