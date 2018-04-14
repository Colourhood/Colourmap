import UIKit

class CallOut: UILabel {
    override func awakeFromNib() {
        backgroundColor = UIColor(white: 1, alpha: 0.9)
        roundCorners()
    }

    private func roundCorners() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width * 0.043
    }
}
