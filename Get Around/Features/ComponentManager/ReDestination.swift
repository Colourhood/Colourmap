import UIKit
import RxSwift
import RxCocoa

final class ReDestination: ComponentManager {
    var destinationView: Destination?

    // MARK: Initialization
    override init(controller: UIViewController, store: DataStore, service: ServiceProvider) {
        super.init(controller: controller, store: store, service: service)
        initialFrame()
        renderDestination()
        subscriptions()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Notification Center Observer
    private func subscriptions() {
        // External Subscriptions
        store.destinationPress.subscribe(onNext: { [weak self] in
            self?.animateToTop()
        }).disposed(by: disposeBag)

        store.mapDragged.subscribe(onNext: { [weak self] in
            self?.checkTextField()
        }).disposed(by: disposeBag)

        store.destinationPanelAnimateTop.subscribe(onNext: { [weak self] in
            self?.showKeyboard()
        }).disposed(by: disposeBag)

        // Internal Subscriptions
        destinationView?.destinationTextfield.rx.controlEvent(.editingChanged)
            .debounce(0.2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.destinationDidChange()
            }).disposed(by: disposeBag)

        destinationView?.destinationTextfield.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { _ in
                self.store.searchResultsPressed.onNext(())
            }).disposed(by: disposeBag)
    }

    private func destinationDidChange() {
        guard let address =  destinationView?.destinationTextfield.text else { return }

        if address.isEmpty {
            store.searchResultsDismiss.onNext(())
        } else {
            service.search.searchAddress(address)
        }
    }

    @objc func showKeyboard() {
        destinationView?.destinationTextfield.becomeFirstResponder()
    }

    // MARK: Animations
    func animateIntroduction() {
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseInOut, animations: {
            self.frame.origin.y = Layout.height - self.frame.height
        })
    }

    func animateToTop() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame.size.width = Layout.width * 0.90
            self.frame.origin.y = Layout.height * 0.08
            self.destinationView?.layer.cornerRadius = self.frame.size.width * 0.025
            self.center.x = Position.centerX
        }, completion: { _ in
            self.store.destinationPanelAnimateTop.onNext(())
        })
    }

    func animateToBottom() {
        destinationView?.destinationPanelButton.isHidden = false
        UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseInOut, animations: {
            self.frame.origin.y = (Layout.height - self.frame.height)
            self.frame.size.width = Layout.width
            self.center.x = Position.centerX
        })
    }

    // MARK: Private Methods
    private func checkTextField() {
        guard let text = destinationView?.destinationTextfield.text else { return }
        store.selectedLocation.value = text

        if text.isEmpty {
            animateToBottom()
        }
    }

    // MARK: Private Component Rendering
    private func renderDestination() {
        guard let view: Destination = renderNib() else { return }
        view.frame = bounds
        destinationView = view
        destinationView?.store = store
        addSubview(view)
    }

    // MARK: Private Superview Framing
    private func initialFrame() {
        let newSize = CGSize(width: Layout.width, height: Layout.height * 0.13)
        let newOrigin = CGPoint(x: 0, y: Layout.height)
        frame = CGRect(origin: newOrigin, size: newSize)
        center.x = Position.centerX
    }
}
