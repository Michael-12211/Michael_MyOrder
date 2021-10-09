//
//  Michael_MyOrderApp.swift
//  Shared
//
//  Created by Michael Kempe on 2021-09-24.
//

import SwiftUI

@main
struct Michael_MyOrderApp: App {
    
    let persistenceController = PersistenceController.shared
    let coreDBHelper = CoreDBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coreDBHelper)
        }
    }
}
