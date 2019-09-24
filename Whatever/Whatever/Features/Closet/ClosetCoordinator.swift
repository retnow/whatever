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
    internal override func generateRootViewController() -> UINavigationController {
        let navigationController = NavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }

    init() {
        super.init(initialRoute: .yourCloset)
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
