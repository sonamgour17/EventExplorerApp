//
//  MainTabView.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var router = AppRouter()

    var body: some View {
        TabView(selection: $router.selectedTab) {
            NavigationStack {
                EventListView()
            }
            .tabItem {
                Label(
                    AppTab.events.title,
                    systemImage: AppTab.events.systemImage
                )
            }
            .tag(AppTab.events)

            NavigationStack {
                BookmarksView()
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
