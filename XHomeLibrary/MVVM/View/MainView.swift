//
//  MainView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var context
    
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

                LocalBookshelfView(context: context)
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
            .sheet(isPresented: $bookWatcher.showBookDetail) {
                print("close home sheet")
                bookWatcher.clear()
            } content: {
                if bookWatcher.showBookDetail {
                    BookDetailView(book: bookWatcher.showBook)
    //                    .interactiveDismissDisabled()  // 禁止滑动关闭sheet
                }
            }
        }
    }
}

#Preview {
    MainView()
}
