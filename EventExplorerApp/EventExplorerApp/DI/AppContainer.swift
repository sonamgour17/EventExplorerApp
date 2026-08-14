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
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        cacheService: CacheServiceProtocol = CacheService(),
        imageCacheService: ImageCacheServiceProtocol = ImageCacheService()
    ) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.imageCacheService = imageCacheService
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
