//
//  SecureAppApp.swift
//  SecureApp
//
//  Created by Javier Etxarri on 12/5/23.
//

import SwiftUI

@main
struct SecureAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    print(URL.documentsDirectory)
                }
        }
    }
}
