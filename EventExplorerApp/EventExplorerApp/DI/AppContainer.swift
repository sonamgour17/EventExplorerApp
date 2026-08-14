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

    init(
        networkService: NetworkServiceProtocol = NetworkService()
    ) {
        self.networkService = networkService
    }

    // Creates the event list ViewModel.
    func makeEventListViewModel() -> EventListViewModel {
        EventListViewModel(
            networkService: networkService
        )
    }
}
