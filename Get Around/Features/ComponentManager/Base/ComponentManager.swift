import UIKit

class ComponentManager: UIView {
    // MARK: Initialization
    init(controller: UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controller.view.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
