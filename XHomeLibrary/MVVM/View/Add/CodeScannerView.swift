//
//  CodeScannerView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/4.
//

import SwiftUI
import SPAlert

struct CodeScannerView: View {
    @EnvironmentObject var bookVM: BookViewModel

    var body: some View {
        VStack {
            CodeScanner(code: $bookVM.book.isbn) { code in
                print("goto fetch data from network: code=\(code)")
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
