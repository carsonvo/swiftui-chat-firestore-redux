//
//  AddNewChatView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 24/02/2022.
//

import SwiftUI

struct AddNewChatView: View {
    
    @EnvironmentObject private var profileState: ProfileState
    @EnvironmentObject private var profileResultState: ProfileResultState
    @FocusState private var focusedField: Bool
    @State private var username = ""
    @State private var chatLogsToggle: (isActive: Bool, chatId: String?) = (false, nil)
    
    let helpers = Helpers()
    
    var body: some View {
        VStack {
            HStack {
                textField
                findingButton
            }
            if let profile = profileResultState.searchResult {
                resultView(profile)
            }
            Spacer()
            chatLogsViewLink()
        }
        .padding()
        .navigationTitle("New Chat")
    }
    
    var textField: some View {
        TextField("Username", text: $username)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField)
    }
    
    var findingButton: some View {
        Button("Find") {
            focusedField = false
            helpers.search(username)
        }
        .padding(5)
        .buttonStyle(.borderedProminent)
    }
    
    private func avatar(_ path: String) -> some View {
        ImageFBUILoader(
            imagePath: path,
            size: .init(width: 100, height: 100)
        )
            .frame(width: 100, height: 100)
            .cornerRadius(50)
    }
    
    @ViewBuilder
    private func nameText(_ profile: Profile) -> some View {
        if profile.id == profileState.profile?.id {
            Text("You")
        } else {
            Text(profile.fullName)
        }
    }
    
    private func userNameText(_ profile: Profile) -> some View {
        Text("@\(profile.username ?? "")")
    }
    
    @ViewBuilder
    private func chatNowButton(_ profile: Profile) -> some View {
        if let user = profileState.profile, profile.id != user.id {
            Button("Chat Now") {
                helpers.addNew(user, profile) { chatId in
                    if let chatId = chatId {
                        chatLogsToggle = (true, chatId)
                    }
                }
            }
        }
    }
    
    private func resultView(_ profile: Profile) -> some View {
        VStack {
            avatar(profile.avatarPath ?? "")
            nameText(profile)
            userNameText(profile)
            chatNowButton(profile)
        }
    }
    
    @ViewBuilder
    private func chatLogsViewLink() -> some View {
        if let chatId = chatLogsToggle.chatId {
            NavigationLink(isActive: $chatLogsToggle.isActive) {
                ChatLogsView(chatId: chatId)
            } label: {}
        }
    }
}

struct AddNewChatView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewChatView()
    }
}
