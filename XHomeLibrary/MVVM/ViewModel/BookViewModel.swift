//
//  BookViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import Kingfisher
import SwiftUI

class BookViewModel: ObservableObject {
    var managedObjectContext: NSManagedObjectContext
    @Published var book: Book

    // 图片处理
    // - 本地图片
    @Published var localImagePath: String
    // - 网络图片
    @Published var remoteImageURL: String

    init(book: Book, context: NSManagedObjectContext) {
        self.managedObjectContext = context
        self.book = book
        self.localImagePath = ""
        self.remoteImageURL = ""
        if !book.cover.isEmpty {
            if book.isLocal() {
                self.localImagePath = book.cover
            } else {
                self.remoteImageURL = book.cover
            }
        }
        print("[BookVM] init BookViewModel with book: name=\(book.name), id=\(book.id), cover=\(book.cover), isLocal=\(book.isLocal())")
    }

    func getContext() -> NSManagedObjectContext {
        return managedObjectContext
    }
}

extension BookViewModel {
    func reset() {
        print("[BookVM] reset book to empty")
        book = Book.newEmptyBook()
        localImagePath = ""
        remoteImageURL = ""
    }

    func getLocalBookCoverUIImage() -> UIImage {
        if localImagePath.isEmpty {
            return UIImage()
        } else {
            return UIImage(contentsOfFile: localImagePath) ?? UIImage()
        }
    }

//    func uploadBookCover(image: UIImage) -> String {
//        // todo 上传图片
//        return ""
//    }

    func updateLocalBook() {
        if !localImagePath.isEmpty {
            book.cover = localImagePath
        }

        guard let bookEntity = fetchBookByID(id: book.id) else { return }
        book.trans2UpdateEntity(bookEntity: bookEntity)
        bookEntity.updateTime = Date()

        print("[BookVM] will update book: id=\(book.id), name=\(book.name), cover=\(book.cover)")

        PersistenceController.shared.save()
    }

    func addLocalBook() {
        book.cover = localImagePath

        let bookEntity = book.trans2NewEntity(context: getContext())
        bookEntity.id = UUID().uuidString
        bookEntity.createTime = Date()
        bookEntity.updateTime = Date()

        print("[BookVM] will add new book: id=\(book.id), name=\(book.name), cover=\(book.cover)")

        PersistenceController.shared.save()
    }

    private func fetchBookByID(id: String) -> BookEntity? {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)

        let fetchRequest: NSFetchRequest = BookEntity.fetchRequest()
        fetchRequest.predicate = predicate

        var bookEntities: [BookEntity] = []
        do {
            bookEntities = try getContext().fetch(fetchRequest)
        } catch let err {
            print(err.localizedDescription)
        }
        return bookEntities.first
    }
}
