//
//  BookshelfView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct LocalBookshelfView: View {
    @StateObject var shelfVM: LocalBookshelfViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                // 头部：搜索栏
                header
                
                if shelfVM.isEmpty() {
                    emptylist
                } else {
                    // 书籍列表
                    booklist
                }
            }
            .padding(.horizontal)
            .background(Color.xgrayBg)
        }
    }

    var header: some View {
        HStack {
            TextField("输入书名...", text: $shelfVM.keyword)
                .padding(10)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

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
                Text("共找到 \(shelfVM.getTotal()) 条结果")
                    .font(.system(size: 12, weight: .thin, design: .default))
                    .underline(true, color: Color.gray)
                    .italic(true)
                Spacer()
            }

            ForEach(shelfVM.books, id: \.self.id) { book in
                BookItemView(book: book)
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
    LocalBookshelfView()
        .background(Color.xgrayBg.opacity(0.5))
}
