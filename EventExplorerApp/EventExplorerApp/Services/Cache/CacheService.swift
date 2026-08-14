//
//  CacheService.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation

protocol CacheServiceProtocol: Sendable {
    func save(_ events: [Event]) async
    func fetch() async -> [Event]?
}

// events ka in-memory cache, TTL ke sath — taaki har baar screen pe
// aane pe network call na ho. actor use kiya hai thread-safety ke liye
actor CacheService: CacheServiceProtocol {
    private var cachedEvents: [Event]?
    private var cachedAt: Date?
    private let ttl: TimeInterval

    init(ttl: TimeInterval = 300) {
        self.ttl = ttl
    }

    func save(_ events: [Event]) {
        cachedEvents = events
        cachedAt = Date()
    }

    func fetch() -> [Event]? {
        guard let cachedAt, let cachedEvents else { return nil }
        let isExpired = Date().timeIntervalSince(cachedAt) > ttl
        return isExpired ? nil : cachedEvents
    }
}
