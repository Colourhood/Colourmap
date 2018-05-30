import Simplerhood
import RxCocoa
import RxSwift
import UIKit

enum SearchResultEvents {
    case press
    case dismiss
}

final class ReSearchResults: ComponentManager {
    private var searchResults: SearchResults?
    private var didShow = false
    let events = PublishSubject<SearchResultEvents>()

    // MARK: Private Component Rendering
    internal override func renderComponent() {
        let view = SearchResults(frame: bounds)
        view.dataSource = self
        view.delegate = self
        searchResults = view
        addSubview(view)
    }

    // MARK: Private Superview Framing
    internal override func initialFrame() {
        self.frame.size.width = Layout.width * 0.90
        self.frame.origin.y = (Layout.height * 0.13) * 1.65
        self.center.x = Position.centerX
    }

//    private func subscriptions() {
//        // External Subscriptions
//        store.addressSuggestions.asObservable()
//            .subscribe(onNext: { results in
//                self.didShow = true
//                let count = self.store.addressSuggestions.value.count
//                let newHeight = Layout.height * 0.065 * CGFloat(count)
//                self.frame.size.height = newHeight
//                self.searchResults?.frame.size.height = newHeight
//                self.searchResults?.reloadData()
//            }).disposed(by: disposeBag)
//
//        store.dsSearchResults.event.subscribe(onNext: { [weak self] event in
//            switch event {
//            case .dismiss:
//                self?.hideSearchResults()
//            case .press:
//                self?.animateDismiss()
//            }
//        }).disposed(by: disposeBag)
//
//        // Internal Subscriptions
//        searchResults?.rx.itemSelected
//            .subscribe(onNext: { [unowned self] index in
//                let selectedAddress = self.store.addressSuggestions.value[index.row].title
//                self.store.selectedLocation.value = selectedAddress
//                self.store.dsPin.event.onNext(.isHidden(val: true))
//                self.controller.view.endEditing(true)
//                self.store.dsSearchResults.event.onNext(.press)
//            }).disposed(by: disposeBag)
//    }

    private func hideSearchResults() {
        let newHeight = CGFloat(0)
        frame.size.height = newHeight
        searchResults?.frame.size.height = newHeight
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
}

extension ReSearchResults: UITableViewDataSource, UITableViewDelegate {
    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let count = store.addressSuggestions.value.count
//        return count
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let locationData = store.addressSuggestions.value[indexPath.row]
        /* guard let cell: AddressCell = renderNib() else { */ return UITableViewCell() // }
//        cell.mainAddress.text = locationData.title
//        cell.subAddress.text = locationData.subtitle
//        return cell
    }
}

