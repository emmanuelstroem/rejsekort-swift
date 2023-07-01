//
//  DataController.swift
//  rejseprofil
//
//  Created by Emmanuel on 09/05/2022.
//

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "rejseprofil")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "rejseprofil")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error with PersistanceController: \(error.localizedDescription)")
            }
        }
    }
    
    func destroyAll() {
        // Get a reference to a NSPersistentStoreCoordinator
        let storeContainer = self.container.persistentStoreCoordinator
        
        // Delete each existing persistent store
        for store in storeContainer.persistentStores {
            do {
                try storeContainer.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
                print("CoreData: Successfully Destroyed")
            }
            catch {
                print("CoreData: Failed to Destroy")
            }
        }
    }
    
    
    func deleteUser() {
        // Create a fetch request with a predicate
        let fetchRequest: NSFetchRequest<User>
        fetchRequest = User.fetchRequest()
        
        //    fetchRequest.predicate = // an NSPredicate
        
        // Setting includesPropertyValues to false means
        // the fetch request will only get the managed
        // object ID for each object
        //    fetchRequest.includesPropertyValues = false
        
        // Get a reference to a managed object context
        let context = container.viewContext
        
        // Perform the fetch request
        do {
            let objects = try container.viewContext.fetch(fetchRequest)
            
            // Delete the objects
            for object in objects {
                container.viewContext.delete(object)
            }
            print("CoreData: Successfully Deleted Users")
        }
        catch {
            print("CoreData: Could not Delete Users")
        }
        
        // Save the deletions to the persistent store
        do {
            try context.save()
            print("CoreData: Saved Delete Users")
        }
        catch {
            print("CoreData: Could not save Delete Users")
        }
    }
}

