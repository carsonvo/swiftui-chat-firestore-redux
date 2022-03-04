//
//  ChatLogsView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 26/02/2022.
//

import SwiftUI

struct ChatLogsView: View {
    @EnvironmentObject private var profileState: ProfileState
    @EnvironmentObject private var chatState: ChatState
    @EnvironmentObject private var messagesState: MessagesState
    @FocusState private var focusedField: Bool
    @State private var text = ""
    @State private var imagePickerToggle = false
    
    let chatId: String
    let helpers = Helpers()
    
    var body: some View {
        VStack {
            scrollView
            inputField
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
               toUserInfo
            }
        }
        .onDisappear{
            helpers.leaveRoom()
        }
        .onAppear {
            helpers.listenChatRoom(chatId: chatId, limit: AppConstant.limitToLoadMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $imagePickerToggle) {
            imagePicker
        }
    }
    
    var scrollView: some View {
        ScrollView {
            LazyVStack {
                ForEach((messagesState.messagesDict[chatId] ?? []).reversed()) { message in
                    Bubble(
                        text: message.text,
                        time: message.time?.toTime(),
                        contentType: message.contentType,
                        alignment: profileState.profile?.id == message.fromId ? .trailing : .leading
                    )
                        .reversed()
                        .onAppear {
                            if let time = message.time,
                               message == messagesState.messagesDict[chatId]?.first,
                               messagesState.ableToloadMore,
                               !messagesState.isLoadingMessages
                            {
                                helpers.loadMoreMessage(chatId: chatId, fromTime: time, limit: AppConstant.limitToLoadMessage)
                            }
                        }
                }
            }
            loadingIndicator
        }
        .reversed()
        .onTapGesture {
            focusedField = false
        }
    }
    
    var inputField: some View {
        ChatLogField(
            text: $text,
            focusedField: $focusedField,
            onSend: {
                if !text.isEmpty {
                    helpers.sendMessage(
                        fromUser: profileState.profile,
                        currentChat: chatState.chats.first(where: {$0.id == chatId}),
                        text: text
                    )
                    text = ""
                }
            },
            onPhoto: {
                imagePickerToggle.toggle()
            },
            onCamera: {
                
            }
        )
    }
    
    @ViewBuilder
    var toUserInfo: some View {
        if let toUser = chatState.chats.first(where: {$0.id == chatId})?.toUser {
            HStack {
                ImageFBUILoader(
                    imagePath: toUser.avatarPath ?? "",
                    size: .init(width: 40, height: 40)
                )
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                VStack(alignment: .leading) {
                    Text(toUser.fullName)
                        .font(.callout)
                    Text("@\(toUser.username ?? "")")
                        .font(.footnote)
                }
            }
        }
    }
    
    @ViewBuilder
    var loadingIndicator: some View {
        if messagesState.ableToloadMore {
            ProgressView()
        }
    }
    
    var imagePicker: some View {
        ImagePicker { uiImage in
            if let uiImage = uiImage {
                helpers.sendPhoto(
                    fromUser: profileState.profile,
                    currentChat: chatState.chats.first(where: {$0.id == chatId}),
                    photo: uiImage
                )
            }
        }
    }
}
