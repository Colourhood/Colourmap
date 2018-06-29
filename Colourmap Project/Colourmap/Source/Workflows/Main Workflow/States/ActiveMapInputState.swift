import Simplerhood
import RxSwift
import MapKit

extension MainContext {
    final class ActiveMapInputSearchState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var disposeBag = DisposeBag()

        // MARK: Services
        private var stateManager: StateManager?
        private var geocoder: CLGeocoder?

        // MARK: ReComponents
        private var destination: ReDestination?
        private var map: ReMap?
        private var pin: RePin?

        // MARK: Open Methods
        override func bindContext() {
            mainContext = super.context as? MainContext

            stateManager = mainContext?.provider?.stateManager
            geocoder = mainContext?.provider?.geocoder

            destination = mainContext?.controller?.destination
            map = mainContext?.controller?.map
            pin = mainContext?.controller?.pin
        }

        override func stateEntry() {
            pin?.show()
            subscribeToComponentEvents()
        }

        // MARK: Component Subscriptions
        private func subscribeToComponentEvents() {
            destination?.events
                .subscribe(onNext: { [unowned self] events in
                    switch events {
                    case .press:
                        self.changeStateToActiveTextInputState()
                    default: break
                    }
            }).disposed(by: disposeBag)

            map?.events
                .subscribe(onNext: { [unowned self] events in
                    switch events {
                    case .onDragStopped(let centerCoordinate):
                        self.fetchCenterLocationAddress(coordinate: centerCoordinate)
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        // MARK: Private Methods
        private func fetchCenterLocationAddress(coordinate: CLLocationCoordinate2D) {
            geocoder?.reverseGeolocationCoordinate2D(coordinate: coordinate) { [unowned self] placemark in
                self.destination?.changeDestinationAddress(address: placemark?.name)
            }
        }

        // MARK: State Changes
        private func changeStateToActiveTextInputState() {
            stateManager?.changeState(ActiveTextInputSearchState(context: context))
        }
    }
}
