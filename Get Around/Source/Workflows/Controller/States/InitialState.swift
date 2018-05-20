import RxSwift

extension StateManager {
    final class InitialState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?

        // MARK: Parent Methods
        override func bindContext() {
            mainContext = super.context as? MainContext
        }

        override func stateEntry() {
            animateDestinationPopFromBottom()
            subscribeToComponentEvents()
        }

        // MARK: Private Methods
        private func subscribeToComponentEvents() {
            mainContext?.mainController?.destination.events
                .subscribe(onNext: { [unowned self] event in
                    switch event {
                    case .press:
                        self.changeStateToActiveSearch()
                    }
                }).disposed(by: disposeBag)

            mainContext?.mainController?.map.events
                .subscribe(onNext: { event in
                    switch event {
                    case .onDrag: break
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        private func animateDestinationPopFromBottom() {
            mainContext?.mainController?.destination.popFromBottom()
        }

        // MARK: State Changes
        private func changeStateToActiveSearch() {
            mainContext?.stateManager?.changeState(ActiveSearchState(context: super.context))
        }
    }
}
