//
//  FirebaseService.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import Foundation
import UIKit
import FirebaseAuth

class FirebaseAuthentication {
    static let shared = FirebaseAuthentication()
    
    func createUser(_ email: String, _ password: String) async throws -> Profile {
        do {
            let exist = try await checkEmailExist(email)
            if exist {
                throw ErrorType.emailExist
            }
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authResult.user
            if let email = user.email, !email.isEmpty {
                let profile =  Profile(id: user.uid, email: email, username: nil, firstName: nil, lastName: nil, avatarPath: nil)
                return profile
            } else {
                throw ErrorType.cannotCreateAccount
            }
        } catch {
            throw error
        }
    }
    
    func signIn(_ email: String, _ password: String) async throws -> String {
        do {
            let authResult = try await  Auth.auth().signIn(withEmail: email, password: password)
            return authResult.user.uid
        } catch {
            throw ErrorType.accountNotExist
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func checkEmailExist(_ email: String) async throws -> Bool {
        do {
            let providers = try await Auth.auth().fetchSignInMethods(forEmail: email)
            return (providers.count > 0)
        } catch {
            throw ErrorType.failedToCheckEmailExist
        }
    }
}
