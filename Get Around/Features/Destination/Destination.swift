import UIKit

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!

    var store: DataStore?

    override func awakeFromNib() {
        roundEdges(0.03)
    }

    @IBAction func panelWasPressed() {
        destinationPanelButton.isHidden = true
        store?.destinationPress.onNext(())
    }
}
