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

    func getContext() -> NSManagedObjectContext {
        return managedObjectContext
    }
}

extension BookViewModel {
    func resetBook() {
        print("[BookVM] reset book to empty")
        self.book = Book.newEmptyBook()
    }
    
    func updateBook() {
        print("[BookVM] will update book(\(book.name)), id=\(book.id)")
        guard let bookEntity = fetchBookByID(id: book.id) else { return }
        book.trans2UpdateEntity(bookEntity: bookEntity)
        bookEntity.updateTime = Date()
        PersistenceController.shared.save()
    }

    func addNewBook() {
        print("[BookVM] will add new book(\(book.name)), id=\(book.id)")
        let bookEntity = book.trans2NewEntity(context: getContext())
        bookEntity.id = UUID().uuidString
        bookEntity.createTime = Date()
        bookEntity.updateTime = Date()
        PersistenceController.shared.save()
    }

    func fetchBookByID(id: String) -> BookEntity? {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)

        let fetchRequest: NSFetchRequest = BookEntity.fetchRequest()
        fetchRequest.predicate = predicate

        
        var bookEntities : [BookEntity] = []
        do {
            bookEntities = try getContext().fetch(fetchRequest)
        } catch let err {
            print(err.localizedDescription)
        }
        return bookEntities.first
    }
}
