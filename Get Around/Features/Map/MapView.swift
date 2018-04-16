import UIKit
import MapKit

final class MapView: UIViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    var searchResultsSubview: ReSearchResults!
    var destinationSubview: ReDestination!
    var pinSubview: RePin!

    override func viewDidLoad() {
        searchResultsSubview = ReSearchResults(controller: self)
        destinationSubview = ReDestination(controller: self)
        pinSubview = RePin(controller: self)

        map.dragToDismiss(controller: self)
        destinationSubview.animateIntroduction {
        }
    }
}
