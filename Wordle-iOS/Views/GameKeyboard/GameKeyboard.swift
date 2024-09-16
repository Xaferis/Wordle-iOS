//
//  GameKeyboard.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 14/09/2024.
//

import SwiftUI

struct GameKeyboard: View {

    // MARK: - Constants

    let qwertyRows: [[Character]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M", "⌫"]
    ]
    let hapticFeedback = UIImpactFeedbackGenerator(style: .light)

    // MARK: - Properties

    @Binding var correctlyPlacedKeys: Set<Character>
    @Binding var wronglyPlacedKeys: Set<Character>
    @Binding var notPresentKeys: Set<Character>

    @State private var viewWidth: CGFloat = 200 // random value

    let onKeyPress: Callback<Character>
    let onBackspaceKeyPress: VoidClosure

    // MARK: - Computed

    var keyWidth: CGFloat {
        let firstRowCount = qwertyRows[0].count
        let spacing = CGFloat(firstRowCount * 4)

        return (viewWidth - spacing) / CGFloat(firstRowCount)
    }

    var backspaceKeyWidth: CGFloat { keyWidth * 1.5 }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 8) {
            ForEach(qwertyRows, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
//                            hapticFeedback.impactOccurred()

                            if key == "⌫" {
                                onBackspaceKeyPress()
                            } else {
                                onKeyPress(key)
                            }
                        }) {
                            Text("\(key)")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.black)
                                .frame(width: key == "⌫" ? backspaceKeyWidth : keyWidth, height: 50)
                                .background(colorOfTheKey(key))
                                .cornerRadius(5)
                        }
                    }
                }
                .offset(x: qwertyRows.last == row ? backspaceKeyWidth / 2 + 2 : .zero, y: .zero)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(GeometryReader { geometry in
            Color.clear
                .onAppear {
                    if geometry.size.width > 0 {
                        self.viewWidth = geometry.size.width
                    }
                }
        })
    }

}

// MARK: - Private

private extension GameKeyboard {

    func colorOfTheKey(_ key: Character) -> Color {
        switch key {
        case _ where correctlyPlacedKeys.contains(key):
            return .green

        case _ where wronglyPlacedKeys.contains(key):
            return .yellow

        case _ where notPresentKeys.contains(key):
            return .gray

        default:
            return .gray.opacity(0.2)
        }
    }

}

// MARK: - Preview

#Preview {
    GameKeyboard(
        correctlyPlacedKeys: .constant([]),
        wronglyPlacedKeys: .constant([]),
        notPresentKeys: .constant([]),
        onKeyPress: { _ in },
        onBackspaceKeyPress: {}
    )
}
