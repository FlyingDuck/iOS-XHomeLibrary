//
//  CodeScannerView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/4.
//

import SPAlert
import SwiftUI

struct CodeScannerView: View {
    @EnvironmentObject var bookVM: BookViewModel

    var body: some View {
        VStack {
            CodeScanner { code in
                print("goto fetch data from network: code=\(code)")

                bookVM.book.name = "扫码书名-\(code)"
                bookVM.book.author = "扫码作者\(code)"
                bookVM.book.publisher = "扫码出版社"
                bookVM.book.isbn = code
                bookVM.book.description = "扫码简介"

                let alert = SPAlertView(title: "获取条形码", message: "\(code)", preset: .done)
                alert.present(haptic: .success)
            }
        }
    }
}

#Preview {
    NavigationView {
        let context = PersistenceController.shared.container.viewContext
        CodeScannerView()
            .environmentObject(BookViewModel(
                book: Book.newEmptyBook(),
                context: context)
            )
    }
}
