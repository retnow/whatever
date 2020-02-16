//
//  ForgotPasswordViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 15/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

extension String {
    static let title = NSLocalizedString("forgot_password_title", comment: "")
    static let description = NSLocalizedString("forgot_password_description", comment: "")
    static let resetPassword = NSLocalizedString("forgot_password_reset", comment: "")
    static let backToLogin =  NSLocalizedString("forgot_password_back", comment: "")
}

// TODO: Handle different view states depending on forgot password flow.

final class ForgotPasswordViewController: AppViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var descriptionLabel: Body!
    @IBOutlet weak var emailTitleLabel: Caption2!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var resetPasswordButton: PrimaryButton!
    @IBOutlet weak var backToLoginButton: TertiaryButton!

    var viewModel: ForgotPasswordViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        emailTextField.delegate = self

        titleLabel.text = .title
        descriptionLabel.setText(
            to: .description,
            withLineHeightMultiple: CGFloat(Constants.Styling.bodyLineSpacing))
        
        resetPasswordButton.setTitle(.resetPassword, for: .normal)
        resetPasswordButton.addTarget(
            self,
            action: #selector(resetPasswordPressed),
            for: .touchUpInside)
        
        backToLoginButton.setTitle(.backToLogin, for: .normal)
        backToLoginButton.addTarget(
            self,
            action: #selector(backToLoginPressed),
            for: .touchUpInside)
    }
    
    @objc
    func resetPasswordPressed() {
        let email = self.emailTextField.text ?? ""
        viewModel?.resetPasswordSelected(email: email)
    }
    
    @objc
    func backToLoginPressed() {
        viewModel?.backToLoginSelected()
    }
}

/// Implementation of text field delegate methods.
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
