//
//  BookWatcher.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import SwiftUI

class BookWatcher: ObservableObject {
    static let shared = BookWatcher()

    // 选中的书籍
    @Published var showBookDetail: Bool = false
    @Published var bookDetail: Book = .newEmptyBook()

    // 首页推荐
    @Published var recBooks: [Book] = []

    var managedObjectContext: NSManagedObjectContext
    init() {
        print("init BookWatcher")
        let context = PersistenceController.shared.container.viewContext
        self.managedObjectContext = context
        self.refreshRecommandBooks()
    }

    func getContext() -> NSManagedObjectContext {
        return self.managedObjectContext
    }
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

        self.appendRecommandQueue(book: book)
    }

    func refreshRecommandBooks() {
        print("[BookWatcher] refresh recommand books")

        var bookEntities: [BookEntity] = []

        let request: NSFetchRequest = BookEntity.fetchRequest()
        do {
            request.sortDescriptors = [NSSortDescriptor(keyPath: \BookEntity.updateTime, ascending: false)]
            bookEntities = try self.getContext().fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }

        var books: [Book] = []

        for bookEntity in bookEntities {
            books.append(bookEntity.trans2LocalBook())
        }

        if books.count < 12 {
            for _ in 0 ... 12 - books.count {
                books.append(Book.newEmptyBook())
            }
        }
        self.recBooks = books
    }

    private func appendRecommandQueue(book: Book) {
        if book.id.isEmpty {
            return
        }

        var books: [Book] = []
        var replaced = false
        for recBook in self.recBooks {
            if recBook.id == book.id {
                books.append(book)
                replaced = true
            } else {
                books.append(recBook)
            }
        }
        print("append book to recommand queue: count=\(self.recBooks.count)")

        if !replaced {
            books.insert(book, at: 0)
        }
        if books.count > 12 {
            books.removeLast()
        }
        self.recBooks = books
    }
}
