import UIKit
import MapKit

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension MKMapView {
    func dragToDismiss(controller: UIViewController) {
        let dragGesture = UIPanGestureRecognizer(target: controller, action: #selector (controller.dismissKeyboard))
        dragGesture.delegate = controller
        addGestureRecognizer(dragGesture)
    }
}
