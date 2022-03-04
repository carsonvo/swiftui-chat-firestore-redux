//
//  LogInView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 14/02/2022.
//

import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Bool
    
    let helpers = Helpers()
    
    var body: some View {
        NavigationView {
            VStack {
                emailTextField
                passwordTextField
                loginButton
                newAccountButton
                Spacer()
            }
            .padding()
            .navigationTitle("Log In")
        }
        .navigationViewStyle(.stack)
    }
    
    private var emailTextField: some View {
        TextField("Email", text: $email)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField)
    }
    
    private var passwordTextField: some View {
        PasswordField(placeHolder: "Password", password: $password, focusedField: $focusedField)
    }
    
    private var loginButton: some View {
        Button("Log In") {
            focusedField = false
            helpers.login(email, password)
        }
        .padding(5)
        .buttonStyle(.borderedProminent)
        .disabled(!helpers.ableToLogin(email, password))
    }
    
    private var newAccountButton: some View {
        NavigationLink("Create new account") {
            signUpView
        }
        .font(.footnote)
        .foregroundColor(.blue)
    }
    
    private var signUpView: some View {
        SignUpView()
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
