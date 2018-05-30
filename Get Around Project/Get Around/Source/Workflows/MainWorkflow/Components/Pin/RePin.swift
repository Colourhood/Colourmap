import UIKit
import RxSwift
import Simplerhood

enum PinEvents {
    case isHidden(val: Bool)
}

final class RePin: ComponentManager {
    // MARK: Class properties
    let events = PublishSubject<PinEvents>()
    let disposeBag = DisposeBag()

    override func childViewEvents() {
        events.subscribe(onNext: { [weak self] event in
            switch event {
            case .isHidden(let value):
                self?.isHidden = value
            }
        }).disposed(by: disposeBag)
    }

    // MARK: Component Render
    internal override func renderComponent() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame = bounds
        addSubview(pin)
    }

    // MARK: Superview Framing
    internal override func initialFrame() {
        frame.size = CGSize(width: Layout.width * 0.08, height: Layout.width * 0.08)
        center = CGPoint(x: (Position.centerX), y: (Position.centerY * 0.97))
    }
}

