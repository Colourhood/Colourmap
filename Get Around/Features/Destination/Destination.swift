import UIKit

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!

    override func awakeFromNib() {
        roundEdges(0.03)
    }

    @IBAction func panelWasPressed() {
        destinationPanelButton.isHidden = true
        NotificationCenter.default.post(name: Notification.DestinationPanelPressed, object: nil)
    }
}
