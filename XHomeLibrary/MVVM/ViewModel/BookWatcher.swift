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
    @Published var showBook: Book = Book.newEmptyBook()
}

extension BookWatcher {
    func clear() {
        self.showBookDetail = false
    }
    
    func getShowBook() -> Book {
        return self.showBook
    }

    func setShowBook(book: Book) {
        self.showBookDetail = true
        self.showBook = book
    }
}
