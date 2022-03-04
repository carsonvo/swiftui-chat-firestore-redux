//
//  ViewExtension.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 03/03/2022.
//

import Foundation
import SwiftUI

extension View {
    func reversed() -> some View {
        self.scaleEffect(x: 1, y: -1, anchor: .center)
    }
}
