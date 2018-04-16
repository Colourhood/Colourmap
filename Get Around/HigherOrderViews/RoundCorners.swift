import UIKit

protocol RoundedEdges {
    func roundEdges(_ ratio: CGFloat)
}

extension RoundedEdges where Self: UIView {
    func roundEdges(_ ratio: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width * ratio
    }
}
