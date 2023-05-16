//
//  PersistenceType.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import BCSecure2023
import CryptoKit
import SwiftUI

enum PersistenceType: String, CaseIterable, Identifiable {
    case documents = "Documents"
    case userDefaults = "User Defaults"
    case keychain = "Keychain"
    
    var id: Self { self }
}

final class SecureDataViewVM: ObservableObject {
    @KeyChain(key: "KEY") var key = Krypto.newKey()
    
    lazy var krypto: Krypto = {
        if let appKey = key {
            return Krypto(key: SymmetricKey(data: appKey))
        } else {
            return Krypto.shared
        }
    }()
    
    @Published var persiType: PersistenceType = .documents
    
    @Published var texto2Guardar = ""
    @Published var textoRecuperado = ""

    @Published var secTexto2Guardar = ""
    @Published var secTextoRecuperado = ""

    @AppStorage("TEST") var test = ""
    @KeyChain(key: "TEST") var keychainTest = Data(count: 1)

    @AppStorage("TESTSECURE") var testSec = ""
    @KeyChain(key: "TESTSECURE") var keychainTestSec = Data(count: 1)
    
    func doPersistence() {
        guard let data = texto2Guardar.data(using: .utf8) else { return }
        switch persiType {
        case .documents:
            try? data.write(to: URL.documentsDirectory.appending(path: "test.txt"), options: [.atomic])
        case .userDefaults:
            test = texto2Guardar
        case .keychain:
            keychainTest = data
        }
    }
    
    func doRetrieve() {
        switch persiType {
        case .documents:
            if let data = try? Data(contentsOf: URL.documentsDirectory.appending(path: "test.txt")),
               let cadena = String(data: data, encoding: .utf8)
            {
                textoRecuperado = cadena
            }
        case .userDefaults:
            textoRecuperado = test
        case .keychain:
            if let data = keychainTest,
               let cadena = String(data: data, encoding: .utf8)
            {
                textoRecuperado = cadena
            }
        }
    }
    
    func doSecurePersistence() {
        guard let secureData = try? krypto.ChaPolyEncrypt(value: secTexto2Guardar) else { return }
        switch persiType {
        case .documents:
            try? secureData.write(to: URL.documentsDirectory.appending(path: "testSecure.dat"), options: [.atomic])
        case .userDefaults:
            testSec = secureData.base64EncodedString()
        case .keychain:
            keychainTestSec = secureData
        }
    }
    
    func doSecureRetrieve() {
        switch persiType {
        case .documents:
            if let data = try? Data(contentsOf: URL.documentsDirectory.appending(path: "testSecure.dat")),
               let decrypt = try? krypto.ChaPolyDecrypt(data: data)
            {
                secTextoRecuperado = decrypt
            }
        case .userDefaults:
            if let decrypt = try? krypto.ChaPolyDecryptb64(data: testSec) {
                secTextoRecuperado = decrypt
            }
        case .keychain:
            if let data = keychainTestSec,
               let cadena = try? krypto.ChaPolyDecrypt(data: data)
            {
                secTextoRecuperado = cadena
            }
        }
    }
}
