//
//  Routable.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 16/09/2024.
//

import SwiftUI

@MainActor
protocol Routable: ObservableObject {

    // MARK: - Associated types

    associatedtype RouteType: Hashable
    associatedtype Body: View

    // MARK: - Properties

    var pushStack: [RouteType] { get set }

    // MARK: - Functions

    @ViewBuilder
    func view(for route: RouteType) -> Body
    func push(to route: RouteType)
    func pop()

}

// MARK: - Public implementation

extension Routable {

    func push(to route: RouteType) {
        pushStack.append(route)
    }

    func pop() {
        _ = pushStack.popLast()
    }

    func popToRoot() {
        pushStack.removeAll()
    }
 
}
