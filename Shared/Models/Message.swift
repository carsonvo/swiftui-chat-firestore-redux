//
//  Message.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 26/02/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: BaseModel {
    @DocumentID var id: String?
    let text: String?
    let time: Timestamp?
    let contentType: MessageContentType?
    let fromId: String?
    let toId: String?
}


enum MessageContentType: Int, Codable {
    case text = 0
    case image
}
