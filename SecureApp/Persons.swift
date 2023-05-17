//
//  Person.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import BCSecure2023
import CryptoKit
import Foundation

struct Persons: Codable, Identifiable {
    static let krypto: Krypto = {
        if let appKey = SecKeyStore.shared.readKey(label: "KEY") {
            return Krypto(key: SymmetricKey(data: appKey))
        } else {
            return Krypto.shared
        }
    }()
    
    let id = UUID()
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case name, email
    }
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let email = try container.decode(String.self, forKey: .email)
        self.email = try Persons.krypto.ChaPolyDecryptb64(data: email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        let email = try Persons.krypto.ChaPolyEncryptb64(value: self.email)
        try container.encode(email, forKey: .email)
    }
}

extension Persons {
    static let test = Persons(name: "Julio César Fernández", email: "jcfmunoz@icloud.com")
}
