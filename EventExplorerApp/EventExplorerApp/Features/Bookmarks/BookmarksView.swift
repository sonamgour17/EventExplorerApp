//
//  BookmarksView.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import SwiftUI

struct BookmarksView: View {
    
    @StateObject private var viewModel: BookmarksViewModel
    @EnvironmentObject private var router: AppRouter
    
    init(viewModel: BookmarksViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.bookmarkedEvents.isEmpty {
                emptyState
            } else {
                List(viewModel.bookmarkedEvents) { event in
                    EventRowView(event: event)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            router.push(.eventDetail(eventID: event.id))
                        }
                }.listStyle(.plain)
            }
        }
        .navigationTitle("Bookmarks")
        .onAppear {
            viewModel.loadBookmarks()
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "bookmark.slash")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("No bookmarks yet")
                .foregroundColor(.secondary)
        }
    }
}

