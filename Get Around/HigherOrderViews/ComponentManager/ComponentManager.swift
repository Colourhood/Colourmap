import RxSwift
import UIKit

protocol ComponentRender {
    func renderComponent()
    func initialFrame()
}

class ComponentManager: UIView, ComponentRender {
    public let context: Context
    public let disposeBag = DisposeBag()

    // MARK: Initialization
    init(context: Context) {
        self.context = context
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        context.controller?.view.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        self.context = EmptyContext()
        super.init(coder: aDecoder)
    }

    open func renderComponent() {}

    open func initialFrame() {}
}
