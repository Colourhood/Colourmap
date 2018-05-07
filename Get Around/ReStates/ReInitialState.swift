import RxSwift

extension StateManager {
    class ReInitialState: State {
        private var context: MainContext
        private var disposeBag = DisposeBag()

        init(context: MainContext) {
            self.context = context
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
            context.store.dsDestination.event
                .subscribe(onNext: { [unowned self] event in
                    switch event {
                    case .press:
                        self.changeStateToActiveSearch()
                    }
                }).disposed(by: disposeBag)

            context.store.dsMap.event
                .subscribe(onNext: { event in
                    switch event {
                    case .onDrag: break
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        private func changeStateToActiveSearch() {
            context.stateManager?.changeState(ReActiveSearchState(context: context))
        }
    }
}
