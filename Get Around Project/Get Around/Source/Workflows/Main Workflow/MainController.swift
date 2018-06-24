import Simplerhood
import UIKit

final class MainController: UIViewController {
    // MARK: ReComponents
    let map = ReMap()
    let searchResults = ReSearchResults()
    let destination = ReDestination()
    let pin = RePin()
    let blimp = ReBlimp()

    // MARK: Service Provider
    private let provider = ServiceProvider()

    // MARK: Context
    private(set) var mainContext = MainContext()

    // MARK: Superclass Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        map.bindController(self)
        searchResults.bindController(self)
        destination.bindController(self)
        pin.bindController(self)
        blimp.bindController(self)

        mainContext.bindController(self, provider)
    }
}
