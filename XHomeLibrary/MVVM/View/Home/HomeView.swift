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
        VStack {
            header

            Spacer()

            honeycomb

            Spacer()
        }
        .padding(.horizontal)
    }

    var header: some View {
        HStack {
            HStack(spacing: 2) {
                Picker("选择器", selection: $shelfVM.selectedLoc) {
                    ForEach(BookshelfViewModel.Location.allCases) { location in
                        Text(location.descripte).tag(location)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 75, alignment: .center)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .scaledToFit()

                TextField("输入书名...", text: $shelfVM.keyword)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            Button {
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

    var honeycomb: some View {
        ForEach(0...shelfVM.recBooks.count, id: \.self) { bookIndex in
            if bookIndex == 1 {
                HStack(spacing: 20) {
                    ForEach(0...bookIndex, id: \.self) { i in
                        Image(shelfVM.recBooks[i].cover)
                            .resizable()
                            .modifier(HoneycombImageModifer())
                    }
                }
            } else if bookIndex == 4 {
                HStack(spacing: 20) {
                    ForEach(2...bookIndex, id: \.self) { i in
                        Image(shelfVM.recBooks[i].cover)
                            .resizable()
                            .modifier(HoneycombImageModifer())
                    }
                }
            } else if bookIndex == 6 {
                HStack(spacing: 20) {
                    ForEach(5...bookIndex, id: \.self) { i in
                        Image(shelfVM.recBooks[i].cover)
                            .resizable()
                            .modifier(HoneycombImageModifer())
                    }
                }
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
            }
        }

//        return HStack(spacing: 20) {
//            Image("book-cover-1")
//                .resizable()
//                .modifier(HoneycombImageModifer())
//
//            Image("book-cover-0")
//                .resizable()
//                .modifier(HoneycombImageModifer())
//        }
    }
}

#Preview {
    HomeView()
        .background(Color.xgrayBg)
}
