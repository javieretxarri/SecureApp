//
//  DataEncryptView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import SwiftUI

struct DataEncryptView: View {
    @StateObject var vm = DataEncryptVM()

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("String to encrypt")
                        .font(.headline)
                    TextField("Enter the text", text: $vm.textNormal, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
                VStack(alignment: .leading) {
                    Text("Encrypted content")
                        .font(.headline)
                        .padding(.bottom, 10)
                    Text(vm.encrypted.isEmpty ? "No encrypted content yet" : vm.encrypted)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                VStack(alignment: .leading) {
                    Text("Decrypted content")
                        .font(.headline)
                        .padding(.bottom, 10)
                    Text(vm.decrypted.isEmpty ? "No decrypted content yet" : vm.decrypted)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                VStack {
                    Picker(selection: $vm.chiperType) {
                        ForEach(CipherCase.allCases) { cipher in
                            Text(cipher.rawValue)
                                .tag(cipher)
                        }
                    } label: {
                        Text("Cipher Type")
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)

                    HStack {
                        Button {
                            vm.encrypt()
                        } label: {
                            Text("Encrypt Text")
                        }

                        Spacer()
                        Button {
                            vm.decrypt()
                        } label: {
                            Text("Decrypt Text")
                        }
                    }
                }
                .buttonStyle(.bordered)
            } header: {
                Text("Data Encryption")
            }
            .alertErrot(showAlert: $vm.showAlert, errorMsg: vm.errorMSG)
//            .modifier(AlertError(showAlert: $vm.showAlert, errorMsg: vm.errorMSG))

            Section {
                VStack(alignment: .leading) {
                    Text("String to hash")
                        .font(.headline)
                    TextField("Enter the text", text: $vm.text2Hash, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
                VStack(alignment: .leading) {
                    Text("Hashed content")
                        .font(.headline)
                        .padding(.bottom, 10)
                    Text(vm.hashedText.isEmpty ? "No hashed content yet" : vm.hashedText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading) {
                    Text("String to compare by hash")
                        .font(.headline)
                    TextField("Enter the text", text: $vm.text2Compare, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }

                Text(vm.result.isEmpty ? "There is not comparison" : vm.result)
                    .font(.headline)

                VStack {
                    Picker(selection: $vm.hashedType) {
                        ForEach(HashCase.allCases) { hash in
                            Text(hash.rawValue)
                                .tag(hash)
                        }
                    } label: {
                        Text("Hash Type")
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)

                    HStack {
                        Button {
                            vm.calculateHash()
                        } label: {
                            Text("Hash Text")
                        }

                        Spacer()
                        Button {
                            vm.compareHash()
                        } label: {
                            Text("Compare text with Hash ")
                        }
                    }
                }
                .buttonStyle(.bordered)

            } header: {
                Text("HASH")
            }
        }
    }
}

struct DataEncryptView_Previews: PreviewProvider {
    static var previews: some View {
        DataEncryptView()
    }
}
