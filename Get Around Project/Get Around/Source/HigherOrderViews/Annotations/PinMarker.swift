import MapKit

final class PinMarker: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)


        let pinView = UIImageView(image: #imageLiteral(resourceName: "pin"))
        pinView.frame.size = CGSize(width: Layout.width * 0.08, height: Layout.width * 0.08)
        addSubview(pinView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
