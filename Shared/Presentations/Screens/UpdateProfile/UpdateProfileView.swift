//
//  UpdateProfileView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import SwiftUI

struct UpdateProfileView: View {
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var avatar: UIImage?
    @State private var avatarToggle = false
    @FocusState private var focusedField: Bool
    
    let helpers = Helpers()
    
    var body: some View {
        NavigationView {
            VStack {
                avatarSetting
                usernameField
                firstNameField
                lastNameField
                doneButton
                Spacer()
            }
            .padding()
            .sheet(isPresented: $avatarToggle) {
                imagePicker
            }
            .navigationTitle("Informations")
        }
        .navigationViewStyle(.stack)
    }
    
    private var avatarSetting: some View {
        Button(action: { avatarToggle.toggle() }) {
            ZStack(alignment: .bottomTrailing) {
                if let avatar = avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .cornerRadius(50)
                }
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(.bottom, 4)
                    .padding(.trailing, 4)
            }
        }
    }
    
    private var usernameField: some View {
        TextField("Username", text: $username)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField)
    }
    
    private var firstNameField: some View {
        TextField("First Name", text: $firstName)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField)
    }
    
    private var lastNameField: some View {
        TextField("Last Name", text: $lastName)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField)
    }
    
    private var doneButton: some View {
        Button("Done") {
            focusedField = false
            helpers.onDone(username, firstName, lastName, avatar)
        }
        .padding(5)
        .buttonStyle(.borderedProminent)
        .disabled(!helpers.ableToDone(username, firstName, lastName))
    }
    
    private var imagePicker: some View {
        ImagePicker { image in
            avatar = image
        }
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
