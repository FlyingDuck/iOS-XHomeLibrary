//
//  Book.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI
import CoreData

enum Location: CaseIterable, Identifiable {
    case all
    case beijing
    case tangshan
    
    var id: Self {
        self
    }
    
    var displayName: String {
        switch self {
        case .all:
            return "所有"
        case .beijing:
            return "北京"
        case .tangshan:
            return "唐山"
        }
    }
    
    var entityName: String {
        switch self {
        case .all:
            return "none"
        case .beijing:
            return "beijing"
        case .tangshan:
            return "tangshan"
        }
    }
}

struct Book {
    var id: String = ""
    var name: String = ""
    var author: String = ""
    var publisher: String = ""
    var location: Location = .all
    var cover: String = ""
    var isbn: String = ""
    var description: String = ""
    
    var local: Bool = false
    
    init(id : String = "", name: String, author: String, publisher: String, location: Location, cover: String, isbn: String, description: String, local: Bool = false) {
        self.id = id
        self.name = name
        self.author = author
        self.publisher = publisher
        self.location = location
        self.cover = cover
        self.isbn = isbn
        self.description = description
        self.local = local
    }
}

extension Book {
    static func newEmptyBook() -> Book {
        return .init(name: "", author: "", publisher: "", location: Location.beijing, cover: "", isbn: "", description: "", local: true)
    }
    
    func isNew() -> Bool {
        return self.id.isEmpty
    }
    
    func isLocal() -> Bool {
        if cover.isEmpty {
            return local
        }
        if isRemoteCoverImage() {
            return false
        }
        return true
    }
    
    private func isRemoteCoverImage() -> Bool {
        return !cover.isEmpty && cover.hasPrefix("http")
    }
    
    func trans2NewEntity(context: NSManagedObjectContext) -> BookEntity {
        let bookEntity: BookEntity = .init(context: context)
        bookEntity.id = self.id
        bookEntity.name = self.name
        bookEntity.author = self.author
        bookEntity.publisher = self.publisher
        bookEntity.location = self.location.entityName
        bookEntity.cover = self.cover
        bookEntity.isbn = self.isbn
        bookEntity.desc = self.description
        return bookEntity
    }
    
    func trans2UpdateEntity(bookEntity: BookEntity) {
        // id 不变
        bookEntity.name = self.name
        bookEntity.author = self.author
        bookEntity.publisher = self.publisher
        bookEntity.location = self.location.entityName
        bookEntity.cover = self.cover
        bookEntity.isbn = self.isbn
        bookEntity.desc = self.description
    }
    
    
}

extension BookEntity {
    func trans2LocalBook() -> Book {
        var book = self.toBook()
        book.local = true
        return book
    }
    
    func trans2CloudBook() -> Book {
        var book = self.toBook()
        book.local = false
        return book
    }
    
    private func toBook() -> Book {
        var location: Location
        
        switch self.location {
        case Location.beijing.entityName:
            location = Location.beijing
        case Location.tangshan.entityName:
            location = Location.tangshan
        default:
            location = Location.all
        }
        
        return .init(id: self.id ?? "",
                     name: self.name ?? "",
                     author: self.author ?? "",
                     publisher: self.publisher ?? "",
                     location: location,
                     cover: self.cover ?? "",
                     isbn: self.isbn ?? "",
                     description: self.desc ?? "",
                     local: true)
    }
}
