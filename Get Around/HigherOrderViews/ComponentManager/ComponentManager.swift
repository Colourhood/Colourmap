import RxSwift
import UIKit

@objc protocol ComponentRender {
    func renderComponent()
    func initialFrame()
    @objc optional func childViewEvents()
}

class ComponentManager: UIView, ComponentRender {
    public let disposeBag = DisposeBag()

    // MARK: Initialization
    init(controller: UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controller.view.addSubview(self)

        initialFrame()
        renderComponent()
        childViewEvents()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Procotol Definitions
    open func initialFrame() {}
    open func renderComponent() {}
    open func childViewEvents() {}
}
