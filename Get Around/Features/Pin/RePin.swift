import UIKit

final class RePin: ComponentManager {

    override init(controller: UIViewController, store: DataStore, service: ServiceProvider) {
        super.init(controller: controller, store: store, service: service)
        initialFrame()
        renderPin()
        subscribe()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func subscribe() {
        store.dsPin.event.subscribe(onNext: { [weak self] event in
            switch event {
            case .isHidden(let value):
                self?.isHidden = value
            }
        }).disposed(by: disposeBag)
    }

    private func renderPin() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame = bounds
        addSubview(pin)
    }

    // MARK: Private Superview Framing
    private func initialFrame() {
        frame.size = CGSize(width: Layout.width * 0.08, height: Layout.width * 0.08)
        center = CGPoint(x: (Position.centerX), y: (Position.centerY * 0.97))
    }
}

