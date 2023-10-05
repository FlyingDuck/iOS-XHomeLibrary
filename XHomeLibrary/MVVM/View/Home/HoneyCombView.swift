//
//  HoneyCombView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct HoneyCombView: View {
    @EnvironmentObject var shelfVM: RemoteShelfViewModel
    @ObservedObject var bookWatcher = BookWatcher.shared

    var body: some View {
        if shelfVM.recBooks.count != 0 {
            List {
                honeycomb
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        } else {
            // 空页面
            VStack {
                Spacer()
                Text("nothing")
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }

    var honeycomb: some View {
        VStack(alignment: .center) {
            HStack {
                // 占位
            }.frame(width: UIScreen.main.bounds.width, height: 40)

            ForEach(0...shelfVM.recBooks.count, id: \.self) { bookIndex in

                if bookIndex == 1 {
                    HStack(spacing: 20) {
                        ForEach(0...bookIndex, id: \.self) { i in
                            Image(shelfVM.recBooks[i].cover)
                                .resizable()
                                .modifier(HoneycombImageModifer())
                                .onTapGesture {
                                    bookWatcher.setBookDetail(book: shelfVM.recBooks[i])
                                }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)

                } else if bookIndex == 4 {
                    HStack(spacing: 20) {
                        ForEach(2...bookIndex, id: \.self) { i in
                            Image(shelfVM.recBooks[i].cover)
                                .resizable()
                                .modifier(HoneycombImageModifer())
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                } else if bookIndex == 6 {
                    HStack(spacing: 20) {
                        ForEach(5...bookIndex, id: \.self) { i in
                            Image(shelfVM.recBooks[i].cover)
                                .resizable()
                                .modifier(HoneycombImageModifer())
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                } else if bookIndex == 9 {
                    HStack(spacing: 20) {
                        ForEach(7...bookIndex, id: \.self) { i in
                            Image(shelfVM.recBooks[i].cover)
                                .resizable()
                                .modifier(HoneycombImageModifer())
                        }
                    }
                } else if bookIndex == 11 {
                    HStack(spacing: 20) {
                        ForEach(10...bookIndex, id: \.self) { i in
                            Image(shelfVM.recBooks[i].cover)
                                .resizable()
                                .modifier(HoneycombImageModifer())
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

#Preview {
    HoneyCombView()
        .environmentObject(RemoteShelfViewModel())
}
