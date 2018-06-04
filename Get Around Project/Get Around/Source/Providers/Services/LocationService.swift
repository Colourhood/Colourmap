import CoreLocation.CLLocationManager
import Foundation

public enum LocationAuthStatus {
    case authorized
    case unauthorized
}

final public class LocationService: NSObject {
    // MARK: Class Properties
    private let manager = CLLocationManager()

    public var currentLocation: CLLocation
    public var authStatus: closure<LocationAuthStatus>?
    public var initialUserLocation: closure<CLLocation>?

    override init() {
        currentLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        super.init()
        manager.delegate = self
    }

    // MARK: Public methods
    public func getLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationAuthorized()
        case .notDetermined:
            locationUnauthorized()
        default: break
        }
    }

    // MARK: Private methods
    private func locationAuthorized() {
        manager.startUpdatingLocation()
        authStatus?(.authorized)
    }

    private func locationUnauthorized() {
        manager.requestWhenInUseAuthorization()
        authStatus?(.unauthorized)
    }

}

extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newCurrentLocation = locations.first else { return }
        self.currentLocation = newCurrentLocation
        initialUserLocation?(newCurrentLocation)
    }
}
