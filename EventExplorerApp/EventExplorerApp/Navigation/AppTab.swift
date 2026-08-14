//
//  AppTab.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation

// Defines the available tabs.
enum AppTab: Hashable, Sendable {
    case events
    case bookmarks

    var title: String {
        switch self {
        case .events:
            return AppConstants.Title.events

        case .bookmarks:
            return AppConstants.Title.bookmarks
        }
    }

    var systemImage: String {
        switch self {
        case .events:
            return AppConstants.Image.events

        case .bookmarks:
            return AppConstants.Image.bookmarks
        }
    }
}
