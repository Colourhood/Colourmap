import UIKit
import MapKit

final class MapView: UIViewController {
    // MARK: Views
    @IBOutlet weak var map: MKMapView!
    var searchResultsSubview: ReSearchResults!
    var destinationSubview: ReDestination!
    var pinSubview: RePin!

    override func viewDidLoad() {
        map.dragToDismiss(controller: self)
        pinSubview = RePin(controller: self)
        destinationSubview = ReDestination(controller: self)
        searchResultsSubview = ReSearchResults(controller: self)
        
        destinationSubview.animateIntroduction {
        }
    }
}
