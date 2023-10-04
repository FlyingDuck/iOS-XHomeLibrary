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
    private static let localImageSavingDir = "XHomeLib"
    @Published var localImage: UIImage
    // - 网络图片
    @Published var remoteImageURL: String

    init(book: Book, context: NSManagedObjectContext) {
        self.managedObjectContext = context
        self.book = book
        self.localImage = UIImage()
        self.remoteImageURL = ""
        if !book.cover.isEmpty {
            if book.isLocal() {
                self.localImage = UIImage(contentsOfFile: book.cover) ?? UIImage()
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
        localImage = UIImage()
        remoteImageURL = ""
    }

    func getLocalBookCoverUIImage() -> UIImage {
        return localImage
    }

    func updateLocalBook() {
        if !(localImage.size == .zero) {
            let imageFilepath = BookViewModel.saveImage2Local(localImage: localImage)
            book.cover = imageFilepath
        }

        guard let bookEntity = fetchBookByID(id: book.id) else { return }
        book.trans2UpdateEntity(bookEntity: bookEntity)
        bookEntity.updateTime = Date()

        print("[BookVM] will update book: id=\(book.id), name=\(book.name), cover=\(book.cover)")

        PersistenceController.shared.save()
    }

    func addLocalBook() {
        let imageFilepath = BookViewModel.saveImage2Local(localImage: localImage)

        book.cover = imageFilepath

        let bookEntity = book.trans2NewEntity(context: getContext())
        bookEntity.id = UUID().uuidString
        bookEntity.createTime = Date()
        bookEntity.updateTime = Date()

        print("[BookVM] will add new book: id=\(book.id), name=\(book.name), cover=\(book.cover)")

        PersistenceController.shared.save()
    }

    func deleteLocalBook() {
        guard let bookEntity = fetchBookByID(id: book.id) else { return }

        let imagePath = bookEntity.cover ?? ""

        getContext().delete(bookEntity)

        PersistenceController.shared.save()

        BookViewModel.removeImageFile(filepath: imagePath)
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

    static func saveImage2Local(localImage: UIImage) -> String {
        if localImage.size == .zero {
            return ""
        }

        let BuildingPropertyDir = localImageSavingDir

        // 创建图片文件目录
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let dir = filePath + "/images/" + BuildingPropertyDir + "/"
        let filemanager = FileManager.default
        try! filemanager.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
        print("images dir: \(dir)")

        // 提取图片文件名
        let newFilepath = dir + UUID().uuidString + ".jpeg"
        print("saving image path: \(newFilepath)")

        // 写入新的目录
        let data: Data = localImage.pngData()!
        try! data.write(to: URL(fileURLWithPath: newFilepath))
        return newFilepath
    }

    static func removeImageFile(filepath: String) {
        if filepath.isEmpty {
            return
        }
        let filemanager = FileManager.default
        do {
            try filemanager.removeItem(atPath: filepath)
        } catch let err {
            print(err.localizedDescription)
        }
    }

//    static func saveImage2Local(tmpFilePath: String) -> String {
//        if tmpFilePath.isEmpty {
//            return ""
//        }
//
//        let BuildingPropertyDir = localImageSavingDir
//        guard let image = UIImage(contentsOfFile: tmpFilePath) else {
//            return ""
//        }
//
//        // 创建图片文件目录
//        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
//        let dir = filePath+"/images/"+BuildingPropertyDir+"/"
//        let filemanager = FileManager.default
//        try! filemanager.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
//        print("images dir: \(dir)")
//
//        // 提取图片文件名
//        let components = tmpFilePath.components(separatedBy: "/")
//        let newFilepath = dir+components.last!
//        print("saving image path: \(newFilepath)")
//
//        // 写入新的目录
//        let data: Data = image.pngData()!
//        try! data.write(to: URL(fileURLWithPath: newFilepath))
//        return newFilepath
//    }
}
