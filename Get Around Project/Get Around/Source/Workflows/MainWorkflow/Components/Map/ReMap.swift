import UIKit
import MapKit
import RxSwift
import Simplerhood

enum MapEvents {
    case onDrag
    case updatedUserLocation(MKUserLocation)
}

final class ReMap: ComponentManager {

    private var mapView: Map?
    let events = PublishSubject<MapEvents>()
    let geocoder = CLGeocoder()

    // MARK: Private Component Rendering
    internal override func renderComponent() {
        guard let view: Map = renderNib() else { return }
        view.frame = bounds
        view.delegate = self
        mapView = view
        addSubview(view)
    }

    // MARK: Private Superview Framing
    internal override func initialFrame() {
        frame = CGRect(x: 0, y: 0, width: Layout.width, height: Layout.height)
    }
}

extension ReMap: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        store.currentLocation = userLocation.coordinate
//
//        if !store.didCenterOnUserLocation {
//            store.didCenterOnUserLocation = true
//            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
//            mapView.setRegion(region, animated: false)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
//                let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
//                self.mapView?.setRegion(region, animated: true)
//            }
//        }
    }

    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        events.onNext(.onDrag)
//        store.dsMap.event.onNext(.onDrag)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        //        if !store.hidePin.value {
//        let centerLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
//
//        geocoder.reverseGeocodeLocation(centerLocation) { [weak self] (placemark, _) in
////            self?.destinationSubview.destinationView?.destinationTextfield.text = placemark?.first?.name
//        }
        //        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if !annotation.isEqual(mapView.userLocation) {
            return PinMarker(annotation: annotation, reuseIdentifier: nil)
        }
        return nil
    }

    func findCenterPoint(start: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        var center = CLLocationCoordinate2D()

        let lon1 = start.longitude * .pi / 180;
        let lon2 = destination.longitude * .pi / 180;

        let lat1 = start.latitude * .pi / 180;
        let lat2 = destination.latitude * .pi / 180;

        let dLon = lon2 - lon1;

        let x = cos(lat2) * cos(dLon);
        let y = cos(lat2) * sin(dLon);

        let lat3 = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) );
        let lon3 = lon1 + atan2(y, cos(lat1) + x);

        center.latitude  = lat3 * 180 / .pi;
        center.longitude = lon3 * 180 / .pi;

        return center
    }

    private func getDestinationLocation() {
//        let address = store.selectedLocation.value
//        geocoder.geocodeAddressString(address) { [weak self] (placemark, _) in
//            self?.store.destinationLocation = placemark?.first?.location?.coordinate
//            self?.zoomOutToStartAndDestination()
//        }
    }

    func zoomOutToStartAndDestination() {
//        guard let start = store.currentLocation, let destination = store.destinationLocation else { return }
//        let center = findCenterPoint(start: start, destination: destination)
//
//        let latDelta = abs(start.latitude - destination.latitude) * Double(Layout.height / Layout.width) * 1.3
//        let lonDelta = abs(start.longitude - destination.longitude) * 1.6
//
//        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
//        let region = MKCoordinateRegion(center: center, span: span)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = destination
//
//        store.dsMap.event.onNext(.map(type: .mutedStandard))
//        resetAnnotations()
//        mapView?.addAnnotation(annotation)
//        mapView?.setRegion(region, animated: true)
        //        map.isScrollEnabled = false
        //        map.isZoomEnabled = false
    }

    private func resetAnnotations() {
        let pinAnnotations = mapView?.annotations.filter { !$0.isEqual(mapView?.userLocation) } ?? []
        mapView?.removeAnnotations(pinAnnotations)
    }

    func dragToDismiss(controller: UIViewController) {
        let dragGesture = UIPanGestureRecognizer(target: controller, action: #selector (controller.dismissKeyboard))
        dragGesture.delegate = controller
        addGestureRecognizer(dragGesture)
    }
}


