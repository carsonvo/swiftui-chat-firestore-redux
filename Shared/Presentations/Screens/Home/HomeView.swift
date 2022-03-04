//
//  HomeView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject private var profileState: ProfileState
    @EnvironmentObject private var chatState: ChatState
    @State private var chatLogToggle = false

    let helpers = Helpers()
    
    var body: some View {
        NavigationView {
            ZStack {
                if chatState.chats.isEmpty {
                    emptyText
                } else {
                    chatList
                }
            }
            .navigationTitle("Chats")
            .navigationBarItems(leading: settingButton, trailing: buttonAdd)
            .onAppear {
                helpers.disableAutoTransparentNavbar()
                helpers.startListenChats(profileState.profile?.id)
            }
        }
        .navigationViewStyle(.stack)
    }
    
    var chatList: some View {
        List {
            ForEach(helpers.buildChatViewModels(chatState.chats)) { chat in
                NavigationLink {
                    chatLogsView(chatId: chat.id)
                } label: {
                    ChatRowView(chat: chat)
                }
            }
        }
        .listStyle(.plain)
    }
    
    var emptyText: some View {
        VStack {
            Spacer()
            Text("There is no chat.")
            Spacer()
            Spacer()
        }
    }
    
    var buttonAdd: some View {
        NavigationLink {
            addNewUserView
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.accentColor)
        }
    }
    
    var settingButton: some View {
        Menu {
            Button(action: helpers.signOut) {
                Text("Log out")
            }
        } label: {
            Image(systemName: "gear")
                .foregroundColor(.accentColor)
        }
    }
    
    var addNewUserView: some View {
        AddNewChatView()
    }
    
    @ViewBuilder
    func chatLogsView(chatId: String?) -> some View {
        if let id = chatId {
            ChatLogsView(chatId: id)
        }
    }
}
