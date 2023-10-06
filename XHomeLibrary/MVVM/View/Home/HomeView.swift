//
//  HomeView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var remoteShelfVM: RemoteShelfViewModel = .init()
    @ObservedObject var bookWatcher = BookWatcher.shared
    
    init() {
        print("init homeView")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HoneyCombView(recommandBooks: bookWatcher.refreshRecommandBooks())
                    .environmentObject(remoteShelfVM)
            }
            .navigationBarTitle("首页", displayMode: .inline)
            .searchable(text: $remoteShelfVM.keyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "输入书名")
            .onChange(of: remoteShelfVM.keyword, perform: { value in
                print("onChange: keyword=\(remoteShelfVM.keyword)")
            })
            .onSubmit(of: [.search]) {
                print("onSubmit: keyword=\(remoteShelfVM.keyword)")
                remoteShelfVM.goShelf()
                remoteShelfVM.search()
            }
        }
        .fullScreenCover(isPresented: $remoteShelfVM.show, content: {
            BookshelfView()
                .environmentObject(remoteShelfVM)
        })
        
    }

    var header: some View {
        VStack(spacing: 30) {
            HStack {
                HStack(spacing: 2) {
                    TextField("输入书名...", text: $remoteShelfVM.keyword)
                        .padding(10)
                        .background(Color.xgrayBg)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                Button {
                    remoteShelfVM.goShelf()
                    remoteShelfVM.search()
                } label: {
                    Text("搜索")
                }
                .padding(.all, 10)
                .background(Color.blue.opacity(0.6))
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }

//            VStack {
//                Text("读书之法，在循序渐进，熟读而精思。")
//                    .padding(.horizontal, 20)
//                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
//                Text("—— 朱熹")
//                    .padding(.horizontal, 20)
//                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
//            }
        }
    }
}

#Preview {
    HomeView()
        .background(Color.xgrayBg)
}
