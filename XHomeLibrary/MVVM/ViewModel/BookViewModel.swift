//
//  BookViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import Kanna
import Kingfisher
import SwifterSwift
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

    func searchISBN(code: String) {
        book.isbn = code

        Networking.request(ISBNAPI.fetchRealURL) { result in
            print("ISBNAPI.fetchRealURL: ", result)
            if result.HttpCode != 200 {
                return
            }
            let html = String(data: result.rawReponse?.data ?? Data(), encoding: .utf8) ?? ""
            print("fetchRealURL html size: ", html.count)

            DispatchQueue.main.async {
                var token = ""
                if let doc = try? HTML(html: html, encoding: .utf8) {
                    for form in doc.css("form") {
                        let action = form["action"] ?? ""
                        let name = form["name"]
                        let method = form["method"]
                        if name == "form1", method == "get", action.hasPrefix("http://opac.nlc.cn:80/F") {
                            print("html from action: ", action)
                            token = action.components(separatedBy: "/").last ?? ""
                        }
                    }
                }
                if token.isEmpty {
                    return
                }

                Networking.request(ISBNAPI.fetchBookInfo(token: token, code: code)) { result in
                    print("ISBNAPI.fetchBookInfo: ", result)
                    if result.HttpCode != 200 {
                        return
                    }
                    let html = String(data: result.rawReponse?.data ?? Data(), encoding: .utf8) ?? ""
                    print("fetchBookInfo html size: ", html.count)

                    if let doc = try? HTML(html: html, encoding: .utf8) {
                        for div in doc.css("div") {
                            let id = div["id"]
                            if id != "details2" {
                                continue
                            }
                            for tr in div.css("tr") {
                                let tds = tr.css("td")
                                if tds.count != 2 {
                                    continue
                                }
                                let key = tds[0].text?.trimmed ?? ""
                                let value = tds[1].text?.trimmed ?? ""
                                if key.isEmpty || value.isEmpty {
                                    continue
                                }
                                switch key {
                                case "题名与责任":
                                    let vals = value.components(separatedBy: "/")
                                    if vals.count == 2 {
                                        self.book.name = vals[0]
                                        self.book.author = vals[1]
                                    } else {
                                        self.book.name = value
                                    }
                                case "出版项":
                                    self.book.publisher = value
                                case "内容提要":
                                    self.book.description = value
                                default:
                                    continue
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func updateLocalBook() -> CoreDataMessage {
        if !book.validate() {
            return CoreDataMessage.warning(msg: "书籍信息输入有误，请检查后重新输入")
        }
        // 判断是否已经存在相同 isbn 的书籍
        let curBookEntitys = fetchBookByISBN(isbn: book.isbn)
        if curBookEntitys.count > 1 {
            return CoreDataMessage.warning(msg: "ISBN=\(book.isbn) 的书籍已存在")
        }

        if !(localImage.size == .zero) {
            let imageFilepath = BookViewModel.saveImage2Local(localImage: localImage)
            book.cover = imageFilepath
        }

        guard let bookEntity = fetchBookByID(id: book.id) else {
            return CoreDataMessage.success()
        }
        book.trans2UpdateEntity(bookEntity: bookEntity)
        bookEntity.updateTime = Date()

        print("[BookVM] will update book: id=\(book.id), name=\(book.name), cover=\(book.cover)")

        PersistenceController.shared.save()
        
        return CoreDataMessage.success()
    }

    func addLocalBook() -> CoreDataMessage {
        if !book.validate() {
            return CoreDataMessage.warning(msg: "书籍信息输入有误，请检查后重新输入")
        }
        // 判断是否已经存在相同 isbn 的书籍
        let curBookEntitys = fetchBookByISBN(isbn: book.isbn)
        if curBookEntitys.count != 0 {
            return CoreDataMessage.warning(msg: "ISBN=\(book.isbn) 的书籍已存在，其书名为：《\(book.name)》")
        }

        let imageFilepath = BookViewModel.saveImage2Local(localImage: localImage)

        book.cover = imageFilepath

        let bookEntity = book.trans2NewEntity(context: getContext())
        bookEntity.id = UUID().uuidString
        bookEntity.createTime = Date()
        bookEntity.updateTime = Date()

        print("[BookVM] will add new book: id=\(book.id), name=\(book.name), cover=\(book.cover)")

        PersistenceController.shared.save()

        return CoreDataMessage.success()
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

    private func fetchBookByISBN(isbn: String) -> [BookEntity] {
        let predicate = NSPredicate(format: "isbn == %@", isbn as CVarArg)

        let fetchRequest: NSFetchRequest = BookEntity.fetchRequest()
        fetchRequest.predicate = predicate

        var bookEntities: [BookEntity] = []
        do {
            bookEntities = try getContext().fetch(fetchRequest)
        } catch let err {
            print(err.localizedDescription)
        }
        return bookEntities
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
}

struct CoreDataMessage {
    var statusCode: Int = 0
    var message: String = ""
}

extension CoreDataMessage {
    func isOK() -> Bool {
        return statusCode == 0
    }

    static func success() -> CoreDataMessage {
        return CoreDataMessage(statusCode: 0, message: "")
    }

    static func warning(msg: String) -> CoreDataMessage {
        return CoreDataMessage(statusCode: 1, message: msg)
    }
}
