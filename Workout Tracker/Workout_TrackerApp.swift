//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 10/7/21.
//

import SwiftUI

@main
struct Workout_TrackerApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    //@Environment(\.managedObjectContext) var managedObjectContext
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
