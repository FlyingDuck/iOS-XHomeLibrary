//
//  BarcodeScanner.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/4.
//

import BarcodeScanner
import SwiftUI

struct BarcodeScannerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var code: String
    let handleCode: (_ code: String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<BarcodeScannerView>) -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = context.coordinator
        viewController.errorDelegate = context.coordinator
        viewController.dismissalDelegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: BarcodeScannerViewController, context: UIViewControllerRepresentableContext<BarcodeScannerView>) {}

    final class Coordinator: NSObject, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
        var parent: BarcodeScannerView

        init(_ parent: BarcodeScannerView) {
            self.parent = parent
        }

        func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String, type: String) {
            print("Barcode Data: \(code)")
            print("Symbology Type: \(type)")
            parent.code = code

            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.parent.handleCode(code)
                if code.hasSuffix("4") {
                    controller.resetWithError(message: "还未接入网络")
                    print("set error")
                } else {
                    print("will dismiss")
                    // controller.dismiss(animated: true, completion: nil)
                    self.parent.presentationMode.wrappedValue.dismiss()
                }
            }
        }

        func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didReceiveError error: Error) {
            print("sacn error happened: \(error)")
        }

        func scannerDidDismiss(_ controller: BarcodeScanner.BarcodeScannerViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
