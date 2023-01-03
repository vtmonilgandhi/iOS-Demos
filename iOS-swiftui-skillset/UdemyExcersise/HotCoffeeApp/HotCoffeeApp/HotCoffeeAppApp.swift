//
//  HotCoffeeAppApp.swift
//  HotCoffeeApp
//
//  Created by Monil Gandhi on 05/10/20.
//

import SwiftUI

@main
struct HotCoffeeAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
