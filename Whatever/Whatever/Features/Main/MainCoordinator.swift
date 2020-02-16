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
    private let outfit = UIViewController()
    private let closet = UIViewController()
    private let calendar = UIViewController()
    private let profile = UIViewController()
    
    init() {
        // TODO: Complete this with different routes when completed.
        // Outfit
        outfit.view.backgroundColor = .white
        outfit.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: .tabBarOutfit),
            tag: 0)
        outfit.tabBarItem.imageInsets = UIEdgeInsets(
            top: 3,
            left: 0,
            bottom: -3,
            right: 0)
        outfit.tabBarItem.accessibilityLabel = NSLocalizedString(
            "tab_bar_outfit_accessibility_label", comment: "")

        // Closet
//        let closetCoordinator = ClosetCoordinator()
        closet.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: .tabBarCloset),
            tag: 1)
//        closetCoordinator.rootViewController.tabBarItem.imageInsets = UIEdgeInsets(
//            top: 3,
//            left: 0,
//            bottom: -3,
//            right: 0)
//        closetCoordinator.rootViewController.tabBarItem.accessibilityLabel = NSLocalizedString(
//            "tab_bar_calendar_accessibility_label", comment: "")
//        closet = closetCoordinator.unownedRouter

        // Calendar
        calendar.view.backgroundColor = .white
        calendar.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: .tabBarCalendar),
            tag: 2)
        calendar.tabBarItem.imageInsets = UIEdgeInsets(
            top: 3,
            left: 0,
            bottom: -3,
            right: 0)
        calendar.tabBarItem.accessibilityLabel = NSLocalizedString(
            "tab_bar_calendar_accessibility_label",
            comment: "")

        // Profile
        profile.view.backgroundColor = .white
        profile.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: .tabBarProfile),
            tag: 3)
        profile.tabBarItem.imageInsets = UIEdgeInsets(
            top: 3,
            left: 0,
            bottom: -3,
            right: 0)
        profile.tabBarItem.accessibilityLabel = NSLocalizedString(
            "tab_bar_profile_accessibility_label",
            comment: "")

        super.init(tabs: [outfit, closet, calendar, profile])
    }
}

