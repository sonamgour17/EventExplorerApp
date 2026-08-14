//
//  AppContainer.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation


// Stores app dependencies.
@MainActor
final class AppContainer {
    
    static let shared = AppContainer()
    
    let networkService: NetworkServiceProtocol
    let cacheService: CacheServiceProtocol
    let imageCacheService: ImageCacheServiceProtocol
    let coreDataService: CoreDataServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        cacheService: CacheServiceProtocol = CacheService(),
        imageCacheService: ImageCacheServiceProtocol = ImageCacheService(),
        coreDataService: CoreDataServiceProtocol = CoreDataService()
    ) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.imageCacheService = imageCacheService
        self.coreDataService = coreDataService
    }
}

extension AppContainer {
    
    func makeEventListViewModel() -> EventListViewModel {
        EventListViewModel(
            networkService: networkService,
            cacheService: cacheService
        )
    }
}
