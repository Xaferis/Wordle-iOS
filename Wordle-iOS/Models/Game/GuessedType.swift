//
//  GuessedType.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 14/09/2024.
//

import SwiftUI

enum GuessedType {

    case rightPosition
    case wrongPosition
    case notUsed
    case none

    var color: Color {
        switch self {
        case .rightPosition:
            return .green

        case .wrongPosition:
            return .yellow

        case .notUsed:
            return .gray

        case .none:
            return .clear
        }
    }

}
