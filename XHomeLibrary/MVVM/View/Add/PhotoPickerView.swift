//
//  PhotoPickerView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/2.
//

import SwiftUI

struct PhotoPickerView: View {
//    @Binding var image: UIImage
    @EnvironmentObject var bookVM: BookViewModel
    var sourceType: UIImagePickerController.SourceType
    
    init(sourceType: UIImagePickerController.SourceType = .photoLibrary) {
        self.sourceType = sourceType
    }

    var body: some View {
        VStack {
            ImagePicker(sourceType: sourceType, selectedImage: $bookVM.localImage) { image in
                print("handle selected image: size=\(image.size)")
            }
        }
        .navigationBarTitle("选择图片")
        .interactiveDismissDisabled() // 禁止滑动关闭sheet
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        let context = PersistenceController.shared.container.viewContext
        PhotoPickerView(sourceType: .photoLibrary)
            .environmentObject(BookViewModel(
                book: Book.newEmptyBook(),
                context: context)
            )
    }
}
