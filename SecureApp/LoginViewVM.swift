//
//  LoginViewVM.swift
//  SecureApp
//
//  Created by Javier Etxarri on 17/5/23.
//

import SwiftUI

final class LoginViewVM: ObservableObject {
    enum Screen: String, Identifiable, CaseIterable {
        case login = "Login"
        case register = "Register"

        var id: Self { self }
    }

    @Published var screen: Screen = .login

    @Published var username = ""
    @Published var password = ""
}
