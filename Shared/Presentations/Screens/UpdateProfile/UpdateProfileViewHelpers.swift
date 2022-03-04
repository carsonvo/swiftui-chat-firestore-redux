//
//  UpdateProfileViewHelpers.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import UIKit

extension UpdateProfileView {
    struct Helpers {
        func ableToDone(_ username: String, _ firstName: String, _ lastName: String) -> Bool {
            !username.isEmpty && !firstName.isEmpty && !lastName.isEmpty
        }
        
        func onDone(_ username: String, _ firstName: String, _ lastName: String, _ avatar: UIImage?) {
            if let avatar = avatar {
                Subscriber.dispatch(action: ProfileAction.updateProfileWithAvatar(username, firstName, lastName, avatar))
            } else {
                Subscriber.dispatch(action: ProfileAction.updateProfile(username, firstName, lastName))
            }
        }
    }
}
