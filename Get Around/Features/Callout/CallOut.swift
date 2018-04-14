import UIKit

class CallOut: UILabel, RoundedEdges {
    override func awakeFromNib() {
        backgroundColor = UIColor(white: 1, alpha: 0.9)
        roundEdges()
    }
}
