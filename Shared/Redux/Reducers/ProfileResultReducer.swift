//
//  ProfileResultReducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 28/02/2022.
//

import Foundation

let profileResultReducer: Reducer<ProfileResultState, ProfileResultAction> = .init { state, action in
    switch action {
    case .clear:
        await MainActor.run { state.searchResult = nil }
    case .search(let username):
        Subscriber.dispatch(action: LoadingAction.setLoading(true))
        do {
            let profile = try await FirebaseFirestore.shared.getUser(username: username.lowercased())
            await MainActor.run { state.searchResult = profile }
        } catch {
            if let error = error as? ErrorType {
                Subscriber.dispatch(action: ErrorAction.setError(error))
                Subscriber.dispatch(action: ProfileResultAction.clear)
            }
        }
        Subscriber.dispatch(action: LoadingAction.setLoading(false))
    }
}
