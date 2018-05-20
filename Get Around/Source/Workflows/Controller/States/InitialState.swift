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
            subscribeToEvents()
        }

        private func subscribeToEvents() {
            mainContext?.mainController?.controllerRendered = { [weak self] _ in
                print("Did call event")
                self?.mainContext?.mainController?.destination.popFromBottom()
            }

//            mainContext?.mainController?.destination.events
//                .subscribe(onNext: { [unowned self] event in
//                    switch event {
//                    case .press:
//                        self.changeStateToActiveSearch()
//                    }
//                }).disposed(by: disposeBag)
//
//            mainContext?.mainController?.map.events
//                .subscribe(onNext: { event in
//                    switch event {
//                    case .onDrag: break
//                    default: break
//                    }
//                }).disposed(by: disposeBag)
        }

        private func changeStateToActiveSearch() {
            mainContext?.stateManager?.changeState(ActiveSearchState(context: super.context))
        }
    }
}
