import UIKit
import MapKit

class MapView: DismissableKeyboardViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    let componentSubview = UIView()

    // MARK: Data
    var locationService = LocationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        showUserLocationOnMap()
        onDragMap()
        view.addSubview(componentSubview)
        renderCallOut()
    }
}

extension MapView: MKMapViewDelegate {
    // MARK: MapKit
    func showUserLocationOnMap() {
        map.showsUserLocation = true
    }
}

extension MapView {
    // MARK: Component Rendering
    private func renderCallOut() {
        componentSubview.frame.size = CGSize(width: Layout.width * 0.7,
                                             height: Layout.height * 0.06)
        componentSubview.center.y = Position.centerY
        componentSubview.center.x = Position.centerX
        componentSubview.alpha = 0

        guard let callOut: CallOut = renderNib() else { return }
        callOut.frame = componentSubview.bounds
        componentSubview.addSubview(callOut)

        UIView.animate(withDuration: 1.5, delay: 1, animations: {
            self.componentSubview.alpha = 1
        }, completion: { _ in
            self.removeCallOut()
            self.renderDestination()
        })
    }

    private func removeCallOut() {
        guard let callout: CallOut = componentSubview.subviews.first as? CallOut else { return }
        callout.removeFromSuperview()
    }

    private func renderDestination() {
        guard let destination: Destination = renderNib() else { return }
        destination.frame = componentSubview.bounds
        componentSubview.addSubview(destination)

        UIView.animate(withDuration: 1.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.componentSubview.frame.size = CGSize(width: Layout.width * 0.90, height: Layout.height * 0.13)
            self.componentSubview.center.x = Position.centerX
            self.componentSubview.frame.origin.y = self.componentSubview.frame.origin.y * 0.20
        }, completion: { _ in
            self.renderPin()
        })
    }

    private func renderPin() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame.size = CGSize(width: Layout.width / 10, height: Layout.width / 10)
        pin.center = CGPoint(x: Position.centerX, y: Position.centerY)
        view.addSubview(pin)
    }

    func onDragMap() {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector (dismissKeyboard))
        dragGesture.delegate = self
        map.addGestureRecognizer(dragGesture)
    }
}
