//
//  GameViewModel.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 13/09/2024.
//

import Combine

@MainActor
final class GameViewModel: ObservableObject {

    // MARK: Router

    let router: MainRouter

    // MARK: - Properties

    @Published var lines: [GuessedLine]
    @Published var guessedLineIndex: Int
    @Published var guessedLineCharIndex: Int

    @Published var correctPositionChars = Set<Character>()
    @Published var wrongPositionChars = Set<Character>()
    @Published var notPresentChars = Set<Character>()

    private let guessedWord = "TRAIL"

    // MARK: - Computed

    var isCurrentGuessedLineFilled: Bool { lines[guessedLineIndex].isLineFilled }

    // MARK: - Initializers

    init(router: MainRouter) {
        lines = (1...6).map { GuessedLine(id: "\($0)") }
        guessedLineIndex = 0
        guessedLineCharIndex = 0

        self.router = router
    }

}

// MARK: - Public

extension GameViewModel {

    func addChar(_ char: Character) {
        guard guessedLineCharIndex < 5 else { return }

        lines[guessedLineIndex].changeChar(to: char, at: guessedLineCharIndex)
        guessedLineCharIndex += 1
    }

    func removeChar() {
        guard guessedLineCharIndex > 0 else { return }

        lines[guessedLineIndex].changeChar(to: nil, at: guessedLineCharIndex - 1)
        guessedLineCharIndex -= 1
    }

    func submit() {
        guard isCurrentGuessedLineFilled else { return }

        compare()

        if lines[guessedLineIndex].chars.allSatisfy({ $0.type == .rightPosition }) {
            Task {
                try await Task.sleep(for: .seconds(2))

                reset()
            }
        } else {
            guessedLineIndex += 1
            guessedLineCharIndex = 0
        }
    }

}

// MARK: - Private

private extension GameViewModel {

    func compare() {
        let mainWord = Array(guessedWord)

        lines[guessedLineIndex].chars.enumerated().forEach { index, char in
            guard let value = char.value else { return }

            if value == mainWord[index] {
                addToCorrectPosition(char: value)
                lines[guessedLineIndex].chars[index].type = .rightPosition
            } else if mainWord.contains(value) {
                addToWrongPosition(char: value)
                lines[guessedLineIndex].chars[index].type = .wrongPosition
            } else {
                notPresentChars.insert(value)
                lines[guessedLineIndex].chars[index].type = .notUsed
            }
        }
    }

    func addToCorrectPosition(char: Character) {
        wrongPositionChars.remove(char)
        correctPositionChars.insert(char)

    }

    func addToWrongPosition(char: Character) {
        guard !correctPositionChars.contains(char) else { return }

        wrongPositionChars.insert(char)
    }

    @MainActor
    func reset() {
        lines = (1...6).map { GuessedLine(id: "\($0)") }
        guessedLineIndex = 0
        guessedLineCharIndex = 0

        correctPositionChars.removeAll(keepingCapacity: false)
        wrongPositionChars.removeAll(keepingCapacity: false)
        notPresentChars.removeAll(keepingCapacity: false)
    }

}
