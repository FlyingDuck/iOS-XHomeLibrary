//
//  TabViewModel.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

class TabViewModel: ObservableObject {
    @Published var tab: Tab = .home
    
    enum Tab: CaseIterable {
        case home
        case bookshelf
//        case mine
        case add
        
        var icon: Image {
            switch self {
            case .home:
                return Image(systemName: "house.fill")
            case .bookshelf:
                return Image(systemName: "books.vertical.fill")
//            case .mine:
//                return Image(systemName: "person.fill")
            case .add:
                return Image(systemName: "note.text.badge.plus")
            }
        }
        
        var title: Text {
            switch self {
            case .home:
                return Text("首页")
            case .bookshelf:
                return Text("本地书架")
//            case .mine:
//                return Text("我的")
            case .add:
                return Text("新增图书")
            }
        }
    }
}

extension TabViewModel {
    func getCurrentTab() -> Tab {
        return self.tab
    }
    
    
    
}
