import UIKit

class ComponentManager: UIView {
    // MARK: Component Rendering
    func renderCallOut() {
        frame.size = CGSize(width: Layout.width * 0.7, height: Layout.height * 0.06)
        center.y = Position.centerY
        center.x = Position.centerX
        alpha = 0

        guard let callOut: CallOut = renderNib() else { return }
        callOut.frame = bounds
        addSubview(callOut)

        UIView.animate(withDuration: 1.5, delay: 1, animations: {
            self.alpha = 1
        }, completion: { _ in
            self.removeCallOut()
            self.renderDestination()
        })
    }

    func renderDestination() {
        guard let destination: Destination = renderNib() else { return }
        destination.frame = bounds
        addSubview(destination)

        UIView.animate(withDuration: 1.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame.size = CGSize(width: Layout.width * 0.90, height: Layout.height * 0.13)
            self.center.x = Position.centerX
            self.frame.origin.y = self.frame.origin.y * 0.20
        }, completion: { _ in
//            self.renderPin()
        })
    }

//    func renderPin() {
//        guard let pin: Pin = renderNib() else { return }
//        pin.frame.size = CGSize(width: Layout.width / 10, height: Layout.width / 10)
//        pin.center = CGPoint(x: Position.centerX, y: Position.centerY)
//        view.addSubview(pin)
//    }

    // MARK: Component Removal
    private func removeCallOut() {
        guard let callout: CallOut = subviews.first as? CallOut else { return }
        callout.removeFromSuperview()
    }
}
