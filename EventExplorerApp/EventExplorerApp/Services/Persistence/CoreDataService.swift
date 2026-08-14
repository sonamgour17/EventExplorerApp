//
//  CoreDataService.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol: Sendable {
    func saveBookmark(_ event: Event)
    func removeBookmark(eventID: String)
    func isBookmarked(eventID: String) -> Bool
    func fetchBookmarks() -> [Event]

    func saveLastFetchedEvents(_ events: [Event])
    func fetchLastFetchedEvents() -> [Event]
}

final class CoreDataService: CoreDataServiceProtocol, @unchecked Sendable {
    private let manager: CoreDataManager

    init(manager: CoreDataManager = .shared) {
        self.manager = manager
    }

    // MARK: - Bookmarks

    func saveBookmark(_ event: Event) {
        guard !isBookmarked(eventID: event.id) else { return }

        let bookmark = BookmarkEntity(context: manager.context)
        bookmark.id = event.id
        bookmark.title = event.title
        bookmark.location = event.location
        bookmark.time = event.time
        bookmark.imageUrl = event.imageUrl
        bookmark.bookmarkedAt = Date()

        manager.save()
    }

    func removeBookmark(eventID: String) {
        let request: NSFetchRequest<BookmarkEntity> = BookmarkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", eventID)

        do {
            let results = try manager.context.fetch(request)
            results.forEach { manager.context.delete($0) }
            manager.save()
        } catch {
            print("Failed to remove bookmark: \(error.localizedDescription)")
        }
    }

    func isBookmarked(eventID: String) -> Bool {
        let request: NSFetchRequest<BookmarkEntity> = BookmarkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", eventID)
        request.fetchLimit = 1

        return (try? manager.context.count(for: request)) ?? 0 > 0
    }

    func fetchBookmarks() -> [Event] {
        let request: NSFetchRequest<BookmarkEntity> = BookmarkEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "bookmarkedAt", ascending: false)]

        guard let results = try? manager.context.fetch(request) else { return [] }
        return results.map {
            Event(id: $0.id ?? "", title: $0.title ?? "", location: $0.location ?? "",
                  time: $0.time ?? "", imageUrl: $0.imageUrl ?? "")
        }
    }

    // MARK: - Offline fallback (last fetched events)

    func saveLastFetchedEvents(_ events: [Event]) {
        let deleteRequest: NSFetchRequest<NSFetchRequestResult> = CachedEventEntity.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        try? manager.context.execute(batchDelete)

        for event in events {
            let cached = CachedEventEntity(context: manager.context)
            cached.id = event.id
            cached.title = event.title
            cached.location = event.location
            cached.time = event.time
            cached.imageUrl = event.imageUrl
            cached.lastFetchedAt = Date()
        }
        manager.save()
    }

    func fetchLastFetchedEvents() -> [Event] {
        let request: NSFetchRequest<CachedEventEntity> = CachedEventEntity.fetchRequest()
        guard let results = try? manager.context.fetch(request) else { return [] }
        return results.map {
            Event(id: $0.id ?? "", title: $0.title ?? "", location: $0.location ?? "",
                  time: $0.time ?? "", imageUrl: $0.imageUrl ?? "")
        }
    }
}
