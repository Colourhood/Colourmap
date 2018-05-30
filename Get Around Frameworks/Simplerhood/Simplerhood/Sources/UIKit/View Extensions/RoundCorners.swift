import UIKit

public protocol RoundedEdges {
    func roundEdges(_ ratio: CGFloat)
}

public extension RoundedEdges where Self: UIView {
    func roundEdges(_ ratio: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width * ratio
    }
}
