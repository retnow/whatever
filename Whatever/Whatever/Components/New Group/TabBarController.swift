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
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(named: .backgroundInverted)
        tabBar.tintColor = UIColor(named: .background)
        tabBar.unselectedItemTintColor = UIColor(named: .disabled)
    }
}

