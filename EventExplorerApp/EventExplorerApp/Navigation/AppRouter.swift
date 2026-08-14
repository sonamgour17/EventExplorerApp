//
//  AppRouter.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//


import Combine
import SwiftUI


// Manages the selected tab.
@MainActor
final class AppRouter: ObservableObject {
    
    @Published var selectedTab: AppTab = .events
    @Published var eventsPath = NavigationPath()
    @Published var bookmarksPath = NavigationPath()
    
    func push(_ route: AppRoute) {

        switch selectedTab {
        case .events:
            eventsPath.append(route)

        case .bookmarks:
            bookmarksPath.append(route)
        

        }
    }
}
