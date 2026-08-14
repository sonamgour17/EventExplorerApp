//
//  MockServices.swift
//  EventExplorerAppTests
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
@testable import EventExplorerApp

final class MockNetworkService: NetworkServiceProtocol {
    let events: [Event]
    var errorToThrow: Error?

    init(events: [Event] = [], errorToThrow: Error? = nil) {
        self.events = events
        self.errorToThrow = errorToThrow
    }

    func fetch<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        if let errorToThrow {
            throw errorToThrow
        }
        guard let result = events as? T else {
            throw APIError.decodingFailed
        }
        return result
    }
}


actor MockCacheService: CacheServiceProtocol {
    private var stored: [Event]?

    func save(_ events: [Event]) {
        stored = events
    }

    func fetch() -> [Event]? {
        stored
    }
}
