//
//  ChatRowView.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 24/02/2022.
//

import SwiftUI

struct ChatRowView: View {
    let chat: ChatRowViewModel
    
    var body: some View {
        HStack {
            avatar
            VStack(alignment: .leading) {
                fullName
                content
            }
            Spacer()
            time
        }
    }
    
    var avatar: some View {
        ImageFBUILoader(
            imagePath: chat.avatarPath ?? "",
            size: .init(width: 50, height: 50)
        )
            .frame(width: 50, height: 50)
            .cornerRadius(25)
    }
    
    var fullName: some View {
        Text(chat.fullName ?? "")
            .font(.headline)
    }
    
    @ViewBuilder
    var content: some View {
        if let contentType = chat.contentType {
            switch contentType {
            case .text:
                Text(chat.text ?? "")
                    .font(.body)
                    .lineLimit(1)
            case .image:
                Image(systemName: "photo")
            }
        }
    }
    
    var time: some View {
        Text(chat.time?.toTime() ?? "")
            .font(.footnote)
            .padding(5)
    }
}

struct ChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRowView(chat: .init(id: UUID().uuidString, avatarPath: nil, fullName: "", time: .init(date: Date()), text: "aaaaa", contentType: .image))
    }
}
