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
import RxKeyboard

final class CreateAccountViewController: AppViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var descriptionLabel: Body!
    @IBOutlet weak var nameTitleLabel: Caption2!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var nameValidationLabel: Label2!
    @IBOutlet weak var emailTitleLabel: Caption2!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var emailValidationLabel: Label2!
    @IBOutlet weak var passwordTitleLabel: Caption2!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var passwordValidationLabel: Label2!
    @IBOutlet weak var confirmPasswordTitleLabel: Caption2!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var confirmPasswordValidationLabel: Label2!
    @IBOutlet weak var createAccountButton: PrimaryButton!

    var viewModel: CreateAccountViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        // Text fields
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        // Scroll view
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] visibleKeyboardHeight in
                self?.scrollView.contentInset.bottom = visibleKeyboardHeight
            })
            .disposed(by: disposeBag)
        
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

        // Validate text fields.
        nameTextField.rx.text.orEmpty
            .map { viewModel.validateName($0) }
            .bind(to: nameValidationLabel.rx.text)
            .disposed(by: disposeBag)

        emailTextField.rx.text.orEmpty
            .map { viewModel.validateEmail($0) }
            .bind(to: emailValidationLabel.rx.text)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .map { viewModel.validatePassword($0) }
            .bind(to: passwordValidationLabel.rx.text)
            .disposed(by: disposeBag)

        Observable.combineLatest(
            passwordTextField.rx.text.orEmpty,
            confirmPasswordTextField.rx.text.orEmpty)
            .map { viewModel.validateMatchingPasswords($0, $1) }
            .bind(to: confirmPasswordValidationLabel.rx.text)
            .disposed(by: disposeBag)

        createAccountButton.rx.tap
            .subscribe(onNext: { [weak self] in
                viewModel.createAccount(
                    name: self?.nameTextField.text ?? "",
                    email: self?.emailTextField.text ?? "",
                    password: self?.passwordTextField.text ?? "") })
            .disposed(by: disposeBag)
    }
}

/// Implementation of text field delegate methods.
extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

