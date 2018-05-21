import RxSwift

extension StateManager {
    final class InitialState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var mainController: MainController?

        // MARK: Parent Methods
        override func bindContext() {
            mainContext = super.context as? MainContext
            mainController = super.context.controller as? MainController
        }

        override func stateEntry() {
            animateDestinationPopFromBottom()
            subscribeToComponentEvents()
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
            mainContext?.stateManager?.changeState(ActiveSearchState(context: super.context))
        }
    }
}
