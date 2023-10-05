//
//  HoneycombImage.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/5.
//

import Kingfisher
import SwiftUI

struct HoneycombImage: View {
    @ObservedObject var bookWatcher = BookWatcher.shared

    private var book: Book

    init(book: Book) {
        self.book = book
    }

    var body: some View {
        if !book.isLocal() {
            KFImage(URL(string: book.cover))
                .placeholder {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.gray.opacity(0.5))
                }
                .resizable()
                .modifier(HoneycombImageModifer())
                .onTapGesture {
                    if !book.id.isEmpty {
                        bookWatcher.setBookDetail(book: book)
                    }
                }
        } else {
            let image = UIImage(contentsOfFile: book.cover)
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .modifier(HoneycombImageModifer())
                    .onTapGesture {
                        if !book.id.isEmpty {
                            bookWatcher.setBookDetail(book: book)
                        }
                    }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.gray.opacity(0.5))
                    .modifier(HoneycombImageModifer())
                    .onTapGesture {
                        if !book.id.isEmpty {
                            bookWatcher.setBookDetail(book: book)
                        }
                    }
            }
        }
    }
}

#Preview {
    HoneycombImage(
        book: Book(id: UUID().uuidString, name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "ttps://img1.baidu.com/it/u=1458656822,2078909008&fm=253&fmt=auto&app=120&f=JPEG", isbn: "123478747585", description: "还没有描述信息")
    )
}
