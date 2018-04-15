import UIKit

class Destination: UIView, RoundedEdges, UITextFieldDelegate {
    @IBOutlet weak var destinationTextfield: UITextField!

    override func awakeFromNib() {
        roundEdges()
        destinationTextfield.addTarget(self, action: #selector (textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        store.location = textField.text
    }
}
