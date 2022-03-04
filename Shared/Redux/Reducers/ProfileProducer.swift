//
//  ProfileProducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 22/02/2022.
//

import Foundation

let profileReducer: Reducer<ProfileState, ProfileAction> = .init { state, action in
    switch action {
    case .signIn(let email, let password):
        Subscriber.dispatch(action: LoadingAction.setLoading(true))
        do {
            let id = try await FirebaseAuthentication.shared.signIn(email, password)
            let profile = try await FirebaseFirestore.shared.getUser(profileId: id)
            if let profile = profile {
                KeychainService.shared.profile = profile
                await MainActor.run { state.profile = profile }
            } else {
                let profile = Profile(id: id, email: email, username: nil, firstName: nil, lastName: nil, avatarPath: nil)
                KeychainService.shared.profile = profile
                await MainActor.run { state.profile = profile }
            }
        } catch {
            if let error = error as? ErrorType {
                Subscriber.dispatch(action: ErrorAction.setError(error))
            }
        }
        Subscriber.dispatch(action: LoadingAction.setLoading(false))
        
    case .signUp(let email, let password):
        Subscriber.dispatch(action: LoadingAction.setLoading(true))
        do {
            let profile = try await FirebaseAuthentication.shared.createUser(email, password)
            try await FirebaseFirestore.shared.updateProfile(profile)
            KeychainService.shared.profile = profile
            await MainActor.run { state.profile = profile }
        } catch {
            if let error = error as? ErrorType {
                Subscriber.dispatch(action: ErrorAction.setError(error))
            }
        }
        Subscriber.dispatch(action: LoadingAction.setLoading(false))

    case .setProfile(let profile):
        await MainActor.run { state.profile = profile }
        
    case .updateProfile(let username, let firstName, let lastName):
        Subscriber.dispatch(action: LoadingAction.setLoading(true))
        do {
            let exist = try await FirebaseFirestore.shared.detectUsernameExist(username.lowercased())
            if !exist, let profile = state.profile {
                let new = Profile(
                    id: profile.id,
                    email: profile.email,
                    username: username.lowercased(),
                    firstName: firstName,
                    lastName: lastName,
                    avatarPath: nil
                )
                try await FirebaseFirestore.shared.updateProfile(new)
                KeychainService.shared.profile = new
                await MainActor.run { state.profile = new }
            } else {
                Subscriber.dispatch(action: ErrorAction.setError(.usernameExist))
            }
        } catch {
            if let error = error as? ErrorType {
                Subscriber.dispatch(action: ErrorAction.setError(error))
            }
        }
        Subscriber.dispatch(action: LoadingAction.setLoading(false))
        
    case .updateProfileWithAvatar(let username, let firstName, let lastName, let avatar):
        Subscriber.dispatch(action: LoadingAction.setLoading(true))
        do {
            let exist = try await FirebaseFirestore.shared.detectUsernameExist(username.lowercased())
            if !exist, let profile = state.profile {
                let path = try await FirebaseStorage.shared.uploadAvatar(username.lowercased(), avatar)
                let new = Profile(
                    id: profile.id,
                    email: profile.email,
                    username: username.lowercased(),
                    firstName: firstName,
                    lastName: lastName,
                    avatarPath: path
                )
                try await FirebaseFirestore.shared.updateProfile(new)
                KeychainService.shared.profile = new
                await MainActor.run { state.profile = new }
            } else {
                Subscriber.dispatch(action: ErrorAction.setError(.usernameExist))
            }
        } catch {
            if let error = error as? ErrorType {
                Subscriber.dispatch(action: ErrorAction.setError(error))
            }
        }
        Subscriber.dispatch(action: LoadingAction.setLoading(false))
        
    case .signOut:
        KeychainService.shared.removeAll()
        FirebaseAuthentication.shared.signOut()
        await MainActor.run { state.profile = nil }
        break
    }
}
