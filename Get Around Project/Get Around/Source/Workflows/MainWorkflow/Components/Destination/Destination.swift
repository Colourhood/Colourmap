import Simplerhood
import RxSwift
import UIKit

final class Destination: UIView, RoundedEdges {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var destinationPanelButton: UIButton!

    private(set) var buttonEmitter = PublishSubject<Void>()

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
