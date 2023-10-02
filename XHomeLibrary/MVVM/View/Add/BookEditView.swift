//
//  EditBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import CoreData
import Kingfisher
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
    }
    
    var baseInfo: some View {
        HStack {
            VStack(spacing: 30) {
                HStack {
                    Text("封面")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .frame(width: 50, alignment: .leading)
                    Spacer()
                    
                    if self.editing {
                        if bookVM.book.isLocal() {
                            Image(uiImage: bookVM.getLocalBookCoverUIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .overlay {
                                    NavigationLink(destination: {
                                        PhotoPickerView()
                                            .environmentObject(bookVM)
                                    }, label: {
                                        Image(systemName: "camera.viewfinder")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.accentColor.opacity(0.2))
                                            .frame(width: 100)
                                    })
                                }
                        } else {
                            KFImage(URL(string: bookVM.book.cover))
                                .placeholder {}
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                                .overlay {
                                    NavigationLink(destination: {
                                        PhotoPickerView()
                                            .environmentObject(bookVM)
                                    }, label: {
                                        Image(systemName: "camera.viewfinder")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.accentColor.opacity(0.2))
                                            .frame(width: 100)
                                    })
                                }
                        }
                    } else {
                        Image(uiImage: bookVM.getLocalBookCoverUIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .overlay {
                                Button(action: {
                                    print("goto photo picker")
                                    bookWatcher.setShowPhotoPicker()
                                }, label: {
                                    Image(systemName: "camera.viewfinder")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.accentColor.opacity(0.2))
                                        .frame(width: 100)
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
                Button {
                    print("go to scan barcode")
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
                // TODO: 这里还需要区分是本地上传还是远端上传
                if self.editing {
                    self.bookVM.updateLocalBook()
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.bookVM.addLocalBook()
                    self.bookVM.reset()
                    self.localShelfVM.search()
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
    NavigationView {
        VStack {
            let context = PersistenceController.shared.container.viewContext
            BookEditView(editing: false)
                .environmentObject(BookViewModel(
                    //                    book: Book.newEmptyBook(),
                    book: Book(name: "古文观止观止观止观止观止观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: ""),
                    context: context)
                )
        }
        .background(Color.xgrayBg)
    }
}
