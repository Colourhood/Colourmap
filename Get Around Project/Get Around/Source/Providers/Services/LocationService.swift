import CoreLocation
import Foundation

public enum LocationAuthStatus {
    case authorized
    case unauthorized
}

final public class LocationService: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    public var authStatus: closure<LocationAuthStatus>?

    override init() {
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
