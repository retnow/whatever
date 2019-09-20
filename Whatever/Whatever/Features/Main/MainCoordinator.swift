//
//  MainCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 8/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator

enum MainRoute: Route {
    // TODO: Complete this when routes are added.
    case outfit
    case closet
    case calendar
    case profile
}

final class MainCoordinator: TabBarCoordinator<MainRoute> {
    internal override func generateRootViewController() -> UITabBarController {
        return TabBarController()
    }
    
    init() {
        // TODO: Complete this with different routes when completed.
        // Initialize tab bar.
        let outfit = UIViewController()
        let closet = ClosetCoordinator()
        let calendar = UIViewController()
        let profile = UIViewController()
        super.init(tabs: [outfit, closet, calendar, profile])
    }
}

