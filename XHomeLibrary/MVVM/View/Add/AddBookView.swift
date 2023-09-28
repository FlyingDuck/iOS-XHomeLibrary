//
//  AddBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

class BookViewModel: ObservableObject {
    @Published var book: Book = .init(location: .beijing)
}

struct AddBookView: View {
    @EnvironmentObject var tabVM: TabViewModel
    @StateObject var bookVM: BookViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                baseInfo
                additionalInfo
                footer
                    .padding(.bottom)
            }
            .background(Color.xgrayBg)
        }
    }
    
    var toolbar: some View {
        Button {
            // todo something
        } label: {
            Image(systemName: "barcode.viewfinder")
                .font(.system(size: 20, weight: .regular, design: .monospaced))
        }
    }
    
    var baseInfo: some View {
        VStack(spacing: 30) {
            HStack() {
                Text("封面")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                Spacer()
                Button {
                    // todo something
                } label: {
//                    Image(systemName: "camera.viewfinder")
                    Image(systemName: "photo.artframe")
                        .font(.system(size: 100, weight: .ultraLight, design: .monospaced))
                        .foregroundColor(.gray.opacity(0.5))
                }
                
                Spacer()
                Divider()
                Button {
                    // todo something
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 30, weight: .regular, design: .monospaced))
                }
                
            }
            
            HStack(spacing: 15) {
                Text("书名")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                VStack(spacing: 2) {
                    TextField("", text: $bookVM.book.name)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                }
            }

            HStack(spacing: 15) {
                Text("作者")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                VStack(spacing: 2) {
                    TextField("", text: $bookVM.book.author)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                }
            }
            
            HStack(spacing: 15) {
                Text("出版社")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                VStack(spacing: 2) {
                    TextField("", text: $bookVM.book.publisher)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                }
            }
            
            HStack(spacing: 15) {
                Text("ISBN")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                VStack(spacing: 2) {
                    TextField("", text: $bookVM.book.isbn)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                }
            }
        }
        .padding(.all, 20)
        .background(Color.xwhiteCard)
        .frame(width: .infinity)
//        .textFieldStyle(.roundedBorder)
    }
    
    var additionalInfo: some View {
        VStack(spacing: 20) {
            HStack {
                Text("藏地")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .leading)
                Picker("选择器", selection: $bookVM.book.location) {
                    Text("北京").tag(BookshelfViewModel.Location.beijing)
                    Text("唐山").tag(BookshelfViewModel.Location.tangshan)
                }.pickerStyle(.segmented)
            }
            
            HStack(alignment: .top) {
                Text("备注")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 50, alignment: .topLeading)
                TextEditor(text: $bookVM.book.description)
                    .frame(height: 150)
                    .border(Color.gray, width: 1)
//                    .padding(.horizontal)
            }
        }
        .padding(.all, 20)
        .background(Color.xwhiteCard)
        .frame(width: .infinity)
    }
    
    var footer: some View {
        HStack {
//            Spacer()
            Button {
                // todo something
            } label: {
                Label("保存", systemImage: "checkmark")
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .padding(.vertical)
                    .background(Color.xwhiteCard)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            }
        }
//        .shadow(color: .white, radius: 5, x: 2, y: 2)
    }
}

#Preview {
    NavigationStack {
        AddBookView()
            .background(Color.xgrayBg)
    }
}
