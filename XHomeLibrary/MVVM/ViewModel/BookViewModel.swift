//
//  BookViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

class BookViewModel: ObservableObject {
    @Published var book: Book = .init(location: .beijing)
}
