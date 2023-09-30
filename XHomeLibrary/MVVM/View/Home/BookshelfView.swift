//
//  BookshelfView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/27.
//

import SwiftUI

struct BookshelfView: View {
    @ObservedObject var bookWatcher = BookWatcher.shared
    
    @EnvironmentObject var shelfVM: BookshelfViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                header
                if shelfVM.isShelfEmpty() {
                    emptylist
                } else {
                    booklist // 书籍列表
                }
            }
            .padding(.horizontal)
            .background(Color.xgrayBg)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .sheet(isPresented: $bookWatcher.showBookDetail) {
            print("close book shelf sheet")
            bookWatcher.clear()
        } content: {
            if bookWatcher.showBookDetail {
                BookDetailView(book: bookWatcher.showBook)
            }
        }
    }
    
//    @ToolbarContentBuilder
//    var toolbar: some ToolbarContent {
//        ToolbarItem(placement: .navigationBarLeading) {
//            Image(systemName: "chevron.backward")
//                .background(Color.gray.opacity(0.2))
//                .clipShape(Circle())
//                .onTapGesture {
//                    dismiss()
//                }
//        }
//        ToolbarItem(placement: .principal) {
//            Text("云书架")
//                .font(.system(size: 20, weight: .regular, design: .rounded))
//        }
    ////        ToolbarItem(placement: .navigationBarTrailing) {
    ////            Image(systemName: "ellipsis").rotationEffect(Angle(degrees: 90))
    ////        }
//    }
    
    var header: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .font(.system(size: 20))
                .foregroundColor(.black.opacity(0.5))
//                .rotationEffect(Angle(degrees: 180))
//                .background(Color.gray.opacity(0.2))
//                .clipShape(Circle())
                .onTapGesture {
                    dismiss()
                    shelfVM.clear()
                    bookWatcher.clear()
                }
            
            HStack(spacing: 2) {
                Picker("选择器", selection: $shelfVM.selectedLoc) {
                    ForEach(Location.allCases) { location in
                        Text(location.displayName).tag(location)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 75, alignment: .center)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .scaledToFit()

                TextField("输入书名...", text: $shelfVM.keyword)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            Button {
                shelfVM.search()
            } label: {
                Text("搜索")
            }
            .padding(.all, 10)
            .background(Color.blue.opacity(0.6))
            .foregroundColor(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
    
    var booklist: some View {
        ScrollView {
            HStack {
                Text("共找到 \(shelfVM.getShelfTotal()) 条结果")
                    .font(.system(size: 12, weight: .thin, design: .default))
                    .underline(true, color: Color.gray)
                    .italic(true)
                Spacer()
            }

            ForEach(shelfVM.books, id: \.self.id) { book in
                BookItemCard(book: book)
            }

            HStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                    .foregroundColor(Color.gray.opacity(0.5))
                Text("到底了")
                    .font(.system(size: 12, weight: .thin, design: .default))
                    .italic()
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                    .foregroundColor(Color.gray.opacity(0.5))
            }.padding(.top)
        }
        .scrollIndicators(.hidden)
    }

    var emptylist: some View {
        VStack(spacing: 20) {
            Image(systemName: "tray.2")
                .font(.system(size: 30, weight: .thin, design: .default))
            Text("这里空空如也")
                .font(.system(size: 20, weight: .thin, design: .rounded))
                .foregroundColor(Color.black.opacity(0.7))
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
    }
}

#Preview {
    BookshelfView()
        .environmentObject(BookshelfViewModel())
}
