//
//  ImagePicker.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/2.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Binding var selectedImage: UIImage
//    @Binding var selectedImagePath: String
    @Environment(\.presentationMode) private var presentationMode
    let handlerImage: (_ image: UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        if sourceType == .camera {
            imagePicker.allowsEditing = true
        } else {
            imagePicker.allowsEditing = false
        }
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image.fixOrientation()
                parent.handlerImage(image)
                if let imageURL = info[.imageURL] as? NSURL {
                    print("pick imageURL = \(imageURL)")
                    if let imagePath = imageURL.path {
//                        parent.selectedImage = UIImage(contentsOfFile: imagePath)!
//                        parent.selectedImagePath = imagePath
                        print("pick imagePath = \(imagePath)")
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
