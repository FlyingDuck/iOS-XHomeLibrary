//
//  Location.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import SwiftUI

enum Location : CaseIterable, Identifiable {
    case all
    case beijing
    case tangshan

    var id: Self {
        self
    }
}

extension Location {
    func descripte() -> String {
        switch self {
        case .all:
            return "所有"
        case .beijing:
            return "北京"
        case .tangshan:
            return "唐山"
        }
    }
}
