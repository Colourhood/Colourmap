import Simplerhood
import RxCocoa
import RxSwift
import UIKit

enum DestinationEvents {
    case press
    case textfieldUpdated(destination: String)
}

final class ReDestination: ComponentManager {
    private var destinationView: Destination?
    private var disposeBag = DisposeBag()
    let events = PublishSubject<DestinationEvents>()

    internal override func childViewEvents() {
        destinationView?.buttonEmitter.subscribe(onNext: { [unowned self] _ in
            self.events.onNext(.press)
        }).disposed(by: disposeBag)

        destinationView?.destinationTextfield.rx.controlEvent(.editingChanged)
            .debounce(0.2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                guard let destinationText = self.destinationView?.destinationTextfield.text else { return }


                self.events.onNext(.textfieldUpdated(destination: destinationText))
            }).disposed(by: disposeBag)
    }

    // MARK: Private Component Rendering
    internal override func renderComponent() {
        guard let view: Destination = renderNib() else { return }
        view.frame = bounds
        destinationView = view
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

extension ReDestination {
    // MARK: Component Changes
    func changeDestinationAddress(address: String?) {
        destinationView?.destinationTextfield.text = address
    }

    func showKeyboard() {
        destinationView?.destinationTextfield.becomeFirstResponder()
    }

    func clearTextfield() {
        destinationView?.destinationTextfield.text = ""
    }

    func textfieldPlaceholder(text: String?) {
        destinationView?.destinationTextfield.text = text
    }
}

extension ReDestination {
    // MARK: Animations
    func popFromBottom() {
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
}
