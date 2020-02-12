//
//  VerifyEmailViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

extension String {
    static let titleText = NSLocalizedString("verify_email_title", comment: "")
    static let continueButtonTitleText = NSLocalizedString("verify_email_button", comment: "")
    static func descriptionText(email: String) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("verify_email_message", comment: ""), email)
    }
}

final class VerifyEmailViewController: AppViewController {
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var messageLabel: Body!
    @IBOutlet weak var continueButton: PrimaryButton!

    var viewModel: VerifyEmailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        titleLabel.text = .titleText
        
        continueButton.setTitle(.continueButtonTitleText, for: .normal)
        continueButton.addTarget(
            self,
            action: #selector(continuePressed),
            for: .touchUpInside)
        
        messageLabel.setText(
            to: String.descriptionText(email: viewModel?.email ?? ""),
            withLineHeightMultiple: 1.25)
    }
    
    @objc private func continuePressed() {
        viewModel?.continueSelected()
    }
}
