import UIKit

class Destination: UIView {
    @IBOutlet weak var destinationTextfield: UITextField!

    override func awakeFromNib() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width * 0.043
    }
}
