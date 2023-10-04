//
//  LocalBookshelfViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import CoreData
import SwiftUI

class LocalShelfViewModel: ObservableObject {
    // 搜索栏参数
    @Published var keyword: String = ""
    // 书架
    @Published var books: [Book] = []
    @Published var total: Int = 0

    var managedObjectContext: NSManagedObjectContext
    init(books: [Book] = [], context: NSManagedObjectContext) {
        print("init LocalShelfViewModel")
        self.managedObjectContext = context
        self.search()
        self.count()
    }
    
    func getContext() -> NSManagedObjectContext {
        return self.managedObjectContext
    }
}

extension LocalShelfViewModel {
    func refresh() {
        self.search()
        self.count()
    }
    
    func search() {
        print("[LocalShelfVM] start to search books")
        
        var bookEntities: [BookEntity] = []
        
        let request: NSFetchRequest = BookEntity.fetchRequest()
        do {
            request.sortDescriptors = [NSSortDescriptor(keyPath: \BookEntity.updateTime, ascending: false)]
            if !self.keyword.isEmpty {
                request.predicate = NSPredicate(format: "name CONTAINS[c] %@", self.keyword)
            }
            bookEntities = try self.getContext().fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        var books: [Book] = []
        
        for bookEntity in bookEntities {
            books.append(bookEntity.trans2LocalBook())
        }
        
//        books = [
//            Book(id: UUID().uuidString, name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: UUID().uuidString, name: "古文观止", author: "佚名", publisher: "新华出版社出版社出版社出版社出版社出版社出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true),
//            Book(id: UUID().uuidString, name: "不知道叫什么书名", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: UUID().uuidString, name: "古文观止", author: "佚名·托夫斯基", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: UUID().uuidString, name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: UUID().uuidString, name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: UUID().uuidString, name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
//            Book(id: UUID().uuidString, name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: UUID().uuidString, name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
//        ]
        
        self.books = books
    }
    
    func getTotal() -> Int {
        return self.total
    }
    
    func isEmpty() -> Bool {
        return self.books.isEmpty
    }
    
    private func count() {
        var bookEntities: [BookEntity] = []
        
        let request: NSFetchRequest = BookEntity.fetchRequest()
        do {
            request.sortDescriptors = [NSSortDescriptor(keyPath: \BookEntity.updateTime, ascending: false)]
            bookEntities = try self.getContext().fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        self.total = bookEntities.count
    }
}
