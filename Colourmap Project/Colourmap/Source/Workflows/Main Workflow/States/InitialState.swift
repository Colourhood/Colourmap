import Simplerhood
import RxSwift
import MapKit

extension MainContext {
    final class InitialState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var shouldCenterOnUserLocation = true
        private var disposeBag = DisposeBag()

        // MARK: Services
        private var stateManager: StateManager?
        private var location: LocationService?
        private var geocoder: CLGeocoder?

        // MARK: ReComponents
        private var destination: ReDestination?
        private var map: ReMap?

        // MARK: Open Methods
        override func bindContext() {
            mainContext = super.context as? MainContext

            location = mainContext?.provider?.location
            stateManager = mainContext?.provider?.stateManager
            geocoder = mainContext?.provider?.geocoder

            destination = mainContext?.controller?.destination
            map = mainContext?.controller?.map
        }

        override func stateEntry() {
            focusOnUserLocation()
            animateDestinationPopFromBottom()
            subscribeToComponentEvents()
        }
        
        // MARK: Component Subscriptions
        private func subscribeToComponentEvents() {
            destination?.events
                .subscribe(onNext: { [unowned self] event in
                    switch event {
                    case .press:
                        self.changeStateToActiveSearch()
                    default: break
                    }
                }).disposed(by: disposeBag)

            map?.events
                .subscribe(onNext: { [unowned self] event in
                    switch event {
                    case .onDragStopped(let centerCoordinate):
                        self.fetchCenterLocationAddress(coordinate: centerCoordinate)
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        // MARK: Component Methods
        private func animateDestinationPopFromBottom() {
            destination?.popFromBottom()
        }

        // MARK: Private Methods
        private func fetchCenterLocationAddress(coordinate: CLLocationCoordinate2D) {
            geocoder?.reverseGeolocationCoordinate2D(coordinate: coordinate) { [unowned self] placemark in
                self.destination?.changeDestinationAddress(address: placemark?.name)
            }
        }

        private func focusOnUserLocation() {
            location?.initialUserLocation = { [weak self] userLocation in
                guard let `self` = self else { return }

                if self.shouldCenterOnUserLocation {
                    self.map?.centerOnUserLocation(location: userLocation)
                    self.shouldCenterOnUserLocation = false
                }
            }
        }

        // MARK: State Changes
        private func changeStateToActiveSearch() {
            stateManager?.changeState(ActiveTextInputSearchState(context: context))
        }
    }
}
