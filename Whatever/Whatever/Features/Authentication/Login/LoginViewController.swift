//
//  LoginViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

final class LoginViewController: AppViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var messageLabel: Body!
    @IBOutlet weak var usernameTitleLabel: Caption2!
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTitleLabel: Caption2!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var forgotPasswordButton: TertiaryButton!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        // Text fields
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // Scroll view
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] visibleKeyboardHeight in
                self?.scrollView.contentInset.bottom = visibleKeyboardHeight
            })
            .disposed(by: disposeBag)
        
        passwordTextField.delegate = self
        
        // Enable/disable sign in button based on valid username/password text fields.
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .distinctUntilChanged()
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .distinctUntilChanged()
            .share(replay: 1)
        
        Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // String constants
        titleLabel.text = NSLocalizedString("login_title", comment: "")
        messageLabel.text = NSLocalizedString("login_message", comment: "")
        usernameTitleLabel.text = NSLocalizedString("login_username", comment: "")
        passwordTitleLabel.text = NSLocalizedString("login_password", comment: "")
        usernameTextField.placeholder = NSLocalizedString("login_username_placeholder", comment: "")
        passwordTextField.placeholder = NSLocalizedString("login_password_placeholder", comment: "")
        loginButton.setTitle(NSLocalizedString("login_action", comment: ""), for: .normal)
        forgotPasswordButton.setTitle(NSLocalizedString("login_forgot_password", comment: ""), for: .normal)
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let email = self.usernameTextField.text ?? ""
                let password = self.passwordTextField.text ?? ""
                viewModel.login(
                    email: email,
                    password: password)
            })
            .disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap
            .subscribe(onNext: viewModel.forgotPasswordWasSelected)
            .disposed(by: disposeBag)
        
        viewModel.state
            .subscribe(onNext: { [weak self] in
                self?.render($0)
            })
            .disposed(by: disposeBag)
    }
    
    // Render correct elements depending on current state.
    // TODO: Fill this in when different view states are required.
    private func render(_ state: LoginViewState) {
        switch state {
        case .initial:
            break
        case .loading:
            break
        case .wrongCredentials:
            break
        case .emailUnverified:
            break
        case .error:
            break
        }
    }
}

/// Implementation of text field delegate methods.
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
