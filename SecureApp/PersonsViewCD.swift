//
//  PersonsViewCD.swift
//  SecureApp
//
//  Created by Javier Etxarri on 16/5/23.
//

import SwiftUI

struct PersonsViewCD: View {
    let screenshot = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
        print("El usuario hizo una captura")
    }

    @Environment(\.managedObjectContext) var context

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    var fetchPersons: FetchedResults<PersonasCD>

    @State var showNew = false

    var body: some View {
        NavigationStack {
            List(fetchPersons) { person in
                VStack(alignment: .leading) {
                    Text(person.name ?? "")
                        .font(.headline)
                    Text(person._email ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .privacySensitive()
                }
            }
            .navigationTitle("Persons")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNew.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showNew) {
            NewPersonView { name, email in
                let new = PersonasCD(context: context)
                new.name = name
                new._email = email
                try? context.save()
            }
            .presentationDetents([.medium])
            .presentationContentInteraction(.automatic)
        }
    }
}

struct PersonsViewCD_Previews: PreviewProvider {
    static var previews: some View {
        PersonsViewCD()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
