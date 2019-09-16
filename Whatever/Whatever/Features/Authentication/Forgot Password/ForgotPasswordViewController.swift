//
//  ForgotPasswordViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 15/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

final class ForgotPasswordViewController: AppViewController {
    private let disposeBag = DisposeBag()

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

        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        // Text fields
        emailTextField.delegate = self

        // Scroll view
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] visibleKeyboardHeight in
                self?.scrollView.contentInset.bottom = visibleKeyboardHeight
            })
            .disposed(by: disposeBag)

        // String constants
        titleLabel.text = NSLocalizedString(
            "forgot_password_title", comment: "")
        descriptionLabel.setText(
            to: NSLocalizedString("forgot_password_description", comment: ""),
            withLineHeightMultiple: 1.25)
        resetPasswordButton.setTitle(
            NSLocalizedString("forgot_password_reset", comment: ""),
            for: .normal)
        backToLoginButton.setTitle(
            NSLocalizedString("forgot_password_back", comment: ""),
            for: .normal)
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }

        resetPasswordButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let email = self.emailTextField.text ?? ""
                viewModel.resetPasswordSelected(email: email)
            })
            .disposed(by: disposeBag)

        backToLoginButton.rx.tap
            .subscribe(onNext: viewModel.backToLoginSelected)
            .disposed(by: disposeBag)
    }

    // Render correct elements depending on current state.
    // TODO: Fill this in when different view states are required.
    private func render(_ state: LoginViewState) {
        switch state {
        case .initial:
            break
        }
    }
}

/// Implementation of text field delegate methods.
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
