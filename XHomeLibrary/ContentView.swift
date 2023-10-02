//
//  ContentView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        MainView(context: context)
    }
}

#Preview {
    ContentView()
}
