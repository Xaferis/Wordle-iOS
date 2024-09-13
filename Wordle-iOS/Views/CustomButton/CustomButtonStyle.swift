//
//  CustomButtonStyle.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 13/09/2024.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {

    let isEnabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(backgroundColor(isPressed: configuration.isPressed))
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }

    func backgroundColor(isPressed: Bool) -> Color {
        if isEnabled {
            return isPressed
            ? .black.opacity(0.7)
            : .black
        } else {
            return .gray
        }
    }

}
