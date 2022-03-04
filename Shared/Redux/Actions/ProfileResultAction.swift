//
//  File.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 28/02/2022.
//

import Foundation

enum ProfileResultAction: ReduxAction {
    case clear
    case search(_ username: String)
}
