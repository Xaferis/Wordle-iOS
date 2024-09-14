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

    @State var correctPositionKeys: [Character] = []
    @State var wrongPositionKeys: [Character] = []
    @State var notPresentKeys: [Character] = []

    @State private var viewWidth: CGFloat = 0

    let onKeyPress: Callback<Character>
    let onBackspaceKeyPress: VoidClosure

    var keyWidth: CGFloat {
        let firstRowCount = qwertyRows[0].count
        let spacing = CGFloat(firstRowCount * 4)

        return (viewWidth - spacing) / CGFloat(firstRowCount)
    }

    var backspaceKeyWidth: CGFloat { keyWidth * 1.5 }

    var body: some View {
        VStack(spacing: 8) {
            ForEach(qwertyRows, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            hapticFeedback.impactOccurred()

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
                    self.viewWidth = geometry.size.width
                    print("\(qwertyRows[0].count)")
                    print("\(viewWidth)")
                }
        })
    }

    func colorOfTheKey(_ key: Character) -> Color {
        if correctPositionKeys.contains(key) {
            return .teal
        } else if wrongPositionKeys.contains(key) {
            return .orange
        } else {
            return .gray.opacity(0.2)
        }
    }

}

#Preview {
    GameKeyboard(onKeyPress: { _ in }, onBackspaceKeyPress: {})
}
