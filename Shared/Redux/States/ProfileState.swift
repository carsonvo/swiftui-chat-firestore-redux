//
//  ProfileState.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 19/02/2022.
//

import Foundation
import SwiftUI

class ProfileState: ReduxState {
    @Published var profile: Profile?
    
    init() {
        self.profile = KeychainService.shared.profile
    }
}
