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
    @Published var showBook: Book?
}

extension BookWatcher {
    func getShowBook() -> Book {
        return self.showBook ?? .init()
    }

    func setShowBook(book: Book) {
        self.showBook = book
        self.showBookDetail = true
    }
}
