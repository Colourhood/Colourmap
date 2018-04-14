import UIKit

class MapView: UIViewController {
    let componentSubview = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(componentSubview)
        renderCallOut()
    }
}

extension MapView {

    private func renderCallOut() {
        componentSubview.frame.size = CGSize(width: view.frame.width * 0.7,
                                             height: view.frame.height * 0.07)
        componentSubview.center.y = Positions.centerY
        componentSubview.center.x = Positions.centerX
        componentSubview.alpha = 0

        guard let callOut: CallOut = renderNib() else { return }
        callOut.frame = componentSubview.bounds
        componentSubview.addSubview(callOut)

        UIView.animate(withDuration: 1.5, delay: 1, animations: {
            self.componentSubview.alpha = 1
        }, completion: { _ in
            self.removeCallOut()
            self.renderDestination()
        })
    }

    private func removeCallOut() {
        guard let callout: CallOut = componentSubview.subviews.first as? CallOut else { return }
        callout.removeFromSuperview()
    }

    private func renderDestination() {
        guard let destination: Destination = renderNib() else { return }
        destination.frame = componentSubview.bounds
        componentSubview.addSubview(destination)

        UIView.animate(withDuration: 1.3, animations: {
            self.componentSubview.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                                      height: self.view.frame.height * 0.13)
            self.componentSubview.frame.origin = CGPoint(x: 0, y: 20)
        }, completion: { _ in
            self.renderPin()
        })
    }

    private func renderPin() {
        guard let pin: Pin = renderNib() else { return }
        pin.frame = CGRect(x: Positions.centerX - 20,
                           y: Positions.centerY - 20,
                           width: view.bounds.width / 10,
                           height: view.bounds.width / 10)

        view.addSubview(pin)
    }
}

