//
//  AppViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/**
A view controller which overrides the preferred status bar style to match the content mode.
*/
class AppViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Hide default back button text by making it an empty string.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
    }
}
