//
//  NavigationController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setup() {
        navigationBar.titleTextAttributes = [
            .font: ScaledFont().font(forTextStyle: .caption1),
            .foregroundColor: UIColor.white]
        navigationBar.tintColor = .black
        navigationBar.isTranslucent = false
        
        // Back arrow
        let backButtonImage = UIImage(named: .back)
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
    
    func setupAsTransparent() {
        navigationBar.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
