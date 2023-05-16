//
//  File.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import SwiftUI

struct AlertError: ViewModifier {
    @Binding var showAlert: Bool
    let errorMsg: String
    func body(content: Content) -> some View {
        content
            .alert("Error alert",
                   isPresented: $showAlert) {
                Button {} label: {
                    Text("Ok")
                }
            } message: {
                Text(errorMsg)
            }
    }
}

extension View {
    func alertErrot(showAlert: Binding<Bool>, errorMsg: String) -> some View {
        modifier(AlertError(showAlert: showAlert, errorMsg: errorMsg))
    }
}
