import UIKit

struct Positions {
    struct Vertical {
        static let center: CGFloat = UIScreen.main.bounds.midY
        static func bottom(view: UIView) -> CGFloat {
            return UIScreen.main.bounds.height - view.frame.height - 40
        }
    }

    struct Horizontal {
        static let center: CGFloat = UIScreen.main.bounds.midX
    }
}
