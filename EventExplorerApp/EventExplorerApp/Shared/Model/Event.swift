//
//  Event.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation

// Represents an event.
struct Event: Codable, Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let location: String
    let time: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case time
        case imageUrl
    }

    var eventDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]

        return formatter.date(from: time)
    }
}
