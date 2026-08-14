//
//  MapsNavigationService.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import MapKit

enum MapsNavigationService {
    static func openDirections(to locationName: String, coordinate: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
