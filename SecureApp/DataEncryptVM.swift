//
//  DataEncryptVM.swift
//  SecureApp
//
//  Created by Javier Etxarri on 15/5/23.
//

import BCSecure2023
import CryptoKit
import SwiftUI

final class DataEncryptVM: ObservableObject {
    @KeyChain(key: "KEY") var key = Krypto.newKey()

    @Published var textNormal = ""
    @Published var encrypted = ""
    @Published var decrypted = ""

    @Published var text2Hash = ""
    @Published var hashedText = ""
    @Published var text2Compare = ""
    @Published var hashKey = ""

    @Published var result = ""

    @Published var showAlert = false
    @Published var errorMSG = ""

    @Published var chiperType: CipherCase = .gcm
    @Published var hashedType: HashCase = .sha256

    lazy var krypto: Krypto = {
        if let appKey = key {
            return Krypto(key: SymmetricKey(data: appKey))
        } else {
            return Krypto.shared
        }
    }()

    func encrypt() {
        switch chiperType {
        case .gcm:
            encryptGCM()
        case .chapoly:
            encryptChaPoly()
        }
    }

    func decrypt() {
        switch chiperType {
        case .gcm:
            decryptGCM()
        case .chapoly:
            decryptChaPoly()
        }
    }

    func encryptGCM() {
        do {
            encrypted = try krypto.GCMEncryptb64(value: textNormal)
        } catch {
            print("Error \(error)")
            showAlert = true
            errorMSG = "Error encrypt GCM \(error.localizedDescription)"
        }
    }

    func decryptGCM() {
        do {
            decrypted = try krypto.GCMDecryptb64(data: encrypted)
        } catch {
            print("Error \(error)")
            showAlert = true
            errorMSG = "Error decrypt GCM \(error.localizedDescription)"
        }
    }

    func encryptChaPoly() {
        do {
            encrypted = try krypto.ChaPolyEncryptb64(value: textNormal)
        } catch {
            print("Error \(error)")
            showAlert = true
            errorMSG = "Error encrypt ChaPoly \(error.localizedDescription)"
        }
    }

    func decryptChaPoly() {
        do {
            decrypted = try krypto.ChaPolyDecryptb64(data: encrypted)
        } catch {
            print("Error \(error)")
            showAlert = true
            errorMSG = "Error decrypt ChaPoly \(error.localizedDescription)"
        }
    }

    func calculateHash() {
        do {
            switch hashedType {
            case .sha256:
                hashedText = try HashKit.shared.sha256(value: text2Hash)
            case .hmac256:
                guard let key else { return }
                hashedText = try HashKit.shared.HMAC256(value: text2Hash, key: key)
            }
        } catch {
            print("Error \(error)")
            showAlert = true
            errorMSG = "Error hashing ChaPoly \(error.localizedDescription)"
        }
    }

    func compareHash() {
        do {
            switch hashedType {
            case .sha256:
                let newHash = try HashKit.shared.sha256(value: text2Compare)
                if newHash == hashedText {
                    result = "Hash are the same. Ok"
                } else {
                    result = "Hash not equal"
                }

            case .hmac256:
                guard let key else { return }
                if HashKit.shared.checkHMAC256(value: text2Compare, hash: hashedText, key: key) {
                    result = "Hash are the same. Ok"
                } else {
                    result = "Hash not equal"
                }
            }
        } catch {
            print("Error \(error)")
            showAlert = true
            errorMSG = "Error hashing ChaPoly \(error.localizedDescription)"
        }
    }
}
