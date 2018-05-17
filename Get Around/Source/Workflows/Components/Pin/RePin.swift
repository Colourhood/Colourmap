import UIKit

final class RePin: ComponentManager {

    override init(context: Context) {
        super.init(context: context)
        initialFrame()
        renderComponent()
        listenForEvents()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func listenForEvents() {
        guard let mainContext = context as? MainContext else { return }

        mainContext.store.dsPin.event
            .subscribe(onNext: { [weak self] event in
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

