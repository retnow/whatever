//
//  ClosetCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 18/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator

enum ClosetRoute: Route {
    case yourCloset
    case addItem
}

final class ClosetCoordinator: NavigationCoordinator<ClosetRoute> {
    init() {
        let nc = NavigationController()
        super.init(
            rootViewController: nc,
            initialRoute: .yourCloset)
    }

    override func prepareTransition(
        for route: ClosetRoute) -> NavigationTransition {
        switch route {
        case .yourCloset:
            let vc = YourClosetViewController()
            return .show(vc)

        case .addItem:
            let vc = UIViewController()
            return .present(vc)
        }
    }
}
