//
//  PersonasCD+CoreDataProperties.swift
//  SecureApp
//
//  Created by Javier Etxarri on 17/5/23.
//
//

import BCSecure2023
import CoreData
import CryptoKit
import Foundation

@objc(PersonasCD)
public class PersonasCD: NSManagedObject {}

public extension PersonasCD {
    private var krypto: Krypto {
        if let appKey = SecKeyStore.shared.readKey(label: "KEY") {
            return Krypto(key: SymmetricKey(data: appKey))
        } else {
            return Krypto.shared
        }
    }

    @nonobjc class func fetchRequest() -> NSFetchRequest<PersonasCD> {
        return NSFetchRequest<PersonasCD>(entityName: "PersonasCD")
    }

    @NSManaged var name: String?
    @NSManaged private var email: String?

    var _email: String? {
        get {
            if let email {
                return try? krypto.ChaPolyDecryptb64(data: email)
            } else {
                return nil
            }
        }
        set {
            if let newValue {
                email = try? krypto.ChaPolyEncryptb64(value: newValue)
            } else {
                email = nil
            }
        }
    }
}

extension PersonasCD: Identifiable {}
