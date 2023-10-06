//
//  HoneyCombView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct HoneyCombView: View {
    @ObservedObject var bookWatcher = BookWatcher.shared
    
    @State private var recommandBooks : [Book]
    
    init(recommandBooks: [Book]) {
        self.recommandBooks = recommandBooks
        print("init HoneyCambView: recommandBooks=\(self.recommandBooks.count)")
    }

    var body: some View {
        ScrollView {
            honeycomb
        }
        .refreshable {
            self.recommandBooks = bookWatcher.refreshRecommandBooks()
        }
    }

    var honeycomb: some View {
        VStack(alignment: .center) {
            HStack {
                // 占位
            }.frame(width: UIScreen.main.bounds.width, height: 40)

            HStack(spacing: 20) {
                ForEach(recommandBooks[0...1], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(recommandBooks[2...4], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(recommandBooks[5...6], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(recommandBooks[7...9], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(recommandBooks[10...11], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    HoneyCombView(recommandBooks: [])
        .environmentObject(RemoteShelfViewModel())
}
