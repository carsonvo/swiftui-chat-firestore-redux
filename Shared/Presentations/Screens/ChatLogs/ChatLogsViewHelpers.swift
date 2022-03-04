//
//  ChatLogsHelpers.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 01/03/2022.
//

import Foundation
import FirebaseFirestore
import UIKit

extension ChatLogsView {
    struct Helpers {
        func sendMessage(fromUser: Profile?, currentChat: Chat?, text: String) {
            guard let fromUser = fromUser, let currentChat = currentChat, let chatId = currentChat.id else {
                return
            }

            let message = Message(
                id: nil,
                text: text,
                time: Timestamp(),
                contentType: .text,
                fromId: fromUser.id,
                toId: currentChat.toUser.id
            )
            Subscriber.dispatch(action: MessagesAction.sendMessage(fromUser: fromUser, toUser: currentChat.toUser, chatId: chatId, message: message))
        }
        
        func sendPhoto(fromUser: Profile?, currentChat: Chat?, photo: UIImage) {
            guard let fromUser = fromUser, let currentChat = currentChat, let chatId = currentChat.id else {
                return
            }
            Subscriber.dispatch(action: MessagesAction.sendPhoto(fromUser: fromUser, toUser: currentChat.toUser, chatId: chatId, photo: photo))
        }
        
        func listenChatRoom(chatId: String, limit: Int) {
            Subscriber.dispatch(action: MessagesAction.listenChatRoom(chatId: chatId, limit: limit))
        }
        
        func leaveRoom() {
            Subscriber.dispatch(action: MessagesAction.leaveRoom)
        }
        
        func loadMoreMessage(chatId: String, fromTime: Timestamp, limit: Int) {
            Subscriber.dispatch(action: MessagesAction.loadMoreMessage(chatId: chatId, fromTime: fromTime, limit: limit))
        }
    }
}
