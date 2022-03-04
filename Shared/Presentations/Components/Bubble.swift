//
//  BubbleText.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 03/03/2022.
//

import SwiftUI

struct Bubble: View {
    let text: String?
    let time: String?
    let contentType: MessageContentType?
    let alignment: HorizontalAlignment
    
    var body: some View {
        HStack {
            if alignment == .trailing {
                Spacer()
                    .frame(minWidth: UIScreen.main.bounds.width/3)
            }
            content
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
                .padding(.vertical, 2)
                .padding(.horizontal, 10)
                .scaledToFit()
                .layoutPriority(1)
            if alignment == .leading {
                Spacer()
                    .frame(minWidth: UIScreen.main.bounds.width/3)
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        if let contentType = contentType {
            switch contentType {
            case .text:
                textView(text ?? "", time ?? "", alignment)
            case .image:
                imageView(text, time ?? "", alignment)
            }
        }
    }
    
    @ViewBuilder
    func textView(_ text: String, _ time: String, _ alignment: HorizontalAlignment) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(text)
                .foregroundColor(alignment == .leading ? .accentColor : .white)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Color.clear
                    .frame(height: 0)
                Text(time)
                    .font(.footnote)
                    .foregroundColor(alignment == .leading ? .accentColor : .white)
                    .fixedSize()
            }
        }
        .padding(5)
        .background(alignment == .leading ? Color.clear : Color.accentColor)
    }
    
    func imageView(_ imagePath: String?, _ time: String, _ alignment: HorizontalAlignment) -> some View {
        ZStack(alignment: .bottomTrailing) {
            if let imagePath = imagePath {
                ImageFBUILoader(
                    imagePath: imagePath,
                    placeHolder: UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal),
                    size: .init(width: 200, height: 150)
                )
            } else {
                ProgressView()
                    .frame(width: 200, height: 150)
            }
            Text(time)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(5)
        }
        .frame(width: 200, height: 150)
    }
}
