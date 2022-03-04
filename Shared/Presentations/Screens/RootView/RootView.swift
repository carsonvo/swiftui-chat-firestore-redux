//
//  RootView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import SwiftUI

struct RootView: View {
    @EnvironmentObject private var profileState: ProfileState
    @EnvironmentObject private var loadingState: LoadingState
    @EnvironmentObject private var errorState: ErrorState
    @EnvironmentObject private var chatState: ChatState
    @EnvironmentObject private var messagesState: MessagesState
    @EnvironmentObject private var profileResultState: ProfileResultState
    
    @State private var errorToggle = false
    
    let helpers = Helpers()
    
    var body: some View {
        ZStack {
            contentView
            loadingView()
        }
        .alert(isPresented: $errorToggle) {
            alert(error: errorState.error.localizedDescription)
        }
        .onChange(of: errorState.error) { newValue in
            errorToggle = newValue != .none
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        if let profile = profileState.profile {
            if profile.username != nil {
                homeView()
            } else {
                updateProfileView()
            }
        } else {
            loginView()
        }
    }
    
    private func loginView() -> some View {
        LogInView()
    }
    
    private func homeView() -> some View {
        HomeView()
            .environmentObject(profileState)
            .environmentObject(chatState)
            .environmentObject(messagesState)
            .environmentObject(profileResultState)
    }
    
    private func updateProfileView() -> some View {
        UpdateProfileView()
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        if loadingState.isLoading {
            ProgressView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color.black.opacity(0.3))
                .foregroundColor(.white)
                .ignoresSafeArea(.all)
                .progressViewStyle(.circular)
        }
    }
    
    private func alert(error: String) -> Alert {
        Alert(
            title: Text(error),
            message: nil,
            dismissButton: .cancel(Text("OK"), action: {
                helpers.closeError()
            })
        )
    }
}
