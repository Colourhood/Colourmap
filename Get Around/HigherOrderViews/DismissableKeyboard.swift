import UIKit

class DismissableKeyboardViewController: UIViewController, UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc func dismissKeyboard(_ gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
}
