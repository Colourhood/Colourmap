import Simplerhood
import UIKit

final class RePin: ComponentManager {
    // MARK: Component Render
    internal override func renderComponent() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame = bounds
        addSubview(pin)
    }

    // MARK: Superview Framing
    internal override func initialFrame() {
        frame.size = CGSize(width: Layout.width * 0.08, height: Layout.width * 0.08)
        center = CGPoint(x: (Position.centerX), y: (Position.centerY * 0.97))
    }
}

extension RePin {
    // MARK: Component Changes
    func hide() {
        isHidden = true
    }

    func show() {
        isHidden = false
    }
}

