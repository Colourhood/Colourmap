import UIKit

class Destination: UIView, RoundedEdges {
    @IBOutlet weak var destinationTextfield: UITextField!

    override func awakeFromNib() {
        roundEdges()
    }
}
