//
//  Book.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct Book {
    var id: String = ""
    var name: String = ""
    var author: String = ""
    var publisher: String = ""
    var location: BookshelfViewModel.Location = .all
    var cover: String = ""
    var isbn: String = ""
    var description: String = ""
    
    var local : Bool = false
}

extension Book {}
