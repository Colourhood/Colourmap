import Simplerhood

extension MainContext {
    final class ActiveSearchState: BaseState {
        private var mainContext: MainContext?

        override func bindContext() {
            mainContext = super.context as? MainContext
        }
    }
}
