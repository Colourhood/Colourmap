import UIKit

class ComponentManager: UIView {
    typealias closure = () -> Void

    // MARK: Initialization
    init(controller: UIViewController) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        controller.view.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Public methods - Rendering
    func renderCallOutThenDestination(finish: @escaping closure = {}) {
        renderCallOut { [weak self] in
            self?.renderDestination {
                finish()
            }
        }
    }

    func renderPin() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame.size = CGSize(width: Layout.width / 10, height: Layout.width / 10)
        pin.center = CGPoint(x: Position.centerX, y: Position.centerY)
        addSubview(pin)
    }

    // MARK: Private Component Rendering
    private func renderCallOut(completed: @escaping closure = {}) {
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
            completed()
        })
    }

    private func renderDestination(completed: @escaping closure = {}) {
        guard let destination: Destination = renderNib() else { return }
        destination.frame = bounds
        addSubview(destination)

        UIView.animate(withDuration: 1.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame.size = CGSize(width: Layout.width * 0.90, height: Layout.height * 0.13)
            self.center.x = Position.centerX
            self.frame.origin.y = self.frame.origin.y * 0.20
        }, completion: { _ in
            completed()
        })
    }

    // MARK: Private Component Removal
    private func removeCallOut() {
        guard let callout: CallOut = subviews.first as? CallOut else { return }
        callout.removeFromSuperview()
    }
}
