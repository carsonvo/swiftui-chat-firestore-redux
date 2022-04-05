//
//  FirebaseFirestore.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 23/02/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

class FirebaseFirestore {
    static let shared = FirebaseFirestore()
    let db = Firestore.firestore()
    private var chatsListener: ListenerRegistration?
    private var chatRoomListener: ListenerRegistration?
    
    var isListeningChats: Bool {
        chatsListener != nil
    }
    
    var isListeningChatRoom: Bool {
        chatRoomListener != nil
    }
    
    func updateProfile(_ profile: Profile) async throws {
        guard let id = profile.id else {
            throw ErrorType.faliedToUpdateProfile
        }
        do {
            try db.collection(key.users.rawValue)
                .document(id)
                .setData(from: profile)
        } catch {
            throw ErrorType.faliedToUpdateProfile
        }
    }
    
    func getUser(profileId: String) async throws -> Profile? {
        do {
            let document = try await db
                .collection(key.users.rawValue)
                .document(profileId)
                .getDocument()
            if document.exists {
                let result = Result { try document.data(as: Profile.self) }
                switch result {
                case .success(let profile):
                    return profile
                case .failure(_):
                   break
                }
            }
            return nil
        } catch {
            throw ErrorType.failedToGetProfile
        }
    }
    
    func getUser(username: String) async throws -> Profile {
        do {
            let query = try await db
                .collection(key.users.rawValue)
                .whereField(key.username.rawValue, isEqualTo: username)
                .limit(to: 1).getDocuments()
            if let document = query.documents.first {
                let result = Result { try document.data(as: Profile.self) }
                switch result {
                case .success(let profile):
                    return profile
                case .failure(_):
                   break
                }
            }
            throw ErrorType.usernameNotfound
        } catch {
            throw ErrorType.usernameNotfound
        }
    }
    
    func detectUsernameExist(_ username: String) async throws -> Bool {
        do {
            let query = try await db
                .collection(key.users.rawValue)
                .whereField(key.username.rawValue, isEqualTo: username)
                .limit(to: 1)
                .getDocuments()
            return query.documents.count > 0
        } catch {
            throw ErrorType.failedToDetectUsernameExist
        }
    }
    
    func getChatBetweenUsers(_ user: Profile, _ toUser: Profile) async throws -> Chat? {
        guard let userId = user.id, let toUserId = toUser.id else {
            throw ErrorType.failedToGetChat
        }
        do {
            let query = try await db
                .collection(key.chats.rawValue)
                .document(userId)
                .collection(key.chat.rawValue)
                .whereField("toUser.id", isEqualTo: toUserId)
                .limit(to: 1)
                .getDocuments()
            
            if let document = query.documents.first {
                let result = Result { try document.data(as: Chat.self) }
                switch result {
                case .success(let chat):
                    return chat
                case .failure(_):
                   break
                }
            }
            return nil
        } catch {
            throw ErrorType.failedToGetChat
        }
    }
    
    func addNewChat(_ user: Profile, _ toUser: Profile) async throws -> Chat {
        guard let userId = user.id else {
            throw ErrorType.failedToAddNewChat
        }
        var chat = Chat(toUser: toUser)
        do {
            let documentRef = try db
                .collection(key.chats.rawValue)
                .document(userId)
                .collection(key.chat.rawValue)
                .addDocument(from: chat)
            chat.id = documentRef.documentID
            return chat
        } catch {
            throw ErrorType.failedToAddNewChat
        }
    }
    
    func updateChat(chatId: String, fromUser: Profile, toUser: Profile, message: Message) {
        guard let fromUserId = fromUser.id else {
            return
        }
        let chat = Chat(message: message, toUser: toUser)
        do {
            let _ = try db
                .collection(key.chats.rawValue)
                .document(fromUserId)
                .collection(key.chat.rawValue)
                .document(chatId)
                .setData(from: chat)
        } catch {
            
        }
    }
    
    func listenChats(_ userId: String, _ completed: @escaping ([Chat]) -> ()) {
        chatsListener = db
            .collection(key.chats.rawValue)
            .document(userId)
            .collection(key.chat.rawValue)
            .addSnapshotListener({ query, error in
                guard let query = query else { return }
                do {
                    let chats = try query.documentChanges.compactMap{ try $0.document.data(as: Chat.self) }
                    completed(chats)
                } catch {
                    
                }
            })
    }
    
    func sendMessage(_ fromUser: Profile, _ toUser: Profile, _ message: Message, _ chatId: String) {
        do {
            let _ = try db
                .collection(key.messages.rawValue)
                .document(chatId)
                .collection(key.messages.rawValue)
                .addDocument(from: message)
            updateChat(chatId: chatId, fromUser: fromUser, toUser: toUser, message: message)
            updateChat(chatId: chatId, fromUser: toUser, toUser: fromUser, message: message)
        } catch {
            
        }
    }
    
    func sendPhoto(_ fromUser: Profile, _ toUser: Profile, _ photo: UIImage, _ chatId: String) async {
        do {
            let imagePath = "\(FirebaseStorage.Folder.chats.rawValue)/\(chatId)/\(UUID().uuidString).jpg"
            let message = Message(id: nil, text: nil, time: Timestamp(), contentType: .image, fromId: fromUser.id, toId: toUser.id)
            let documentRef = try db
                .collection(key.messages.rawValue)
                .document(chatId)
                .collection(key.messages.rawValue)
                .addDocument(from: message)
            let _ = try await FirebaseStorage.shared.uploadPhoto(imagePath, photo)
            let newMessage = Message(id: nil, text: imagePath, time: message.time, contentType: .image, fromId: fromUser.id, toId: toUser.id)
            updateChat(chatId: chatId, fromUser: fromUser, toUser: toUser, message: newMessage)
            updateChat(chatId: chatId, fromUser: toUser, toUser: fromUser, message: newMessage)
            updateMessageAfterUploadPhoto(fromUser, toUser, chatId, newMessage, documentRef.documentID)
        } catch {
            
        }
    }
    
    func updateMessageAfterUploadPhoto(_ fromUser: Profile, _ toUser: Profile, _ chatId: String, _ message: Message, _ messageId: String) {
        do {
            try db
                .collection(key.messages.rawValue)
                .document(chatId)
                .collection(key.messages.rawValue)
                .document(messageId)
                .setData(from: message)
        } catch {
            
        }
    }
    
    func removeChatRoomListener() {
        chatRoomListener?.remove()
        chatRoomListener = nil
    }
    
    func removeChatsListerner() {
        chatsListener?.remove()
        chatsListener = nil
    }
    
    func listenChatRoom(_ chatId: String, _ limit: Int, _ completed: @escaping ([Message]) -> ()) {
        chatRoomListener = db
            .collection(key.messages.rawValue)
            .document(chatId)
            .collection(key.messages.rawValue)
            .order(by: key.time.rawValue)
            .limit(toLast: limit)
            .addSnapshotListener({ query, error in
                guard let query = query else { return }
                do {
                    let messages = try query.documentChanges.compactMap{ try $0.document.data(as: Message.self) }
                    completed(messages)
                } catch {
                    
                }
            })
    }
    
    func loadMoreMessages(_ chatId: String, fromTime: Timestamp, _ limit: Int, _ completed: @escaping ([Message]) -> ()) {
        db
            .collection(key.messages.rawValue)
            .document(chatId)
            .collection(key.messages.rawValue)
            .order(by: key.time.rawValue)
            .limit(toLast: limit)
            .end(before: [fromTime])
            .addSnapshotListener({ query, error in
                guard let query = query else { return }
                do {
                    let messages = try query.documentChanges.compactMap{ try $0.document.data(as: Message.self) }
                    completed(messages.reversed())
                } catch {
                    
                }
            })
    }
}

extension FirebaseFirestore {
    typealias key = CollectionKey
    enum CollectionKey: String {
        case users
        case chats
        case chat
        case messages
        case username
        case time
    }
}
