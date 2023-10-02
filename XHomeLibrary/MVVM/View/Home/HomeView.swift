//
//  HomeView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct HomeView: View {
//    @ObservedObject var bookWatcher = BookWatcher.shared
    @StateObject var shelfVM: BookshelfViewModel = .init()
    
    init() {
        print("init homeView")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                header.padding(.top, 5)
                HoneyCombView()
                    .background(Color.xgrayBg)
                    .environmentObject(shelfVM)
            }
            .background(Color.xgrayTab)
            .padding(.horizontal)
        }
        .fullScreenCover(isPresented: $shelfVM.show, content: {
            BookshelfView()
                .environmentObject(shelfVM)
        })
        
    }

    var header: some View {
        VStack(spacing: 30) {
            HStack {
                HStack(spacing: 2) {
                    TextField("输入书名...", text: $shelfVM.keyword)
                        .padding(10)
                        .background(Color.xgrayBg)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                Button {
                    shelfVM.goShelf()
                    shelfVM.search()
                } label: {
                    Text("搜索")
                }
                .padding(.all, 10)
                .background(Color.blue.opacity(0.6))
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }

//            VStack {
//                Text("读书之法，在循序渐进，熟读而精思。")
//                    .padding(.horizontal, 20)
//                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
//                Text("—— 朱熹")
//                    .padding(.horizontal, 20)
//                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
//            }
        }
    }
}

#Preview {
    HomeView()
        .background(Color.xgrayBg)
}
