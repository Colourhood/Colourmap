import UIKit
import MapKit

class MapView: DismissableKeyboardViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    let componentSubview = ComponentManager()
    let pinSubview = ComponentManager()
    var locationService = LocationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        onDragMap()
        view.addSubview(componentSubview)
        view.addSubview(pinSubview)

        componentSubview.renderCallOutThenDestination {
            self.pinSubview.pin()
        }
    }
}

extension MapView {

    func onDragMap() {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector (dismissKeyboard))
        dragGesture.delegate = self
        map.addGestureRecognizer(dragGesture)
    }
}
