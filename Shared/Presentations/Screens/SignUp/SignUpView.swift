//
//  SignUpView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var secondPassword = ""
    @FocusState private var focusedField: Bool
    
    let helpers = Helpers()
    
    var body: some View {
        VStack {
            emailTextField
            firstPasswordField
            secondPasswordField
            signupButton
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
    
    private var emailTextField: some View {
        TextField("Email", text: $email)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField)
    }
    
    private var firstPasswordField: some View {
        PasswordField(placeHolder: "Password", password: $password, focusedField: $focusedField)
    }
    
    private var secondPasswordField: some View {
        PasswordField(placeHolder: "Confirm password", password: $secondPassword, focusedField: $focusedField)
    }
    
    private var signupButton: some View {
        Button("Sign Up") {
            focusedField = false
            helpers.signUp(email, password)
        }
        .padding(5)
        .buttonStyle(.borderedProminent)
        .disabled(!helpers.isAbleToSignUp(email, password, secondPassword))
    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
