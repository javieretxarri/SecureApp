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

    let inactive = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
    let active = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)

    @State var obfuscate = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    print(URL.documentsDirectory)
                }
                .onReceive(inactive) { _ in
                    obfuscate = true
                }
                .onReceive(active) { _ in
                    obfuscate = false
                }
                .fullScreenCover(isPresented: $obfuscate) {
                    ObfuscateView()
                }
        }
    }
}
