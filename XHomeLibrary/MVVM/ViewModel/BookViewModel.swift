//
//  BookViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import SwiftUI

class BookViewModel: ObservableObject {
    @Published var book: Book

    var managedObjectContext: NSManagedObjectContext
    init(book: Book, context: NSManagedObjectContext) {
        self.book = book
        self.managedObjectContext = context
    }
}

extension BookViewModel {
    func getContext() -> NSManagedObjectContext {
        return managedObjectContext
    }

    func addNewBook() {
        print("[BookVM] will add new book, \(book.name)")
        let bookEntity = book.trans2Entity(context: getContext())
        bookEntity.createTime = Date()
        PersistenceController.shared.save()
    }
}
