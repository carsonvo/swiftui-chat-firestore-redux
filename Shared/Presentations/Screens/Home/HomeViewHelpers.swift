//
//  HomeViewHelpers.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 24/02/2022.
//

import Foundation
import SwiftUI

extension HomeView {
    struct Helpers {
        func buildChatViewModels(_ chats: [Chat]) -> [ChatRowViewModel] {
            chats.map{
                (
                    .init(
                        id: $0.id,
                        avatarPath: $0.toUser.avatarPath,
                        fullName: $0.toUser.fullName,
                        time: $0.time,
                        text: $0.text,
                        contentType: $0.contentType
                    )
                )
            }
        }
        
        func startListenChats(_ userId: String?) {
            guard let userId = userId else {
                return
            }
            Subscriber.dispatch(action: ChatAction.listenChats(userId))
        }
        
        func signOut() {
            Subscriber.dispatch(action: ProfileAction.signOut)
        }
        
        func disableAutoTransparentNavbar() {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}
