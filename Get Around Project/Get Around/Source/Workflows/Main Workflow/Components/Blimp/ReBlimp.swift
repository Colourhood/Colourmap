import Simplerhood
import RxSwift

enum BlimpEvents {
    case press
}

final class ReBlimp: ComponentManager, Shadows {
    private var blimpView: Blimp?
    private var disposeBag = DisposeBag()
    let events = PublishSubject<BlimpEvents>()

    override func childViewEvents() {
        blimpView?.buttonEmitter.subscribe(onNext: { [unowned self] in
            self.events.onNext(.press)
        }).disposed(by: disposeBag)
    }

    // MARK: Private Component Rendering
    override func renderComponent() {
        guard let view: Blimp = renderNib() else { return }
        view.frame = bounds
        blimpView = view
        addSubview(view)
    }

    // MARK: Private Superview Framing
    override func initialFrame() {
        let newSize = CGSize(width: 2, height: Layout.height)
        let newOrigin = CGPoint(x: 0, y: 0)
        frame = CGRect(origin: newOrigin, size: newSize)
        addshadow(right: true)
    }
}
