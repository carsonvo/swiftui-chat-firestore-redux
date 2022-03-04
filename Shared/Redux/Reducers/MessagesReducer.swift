//
//  MessagesReducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 26/02/2022.
//

import Foundation

let messagesReducer: Reducer<MessagesState, MessagesAction> = .init { state, action in
    switch action {
    case .sendMessage(let fromUser, let toUser, let chatId, let message):
        FirebaseFirestore.shared.sendMessage(fromUser, toUser, message, chatId)
        
    case .sendPhoto(let fromUser, let toUser, let chatId, let photo):
        await FirebaseFirestore.shared.sendPhoto(fromUser, toUser, photo, chatId)
        
    case .listenChatRoom(let chatId, let limit):
        if FirebaseFirestore.shared.isListeningChatRoom { return }
        FirebaseFirestore.shared.listenChatRoom(chatId, limit) { newMessages in
            DispatchQueue.main.async {
                var messages = state.messagesDict[chatId] ?? []
                for message in newMessages {
                    if let index = messages.firstIndex(where: { message.id == $0.id }) {
                        messages[index] = message
                    } else {
                        messages.append(message)
                    }
                }
                state.messagesDict[chatId] = messages
                if newMessages.isEmpty {
                    state.ableToloadMore = false
                }
            }
        }
        
    case .leaveRoom:
        FirebaseFirestore.shared.removeChatRoomListen()
        DispatchQueue.main.async {
            state.isLoadingMessages = false
            state.ableToloadMore = true
        }
        
    case .loadMoreMessage(let chatId, let fromTime, let limit):
        DispatchQueue.main.async {
            state.isLoadingMessages = true
        }
        FirebaseFirestore.shared.loadMoreMessages(chatId, fromTime: fromTime, limit) { oldMessages in
            DispatchQueue.main.async {
                var messages = state.messagesDict[chatId] ?? []
                for message in oldMessages {
                    if let index = messages.firstIndex(where: { message.id == $0.id }) {
                        messages[index] = message
                    } else {
                        messages.insert(message, at: 0)
                    }
                }
                state.messagesDict[chatId] = messages
                state.isLoadingMessages = false
                state.ableToloadMore = oldMessages.count >= AppConstant.limitToLoadMessage
            }
        }
    }
}
