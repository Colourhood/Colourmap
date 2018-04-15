import UIKit

final class RePin: ComponentManager {
    func renderPin() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame.size = CGSize(width: Layout.width / 10, height: Layout.width / 10)
        pin.center = CGPoint(x: Position.centerX, y: Position.centerY)
        addSubview(pin)
    }
}

