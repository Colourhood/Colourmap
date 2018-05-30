import Simplerhood
import RxSwift

extension MainContext {
    final class InitialState: BaseState {
        // MARK: Class Properties
        private var mainController: MainController?
        private var mainContext: MainContext?
        private var stateManager: StateManager?
        private var disposeBag = DisposeBag()

        // MARK: Parent Methods
        override func bindContext() {
            mainContext = super.context as? MainContext
            mainController = mainContext?.controller
            stateManager = mainContext?.provider?.stateManager
        }

        override func stateEntry() {
            animateDestinationPopFromBottom()
            subscribeToComponentEvents()
        }

        override func stateExit() {
        }

        // MARK: Private Methods
        private func subscribeToComponentEvents() {
            mainController?.destination.events
                .subscribe(onNext: { [unowned self] event in
                    switch event {
                    case .press:
                        self.changeStateToActiveSearch()
                    }
                }).disposed(by: disposeBag)

            mainController?.map.events
                .subscribe(onNext: { event in
                    switch event {
                    case .onDrag: break
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        private func animateDestinationPopFromBottom() {
            mainController?.destination.popFromBottom()
        }

        // MARK: State Changes
        private func changeStateToActiveSearch() {
            guard let mainCon = mainContext else { return }
            stateManager?.changeState(ActiveSearchState(context: mainCon))
        }
    }
}
