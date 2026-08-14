//
//  GeocodingHelper.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import CoreLocation

enum GeocodingHelper {
    static func coordinate(for locationName: String) async -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(locationName)
            return placemarks.first?.location?.coordinate
        } catch {
            return nil
        }
    }
}
