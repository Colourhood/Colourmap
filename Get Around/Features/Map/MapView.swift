import UIKit
import MapKit

class MapView: UIViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    let componentSubview = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        onDragMap()
        view.addSubview(componentSubview)
        renderCallOut()
    }
}

extension MapView {

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
            self.componentSubview.frame = CGRect(x: 0, y: 20, width: Layout.width, height: Layout.height * 0.13)
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
}

extension MapView: UIGestureRecognizerDelegate {

    // MARK: Gesture Recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func onDragMap() {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector (MapView.dismissKeyboard))
        dragGesture.delegate = self
        map.addGestureRecognizer(dragGesture)
    }

    @objc func dismissKeyboard(_ gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
}
