//
//  HomeView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var shelfVM: BookshelfViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                header.padding(.top, 5)
                HoneyCombView().environmentObject(shelfVM)
            }
            .padding(.horizontal)
            .background(Color.xgrayBg)
        }
        .fullScreenCover(isPresented: $shelfVM.show, content: {
            BookshelfView().environmentObject(shelfVM)
        })
    }

    var header: some View {
        HStack {
            HStack(spacing: 2) {
                TextField("输入书名...", text: $shelfVM.keyword)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
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
    }
}

#Preview {
    HomeView()
        .background(Color.xgrayBg)
}
