//
//  BookItemView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import Kingfisher
import SwiftUI

struct BookItemCard: View {
    @ObservedObject var bookWatcher = BookWatcher.shared

    var book: Book

    var body: some View {
        HStack {
            cover
            info
            Spacer()
            operationArea
        }
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/6)
        .background(Color.xwhiteCard)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    var cover: some View {
        VStack {
            if !book.isLocal() {
                KFImage(URL(string: book.cover))
                    .placeholder {
                        Image(systemName: "questionmark.app.dashed")
                            .foregroundColor(.gray.opacity(0.4))
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .padding(.all, 10)
            } else {
                let image = UIImage(contentsOfFile: book.cover)
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .padding(.all, 10)
                } else {
                    Image(systemName: "questionmark.app.dashed")
                        .foregroundColor(.gray.opacity(0.4))
                }
            }
        }
    }

    var info: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(book.name)")
                .font(.system(size: 16, weight: .heavy, design: .rounded))
            Text("\(book.author)")
                .font(.system(size: 12, weight: .regular, design: .rounded))
            Spacer()
            Text("\(book.publisher)")
                .font(.system(size: 10, weight: .light, design: .rounded))
                .italic()
                .underline()
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 10))
                    .foregroundColor(Color.gray)
                Text("\(book.location.displayName)")
                    .font(.system(size: 10, weight: .light, design: .rounded))
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
    }

    var operationArea: some View {
        VStack {
            Button(action: {
                bookWatcher.setShowBook(book: book)
            }, label: {
//                    Label("", systemImage: "chevron.right")
                Label("", systemImage: "poweron")
//                    Label("", systemImage: "ellipsis")
//                        .rotationEffect(Angle(degrees: 90))
                    .font(.system(size: 20))
                    .foregroundColor(Color.accentColor.opacity(0.3))
                    .shadow(radius: 10)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 5)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                    .shadow(color: .white, radius: 5, x: 10, y: 10)
            })
        }
    }
}

#Preview {
    BookItemCard(book: Book(name: "古文观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true))
        .background(Color.xgrayTab)
//        .background(Color.green)
}
