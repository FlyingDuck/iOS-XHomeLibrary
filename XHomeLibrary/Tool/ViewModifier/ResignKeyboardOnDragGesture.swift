//
//  ResignKeyboardOnDragGesture.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/3.
//

import SwiftUI

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func body(content: Content) -> some View {
        content
            .gesture(gesture)
    }
}

extension View {
    func dismissKeyboard() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

//struct HideKeyboardView: View {
//    @State private var name = ""
//    var body: some View {
//        Form {
//            TextField("Enter your name", text: $name)
//        }
//        .dismissKeyboard()
//    }
//}
