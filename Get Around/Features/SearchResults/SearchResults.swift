import UIKit

class SearchResults: UITableView, UITableViewDataSource, UITableViewDelegate, RoundedEdges {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        isScrollEnabled = false
        separatorStyle = .none
        alpha = 0.9
        roundEdges()
        
        registerCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Private methods
    private func registerCell() {
        register(AddressCell.self, forCellReuseIdentifier: String(describing: AddressCell.self))
    }
    
    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.addressSuggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationData = store.addressSuggestions[indexPath.row]
        guard let cell: AddressCell = renderNib() else { return UITableViewCell() }
        cell.mainAddress.text = locationData.title
        cell.subAddress.text = locationData.subtitle
        return cell
    }
}
