import UIKit
import MapKit

final class MapView: UIViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    var searchResultsSubview: ReSearchResults!
    var destinationSubview: ReDestination!
    var pinSubview: RePin!

    override func viewDidLoad() {
        map.dragToDismiss(controller: self)
        pinSubview = RePin(controller: self)
        searchResultsSubview = ReSearchResults(controller: self)
        destinationSubview = ReDestination(controller: self)
        destinationSubview.animateIntroduction()
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if !store.didCenterOnUserLocation {
            store.didCenterOnUserLocation = true
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            map.setRegion(region, animated: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
                let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
                self.map.setRegion(region, animated: true)
            }
        }
    }
}
