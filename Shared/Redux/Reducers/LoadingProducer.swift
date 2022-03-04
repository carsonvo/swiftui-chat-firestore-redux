//
//  LoadingProducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation

let loadingReducer: Reducer<LoadingState, LoadingAction> = Reducer { state, action in
    switch action {
    case .setLoading(let isloading):
        await MainActor.run { state.isLoading = isloading }
    }
}
