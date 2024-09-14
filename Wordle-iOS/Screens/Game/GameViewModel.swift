//
//  GameViewModel.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 13/09/2024.
//

import SwiftUI

final class GameViewModel: ObservableObject {

    // MARK: - Properties

    @Published var lines: [GuessedLine]
    @Published var guessedLineIndex: Int
    @Published var guessedLineCharIndex: Int

    // MARK: - Computed

    var isCurrentGuessedLineFilled: Bool { lines[guessedLineIndex].isLineFilled }

    // MARK: - Initializers

    init() {
        lines = (1...6).map { GuessedLine(id: "\($0)") }
        guessedLineIndex = 0
        guessedLineCharIndex = 0
    }

}

// MARK: - Public

extension GameViewModel {

    func addChar(_ char: Character) {
        guard guessedLineCharIndex < 5 else { return }

        lines[guessedLineIndex].changeChar(to: char, at: guessedLineCharIndex)
        guessedLineCharIndex += 1

        print(guessedLineCharIndex)
    }

    func removeChar() {
        guard guessedLineCharIndex > 0 else { return }

        lines[guessedLineIndex].changeChar(to: nil, at: guessedLineCharIndex - 1)
        guessedLineCharIndex -= 1

        print(guessedLineCharIndex)
    }

    func submit() {
        guard isCurrentGuessedLineFilled else { return }

        guessedLineIndex += 1
        guessedLineCharIndex = 0

        print("Submit")
        print("line index \(guessedLineIndex)")
        print("char index \(guessedLineCharIndex)")
    }

}
