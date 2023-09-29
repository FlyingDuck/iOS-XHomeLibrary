//
//  BookItemView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct BookItemCard: View {
    @ObservedObject var bookWatcher = BookWatcher.shared

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
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                Text("\(book.author)")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                Spacer()
                Text("\(book.publisher)")
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .italic()

                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                    Text("\(book.location.descripte)")
                        .font(.system(size: 12, weight: .light, design: .rounded))
                        .foregroundColor(Color.gray)

                    if book.local {
                        Spacer()
//                        Image(systemName: "externaldrive.fill.badge.timemachine")
                        Image(systemName: "clock.badge.exclamationmark")
                            .font(.system(size: 12))
                            .foregroundColor(Color.orange.opacity(0.6))
                    }
                }
            }
            .frame(maxWidth: 3 * UIScreen.main.bounds.width/5, alignment: .leading)
            .lineLimit(1)
            .padding(.vertical, 30)

            Spacer()

            VStack {
                Button(action: {
                    bookWatcher.setShowBook(book: book)
                }, label: {
//                    Label("", systemImage: "chevron.right")
                    Label("", systemImage: "poweron")
//                    Label("", systemImage: "ellipsis")
//                        .rotationEffect(Angle(degrees: 90))
                        .font(.system(size: 20))
                        .foregroundColor(Color.black.opacity(0.2))
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal, 5)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                        .shadow(color: .white, radius: 5, x: 10, y: 10)
                })
            }
        }
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/6)
        .background(Color.xwhiteCard)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    BookItemCard(book: Book(id: "1", name: "古文观止 古文观止 古文观止 古文观止", author: "佚名 古文观止 古文观止 古文观止", publisher: "新华出版社出版社出版社出版社出版社", location: .beijing, cover: "book-cover-0", isbn: "123478747585", description: "还没有描述信息", local: true))
        .background(Color.green)
}
