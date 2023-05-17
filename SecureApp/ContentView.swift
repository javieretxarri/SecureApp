//
//  ContentView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 12/5/23.
//

import BCSecure2023
import CryptoKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PersonsViewCD()
                .tabItem {
                    Label("Persons CD", systemImage: "cylinder.split.1x2")
                }
            PersonsView()
                .tabItem {
                    Label("Persons", systemImage: "person")
                }
            DataEncryptView()
                .tabItem {
                    Label("Cipher", systemImage: "lock")
                }
            SecureDataView()
                .tabItem {
                    Label("Data", systemImage: "doc")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
