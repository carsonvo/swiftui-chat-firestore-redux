//
//  AddNewChatViewHelper.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 28/02/2022.
//

import Foundation

extension AddNewChatView {
    struct Helpers {
        func search(_ username: String) {
            Subscriber.dispatch(action: ProfileResultAction.search(username))
        }
        
        func addNew(_ user: Profile, _ toUser: Profile, completed: @escaping (_ chatId: String?) -> ()) {
            Subscriber.dispatch(action: ChatAction.addNew(user, toUser, completed))
        }
    }
}
