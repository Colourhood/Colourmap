import Foundation
import UIKit

final class ReSearchResults: ComponentManager {
    var searchResults: SearchResults?
    var didRenderView: Bool = false

    override init(controller: UIViewController) {
        super.init(controller: controller)
        initialFrame()
        renderSearchResults()
        registerNotification()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Notification Observer
    private func registerNotification() {
        NotificationCenter.default.addObserver(forName: Notification.UpdateSearchResults, object: nil, queue: .main) { [weak self] _ in
            self?.searchResults?.frame.size.height = Layout.height * 0.068 * CGFloat(store.addressSuggestions.count)
            self?.searchResults?.reloadData()
        }

        NotificationCenter.default.addObserver(forName: Notification.DismissSearchResults, object: nil, queue: .main) { [weak self] _ in
            self?.searchResults?.frame.size.height = 0.0
        }
    }

    // MARK: Private Component Rendering
    private func renderSearchResults() {
        let view = SearchResults(frame: bounds)
        searchResults = view
        addSubview(view)
    }

    // MARK: Private Superview Framing
    private func initialFrame() {
        self.frame.size.width = Layout.width * 0.90
        self.frame.origin.y = (Layout.height * 0.13) * 1.5
        self.center.x = Position.centerX
    }
}
