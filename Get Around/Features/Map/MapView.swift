import UIKit
import MapKit

class MapView: DismissableKeyboardViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    let componentSubview = ComponentManager()
    var locationService = LocationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        onDragMap()
        view.addSubview(componentSubview)
        componentSubview.renderCallOut()
    }
}

extension MapView {

    func onDragMap() {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector (dismissKeyboard))
        dragGesture.delegate = self
        map.addGestureRecognizer(dragGesture)
    }
}
