import UIKit

protocol RoundedEdges {
    func roundEdges()
}

extension RoundedEdges where Self: UIView {
    func roundEdges() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width * 0.02
    }
}
