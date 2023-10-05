//
//  BookshelfViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

class RemoteShelfViewModel: ObservableObject {
    // 是否展示书架
    @Published var show : Bool = false
    
    // 搜索栏参数
    @Published var selectedLoc: Location = .all
    @Published var keyword: String = ""
    // 书架
    @Published var books: [Book] = []
    
    
    // 首页推荐
    @Published var recBooks: [Book] = []

    init() {
        self.recommand()
    }

    
}

extension RemoteShelfViewModel {
    
    func clear() {
        self.show = false
        self.books = []
        self.keyword = ""
        self.selectedLoc = .all
    }
    
    func search() {
        print("[ShelfVM] start to search books")
        
        let books = [
            Book(id: UUID().uuidString, name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: UUID().uuidString, name: "古文观止", author: "佚名", publisher: "新华出版社出版社出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(id: UUID().uuidString, name: "不知道叫什么书名", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: UUID().uuidString, name: "古文观止", author: "佚名·托夫斯基", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: UUID().uuidString, name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: UUID().uuidString, name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: UUID().uuidString, name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(id: UUID().uuidString, name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: UUID().uuidString, name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
        ]
        if self.keyword.isEmpty {
            self.books = []
        } else {
            self.books = books.shuffled()
        }
    }
    
    func recommand() {
        print("[ShelfVM] start to recommand books")
        
        let books = [
            Book(name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(name: "古文观止", author: "佚名", publisher: "新华出版社出版社出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(name: "不知道叫什么书名", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(name: "古文观止", author: "佚名·托夫斯基", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
            Book(name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
        ]
        
        self.recBooks = books.shuffled()
        if books.count < 12 {
            for _ in 0...12-self.recBooks.count {
                self.recBooks.append(Book(name: "", author: "", publisher: "", location: .beijing, cover: "book-cover-00", isbn: "", description: ""))
            }
        }
    }
    
    func goShelf() {
        self.show = true
    }
    
    func goBack() {
        self.show = false
    }
    
    func getShelfTotal() -> Int {
        return self.books.count
    }
    
    func isShelfEmpty() -> Bool {
        return self.books.isEmpty
    }
    
}
