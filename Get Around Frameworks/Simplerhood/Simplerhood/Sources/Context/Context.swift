import UIKit

public protocol Context {
    func bindController(_ controller: UIViewController, _ provider: ServiceProvider)
}
