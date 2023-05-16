//
//  Person.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import Foundation

struct Persons: Codable, Identifiable {
    let id = UUID()
    let name: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case name, email
    }
}

extension Persons {
    static let test = Persons(name: "Pedro Pepito Gonzalez", email: "unomas@porelmundo.com")
}
