//
//  KeychainService.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import KeychainAccess

class KeychainService {
    static let shared = KeychainService()
    let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var profile: Profile? {
        get {
            getValue(key: .profile)
        }
        set {
            if let profile = newValue {
                setValue(value: profile, key: .profile)
            } else {
                removeValue(key: .profile)
            }
        }
    }
}

extension KeychainService {
    enum Key {
        case profile
        
        var value: String {
            switch self {
            case .profile:
                return "profile"
            }
        }
    }
    
    func setValue<T: Encodable>(value: T, key: Key) {
        if let data = try? encoder.encode(value) {
            do {
                try keychain.set(data, key: key.value)
            } catch {
                
            }
        } else {
            
        }
    }
    
    func getValue<T: Decodable>(key: Key) -> T? {
        guard let data = try? keychain.getData(key.value) else { return nil }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    func removeValue(key: Key) {
        keychain[key.value] = nil
    }
    
    func removeAll() {
        do {
            try keychain.removeAll()
        } catch {
            
        }
    }
}
