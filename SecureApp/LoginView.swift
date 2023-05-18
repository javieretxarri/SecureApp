//
//  LoginView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 17/5/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var vm = LoginViewVM()
    
    var body: some View {
        VStack {
            Picker(selection: $vm.screen) {
                ForEach(LoginViewVM.Screen.allCases) { sc in
                    Text(sc.rawValue)
                        .tag(sc)
                }
            } label: {
                Text("")
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            switch vm.screen {
            case .login: login
            case .register: register
            }
            
            Spacer()
        }
    }
    
    var login: some View {
        VStack(alignment: .leading) {
            Text("Enter login information")
                .font(.headline)
                .padding(.bottom)
            Text("Username")
            TextField("Enter the username", text: $vm.username)
                .textContentType(.username)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Text("Password")
            SecureField("Enter the password", text: $vm.password)
                .textContentType(.password)
            Button {} label: {
                Text("Enter \(Image(systemName: "lock"))")
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top)
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .background {
            Color(white: 0.95)
        }
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    var register: some View {
        Text("REGISTER")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
