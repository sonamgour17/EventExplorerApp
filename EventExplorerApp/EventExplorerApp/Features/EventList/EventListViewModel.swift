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
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkServiceProtocol,
         cacheService: CacheServiceProtocol
    ) {
        self.networkService = networkService
        self.cacheService = cacheService
        
    }
    
    var events: [Event] {
        if case .loaded(let events) = state { return events }
        return []
    }
    
    func loadEvents() async {
        
        // pehle cache check — agar fresh data mil gaya to API call skip
        if let cached = await cacheService.fetch() {
           
            print("Served from CACHE")
            state = cached.isEmpty ? .empty : .loaded(cached)
            return
        }
        print("Fetching from NETWORK")
        
        state = .loading
        
        do {
            let fetchedEvents: [Event] = try await networkService.fetch(.events)
            await cacheService.save(fetchedEvents)  

            state = fetchedEvents.isEmpty ? .empty : .loaded(fetchedEvents)
        } catch let apiError as APIError {
            state = .error(apiError)
        } catch {
            state = .error(.unknown)
        }
    }
}
