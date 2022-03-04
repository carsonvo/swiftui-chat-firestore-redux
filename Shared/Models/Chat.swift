//
//  Chat.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: BaseModel {
    @DocumentID var id: String?
    let text: String?
    let time: Timestamp?
    let toUser: Profile
    let contentType: MessageContentType?
    
    init(toUser: Profile) {
        self.id = nil
        self.toUser = toUser
        self.text = nil
        self.time = nil
        self.contentType = nil
    }
    
    init(message: Message, toUser: Profile) {
        self.id = nil
        self.toUser = toUser
        self.text = message.text
        self.time = message.time
        self.contentType = message.contentType
    }
}
