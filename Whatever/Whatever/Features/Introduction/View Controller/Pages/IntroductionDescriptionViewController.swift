//
//  IntroductionDescriptionViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class IntroductionDescriptionViewController: UIViewController {
    let titleText: String
    let descriptionText: String
    let image: UIImage
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var descriptionLabel: Heading3!
    
    init(
        title: String,
        description: String,
        image: UIImage) {
        self.titleText = title
        self.descriptionText = description
        self.image = image
        
        super.init(
            nibName: String(describing: IntroductionDescriptionViewController.self),
            bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        iconImageView.image = image
    }
}
