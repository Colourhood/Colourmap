import UIKit
import Simplerhood

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!

    var destinationButtonPressed: closure<Void>?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundEdges(0.03)
        customizeTextField()
    }

    private func customizeTextField() {
        destinationTextfield.autocorrectionType = .no
        destinationTextfield.autocapitalizationType = .none
    }

    @IBAction private func panelWasPressed() {
//        destinationPanelButton.isHidden = true
        destinationButtonPressed?(())
    }
}
