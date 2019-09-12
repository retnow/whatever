//
//  VerifyEmailViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class VerifyEmailViewController: AppViewController {
    private let disposeBag = DisposeBag()
    
    private let email: String?
    
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var messageLabel: Body!
    @IBOutlet weak var continueButton: PrimaryButton!
    
    init(with email: String?) {
        self.email = email
        super.init(
            nibName: String(describing: VerifyEmailViewController.self),
            bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // TODO: Bind view model.
    }
    
    private func setupUI() {
        // String constants.
        titleLabel.text = NSLocalizedString("verify_email_title", comment: "")
        if let email = self.email {
            messageLabel.setText(
                to: String.localizedStringWithFormat(
                    NSLocalizedString("verify_email_message", comment: ""),
                    email),
                withLineHeightMultiple: 1.25)
        } else {
            messageLabel.setText(
                to: NSLocalizedString(
                    "verify_email_message_no_email",
                    comment: ""),
                withLineHeightMultiple: 1.25)
        }

        continueButton.setTitle(
            NSLocalizedString("verify_email_button", comment: ""),
            for: .normal)
    }
}
