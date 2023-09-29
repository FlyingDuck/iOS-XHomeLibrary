//
//  BookDetail.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    var body: some View {
        VStack(spacing: 0) {
            pageTitle
            
            baseInfo
            divider
            additionalInfo
            footer
            
        }
        .frame(maxHeight: UIScreen.main.bounds.height)
        .background(Color.xwhiteCard)
    }
    
    var pageTitle : some View {
        HStack {
            Text("图书详情").font(.headline)
        }
        .padding(.vertical, 30)
    }
    
    var baseInfo: some View {
        HStack {
            VStack {
                Image(book.cover)
                    .resizable()
                    .scaledToFit()
            }
            
            Divider().padding(.vertical)
            
            VStack(alignment: .leading, spacing: 60) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(book.name)
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .lineLimit(2)
                    Text(book.author)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .lineLimit(1)
                }
                VStack(alignment: .leading) {
                    Text(book.publisher)
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .lineLimit(1)
                    HStack {
                        Image(systemName: "barcode")
                            .font(.system(size: 13, weight: .thin, design: .rounded))
                            .foregroundColor(.gray)
                        Text(book.isbn)
                            .font(.system(size: 15, weight: .thin, design: .rounded))
                            .italic()
                            .lineLimit(1)
                    }
                }
            }
            .padding(.vertical, 20)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.2)
        .background(Color.xwhiteCard)
    }
    
    var divider: some View {
        HStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                .foregroundColor(Color.gray.opacity(0.5))
            Circle()
                .foregroundColor(Color.gray.opacity(0.5))
                .frame(height: 4)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                .foregroundColor(Color.gray.opacity(0.5))
        }
        .padding(.horizontal)
        .background(Color.xwhiteCard)
    }
    
    var additionalInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
                Text("\(book.location.descripte)")
                    .font(.system(size: 15, weight: .light, design: .rounded))
//                    .foregroundColor(Color.gray)
            }
            .padding(.horizontal)
            
            HStack(alignment: .top) {
                if book.description.isEmpty {
                    Text("关于《\(book.name)》, Ta 什么也没写")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.gray)
                } else {
                    Text(book.description)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 5, alignment: .leading)
            .overlay(
                Rectangle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .padding(.horizontal)
            )
        }
        .padding(.all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
        .background(Color.xwhiteCard)
        .frame(width: UIScreen.main.bounds.width)
    }
    
    
    var footer : some View {
        
        HStack {
            Button {
                // todo something
            } label: {
                Label("去编辑", systemImage: "square.and.pencil")
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .padding(.vertical)
                    .background(Color.xwhiteCard)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .stroke(Color.accentColor.opacity(0.8), lineWidth: 1)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    BookDetailView(book:
        Book(id: "6", name: "失眠·夜看的哲学书", author: "张萨达", publisher: "新华出版社", location: .beijing, cover: "book-cover-2", isbn: "123478747585", description: "还没有描述信息"))
}
