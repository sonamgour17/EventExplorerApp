//
//  CoreDataManager.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "EventExplorerApp")
        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Core Data save failed: \(error.localizedDescription)")
        }
    }
}
