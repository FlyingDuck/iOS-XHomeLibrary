//
//  MainView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import CoreData
import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var bookWatcher = BookWatcher.shared
    @StateObject var tabVM: TabViewModel = .init()
    @ObservedObject private var localShelfVM: LocalShelfViewModel
    @ObservedObject var addingBookVM: BookViewModel

    init(context: NSManagedObjectContext) {
        print("init MainView")
        self.localShelfVM = LocalShelfViewModel(context: context)
        self.addingBookVM = BookViewModel(book: Book.newEmptyBook(), context: context)
    }

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
                    .environmentObject(self.localShelfVM)
                    .environmentObject(self.addingBookVM)

                LocalShelfView()
                    .badge(localShelfVM.getTotal())
                    .padding(.vertical, 1)
                    .background(Color.xgrayTab)
                    .tabItem {
                        TabViewModel.Tab.bookshelf.icon
                        TabViewModel.Tab.bookshelf.title
                    }
                    .tag(TabViewModel.Tab.bookshelf)
                    .environmentObject(self.localShelfVM)
                    .sheet(isPresented: $bookWatcher.showBookDetail) {
                        print("close local shelf sheet")
                        bookWatcher.clear()
                    } content: {
                        BookDetailView(book: bookWatcher.getBookDetail(), context: context)
                            .environmentObject(self.localShelfVM)
                    }
            }
            .navigationTitle(tabVM.getCurrentTab().title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Group {
        let context = PersistenceController.shared.container.viewContext
        MainView(context: context)
            .environment(\.managedObjectContext, context)
    }
}
