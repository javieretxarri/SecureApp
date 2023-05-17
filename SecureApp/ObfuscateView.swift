//
//  ObfuscateView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 17/5/23.
//

import SwiftUI

struct ObfuscateView: View {
    @State var appear = false

    var body: some View {
        ZStack {
            Rectangle()
            Image(systemName: "lock")
                .font(.largeTitle)
                .foregroundColor(.white)
                .offset(y: appear ? 0 : 500)
        }
        .ignoresSafeArea()
        .animation(.spring().speed(4.0), value: appear)
        .onAppear {
            appear = true
        }
    }
}

struct ObfuscateView_Previews: PreviewProvider {
    static var previews: some View {
        ObfuscateView()
    }
}
