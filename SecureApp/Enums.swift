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

enum DataEncrypFields {
    case ecnryptText, hashText, hashCompareText

    mutating func next() {
        switch self {
        case .ecnryptText:
            self = .hashText
        case .hashText:
            self = .hashCompareText
        case .hashCompareText:
            self = .ecnryptText
        }
    }

    mutating func prev() {
        switch self {
        case .ecnryptText:
            self = .hashCompareText
        case .hashText:
            self = .ecnryptText
        case .hashCompareText:
            self = .hashText
        }
    }
}

enum SecureDataFields {
    case plainText, secureText

    mutating func next() {
        switch self {
        case .plainText:
            self = .secureText
        case .secureText:
            self = .plainText
        }
    }

    mutating func prev() {
        switch self {
        case .plainText:
            self = .secureText
        case .secureText:
            self = .plainText
        }
    }
}
