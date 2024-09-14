//
//  GameView.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 13/09/2024.
//

import SwiftUI

struct GameView: View {

    // MARK: - Constants

    private enum C {

        static let fieldCornerRadius: CGFloat = 12

    }

    // MARK: - Properties

    @StateObject private var viewModel: GameViewModel = .init()

    // MARK: - Body

    var body: some View {
        VStack {
            Text("Wordle")
                .font(.largeTitle)
                .fontWeight(.heavy)

            VStack(spacing: 12) {
                ForEach(viewModel.lines) { line in
                    HStack {
                        ForEach(line.chars) { char in
                            RoundedRectangle(cornerRadius: C.fieldCornerRadius)
                                .stroke(.black, lineWidth: viewModel.lines[viewModel.guessedLineIndex] == line ? 6 : 3)
//                                .background(type.color)
                                .cornerRadius(radius: C.fieldCornerRadius)
                                .frame(maxWidth: 45, maxHeight: 55)
                                .overlay {
                                    Text("\(char.value ?? " ")")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                }
                                .animation(.default, value: viewModel.guessedLineIndex)
                        }
                    }
                }
            }
            .padding(.bottom, 16)
            .frame(maxHeight: .infinity, alignment: .center)

            GameKeyboard(onKeyPress: viewModel.addChar(_:), onBackspaceKeyPress: viewModel.removeChar)

            CustomButton(title: "Submit") {
                viewModel.submit()
            }
            .disabled(!viewModel.isCurrentGuessedLineFilled)
        }
        .padding()
    }

}

#Preview {
    GameView()
}
