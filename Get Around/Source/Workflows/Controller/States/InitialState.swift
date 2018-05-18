import RxSwift

extension StateManager {
    final class InitialState: State {
        // MARK: Class Properties
        private var context: MainContext
        private var controller: MainController?
        private var disposeBag = DisposeBag()

        init(context: MainContext) {
            self.context = context
            self.controller = context.controller as? MainController
            subscribeToReComponents()
        }

        private func subscribeToReComponents() {
            guard let controller = context.controller as? MainController else { return }

            context.store.viewDidLoad
                .subscribe(onNext: { _ in
                    controller.destination.popFromBottom()
                }).disposed(by: disposeBag)
        }

        private func subscribeToEvents() {
            controller?.destination.events
                .subscribe(onNext: { [unowned self] event in
                    switch event {
                    case .press:
                        self.changeStateToActiveSearch()
                    }
                }).disposed(by: disposeBag)

            controller?.map.events
                .subscribe(onNext: { event in
                    switch event {
                    case .onDrag: break
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        private func changeStateToActiveSearch() {
            context.stateManager?.changeState(ActiveSearchState(context: context))
        }
    }
}
