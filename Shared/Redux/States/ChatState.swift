//
//  ChatState.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import FirebaseFirestore

class ChatState: ReduxState {
    @Published var chats: [Chat] = []
}
