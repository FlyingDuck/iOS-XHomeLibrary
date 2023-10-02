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

    var managedObjectContext: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        print("init LocalShelfViewModel")
        self.managedObjectContext = context
        self.search()
    }
    
    func getContext() -> NSManagedObjectContext {
        return self.managedObjectContext
    }
}

extension LocalShelfViewModel {
    func search() {
        print("[LocalShelfVM] start to search books")
        
        var bookEntities: [BookEntity] = []
        
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BookEntity.updateTime, ascending: false)]
        if !self.keyword.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[c] %@", self.keyword)
        }
        do {
            bookEntities = try getContext().fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        var books: [Book] = []
        
        for bookEntity in bookEntities {
            books.append(bookEntity.trans2LocalBook())
        }
        
        self.books = books
        
//        let books = [
//            Book(id: "1", name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: "2", name: "古文观止", author: "佚名", publisher: "新华出版社出版社出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
//            Book(id: "3", name: "不知道叫什么书名", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: "4", name: "古文观止", author: "佚名·托夫斯基", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: "5", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: "6", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: "7", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
//            Book(id: "8", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
//            Book(id: "9", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
//        ]
//        if self.keyword == "empty" {
//            self.books = []
//        } else {
//            self.books = books.shuffled()
//        }
    }
    
    func getTotal() -> Int {
        return self.books.count
    }
    
    func isEmpty() -> Bool {
        return self.books.isEmpty
    }
}