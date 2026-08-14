//
//  EventListViewModelTests.swift
//  EventExplorerAppTests
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import XCTest
@testable import EventExplorerApp

@MainActor
final class EventListViewModelTests: XCTestCase {

    private let events: [Event] = [
        Event(id: "1", title: "SwiftUI Conf", location: "Toronto", time: "2026-09-10T18:00:00.000Z", imageUrl: ""),
        Event(id: "2", title: "iOS Meetup", location: "Milton", time: "2026-09-15T18:00:00.000Z", imageUrl: "")
    ]


    func test_success() async {
        let sut = EventListViewModel(
            networkService: MockNetworkService(events: events),
            cacheService: MockCacheService()
        )

        await sut.loadEvents()

        XCTAssertEqual(sut.state, .loaded(events))
    }

 
    func test_failure() async {
        let sut = EventListViewModel(
            networkService: MockNetworkService(events: [], errorToThrow: APIError.noInternet),
            cacheService: MockCacheService()
        )

        await sut.loadEvents()

        XCTAssertEqual(sut.state, .error(.noInternet))
    }


    func test_cacheHit() async {
        let cache = MockCacheService()
        await cache.save(events)

        let network = MockNetworkService(events: [], errorToThrow: APIError.unknown)
        let sut = EventListViewModel(networkService: network, cacheService: cache)

        await sut.loadEvents()

        XCTAssertEqual(sut.state, .loaded(events))
    }

 
    func test_emptyList() async {
        let sut = EventListViewModel(
            networkService: MockNetworkService(events: []),
            cacheService: MockCacheService()
        )

        await sut.loadEvents()

        XCTAssertEqual(sut.state, .empty)
    }

    func test_unknownError() async {
        struct RandomError: Error {}
        let sut = EventListViewModel(
            networkService: MockNetworkService(events: [], errorToThrow: RandomError()),
            cacheService: MockCacheService()
        )

        await sut.loadEvents()

        XCTAssertEqual(sut.state, .error(.unknown))
    }

    func test_initialState() async {
        let sut = EventListViewModel(
            networkService: MockNetworkService(events: events),
            cacheService: MockCacheService()
        )

        XCTAssertEqual(sut.state, .loading)
    }

  
    func test_savesToCache() async {
        let cache = MockCacheService()
        let sut = EventListViewModel(
            networkService: MockNetworkService(events: events),
            cacheService: cache
        )

        await sut.loadEvents()
        let saved = await cache.fetch()

        XCTAssertEqual(saved, events)
    }
}
