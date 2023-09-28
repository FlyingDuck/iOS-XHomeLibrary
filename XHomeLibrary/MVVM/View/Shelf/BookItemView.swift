//
//  BookItemView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct BookItemView: View {
    var book: Book

    var body: some View {
        HStack {
            Image(book.cover)
                .resizable()
                .scaledToFit()
//                .frame(width: 100, height: 180, alignment: .center)
                .padding(.all, 10)

            VStack(alignment: .leading, spacing: 10) {
                Text("\(book.name)")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                Text("\(book.author)")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                Text("\(book.publisher)")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .italic()

                Spacer()
                HStack() {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                    Text("\(book.location.descripte)")
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .foregroundColor(Color.gray)
                    
                    if book.local {
                        Spacer()
//                        Image(systemName: "externaldrive.fill.badge.timemachine")
                        Image(systemName: "clock.badge.exclamationmark")
                            .font(.system(size: 15))
                            .foregroundColor(Color.orange.opacity(0.6))
                    }
                    
                }
            }
            .frame(maxWidth: 3*UIScreen.main.bounds.width/5, alignment: .leading)
            .lineLimit(1)
            .padding(.vertical, 40)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Color.gray.opacity(0.7))
                .padding(.horizontal, 10)
        }
        .padding(.horizontal, 5)
//        .frame(width: UIScreen.main.bounds.width, height: 200, alignment:  .center)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/5)
        .background(Color.xwhiteCard)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    BookItemView(book: Book(id: "1", name: "古文观止 古文观止 古文观止 古文观止", author: "佚名 古文观止 古文观止 古文观止", publisher: "新华出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true))
        .background(Color.red)
}
