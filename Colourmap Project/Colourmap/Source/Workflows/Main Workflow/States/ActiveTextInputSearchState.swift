import Simplerhood
import RxSwift
import MapKit

extension MainContext {
    final class ActiveTextInputSearchState: BaseState {
        // MARK: Class Properties
        private var mainContext: MainContext?
        private var isDestinationInputEmpty = true
        private var disposeBag = DisposeBag()

        // MARK: Services
        private var stateManager: StateManager?
        private var geocoder: CLGeocoder?
        private var search: SearchService?

        // MARK: ReComponents
        private var destination: ReDestination?
        private var searchResults: ReSearchResults?
        private var map: ReMap?
        private var pin: RePin?

        // MARK: Open Methods
        override func bindContext() {
            mainContext = super.context as? MainContext

            stateManager = mainContext?.provider?.stateManager
            geocoder = mainContext?.provider?.geocoder
            search = mainContext?.provider?.search

            destination = mainContext?.controller?.destination
            searchResults = mainContext?.controller?.searchResults
            map = mainContext?.controller?.map
            pin = mainContext?.controller?.pin
        }

        override func stateEntry() {
            destination?.clearTextfield()
            destination?.animateToTop()
            destination?.showKeyboard()
            pin?.hide()

            subscribeToComponentEvents()
        }

        // MARK: Component Events
        private func subscribeToComponentEvents() {
            destination?.events
                .subscribe(onNext: { [unowned self] events in
                    switch events {
                    case .textfieldUpdated(let destinationInput):
                        self.handleDestinationInput(destination: destinationInput)
                    case .press:
                        self.destination?.showKeyboard()
                    }
                }).disposed(by: disposeBag)

            searchResults?.events
                .subscribe(onNext: { [unowned self] events in
                    switch events {
                    case .press(let destinationAddress):
                        self.handleSearchResultPress(destinationAddress: destinationAddress)
                    default: break
                    }
                }).disposed(by: disposeBag)

            map?.events
                .subscribe(onNext: { [unowned self] events in
                    switch events {
                    case .onDrag:
                        self.mainContext?.controller?.dismissKeyboard()
                        self.handleMapDrag()
                    default: break
                    }
                }).disposed(by: disposeBag)
        }

        // MARK: Component Methods
        private func updateSearchResults(data: [MKLocalSearchCompletion]) {
            searchResults?.updateSearchResults(data)
        }

        // MARK: Private Methods
        private func searchAddress(destination: String) {
            search?.searchAddress(destination) { [weak self] destinationSuggestions in
                guard let `self` = self else { return }
                self.updateSearchResults(data: destinationSuggestions)
            }
        }

        private func handleDestinationInput(destination: String) {
            if destination.isEmpty {
                isDestinationInputEmpty = true
                searchResults?.dismiss()
            } else {
                isDestinationInputEmpty = false
                searchAddress(destination: destination)
            }
        }

        private func handleSearchResultPress(destinationAddress: String) {
            geocoder?.geocodeAddressString(destinationAddress) { [unowned self] place, error in
                if let location = place?.first?.location {
                    self.changeStateToZoomedOutDestinationState(destination: location)
                }
                if let error = error {
                    print("There was an error \(error)")
                }
            }
        }

        private func handleMapDrag() {
            if isDestinationInputEmpty {
                changeStateToActiveMapInputState()
            }
        }

        // MARK: State Changes
        private func changeStateToActiveMapInputState() {
            stateManager?.changeState(ActiveMapInputSearchState(context: context))
        }

        private func changeStateToZoomedOutDestinationState(destination: CLLocation) {
            stateManager?.changeState(ZoomedOutDestinationState(context: context, destination: destination))
        }
    }
}
