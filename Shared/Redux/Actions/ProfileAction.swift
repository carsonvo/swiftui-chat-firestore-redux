//
//  ProfileAction.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 22/02/2022.
//

import Foundation
import UIKit

enum ProfileAction: ReduxAction {
    case signIn(_ email: String, _ password: String)
    case signUp(_ email: String, _ password: String)
    case signOut
    case setProfile(_ profile: Profile)
    case updateProfile(_ username: String, _ firstName: String, _ lastName: String)
    case updateProfileWithAvatar(_ username: String, _ firstName: String, _ lastName: String, _ avatar: UIImage)
}
