import UIKit
import MapKit

final class MapView: UIViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    var destinationSubview: ReDestination!
    var pinSubview: RePin!

    override func viewDidLoad() {
        destinationSubview = ReDestination(controller: self)
        pinSubview = RePin(controller: self)
        map.dragToDismiss(controller: self)
        destinationSubview.animateIntroduction {
        }
    }
}
