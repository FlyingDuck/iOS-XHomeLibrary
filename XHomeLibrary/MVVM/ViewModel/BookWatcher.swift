//
//  BookWatcher.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

class BookWatcher: ObservableObject {
    static let shared = BookWatcher()

    @Published var showBookDetail: Bool = false
    @Published var bookDetail: Book = .newEmptyBook()
}

extension BookWatcher {
    func isNetworkAvaliable() -> Bool {
        // todo 判断网络状态
        return false
    }

    func clear() {
        self.bookDetail = .newEmptyBook()
        self.showBookDetail = false
    }

    func getBookDetail() -> Book {
        return self.bookDetail
    }

    func setBookDetail(book: Book) {
        self.showBookDetail = true
        self.bookDetail = book
    }
}
