//
//  EditBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct BookEditView: View {
    @StateObject var bookVM: BookViewModel = .init(book: .init())

    var body: some View {
        ScrollView {
            baseInfo
            additionalInfo
            footer
        }
        .scrollIndicators(.hidden)
    }
    
    var baseInfo: some View {
        VStack(spacing: 30) {
            HStack {
                Text("封面")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                Spacer()
                
                if bookVM.book.cover.isEmpty {
                    Button {
                        // todo something
                    } label: {
                        Image(systemName: "photo.artframe")
                            .font(.system(size: 100, weight: .ultraLight, design: .monospaced))
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(maxHeight: .infinity)
                    }
                } else {
                    HStack {
                        Image(bookVM.book.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .overlay {
                                Button(action: {
                                    print("tap to change picture")
                                }, label: {
                                    Image(systemName: "camera.viewfinder")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.accentColor.opacity(0.2))
                                        .frame(width: 100)
                                })
                            }
                    }
                }
                
                Spacer()
                Divider()
                Button {
                    // todo something
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 30, weight: .regular, design: .monospaced))
                        .foregroundColor(.accentColor.opacity(0.7))
                }
            }
            .frame(height: 150)
            
            TextInputRow(title: "书名", text: $bookVM.book.name)
            TextInputRow(title: "作者", text: $bookVM.book.author)
            TextInputRow(title: "出版社", text: $bookVM.book.publisher)
            TextInputRow(title: "ISBN", text: $bookVM.book.isbn)
//                .keyboardType(.numberPad)
        }
        .padding(.all, 20)
        .background(Color.xwhiteCard)
        .frame(width: UIScreen.main.bounds.width)
    }
    
    var additionalInfo: some View {
        VStack(spacing: 20) {
            HStack {
                Text("藏地")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                Picker("选择器", selection: $bookVM.book.location) {
                    Text("北京").tag(BookshelfViewModel.Location.beijing)
                    Text("唐山").tag(BookshelfViewModel.Location.tangshan)
                }.pickerStyle(.segmented)
            }
            
            HStack(alignment: .top) {
                Text("备注")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .topLeading)
                TextEditor(text: $bookVM.book.description)
                    .font(.system(size: 12))
                    .frame(height: 150)
                    .border(Color.gray, width: 1)
//                    .padding(.horizontal)
            }
        }
        .padding(.all, 20)
        .background(Color.xwhiteCard)
        .frame(width: UIScreen.main.bounds.width)
    }
    
    var footer: some View {
        HStack {
            Button {
                // todo something
            } label: {
                Label("保存", systemImage: "checkmark")
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .padding(.vertical)
//                    .background(Color.xwhiteCard)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .stroke(Color.accentColor.opacity(0.8), lineWidth: 1)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
//        .shadow(color: .white, radius: 5, x: 2, y: 2)
    }
}

#Preview {
    BookEditView()
        .environmentObject(BookViewModel(
            //        book: .init()
            book: Book(id: "1", name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: "还没有描述信息")
        ))
}
