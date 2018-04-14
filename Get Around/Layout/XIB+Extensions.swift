import UIKit

func renderNib<T: UIView>() -> T? {
    let component = UINib(nibName: String(describing: T.self), bundle: nil)
                    .instantiate(withOwner: nil, options: nil).first as? T

    return component
}
