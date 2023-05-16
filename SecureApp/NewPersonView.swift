//
//  NewPersonView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import SwiftUI

struct NewPersonView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var persons: [Persons]

    @State var name = ""
    @State var email = ""

    var body: some View {
        VStack {
            Text("New Person")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
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
                }

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Exit")
                    }
                    Spacer()
                    Button {
                        let new = Persons(name: name, email: email)
                        persons.append(new)
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
        NewPersonView(persons: .constant([.test]))
    }
}
