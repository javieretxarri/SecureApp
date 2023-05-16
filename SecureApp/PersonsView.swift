//
//  PersonsView.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import SwiftUI

struct PersonsView: View {
    @ObservedObject var vm = PersonsVM()

    @State var showNew = false

    var body: some View {
        NavigationStack {
            List(vm.persons) { person in
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.headline)
                    Text(person.email)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Persons")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button {
                            vm.savePersons()
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                        Button {
                            vm.saveSecPersons()
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                        .buttonStyle(.borderedProminent)
                        Divider()
                        Button {
                            vm.cleanPersons()
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            vm.loadPersons()
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        Button {
                            vm.loadSecPersons()
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .buttonStyle(.borderedProminent)
                        Divider()
                        Button {
                            showNew.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showNew) {
            NewPersonView(persons: $vm.persons)
                .presentationDetents([.medium, .large])
                .presentationContentInteraction(.automatic)
        }
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView()
    }
}
