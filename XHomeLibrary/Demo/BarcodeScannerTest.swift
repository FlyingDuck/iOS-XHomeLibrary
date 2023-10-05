//
//  BarcodeScannerTest.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/4.
//

import BarcodeScanner
import SwiftUI

struct BarcodeScannerTest: View {
    @State var code: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("条形码: \(code)")
            
            NavigationView {
                NavigationLink {
                    CodeScanner { code in
                        print("goto fetch data from network: code=\(code)")
                    }
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 50, weight: .regular, design: .monospaced))
                        .foregroundColor(.accentColor.opacity(0.7))
                        .shadow(color: .accentColor, radius: 10, x: 0, y: 0)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    BarcodeScannerTest()
}
