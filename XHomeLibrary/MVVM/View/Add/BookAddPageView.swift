//
//  AddBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct BookAddPageView: View {
    var body: some View {
        NavigationView {
            VStack {
//                HStack {}.frame(width: UIScreen.main.bounds.width, height: 1)
                BookEditView()
            }
            .background(Color.xgrayBg)
        }
    }
}

#Preview {
    NavigationStack {
        BookAddPageView()
            .background(Color.xgrayBg)
    }
}
