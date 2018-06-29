import Simplerhood
import UIKit

final class SearchResults: UITableView, RoundedEdges {
    // MARK: Initialization
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        roundEdges(0.025)
        registerCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        roundEdges(0.025)
        registerCell()
    }

    // MARK: Private methods
    private func registerCell() {
        let cellName = "AddressCell"
        register(AddressCell.self, forCellReuseIdentifier: cellName)
    }
}
