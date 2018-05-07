import UIKit
import RxSwift
import RxCocoa

final class ReDestination: ComponentManager {
    private var destinationView: Destination?

    override init(context: Context) {
        super.init(context: context)
        initialFrame()
        renderComponent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialFrame()
        renderComponent()
    }

//    // MARK: Notification Center Observer
//    private func subscriptions() {
//        // External Subscriptions
//        store.dsDestination.event.subscribe(onNext: { [weak self] event in
//            switch event {
//            case .press:
//                self?.animateToTop()
//                self?.store.dsPin.event.onNext(.isHidden(val: false))
//            }
//        }).disposed(by: disposeBag)
//
//        store.dsMap.event.subscribe(onNext: { [weak self] event in
//            switch event {
//            case .onDrag:
//                self?.checkTextField()
//            default: break
//            }
//        }).disposed(by: disposeBag)
//
////        store.destinationPanelAnimateTop.subscribe(onNext: { [weak self] in
////            self?.showKeyboard()
////        }).disposed(by: disposeBag)
//
//        store.selectedLocation.asObservable()
//            .subscribe(onNext: { address in
//                self.destinationView?.destinationTextfield.text = address
//            }).disposed(by: disposeBag)
//
//        // Internal Subscriptions
//        destinationView?.destinationTextfield.rx.controlEvent(.editingDidBegin)
//            .subscribe(onNext: { [weak self] _ in
//                self?.store.dsPin.event.onNext(.isHidden(val: false))
//            }).disposed(by: disposeBag)
//
//        destinationView?.destinationTextfield.rx.controlEvent(.editingChanged)
//            .debounce(0.2, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                self?.destinationDidChange()
//            }).disposed(by: disposeBag)
//
//        destinationView?.destinationTextfield.rx.controlEvent(.editingDidEndOnExit)
//            .subscribe(onNext: { [weak self] _ in
//                self?.store.dsSearchResults.event.onNext(.press)
//                self?.store.dsPin.event.onNext(.isHidden(val: true))
//            }).disposed(by: disposeBag)
//    }
//
//    private func destinationDidChange() {
//        guard let address =  destinationView?.destinationTextfield.text else { return }
//
//        if address.isEmpty {
//            store.dsSearchResults.event.onNext(.press)
//        } else {
//            service.search.searchAddress(address)
//        }
//    }
//
//    private func showKeyboard() {
//        destinationView?.destinationTextfield.becomeFirstResponder()
//    }

    // MARK: Animations
    public func popFromBottom() {
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseInOut, animations: {
            self.frame.origin.y = Layout.height - self.frame.height
        })
    }

    private func animateToTop() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame.size.width = Layout.width * 0.90
            self.frame.origin.y = Layout.height * 0.08
            self.destinationView?.layer.cornerRadius = self.frame.size.width * 0.025
            self.center.x = Position.centerX
        }, completion: { _ in
//            self.showKeyboard()
        })
    }

    private func animateToBottom() {
        destinationView?.destinationPanelButton.isHidden = false
        UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseInOut, animations: {
            self.frame.origin.y = (Layout.height - self.frame.height)
            self.frame.size.width = Layout.width
            self.center.x = Position.centerX
        })
    }

//    // MARK: Private Methods
//    private func checkTextField() {
//        guard let text = destinationView?.destinationTextfield.text else { return }
//        store.selectedLocation.value = text
//
//        if text.isEmpty {
//            animateToBottom()
//        }
//    }

    // MARK: Private Component Rendering
    internal override func renderComponent() {
        guard let view: Destination = renderNib() else { return }
        view.frame = bounds
        destinationView = view
        destinationView?.store = context.store
        addSubview(view)
    }

    // MARK: Private Superview Framing
    internal override func initialFrame() {
        let newSize = CGSize(width: Layout.width, height: Layout.height * 0.13)
        let newOrigin = CGPoint(x: 0, y: Layout.height)
        frame = CGRect(origin: newOrigin, size: newSize)
        center.x = Position.centerX
    }
}
