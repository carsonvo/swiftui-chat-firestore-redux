//
//  ChatApp.swift
//  Shared
//
//  Created by Vo Thanh on 14/02/2022.
//

import SwiftUI
import Firebase

@main

struct ChatApp: App {
    let appStore = configApp()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appStore.profileState)
                .environmentObject(appStore.loadingState)
                .environmentObject(appStore.errorState)
                .environmentObject(appStore.chatState)
                .environmentObject(appStore.messagesState)
                .environmentObject(appStore.profileResultState)
        }
    }
}

func configApp() -> AppStore {
    FirebaseApp.configure()
    return AppStore()
}
