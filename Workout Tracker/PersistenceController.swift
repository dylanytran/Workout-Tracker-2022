//
//  PersistenceController.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 11/11/21.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
    
        for _ in 0..<10 {
            let exercise = Exercise(context: controller.container.viewContext)
            exercise.name = "Example Exercise 1"
            exercise.sets = "Many Sets"
            exercise.reps = "Many Reps"
            exercise.weight = "A Lot of Weight"
        }
        
        return controller
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            }
        }
    }
}
