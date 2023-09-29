//
//  BookshelfViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

class BookshelfViewModel: ObservableObject {
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

    enum Location: CaseIterable, Identifiable {
        case all
        case beijing
        case tangshan

        var id: Self {
            self
        }

        var descripte: String {
            switch self {
            case .all:
                return "所有"
            case .beijing:
                return "北京"
            case .tangshan:
                return "唐山"
            }
        }
    }
}

extension BookshelfViewModel {
    
    func clear() {
        self.show = false
        self.books = []
        self.keyword = ""
        self.selectedLoc = .all
    }
    
    func search() {
        let books = [
            Book(id: "1", name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "2", name: "古文观止", author: "佚名", publisher: "新华出版社出版社出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(id: "3", name: "不知道叫什么书名", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "4", name: "古文观止", author: "佚名·托夫斯基", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "5", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "6", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "7", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(id: "8", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "9", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
        ]
        if self.keyword.isEmpty {
            self.books = []
        } else {
            self.books = books.shuffled()
        }
    }
    
    func recommand() {
        let books = [
            Book(id: "1", name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "2", name: "古文观止", author: "佚名", publisher: "新华出版社出版社出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(id: "3", name: "不知道叫什么书名", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "4", name: "古文观止", author: "佚名·托夫斯基", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "5", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "6", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "7", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true),
            Book(id: "8", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
            Book(id: "9", name: "古文观止", author: "李美霞", publisher: "新华出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息"),
        ]
        
        self.recBooks = books.shuffled()
        if books.count < 12 {
            for i in 0...12-self.recBooks.count {
                self.recBooks.append(Book(id: "\(self.recBooks.count+i+1)", name: "", author: "", publisher: "", location: .beijing, cover: "book-cover-00", isbn: "", description: ""))
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
