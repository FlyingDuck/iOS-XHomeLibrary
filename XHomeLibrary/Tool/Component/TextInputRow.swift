//
//  TextInputRow.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwiftUI

struct TextInputRow: View {
    var title: String
    @Binding var text : String
    
    var body: some View {
        HStack(spacing: 15) {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .frame(width: 50, alignment: .leading)
            VStack(spacing: 2) {
                TextField("", text: $text)
                    .padding(.horizontal, 10)
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    TextInputRow(title: "项目", text: .constant("预览"))
}
