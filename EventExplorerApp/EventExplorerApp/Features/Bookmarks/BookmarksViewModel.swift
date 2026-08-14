//
//  BookmarksViewModel.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import Combine

@MainActor
final class BookmarksViewModel: ObservableObject {
    
    @Published private(set) var bookmarkedEvents: [Event] = []

    private let coreDataService: CoreDataServiceProtocol

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }

    func loadBookmarks() {
        bookmarkedEvents = coreDataService.fetchBookmarks()
    }
}
