import UIKit

class SearchResults: UITableView, RoundedEdges {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        customUI()
        registerCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Private methods
    private func customUI() {
        isScrollEnabled = false
        separatorStyle = .none
        alpha = 0.9
        roundEdges(0.025)
    }

    private func registerCell() {
        register(AddressCell.self, forCellReuseIdentifier: String(describing: AddressCell.self))
    }
}
