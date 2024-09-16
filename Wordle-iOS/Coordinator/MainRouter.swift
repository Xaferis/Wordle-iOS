//
//  MainRouter.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 16/09/2024.
//

import SwiftUI

final class MainRouter: Routable {

    enum Route: Hashable {

        case game

    }

    @Published var pushStack: [Route] = []

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .game:
            GameView(viewModel: .init(router: self))
        }
    }

}
