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
    @Published var showPhotoPicker: Bool = false
    @Published var showSheet: Bool = false
    @Published var showBook: Book = .newEmptyBook()
}

extension BookWatcher {
    func isNetworkAvaliable() -> Bool {
        // todo 判断网络状态
        return false
    }
    
    func refreshSheetStatus() {
        self.showSheet = self.showBookDetail || self.showPhotoPicker
    }
    
    func clear() {
        self.showBook = .newEmptyBook()
        self.showBookDetail = false
        self.showPhotoPicker = false
        self.showSheet = self.showBookDetail || self.showPhotoPicker
    }
    
    func getShowBook() -> Book {
        return self.showBook
    }

    func setShowBook(book: Book) {
        self.showBookDetail = true
        self.showBook = book
        self.refreshSheetStatus()
    }
    
    func setShowPhotoPicker() {
        self.showPhotoPicker = true
        self.refreshSheetStatus()
    }
}
