import Foundation
import UIKit

final class ReSearchResults: ComponentManager {
    var searchResults: SearchResults?
    var didShow = false

    override init(controller: UIViewController, store: DataStore, service: ServiceProvider) {
        super.init(controller: controller, store: store, service: service)
        initialFrame()
        renderSearchResults()
        registerNotification()
        swipeUpPanGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Notification Observer
    private func registerNotification() {
        NotificationCenter.default.addObserver(forName: Notification.UpdateSearchResults, object: nil, queue: .main) { [weak self] _ in
            guard let `self` = self else { return }
            self.didShow = true
            let newHeight = Layout.height * 0.065 * CGFloat(self.store.addressSuggestions.count)
            self.frame.size.height = newHeight
            self.searchResults?.frame.size.height = newHeight
            self.searchResults?.reloadData()
        }

        NotificationCenter.default.addObserver(forName: Notification.DismissSearchResults, object: nil, queue: .main) { [weak self] _ in
            let newHeight = CGFloat(0)
            self?.frame.size.height = newHeight
            self?.searchResults?.frame.size.height = newHeight
        }

        NotificationCenter.default.addObserver(self, selector: #selector(animateDismiss),
                                               name: Notification.SearchResultsCellWasPressed, object: nil)
    }

    // MARK: Animation
    private func swipeUpPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector (handleGesture))
        addGestureRecognizer(gesture)
    }

    @objc private func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)

        switch gesture.state {
        case .changed:
            if translation.y < 0 {
                self.frame.origin.y = (Layout.height * 0.13 * 1.65) + translation.y
                self.alpha = (self.frame.size.height * 0.03) / (translation.y * -1)
            }
        case .ended:
            if translation.y < -(frame.size.height / 5) {
                animateDismiss()
            } else {
                // Go back into original position
                UIView.animate(withDuration: 0.2) {
                    self.frame.origin.y = (Layout.height * 0.13 * 1.65)
                    self.alpha = 1
                }
            }
            break
        default: break
        }
    }

    // MARK: Animation Blocks
    @objc private func animateDismiss() {
        if didShow {
            UIView.animate(withDuration: 0.4, animations: {
                self.frame.origin.y = (Layout.height * 0.08)
                self.alpha = 0
            }, completion: { _ in
                let newHeight = CGFloat(0)
                self.frame.origin.y = Layout.height * 0.13 * 1.65
                self.frame.size.height = newHeight
                self.searchResults?.frame.size.height = newHeight
                self.alpha = 1
            })
            didShow = false
        }
    }

    // MARK: Private Component Rendering
    private func renderSearchResults() {
        let view = SearchResults(frame: bounds)
        view.dataSource = self
        view.delegate = self
        searchResults = view
        addSubview(view)
    }

    // MARK: Private Superview Framing
    private func initialFrame() {
        self.frame.size.width = Layout.width * 0.90
        self.frame.origin.y = (Layout.height * 0.13) * 1.65
        self.center.x = Position.centerX
    }
}

extension ReSearchResults: UITableViewDataSource, UITableViewDelegate {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.selectedLocation = store.addressSuggestions[indexPath.row].title
        NotificationCenter.default.post(name: Notification.SearchResultsCellWasPressed, object: nil)
    }
}

