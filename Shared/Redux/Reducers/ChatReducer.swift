//
//  ChatReducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation

let chatReducer: Reducer<ChatState, ChatAction> = .init { state, action in
    switch action {
    case .addNew(let user, let toUser, let completed):
        Subscriber.dispatch(action: LoadingAction.setLoading(true))
        do {
            let chat = state.chats.first(where: { $0.toUser.id == toUser.id })
            if let chat = chat {
                completed(chat.id)
            } else {
                let chat = try? await FirebaseFirestore.shared.getChatBetweenUsers(user, toUser)
                if let chat = chat {
                    completed(chat.id)
                } else {
                    let chat = try await FirebaseFirestore.shared.addNewChat(user, toUser)
                    completed(chat.id)
                }
            }
        } catch {
            if let error = error as? ErrorType {
                Subscriber.dispatch(action: ErrorAction.setError(error))
            }
        }
        Subscriber.dispatch(action: LoadingAction.setLoading(false))
        
    case .listenChats(let userId):
        if FirebaseFirestore.shared.isListeningChats { return }
        FirebaseFirestore.shared.listenChats(userId) { newChats in
            DispatchQueue.main.async {
                var chats = state.chats
                for chat in newChats {
                    if let index = chats.firstIndex(where: { chat.id == $0.id }) {
                        chats[index] = chat
                    } else {
                        chats.append(chat)
                    }
                }
                state.chats = chats.sorted(by: {
                    $0.time?.dateValue() ?? .init() > $1.time?.dateValue() ?? .init()
                })
            }
        }
    }
}
