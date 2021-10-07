//
//  Persistence.swift
//  Michael_MyOrder (iOS)
//
//  Created by Michael Kempe on 2021-10-07.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Michael_MyOrder")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                //TODO: handle error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}
