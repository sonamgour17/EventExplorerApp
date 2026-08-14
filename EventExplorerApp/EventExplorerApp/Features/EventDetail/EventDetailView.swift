//
//  EventDetailView.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import SwiftUI

struct EventDetailView: View {
    @StateObject private var viewModel: EventDetailViewModel

    init(viewModel: EventDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            if let event = viewModel.event {
                VStack(alignment: .leading, spacing: 16) {
                    CachedAsyncImage(url: URL(string: event.imageUrl))
                        .frame(height: 220)
                        .clipped()

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(event.title).font(.title2.bold())
                            Spacer()
                            BookmarkButton(isBookmarked: viewModel.isBookmarked) {
                                viewModel.toggleBookmark()
                            }
                        }

                        Label(event.location, systemImage: "mappin.and.ellipse")
                            .foregroundColor(.secondary)

                        if let date = event.eventDate {
                            Label(date.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                                .foregroundColor(.secondary)
                        }

                        if let distanceText = viewModel.distanceText {
                            Label("\(distanceText) away", systemImage: "location.fill")
                                .foregroundColor(.secondary)
                        }

                        Button {
                            viewModel.openInMaps()
                        } label: {
                            Label("Open in Maps", systemImage: "map")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                }
            } else if viewModel.isLoading {
                ProgressView().padding(.top, 40)
            } else {
                Text("Event not found.").foregroundColor(.secondary).padding(.top, 40)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.loadEvent() }
    }
}
