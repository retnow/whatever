//
//  TabBarController.swift
//  Whatever
//
//  Created by Retno Widyanti on 8/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tabBar.isTranslucent = true
        tabBar.barTintColor = UIColor(named: .background)
        tabBar.tintColor = UIColor(named: .backgroundInverted)
        tabBar.unselectedItemTintColor = UIColor(named: .disabled)
    }
}

