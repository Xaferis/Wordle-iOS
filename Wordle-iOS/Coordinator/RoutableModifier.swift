//
//  RoutableModifier.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 16/09/2024.
//

import SwiftUI

struct RoutableModifier<Router: Routable>: ViewModifier {

    @StateObject var router: Router

    func body(content: Content) -> some View {
        NavigationStack(path: $router.pushStack) {
            content
                .navigationDestination(for: Router.RouteType.self) {
                    router.view(for: $0)
                }
        }
    }

}

extension View {

    func routableRoot<Router: Routable>(router: Router) -> some View {
        modifier(RoutableModifier(router: router))
    }

}
