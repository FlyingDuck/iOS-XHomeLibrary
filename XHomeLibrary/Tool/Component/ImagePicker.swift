//
//  ImagePicker.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/2.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

//    @Binding var selectedImage: UIImage
    @Binding var selectedImagePath: String
    @Environment(\.presentationMode) private var presentationMode
    let handlerImage: (_ image: UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
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
//                parent.selectedImage = image
                parent.handlerImage(image)
                if let imageURL = info[.imageURL] as? NSURL {
                    print("pick imageURL = \(imageURL)")
                    if let imagePath = imageURL.path {
//                        parent.selectedImage = UIImage(contentsOfFile: imagePath)!
                        parent.selectedImagePath = imagePath
                        print("pick imagePath = \(imagePath)")
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

//    @Binding var sourceType: UIImagePickerController.SourceType
//    let handlerImage: (_ image: UIImage) -> Void
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//
//    // 在构造时调用
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker=UIImagePickerController()
//        picker.allowsEditing=false
//        picker.sourceType=sourceType
//        print("picker source \(sourceType.rawValue)")
//        return picker
//    }
//
//    // 刷新时被调用
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent=parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            print("iamge picker controller")
//            if let image=info[.originalImage] as? UIImage {
//                parent.handlerImage(image)
//                if let p=info[.imageURL] {
//                    print("image = \(p)")
//                }
//            }
//        }
//    }

    // 先了解ios的关于文件概念。在ios系统中有一个沙箱(sandbox)的概念，app自身使用的文件都是在这个沙箱中，
    // 我们只需要打开沙箱，找到目录保存文件或者找到文件加载进来。沙箱中有4个目录 Documents, Library, SystemData, tmp。
    // 我们需要将图片保存在documents这个目录下。

//    static let BuildingPropertyDir: String="imagePicker"
//
//    static func saveImage(image: UIImage) -> String {
//        let filePath=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
//        let dir=filePath+"/images/"+BuildingPropertyDir+"/"
//        let filemanager=FileManager.default
//        try! filemanager.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
//        let now=Date()
//        let formatter=DateFormatter()
//        formatter.dateFormat="YYYYMMddHHmmss"
//        let time=formatter.string(from: now)
//        let fn=time+".png"
//        let filename=dir+fn
//
//        let data: Data=image.pngData()!
//        try! data.write(to: URL(fileURLWithPath: filename))
//        //        print("filename \(filename)")
//        return fn
//    }
//
//    static func loadImages() -> [(String, UIImage)] {
//        var images: [(String, UIImage)]=[]
//        let filePath=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
//        let dir=filePath+"/images/"+BuildingPropertyDir
//
//        let manager=FileManager.default
//        let files=try! manager.contentsOfDirectory(atPath: dir)
//
//        for f in files {
//            let filename=dir+"/"+f
//            if let image=UIImage(contentsOfFile: filename) {
//                let i=(f, image)
//                images.append(i)
//            }
//        }
//
//        return images
//    }
}
