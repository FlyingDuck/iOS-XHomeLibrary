//
//  UnderlineButtonView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct UnderlineTextField: View {
    @Binding var text : String
    
    var body: some View {
        VStack(spacing: 2) {
            TextField("", text: $text)
                .padding(.horizontal, 10)
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
        }
    }
}

#Preview {
    UnderlineTextField(text: .constant(""))
}
