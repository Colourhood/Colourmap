import UIKit
import MapKit

class MapView: UIViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    var componentSubview: ComponentManager!
    var pinSubview: ComponentManager!
    var locationService = LocationService()

    override func viewDidLoad() {
        componentSubview = ComponentManager(controller: self)
        pinSubview = ComponentManager(controller: self)
        map.dragToDismiss(controller: self)
        super.viewDidLoad()

        componentSubview.renderCallOutThenDestination { [weak self] in
            self?.pinSubview.renderPin()
        }
    }
}
