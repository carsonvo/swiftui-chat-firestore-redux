//
//  Helpers.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import Foundation
import FirebaseFirestore
import Photos

struct AppHelpers {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        password.count >= 6
    }
    
    static func closeMainError() {
        Subscriber.dispatch(action: ErrorAction.setError(.none))
    }
}
