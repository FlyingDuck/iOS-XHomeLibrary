//
//  HoneyCombView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct HoneyCombView: View {
    @ObservedObject var bookWatcher = BookWatcher.shared

    init() {
        print("init HoneyCambView")
    }

    var body: some View {
        ScrollView {
            honeycomb
        }
        .refreshable {
            bookWatcher.refreshRecommandBooks()
        }
    }

    var honeycomb: some View {
        VStack(alignment: .center) {
            HStack {
                // 占位
            }.frame(width: UIScreen.main.bounds.width, height: 40)

            HStack(spacing: 20) {
                ForEach(bookWatcher.recBooks[0...1], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(bookWatcher.recBooks[2...4], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(bookWatcher.recBooks[5...6], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(bookWatcher.recBooks[7...9], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack(spacing: 20) {
                ForEach(bookWatcher.recBooks[10...11], id: \.self.id) { book in
                    HoneycombImage(book: book)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    HoneyCombView()
        .environmentObject(RemoteShelfViewModel())
}
