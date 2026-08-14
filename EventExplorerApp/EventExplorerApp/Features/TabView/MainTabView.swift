//
//  MainTabView.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject private var router = AppRouter()
    private let container: AppContainer
    
    init(container: AppContainer = .shared) {
        self.container = container
    }
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            eventsTab
                .tabItem { Label(AppTab.events.title, systemImage: AppTab.events.systemImage) }
                .tag(AppTab.events)
            
            bookmarksTab
                .tabItem { Label(AppTab.bookmarks.title, systemImage: AppTab.bookmarks.systemImage) }
                .tag(AppTab.bookmarks)
        }
        .environmentObject(router)
        .environment(\.imageCache, container.imageCacheService)
    }
    
    @ViewBuilder
    private var eventsTab: some View {
        NavigationStack(path: $router.eventsPath) {
            EventListView(viewModel: container.makeEventListViewModel())
                .navigationDestination(for: AppRoute.self, destination: destination)
        }
    }
    
    @ViewBuilder
    private var bookmarksTab: some View {
        NavigationStack(path: $router.bookmarksPath) {
            BookmarksView(viewModel: container.makeBookmarksViewModel())
                .navigationDestination(for: AppRoute.self, destination: destination)
        }
    }
    
    
    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .eventDetail(let eventID):
            EventDetailView(viewModel: container.makeEventDetailViewModel(eventID: eventID))
        }
    }
    
    
}

#Preview {
    MainTabView()
}
