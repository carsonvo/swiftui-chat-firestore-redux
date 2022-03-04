//
//  ChatAction.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation

enum ChatAction: ReduxAction {
    case addNew(_ user: Profile, _ toUser: Profile, _ completed: (_ chatId: String?) -> ())
    case listenChats(_ userId: String)
}
