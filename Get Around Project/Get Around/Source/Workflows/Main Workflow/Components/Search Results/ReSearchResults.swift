import Simplerhood
import RxCocoa
import RxSwift
import MapKit
import UIKit

enum SearchResultEvents {
    case press
    case dismiss
}

final class ReSearchResults: ComponentManager {
    private var searchResults: SearchResults?

    private var dataSource: [MKLocalSearchCompletion] = []
    private var didShow = false

    let events = PublishSubject<SearchResultEvents>()

    // MARK: Private Component Rendering
    internal override func renderComponent() {
        guard let view: SearchResults = renderNib() else { return }
        view.frame = bounds
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

    override func childViewEvents() {
        swipeUpPanGesture()
    }
}

extension ReSearchResults {
    // MARK: Component Changes
    func updateSearchResults(_ searchCompletion: [MKLocalSearchCompletion]) {
        dataSource = searchCompletion
        updateRenderingOfResults()
    }

    private func updateRenderingOfResults() {
        let count = dataSource.count
        let newViewHeight = Layout.height * 0.065 * CGFloat(count)

        frame.size.height = newViewHeight
        searchResults?.frame.size.height = newViewHeight
        searchResults?.reloadData()
    }
}

extension ReSearchResults {
    // MARK: Animations
    func dismiss() {
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
    }

    private func swipeUpPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector (handleGesture))
        addGestureRecognizer(gesture)
    }

    @objc private func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)

        switch gesture.state {
        case .changed:
            if translation.y < 0 {
                frame.origin.y = (Layout.height * 0.13 * 1.65) + translation.y
                alpha = (frame.size.height * 0.03) / (translation.y * -1)
            }
        case .ended:
            if translation.y < -(frame.size.height / 5) {
                dismiss()
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.frame.origin.y = (Layout.height * 0.13 * 1.65)
                    self.alpha = 1
                }
            }
        default: break
        }
    }
}


//    private func subscriptions() {
//        // External Subscriptions
//        store.addressSuggestions.asObservable()
//            .subscribe(onNext: { results in
//                self.didShow = true
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

//    private func hideSearchResults() {
//        let newHeight = CGFloat(0)
//        frame.size.height = newHeight
//        searchResults?.frame.size.height = newHeight
//    }

extension ReSearchResults: UITableViewDataSource, UITableViewDelegate {
    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDataSource = dataSource[indexPath.row]

        guard let cell: AddressCell = renderNib() else { return UITableViewCell() }
        cell.mainAddress.text = cellDataSource.title
        cell.subAddress.text = cellDataSource.subtitle
        return cell
    }
}

