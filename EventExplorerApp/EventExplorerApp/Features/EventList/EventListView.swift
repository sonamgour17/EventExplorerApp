//
//  EventListView.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import SwiftUI

struct EventListView: View {
    
    @StateObject private var viewModel: EventListViewModel

    init(viewModel: EventListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Events")
            .task {
                await viewModel.loadEvents()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading events...")
        case .loaded(let events):
            List(events) { EventRowView(event: $0) }
                .listStyle(.plain)
        case .empty:
            emptyView
        case .error(let apiError):
            errorView(apiError.errorDescription ?? "Something went wrong.")
        }
    }

    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("No events found")
                .foregroundColor(.secondary)
        }
        .padding()
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.exclamationmark")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Button("Retry") {
                Task { await viewModel.loadEvents() }
            }
        }
        .padding()
    }
}



