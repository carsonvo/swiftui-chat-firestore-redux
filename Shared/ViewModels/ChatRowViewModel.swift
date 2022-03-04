//
//  ChatRowViewModel.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 01/03/2022.
//

import Foundation
import FirebaseFirestore

struct ChatRowViewModel: Identifiable {
    let id: String?
    let avatarPath: String?
    let fullName: String?
    let time: Timestamp?
    let text: String?
    let contentType: MessageContentType?
}
