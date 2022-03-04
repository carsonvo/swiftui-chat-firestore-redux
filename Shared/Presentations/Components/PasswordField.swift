//
//  PasswordField.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import SwiftUI

struct PasswordField: View {
    let placeHolder: String
    let password: Binding<String>
    let focusedField: FocusState<Bool>.Binding
    
    var body: some View {
        SecureField(placeHolder, text: password)
            .focused(focusedField)
            .textFieldStyle(.roundedBorder)
    }
}
