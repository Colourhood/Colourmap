import UIKit

class SearchResults: UITableView {

    override func awakeFromNib() {
        registerCell()
    }

    // MARK: Private methods
    private func registerCell() {
        register(AddressCell.self, forCellReuseIdentifier: String(describing: AddressCell.self))
    }
}
