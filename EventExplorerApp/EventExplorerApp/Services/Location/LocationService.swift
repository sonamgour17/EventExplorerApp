//
//  LocationService.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import CoreLocation
import Combine

protocol LocationServiceProtocol: AnyObject {
    var userLocation: CLLocation? { get }
    var userLocationPublisher: AnyPublisher<CLLocation?, Never> { get }
    func requestPermission()
    func fetchLocation()
}

@MainActor
final class LocationService: NSObject, ObservableObject, LocationServiceProtocol, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published private(set) var userLocation: CLLocation?

    var userLocationPublisher: AnyPublisher<CLLocation?, Never> {
        $userLocation.eraseToAnyPublisher()
    }

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    func fetchLocation() {
        manager.requestLocation()
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            userLocation = locations.first
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
