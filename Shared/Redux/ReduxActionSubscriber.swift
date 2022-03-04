//
//  ReduxActionSubscriber.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 22/02/2022.
//

import Foundation

protocol ReduxActionSubscriber {
    func notify(_ action: ReduxAction) async
}

struct Subscriber {
    static var item: ReduxActionSubscriber?
    
    static func dispatch(action: ReduxAction) {
        Task {
            await item?.notify(action)
        }
    }
}
