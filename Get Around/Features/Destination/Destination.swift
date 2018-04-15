import UIKit

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var destinationTextfield: UITextField!
    private let searchService = SearchService()

    override func awakeFromNib() {
        roundEdges()
        destinationTextfield.addTarget(self, action: #selector (textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let address = textField.text else { return }
        searchService.searchAddress(address)
    }
}
