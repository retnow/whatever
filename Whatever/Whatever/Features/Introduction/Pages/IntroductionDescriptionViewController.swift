//
//  IntroductionDescriptionViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class IntroductionDescriptionViewController: AppViewController {
    let titleText: String
    let descriptionText: String
    let image: UIImage
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var descriptionLabel: Body!
    
    init(
        title: String,
        description: String,
        image: UIImage) {
        self.titleText = title
        self.descriptionText = description
        self.image = image
        
        super.init(
            nibName: String(
                describing: IntroductionDescriptionViewController.self),
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
        titleLabel.setText(
            to: titleText,
            withLineHeightMultiple: 1.0)
        descriptionLabel.setText(
            to: descriptionText,
            withLineHeightMultiple: 1.25)
        iconImageView.image = image
    }
}
