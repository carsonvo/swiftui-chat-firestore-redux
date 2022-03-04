//
//  SignUpHelpers.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import Foundation

extension SignUpView {
    struct Helpers {
        func isValidPassword(_ firstPassword: String, _ secondPassword: String) -> Bool {
            AppHelpers.isValidPassword(firstPassword) && firstPassword == secondPassword
        }
        
        func isAbleToSignUp(_ email: String, _ firstPassword: String, _ secondPassword: String) -> Bool {
            AppHelpers.isValidEmail(email) && isValidPassword(firstPassword, secondPassword)
        }
        
        func signUp(_ email: String, _ password: String) {
            Subscriber.dispatch(action: ProfileAction.signUp(email, password))
        }
    }
}
