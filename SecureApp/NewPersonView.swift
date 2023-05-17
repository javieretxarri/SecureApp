//
//  NewPersonView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import SwiftUI

struct NewPersonView: View {
    @Environment(\.dismiss) var dismiss

    @State var name = ""
    @State var email = ""

    let saveFunc: (String, String) -> ()

    var body: some View {
        VStack {
            Text("New Person")
                .font(.largeTitle)
                .bold()
            Form {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                    TextField("Enter the name", text: $name)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                }
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter the email", text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                }

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Exit")
                    }
                    Spacer()
                    Button {
                        saveFunc(name, email)
                        name = ""
                        email = ""
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView { _, _ in }
    }
}
