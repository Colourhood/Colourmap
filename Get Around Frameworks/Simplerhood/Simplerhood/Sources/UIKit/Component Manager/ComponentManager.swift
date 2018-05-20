import UIKit

@objc public protocol ComponentRender {
    func renderComponent()
    func initialFrame()
    @objc optional func childViewEvents()
}

open class ComponentManager: UIView, ComponentRender {
    // MARK: Initialization
    public init(controller: UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controller.view.addSubview(self)

        initialFrame()
        renderComponent()
        childViewEvents()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Internal Methods
    public func renderNib<T: UIView>() -> T? {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        let component = nib.instantiate(withOwner: nil, options: nil).first as? T
        return component
    }

    // MARK: Procotol Definitions
    open func initialFrame() {}
    open func renderComponent() {}
    open func childViewEvents() {}
}
