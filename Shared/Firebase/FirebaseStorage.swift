//
//  FirebaseStorage.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 28/02/2022.
//

import Foundation
import FirebaseStorage
import UIKit

class FirebaseStorage {
    static let shared = FirebaseStorage()
    let storage = Storage.storage()
    
    func uploadImage(_ path: String, _ image: UIImage, completed: @escaping (Result<String, Error>) -> ()) {
        guard let data = image.jpegData(compressionQuality: 0.3) else {
            completed(.failure(ErrorType.failedToUploadImage))
            return
        }
        let ref = storage.reference(withPath: path)
        ref.putData(data, metadata: nil) { metadata, error in
            if let metadata = metadata, metadata.size > 0 {
                completed(.success(path))
            } else {
                completed(.failure(ErrorType.failedToUploadImage))
            }
        }
    }
    
    func uploadAvatar(_ username: String, _ avatar: UIImage) async throws -> String {
        let path = "\(folder.users.rawValue)/\(username).jpg"
        return try await withCheckedThrowingContinuation { continuation in
            uploadImage(path, avatar) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func uploadPhoto(_ path: String, _ image: UIImage) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            uploadImage(path, image) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func getReference(from path: String) -> StorageReference {
        storage.reference(withPath: path)
    }
}

extension FirebaseStorage {
    typealias folder = Folder
    enum Folder: String {
        case users
        case chats
    }
}
