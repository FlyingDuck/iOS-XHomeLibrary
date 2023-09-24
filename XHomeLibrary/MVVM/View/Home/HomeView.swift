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
}

#Preview {
    HomeView()
}
