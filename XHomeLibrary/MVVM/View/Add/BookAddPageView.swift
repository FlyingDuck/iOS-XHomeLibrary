//
//  AddBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct BookAddPageView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var bookVM : BookViewModel
    
    init() {
        print("init BookAddPageView")
    }

    var body: some View {
            VStack {
                BookEditView(editing: false)
                    .environmentObject(bookVM)
            }
            .background(Color.xgrayBg)
    }
}

#Preview {
    NavigationStack {
        let context = PersistenceController.shared.container.viewContext
        BookAddPageView()
            .background(Color.xgrayBg)
            .environment(\.managedObjectContext, context)
            .environmentObject(BookViewModel(book: Book.newEmptyBook(), context: context))
    }
}
