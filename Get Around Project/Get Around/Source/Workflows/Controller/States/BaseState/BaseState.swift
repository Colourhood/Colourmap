import Foundation
import RxSwift

extension StateManager {
    class BaseState: State {
        private(set) var context: Context
        private(set) var disposeBag = DisposeBag()

        init(context: Context) {
            self.context = context
            bindContext()
            stateEntry()
        }

        deinit {
            stateExit()
        }

        open func bindContext() {}
        open func stateEntry() {}
        open func stateExit() {}
    }
}
