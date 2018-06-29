import Simplerhood
import RxSwift
import MapKit

extension MainContext {
    final class ZoomedOutDestinationState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var destinationLocation: CLLocation
        private var disposeBag = DisposeBag()

        // MARK: Services
        private var stateManager: StateManager?
        private var location: LocationService?
        private var geocoder: CLGeocoder?

        // MARK: ReComponents
        private var destination: ReDestination?
        private var searchResults: ReSearchResults?
        private var map: ReMap?

        // MARK: Initialization
        init(context: Context, destination: CLLocation) {
            self.destinationLocation = destination
            super.init(context: context)
        }

        // MARK: Open Methods
        override func bindContext() {
            mainContext = super.context as? MainContext

            stateManager = mainContext?.provider?.stateManager
            location = mainContext?.provider?.location
            geocoder = mainContext?.provider?.geocoder

            destination = mainContext?.controller?.destination
            searchResults = mainContext?.controller?.searchResults
            map = mainContext?.controller?.map
        }

        override func stateEntry() {
            searchResults?.dismiss()
            zoomOutMapToDestination()
            subscribeToComponentEvents()
        }

        override func stateExit() {
            map?.resetAnnotations()
            map?.enableZooming()
            map?.enableScrolling()
        }

        // MARK: Component Subscriptions
        private func subscribeToComponentEvents() {
            destination?.events
                .subscribe(onNext: { [unowned self] events in
                    switch events {
                    case .press:
                        self.changeStateToActiveTextInputSearchState()
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        // MARK: Component Methods
        private func zoomOutMapToDestination() {
            guard let currentLocation = location?.currentLocation.coordinate else { return }
            map?.zoomOutToStartAndDestination(start: currentLocation, destination: destinationLocation.coordinate)
            map?.disableZooming()
            map?.disableScrolling()
        }

        // MARK: State Changes
        private func changeStateToActiveTextInputSearchState() {
            stateManager?.changeState(ActiveTextInputSearchState(context: context))
        }
    }
}
