//
//  SecureDataView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import SwiftUI

struct SecureDataView: View {
    @ObservedObject var vm = SecureDataViewVM()
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $vm.persiType) {
                    ForEach(PersistenceType.allCases) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Persistence Type")
            }

            Section {
                TextField("Enter the text", text: $vm.texto2Guardar, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                
                HStack {
                    Button {
                        vm.doPersistence()
                    } label: {
                        Text("Store")
                    }
                    Spacer()
                    Button {
                        vm.doRetrieve()
                    } label: {
                        Text("Retrieve")
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Persisted text")
                        .font(.headline)
                        .padding(.bottom, 10)
                    Text(vm.textoRecuperado.isEmpty ? "No persisted content yet" : vm.textoRecuperado)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Persistencia")
            }
            
            Section {
                TextField("Enter the text", text: $vm.secTexto2Guardar, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                
                HStack {
                    Button {
                        vm.doSecurePersistence()
                    } label: {
                        Text("Store")
                    }
                    Spacer()
                    Button {
                        vm.doSecureRetrieve()
                    } label: {
                        Text("Retrieve")
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Secure Persisted text")
                        .font(.headline)
                        .padding(.bottom, 10)
                    Text(vm.secTextoRecuperado.isEmpty ? "No persisted secure content yet" : vm.secTextoRecuperado)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Persistencia cifrada")
            }
        }
        .textFieldStyle(.roundedBorder)
        .buttonStyle(.bordered)
    }
}

struct SecureDataView_Previews: PreviewProvider {
    static var previews: some View {
        SecureDataView()
    }
}
