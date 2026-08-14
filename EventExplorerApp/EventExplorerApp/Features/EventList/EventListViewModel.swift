//
//  EventListViewModel.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import Combine

enum EventListViewState: Equatable {
    case loading
    case loaded([Event])
    case empty
    case error(APIError)
}

@MainActor
final class EventListViewModel: ObservableObject {
    @Published private(set) var state: EventListViewState = .loading

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    var events: [Event] {
        if case .loaded(let events) = state { return events }
        return []
    }

    func loadEvents() async {
        state = .loading

        do {
            let fetchedEvents: [Event] = try await networkService.fetch(.events)
            state = fetchedEvents.isEmpty ? .empty : .loaded(fetchedEvents)
        } catch let apiError as APIError {
            state = .error(apiError)
        } catch {
            state = .error(.unknown)
        }
    }
}
