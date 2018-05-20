import CoreLocation
import Foundation
import RxSwift

enum LocationAuthStatus {
    case authorized
    case unauthorized
}

final class LocationService: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private(set) var authStatus = PublishSubject<LocationAuthStatus>()

    override init() {
        super.init()
        manager.delegate = self
    }

    // MARK: Public methods
    func getLocationPermission() {
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
        authStatus.onNext(.authorized)
    }

    private func locationUnauthorized() {
        manager.requestWhenInUseAuthorization()
        authStatus.onNext(.unauthorized)
    }
}
