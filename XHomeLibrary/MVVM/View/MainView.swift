//
//  MainView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var bookWatcher = BookWatcher.shared

    @StateObject var tabVM: TabViewModel = .init()

    var body: some View {
        NavigationStack {
            TabView(selection: $tabVM.tab) {
                HomeView()
                    .padding(.vertical, 1)
                    .background(Color.xgrayTab)
                    .tabItem {
                        TabViewModel.Tab.home.icon
                        TabViewModel.Tab.home.title
                    }
                    .tag(TabViewModel.Tab.home)

                BookAddPageView()
                    .padding(.vertical, 1)
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
            }
            .navigationTitle(tabVM.getCurrentTab().title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
