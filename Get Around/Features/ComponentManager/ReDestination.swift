import UIKit

final class ReDestination: ComponentManager {

    var destinationView: Destination?

    // MARK: Initialization
    override init(controller: UIViewController) {
        super.init(controller: controller)
        initialFrame()
        renderDestination()
        registerNotification()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Notification Center Observer
    private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector (animateToTop),
                                               name: Notification.DestinationPanelPressed, object: nil)
    }

    // MARK: Animations
    func animateIntroduction(next: @escaping closure) {
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseInOut, animations: {
            self.frame.origin.y = Layout.height - self.frame.height
        }, completion: { _ in
            next()
        })
    }

    @objc func animateToTop() {
        UIView.animate(withDuration: 0.80, delay: 0.0, options: .curveEaseOut, animations: {
            self.frame.size.width = Layout.width * 0.90
            self.frame.origin.y = Layout.height * 0.08
            self.destinationView?.layer.cornerRadius = self.frame.size.width * 0.025
            self.center.x = Position.centerX
        }, completion: { _ in
            NotificationCenter.default.post(name: Notification.DestinationPanelDidAnimateTop, object: nil)
        })
    }

    // MARK: Private Component Rendering
    private func renderDestination() {
        guard let view: Destination = renderNib() else { return }
        view.frame = bounds
        destinationView = view
        addSubview(view)
    }

    // MARK: Private Superview Framing
    private func initialFrame() {
        let newSize = CGSize(width: Layout.width, height: Layout.height * 0.13)
        let newOrigin = CGPoint(x: 0, y: Layout.height)
        frame = CGRect(origin: newOrigin, size: newSize)
        center.x = Position.centerX
    }
}
