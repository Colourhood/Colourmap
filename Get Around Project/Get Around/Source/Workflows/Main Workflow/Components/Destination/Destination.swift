import UIKit.UIView
import Simplerhood
import RxSwift

final class Destination: UIView, RoundedEdges, Shadows {
    // MARK: IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!

    // MARK: Class Properties
    let buttonEmitter = PublishSubject<Void>()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundEdges(0.03)
        customizeTextField()
    }

    private func customizeTextField() {
        destinationTextfield.autocorrectionType = .no
        destinationTextfield.autocapitalizationType = .none
    }

    @IBAction private func panelWasPressed() {
        buttonEmitter.onNext(())
    }
}
