//
//  AppStore.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 22/02/2022.
//

import Foundation

class AppStore: ReduxActionSubscriber {

    private (set) var profileState: ProfileState
    private (set) var loadingState: LoadingState
    private (set) var errorState: ErrorState
    private (set) var chatState: ChatState
    private (set) var messagesState: MessagesState
    private (set) var profileResultState: ProfileResultState
    
    init() {
        self.profileState = ProfileState()
        self.loadingState = LoadingState()
        self.errorState = ErrorState()
        self.chatState = ChatState()
        self.messagesState = MessagesState()
        self.profileResultState = ProfileResultState()
        Subscriber.item = self
    }

    func notify(_ action: ReduxAction) async {
        if let action = action as? ProfileAction {
            await profileReducer.reduce(profileState, action)
        }
        
        if let action = action as? LoadingAction {
            await loadingReducer.reduce(loadingState, action)
        }
        
        if let action = action as? ErrorAction {
            await errorReducer.reduce(errorState, action)
        }
        
        if let action = action as? ChatAction {
            await chatReducer.reduce(chatState, action)
        }
        
        if let action = action as? MessagesAction {
            await messagesReducer.reduce(messagesState, action)
        }
        
        if let action = action as? ProfileResultAction {
            await profileResultReducer.reduce(profileResultState, action)
        }
    }
}
