//
//  Profile.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Profile: BaseModel {
    @DocumentID var id: String?
    let email: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    let avatarPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case firstName
        case lastName
        case avatarPath
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if let email = email {
            try container.encode(email, forKey: .email)
        }
        if let username = username {
            try container.encode(username, forKey: .username)
        }
        if let firstName = firstName {
            try container.encode(firstName, forKey: .firstName)
        }
        if let lastName = lastName {
            try container.encode(lastName, forKey: .lastName)
        }
        if let avatarPath = avatarPath {
            try container.encode(avatarPath, forKey: .avatarPath)
        }
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try? values.decode(DocumentID<String>.self, forKey: .id) {
            _id = id
        } else {
            id = try values.decode(String.self, forKey: .id)
        }
        email = try? values.decode(String.self, forKey: .email)
        username = try? values.decode(String.self, forKey: .username)
        firstName = try? values.decode(String.self, forKey: .firstName)
        lastName = try? values.decode(String.self, forKey: .lastName)
        avatarPath = try? values.decode(String.self, forKey: .avatarPath)
    }

    init(id: String?, email: String?, username: String?, firstName: String?, lastName: String?, avatarPath: String?) {
        self.id = id
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.avatarPath = avatarPath
    }
    
    var fullName: String {
        if let firstName = firstName, let lastName = lastName {
            return "\(firstName) \(lastName)"
        } else if let firstName = firstName {
            return firstName
        } else {
            return lastName ?? ""
        }
    }
}
