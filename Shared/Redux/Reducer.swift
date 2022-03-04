//
//  Reducer.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 22/02/2022.
//

import Foundation

struct Reducer<State: ReduxState, Action: ReduxAction> {
   let reduce: (State, Action) async -> ()
}
