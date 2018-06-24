import Simplerhood
import RxSwift
import UIKit

final class Blimp: UIView {
    // MARK: Class Properties
    let buttonEmitter = PublishSubject<Void>()

    // MARK: IBActions
    @IBAction func recenterUserLocation() {
        buttonEmitter.onNext(())
    }
}
