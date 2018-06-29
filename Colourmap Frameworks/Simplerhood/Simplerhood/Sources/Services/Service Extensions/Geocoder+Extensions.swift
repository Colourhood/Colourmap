import CoreLocation.CLGeocoder

public extension CLGeocoder {
    public func reverseGeolocationCoordinate2D(coordinate: CLLocationCoordinate2D,
                                               placemark: @escaping ((CLPlacemark?) -> Void)) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        reverseGeocodeLocation(location) { (places, error) in
            placemark(places?.first)
        }
    }
}
