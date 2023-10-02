//
//  BookshelfView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import CoreData
import SwiftUI

struct LocalShelfView: View {
    @EnvironmentObject private var shelfVM: LocalShelfViewModel
    
    init() {
        print("init LocalShelfView")
    }

    var body: some View {
        NavigationView {
            VStack {
                // 头部：搜索栏
                header
                if shelfVM.isEmpty() {
                    // 空页面
                    emptylist
                } else {
                    // 书籍列表
                    booklist
                        
                }
            }
            .background(Color.xgrayTab)
        }
    }

    var header: some View {
        HStack {
            Button(action: {
                // 上传
            }, label: {
                Image(systemName: "icloud.and.arrow.up")
                    .font(.system(size: 18, weight: .light, design: .default))
            })

            TextField("输入书名...", text: $shelfVM.keyword)
                .padding(10)
                .background(Color.xgrayBg)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            Button {
                shelfVM.search()
            } label: {
                Text("搜索")
            }
            .padding(.all, 10)
            .background(Color.blue.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .padding(.top, 5)
        .padding(.horizontal)
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
            .padding(.top, 5)

            ForEach(shelfVM.books, id: \.self.id) { book in
                BookItemCard(book: book)
            }

            HStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                    .foregroundColor(Color.gray.opacity(0.5))
                Text("到底了")
                    .font(.system(size: 12, weight: .thin, design: .default))
                    .foregroundColor(Color.gray)
                    .italic()
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                    .foregroundColor(Color.gray.opacity(0.5))
            }.padding(.top)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .background(Color.xgrayBg)
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
    

    NavigationStack {
        let context = PersistenceController.shared.container.viewContext
        
        LocalShelfView()
            .environmentObject(LocalShelfViewModel(context: context))
            .environment(\.managedObjectContext, context)
            .background(Color.red)
    }
}
