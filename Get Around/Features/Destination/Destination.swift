import UIKit

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!
    private let searchService = SearchService()

    override func awakeFromNib() {
        roundEdges(0.03)
        registerNotification()
        destinationTextfield.addTarget(self, action: #selector (textFieldDidChange), for: .editingChanged)
    }

    // MARK: Notification Center Observer
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard),
                                               name: Notification.DestinationPanelDidAnimateTop, object: nil)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let address = textField.text else { return }

        searchService.searchAddress(address)
        if address.count == 0 {
            NotificationCenter.default.post(name: Notification.DismissSearchResults, object: nil)
        }
    }

    @objc func showKeyboard() {
        destinationTextfield.becomeFirstResponder()
    }

    @IBAction func panelWasPressed() {
        destinationPanelButton.isHidden = true
        NotificationCenter.default.post(name: Notification.DestinationPanelPressed, object: nil)
    }
}
