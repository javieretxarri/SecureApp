//
//  Enums.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import Foundation

enum CipherCase: String, CaseIterable, Identifiable {
    case gcm = "AES/GCM"
    case chapoly = "Chacha Poly/1305"

    var id: Self { self }
}

enum HashCase: String, CaseIterable, Identifiable {
    case sha256 = "SHA256"
    case hmac256 = "HMAC256"

    var id: Self { self }
}
