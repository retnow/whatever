//
//  IntroductionLogoViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class IntroductionLogoViewController: UIViewController {
    @IBOutlet weak var titleLabel: Heading1!
    @IBOutlet weak var descriptionLabel: Heading3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Strings
        titleLabel.text = NSLocalizedString("app_name", comment: "")
        descriptionLabel.text = NSLocalizedString("app_tagline", comment: "")
    }
}
