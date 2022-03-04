//
//  MessagesState.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 26/02/2022.
//

import Foundation

class MessagesState: ReduxState {
    @Published var messagesDict: [String: [Message]] = [:]
    @Published var ableToloadMore = true
    @Published var isLoadingMessages = false
}
