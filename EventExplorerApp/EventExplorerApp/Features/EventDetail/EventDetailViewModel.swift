//
//  EventDetailViewModel.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import CoreLocation
import MapKit
import Combine

@MainActor
final class EventDetailViewModel: ObservableObject {
    @Published private(set) var event: Event?
    @Published private(set) var isLoading = false
    @Published private(set) var isBookmarked = false
    @Published private(set) var distanceText: String?

    private let eventID: String
    private let cacheService: CacheServiceProtocol
    private let coreDataService: CoreDataServiceProtocol
    private let locationService: LocationServiceProtocol

    private var eventCoordinate: CLLocationCoordinate2D?
    private var cancellables = Set<AnyCancellable>()

    init(eventID: String,
         cacheService: CacheServiceProtocol,
         coreDataService: CoreDataServiceProtocol,
         locationService: LocationServiceProtocol) {
        self.eventID = eventID
        self.cacheService = cacheService
        self.coreDataService = coreDataService
        self.locationService = locationService

        locationService.userLocationPublisher
            .sink { [weak self] location in
                self?.updateDistance(from: location)
            }
            .store(in: &cancellables)
    }

    func loadEvent() async {
        isLoading = true

        if let cached = await cacheService.fetch()?.first(where: { $0.id == eventID }) {
            event = cached
        } else {
            event = coreDataService.fetchLastFetchedEvents().first { $0.id == eventID }
        }

        isBookmarked = coreDataService.isBookmarked(eventID: eventID)
        isLoading = false

        if let event {
            eventCoordinate = await GeocodingHelper.coordinate(for: event.location)
        }

        locationService.requestPermission()
        locationService.fetchLocation()
    }

    private func updateDistance(from userLocation: CLLocation?) {
        guard let userLocation, let eventCoordinate else { return }
        let eventLocation = CLLocation(latitude: eventCoordinate.latitude, longitude: eventCoordinate.longitude)
        let distanceInMeters = userLocation.distance(from: eventLocation)
        distanceText = MKDistanceFormatter().string(fromDistance: distanceInMeters)
    }

    func toggleBookmark() {
        guard let event else { return }
        if isBookmarked {
            coreDataService.removeBookmark(eventID: event.id)
        } else {
            coreDataService.saveBookmark(event)
        }
        isBookmarked.toggle()
    }

    func openInMaps() {
        guard let event, let eventCoordinate else { return }
        MapsNavigationService.openDirections(to: event.location, coordinate: eventCoordinate)
    }
}

