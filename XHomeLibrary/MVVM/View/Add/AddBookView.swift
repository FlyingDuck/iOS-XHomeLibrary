//
//  AddBookView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct AddBookView: View {
    var body: some View {
        NavigationView {
            EditBookView()
        }
    }
}

#Preview {
    NavigationStack {
        AddBookView()
            .background(Color.xgrayBg)
    }
}
