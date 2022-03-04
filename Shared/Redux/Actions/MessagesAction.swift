//
//  MessagesAction.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 26/02/2022.
//

import Foundation
import FirebaseFirestore
import UIKit

enum MessagesAction: ReduxAction {
    case sendMessage(fromUser: Profile, toUser: Profile, chatId: String, message: Message)
    case sendPhoto(fromUser: Profile, toUser: Profile, chatId: String, photo: UIImage)
    case listenChatRoom(chatId: String, limit: Int)
    case leaveRoom
    case loadMoreMessage(chatId: String, fromTime: Timestamp, limit: Int)
}
