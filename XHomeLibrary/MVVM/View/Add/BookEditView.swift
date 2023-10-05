//
//  EditBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import Kingfisher
import SPAlert
import SwiftUI

struct BookEditView: View {
    @ObservedObject var bookWatcher = BookWatcher.shared
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bookVM: BookViewModel
    @EnvironmentObject private var localShelfVM: LocalShelfViewModel
  
    var editing: Bool // 是否是编辑页，false-新增页
    
    init(editing: Bool = true) {
        print("init BookEditView: editing=\(editing)")
        self.editing = editing
    }
    
    var body: some View {
        ScrollView {
                baseInfo
                additionalInfo
                
                Spacer()
                footer
        }
        .scrollIndicators(.hidden)
        .dismissKeyboard()
        .padding(.horizontal, 5)
    }
    
    var baseInfo: some View {
        HStack {
            VStack(spacing: 30) {
                HStack {
                    Text("封面")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .frame(width: 50, alignment: .leading)
                    Spacer()
                    
                    HStack(spacing: 40) {
                        if bookVM.book.isLocal() {
                            let image = bookVM.getLocalBookCoverUIImage()
                            if image.size == .zero {
                                Image(systemName: "questionmark")
                                    .font(.system(size: 40, weight: .light, design: .monospaced))
                                    .foregroundColor(.orange.opacity(0.4))
                                    .frame(width: 100)
                            } else {
                                Image(uiImage: bookVM.getLocalBookCoverUIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            }
                        } else {
                            KFImage(URL(string: bookVM.book.cover))
                                .placeholder {
                                    Image(systemName: "questionmark")
                                        .font(.system(size: 40, weight: .light, design: .monospaced))
                                        .foregroundColor(.orange.opacity(0.4))
                                        .frame(width: 100)
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        }
                        
                        VStack(spacing: 40) {
                            NavigationLink(destination: {
                                PhotoPickerView()
                                    .environmentObject(bookVM)
                            }, label: {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor.opacity(0.6))
                                    .shadow(color: .accentColor, radius: 15, x: 0, y: 0)
                                    .frame(width: 20)
                            })
                            
                            NavigationLink(destination: {
                                PhotoPickerView(sourceType: .camera)
                                    .environmentObject(bookVM)
                            }, label: {
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor.opacity(0.6))
                                    .shadow(color: .accentColor, radius: 15, x: 0, y: 0)
                                    .frame(width: 20)
                            })
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
                
                NavigationLink {
                    CodeScannerView()
                        .environmentObject(bookVM)
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 30, weight: .thin, design: .monospaced))
                        .foregroundColor(.accentColor.opacity(0.7))
                        .shadow(color: .accentColor, radius: 10, x: 0, y: 0)
                        .frame(maxHeight: .infinity)
                }
            }
            .padding(.leading)
        }
        .padding(.all, 20)
        .background(Color.xwhiteCard)
        .frame(maxWidth: UIScreen.main.bounds.width)
        .cornerRadius(10)
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
        .frame(maxWidth: UIScreen.main.bounds.width)
        .cornerRadius(10)
    }
    
    var footer: some View {
        HStack {
            Button {
                // TODO: 这里还需要区分是本地上传还是远端上传
                if self.editing {
                    let editingAlert = SPAlertView(title: "保存中", message: "正在修改《\(self.bookVM.book.name)》信息，请稍等", preset: .spinner)
                    editingAlert.duration = .infinity
                    editingAlert.present()
                    
                    self.bookVM.updateLocalBook()
                    self.bookWatcher.setBookDetail(book: bookVM.book)
                    self.localShelfVM.refresh()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        editingAlert.dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                } else {
                    let addingAlert = SPAlertView(title: "保存中", message: "正在添加《\(self.bookVM.book.name)》信息，请稍等", preset: .spinner)
                    addingAlert.duration = .infinity
                    addingAlert.present()
                    
                    self.bookVM.addLocalBook()
                    self.bookVM.reset()
                    self.bookWatcher.clear()
                    self.localShelfVM.refresh()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        addingAlert.dismiss()
                    }
                }
                
            } label: {
                HStack {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16))
                    Text("保存")
                        .font(.system(size: 16, weight: .regular, design: .default))
                }
                .padding(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.accentColor.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(15)
            }
            
        }
//        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        VStack {
            let context = PersistenceController.shared.container.viewContext
            BookEditView(editing: true)
                .environmentObject(BookViewModel(
                    //                    book: Book.newEmptyBook(),
                    book: Book(name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "ttps://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: ""),
                    context: context)
                )
        }
        .background(Color.red)
    }
}
