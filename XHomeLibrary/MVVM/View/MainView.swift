//
//  MainView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var tabVM: TabViewModel = .init()

    var body: some View {
        NavigationStack {
            TabView(selection: $tabVM.tab) {
                HomeView()
//                    .padding(.vertical, 1)
//                    .background(Color.xgrayTab)
                    .tabItem {
                        TabViewModel.Tab.home.icon
                        TabViewModel.Tab.home.title
                    }
                    .tag(TabViewModel.Tab.home)

                AddBookView()
//                    .padding(.vertical, 1)
                    .background(Color.xgrayTab)
                    .tabItem {
                        TabViewModel.Tab.add.icon
                        TabViewModel.Tab.add.title
                    }
                    .tag(TabViewModel.Tab.add)
                    .environmentObject(tabVM)

                LocalBookshelfView()
                    .padding(.vertical, 1)
                    .background(Color.xgrayTab)
                    .tabItem {
                        TabViewModel.Tab.bookshelf.icon
                        TabViewModel.Tab.bookshelf.title
                    }
                    .tag(TabViewModel.Tab.bookshelf)

//                MineView()
//                    .padding(.vertical, 1)
//                    .background(Color.gray.opacity(0.3))
//                    .tabItem {
//                        TabViewModel.Tab.mine.icon
//                        TabViewModel.Tab.mine.title
//                    }
//                    .tag(TabViewModel.Tab.mine)
            }
            .navigationTitle(tabVM.getCurrentTab().title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                Image(systemName: "text.badge.plus")
            }
        }
    }
}

#Preview {
    MainView()
}
