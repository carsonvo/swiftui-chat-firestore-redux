//
//  DateExtension.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 03/03/2022.
//

import Foundation

extension Date {
    func toTime() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
                
        if calendar.isDateInToday(self) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "MMM dd, yyyy 'at' HH:mm"
            return dateFormatter.string(from: self)
        }
    }
}
