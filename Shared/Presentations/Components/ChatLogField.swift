//
//  ChatLogField.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 26/02/2022.
//

import SwiftUI

struct ChatLogField: View {
    
    let text: Binding<String>
    let focusedField: FocusState<Bool>.Binding
    let onSend: () -> ()
    let onPhoto: () -> ()
    let onCamera: () -> ()
    
    var body: some View {
        HStack {
            paperClipButton
            textField
            sendingButton
        }
        .frame(height: 40)
        .border(Color.accentColor, width: 0.5)
    }
    
    var paperClipButton: some View {
        Menu {
            Button(action: onCamera) {
                Label("Camera", systemImage: "camera.on.rectangle")
            }
            Button(action: onPhoto) {
                Label("Photo", systemImage: "photo.on.rectangle")
            }
        } label: {
            Image(systemName: "paperclip.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
        }
        .padding(.horizontal)
    }
    
    var sendingButton: some View {
        Button(action: onSend) {
            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
        }
        .padding(.horizontal)
    }
    
    var textField: some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text("Enter a message")
                .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
            }
            TextEditor(text: text)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .opacity(text.wrappedValue.isEmpty ? 0.25 : 1)
                .focused(focusedField)
        }
    }
}
