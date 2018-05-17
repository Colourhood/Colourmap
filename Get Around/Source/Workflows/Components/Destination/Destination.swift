import UIKit

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!

    var destinationButtonPressed: closure<Void>?

    override func awakeFromNib() {
        roundEdges(0.03)
        destinationTextfield.autocorrectionType = .no
        destinationTextfield.autocapitalizationType = .none
    }

    @IBAction private func panelWasPressed() {
//        destinationPanelButton.isHidden = true
        destinationButtonPressed?(())
    }
}
