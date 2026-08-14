//
//  APIEndpoint.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation

// Stores API endpoints.
enum APIEndpoint: Sendable {
    case events

    var url: URL? {
        switch self {
        case .events:
            return URL(string: "\(Constants.API.baseURL)/events")
        }
    }
}
