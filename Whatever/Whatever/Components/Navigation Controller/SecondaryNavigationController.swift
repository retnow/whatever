//
//  SecondaryNavigationController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class SecondaryNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setup() {
        navigationBar.titleTextAttributes = [
            .font: ScaledFont().font(forTextStyle: .caption1),
            .foregroundColor: UIColor(named: .text)]
        navigationBar.tintColor = UIColor(named: .text)
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        // Back arrow
        let backButtonImage = UIImage(named: .back)
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
