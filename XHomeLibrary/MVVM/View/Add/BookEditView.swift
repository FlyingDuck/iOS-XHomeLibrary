//
//  EditBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import SwiftUI

struct BookEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bookVM: BookViewModel
    @EnvironmentObject private var localShelfVM: LocalShelfViewModel
    
    var body: some View {
        ScrollView {
            baseInfo
            additionalInfo
            
            Spacer()
            footer
        }
        .scrollIndicators(.hidden)
    }
    
    var baseInfo: some View {
        HStack {
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
                }
                .frame(height: 150)
                
                TextInputRow(title: "书名", text: $bookVM.book.name)
                TextInputRow(title: "作者", text: $bookVM.book.author)
                TextInputRow(title: "出版社", text: $bookVM.book.publisher)
                TextInputRow(title: "ISBN", text: $bookVM.book.isbn).keyboardType(.numberPad)
            }
            
            HStack {
                Divider().background(Color.white.opacity(0.2))
                Button {
                    // todo something
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 30, weight: .regular, design: .monospaced))
                        .foregroundColor(.accentColor.opacity(0.7))
                        .shadow(color: .accentColor, radius: 10, x: 0, y: 0)
                        .frame(maxHeight: .infinity)
                }
            }
            .padding(.leading)
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
                    Text(Location.beijing.displayName).tag(Location.beijing)
                    Text(Location.tangshan.displayName).tag(Location.tangshan)
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
            }
        }
        .padding(.all, 20)
        .background(Color.xwhiteCard)
        .frame(width: UIScreen.main.bounds.width)
    }
    
    var footer: some View {
        HStack {
            Button {
                if self.bookVM.book.isNew() {
                    self.bookVM.addNewBook()
                    self.bookVM.resetBook()
                    self.localShelfVM.search()
                } else {
                    self.bookVM.updateBook()
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            } label: {
                Label("保存", systemImage: "checkmark")
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .padding(.vertical)
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
        .environmentObject(BookViewModel(book: Book(name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "book-cover-1", isbn: "123478747585", description: ""),
                                         context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        )
}
