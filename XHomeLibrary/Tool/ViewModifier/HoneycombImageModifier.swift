//
//  HoneycombImageModifier.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/25.
//

import SwiftUI

struct HoneycombImageModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 60, height: 60)
            .padding(.all, 10)
            .scaleEffect(1.3)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(Color.black.opacity(0.7), lineWidth: 3)
                // .rotationEffect(Angle(degrees: -45))
            )
            .rotationEffect(Angle(degrees: -45))
            .shadow(color:  .black.opacity(0.5), radius: 10, x: 10, y: 10)
        
    }
    
}
