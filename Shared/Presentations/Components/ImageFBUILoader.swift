//
//  ImageFBUILoader.swift
//  Chat (iOS)
//
//  Created by Vo Thanh on 28/02/2022.
//

import SwiftUI
import FirebaseStorageUI

struct ImageFBUILoader: UIViewRepresentable {
    let imagePath: String
    let placeHolder: UIImage?
    let size: CGSize
    
    init(
        imagePath: String,
        placeHolder: UIImage? = UIImage(systemName: "person.circle.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal),
        size: CGSize
    ) {
        self.imagePath = imagePath
        self.placeHolder = placeHolder
        self.size = size
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .init(origin: .zero, size: size))
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let imageView = uiView.subviews.first as? UIImageView {
            imageView.sd_setImage(with: FirebaseStorage.shared.getReference(from: imagePath), placeholderImage: placeHolder)
        }
    }
}

