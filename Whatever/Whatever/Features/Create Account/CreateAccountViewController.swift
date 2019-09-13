//
//  CreateAccountViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateAccountViewController: AppViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var descriptionLabel: Body!
    @IBOutlet weak var nameTitleLabel: Caption2!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var emailTitleLabel: Caption2!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTitleLabel: Caption2!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTitleLabel: Caption2!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var createAccountButton: PrimaryButton!

    var viewModel: CreateAccountViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        // String constants
        titleLabel.text = NSLocalizedString("create_account_title", comment: "")
        descriptionLabel.setText(
            to: NSLocalizedString("create_account_description", comment: ""),
            withLineHeightMultiple: 1.25)
        nameTitleLabel.text = NSLocalizedString("create_account_name_title", comment: "")
        nameTextField.placeholder = NSLocalizedString("create_account_name_placeholder", comment: "")
        emailTitleLabel.text = NSLocalizedString("create_account_email_title", comment: "")
        emailTextField.placeholder = NSLocalizedString("create_account_email_placeholder", comment: "")
        passwordTitleLabel.text = NSLocalizedString("create_account_password_title", comment: "")
        passwordTextField.placeholder = NSLocalizedString("create_account_password_placeholder", comment: "")
        confirmPasswordTitleLabel.text = NSLocalizedString("create_account_confirm_password_title", comment: "")
        confirmPasswordTextField.placeholder = NSLocalizedString("create_account_confirm_password_placeholder", comment: "")
        createAccountButton.setTitle(NSLocalizedString("create_account_button", comment: ""), for: .normal)
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }

        // TODO: Add validation to create account button.
        createAccountButton.rx.tap
            .bind { [weak self] in
                viewModel.createAccount(
                    name: self?.nameTextField.text ?? "",
                    email: self?.emailTextField.text ?? "",
                    password: self?.passwordTextField.text ?? "") }
            .disposed(by: disposeBag)
    }
}
