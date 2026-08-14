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
            
            NavigationStack {
                
                EventListView(
                    viewModel: container.makeEventListViewModel()
                )
            }
            .tabItem {
                Label(
                    AppTab.events.title,
                    systemImage: AppTab.events.systemImage
                )
            }
            .tag(AppTab.events)

            NavigationStack {
                BookmarksView(viewModel: container.makeBookmarksViewModel()) 
            }
            .tabItem {
                Label(
                    AppTab.bookmarks.title,
                    systemImage: AppTab.bookmarks.systemImage
                )
            }
            .tag(AppTab.bookmarks)
        }
        .environmentObject(router)
    }
}

#Preview {
    MainTabView()
}
