//
//  LoginViewHelpers.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import Foundation

extension LogInView {
    struct Helpers {
        func ableToLogin(_ email: String, _ password: String) -> Bool {
            AppHelpers.isValidEmail(email) && AppHelpers.isValidPassword(password)
        }
        
        func login(_ email: String, _ password: String) {
            Subscriber.dispatch(action: ProfileAction.signIn(email, password))
        }
    }
}
