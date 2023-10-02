//
//  ImagePickerTest.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/2.
//

import SwiftUI

struct ImagePickerTest: View {
//    @State private var showPic=false
//    @State private var sourceType: UIImagePickerController.SourceType = .camera

    @State private var isShowPhotoLibrary = false
//    @State private var image = UIImage()
    @State private var imagePath = ""

    var body: some View {
        VStack {
//            var selectedImage = UIImage()
//            if !self.imagePath.isEmpty {
//                selectedImage = UIImage(contentsOfFile: self.imagePath)!
//            }
            
            Image(uiImage: (self.imagePath.isEmpty ? UIImage() : UIImage(contentsOfFile: self.imagePath))!)
//            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)

            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImagePath: $imagePath) {image in
                print("handle image: size=\(image.size)")
            }
        }
    }
}

#Preview {
    ImagePickerTest()
}
