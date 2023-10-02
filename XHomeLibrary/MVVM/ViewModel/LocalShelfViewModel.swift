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
        
        let request : NSFetchRequest = BookEntity.fetchRequest()
        do {
            request.sortDescriptors = [NSSortDescriptor(keyPath: \BookEntity.updateTime, ascending: false)]
            if !self.keyword.isEmpty {
                request.predicate = NSPredicate(format: "name CONTAINS[c] %@", self.keyword)
            }
            bookEntities = try getContext().fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        var books: [Book] = []
        
        for bookEntity in bookEntities {
            books.append(bookEntity.trans2LocalBook())
        }
        
        self.books = books
    }
    
    func getTotal() -> Int {
        return self.books.count
    }
    
    func isEmpty() -> Bool {
        return self.books.isEmpty
    }
}
