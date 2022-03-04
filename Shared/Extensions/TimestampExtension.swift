//
//  TimestampExtension.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 03/03/2022.
//

import Foundation
import FirebaseFirestore

extension Timestamp {
    func toTime() -> String {
        dateValue().toTime()
    }
}
