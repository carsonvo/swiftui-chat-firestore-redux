//
//  ErrorState.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation

class ErrorState: ReduxState {
    @Published var error = ErrorType.none
}

enum ErrorType: Error {
    case none
    case accountNotExist
    case cannotCreateAccount
    case usernameExist
    case emailExist
    case usernameNotfound
    case failedToCheckEmailExist
    case faliedToUpdateProfile
    case failedToGetProfile
    case failedToDetectUsernameExist
    case failedToUploadImage
    case failedToGetChat
    case failedToAddNewChat
    
    var localizedDescription: String {
        switch self {
        case .none:
            return ""
        case .accountNotExist:
            return "The email address or password is incorrect."
        case .cannotCreateAccount:
            return "Failed to create an account."
        case .usernameExist:
            return "Username does exist."
        case .emailExist:
            return "Email does exist."
        case .usernameNotfound:
            return "Username not found."
        case .failedToCheckEmailExist:
            return "Cannot check the email exist."
        case .faliedToUpdateProfile:
            return "Failed to update the profile."
        case .failedToGetProfile:
            return "Cannot get user's profile."
        case .failedToDetectUsernameExist:
            return "Failed to detect username exist."
        case .failedToUploadImage:
            return "Failed to upload image."
        case .failedToGetChat:
            return "Failed to get chat."
        case .failedToAddNewChat:
            return "Failed to add new chat."
        }
    }
}
