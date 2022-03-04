//
//  ErrorReducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import SwiftUI

let errorReducer: Reducer<ErrorState, ErrorAction> = .init { state, action in
    switch action {
    case .setError(let error):
        await MainActor.run { state.error = error }
    }
}
