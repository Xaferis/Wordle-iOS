//
//  GuessedLine.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 14/09/2024.
//

struct GuessedLine: Identifiable, Equatable {

    struct Char: Identifiable, Equatable {

        var id: String
        var value: Character?

    }

    init(id: String) {
        self.id = id

        chars = (1...5).map { Char(id: id.appending("\($0)")) }
    }

    var id: String
    var chars: [Char]

    var isLineFilled: Bool {
        chars.allSatisfy { char in char.value != nil }
    }

    mutating func changeChar(to char: Character?, at index: Int) {
        chars[index].value = char
    }

}
