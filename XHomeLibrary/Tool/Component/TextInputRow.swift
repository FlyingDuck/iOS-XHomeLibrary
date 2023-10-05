//
//  TextInputRow.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/29.
//

import SwifterSwift
import SwiftUI

struct TextInputRow: View {
    var title: String
    @Binding var text: String

    @State var valid: Bool = true
    let textValidate: (_ text: String) -> Bool

    var body: some View {
        HStack(spacing: 15) {
            Text(title)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .frame(width: 50, alignment: .leading)
                
            VStack(spacing: 2) {
                TextField("", text: $text, onEditingChanged: { editing in
                    print("onEditingCHanged: \(title) \(editing)")
                    if !editing {
                        self.valid = self.textValidate(self.text)
                    }
                })
                .onSubmit {
                    self.valid = self.textValidate(self.text)
                }
                .font(.system(size: 12))
                .foregroundColor(self.valid ? .black : .red)
                Rectangle()
                    .fill(self.valid ? Color.gray.opacity(0.5) : .red)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    TextInputRow(title: "项目", text: .constant("预览")) { text in
        print(text)
        return false
    }
}
