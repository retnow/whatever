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

final class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
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
        titleLabel.text = NSLocalizedString("login_hello", comment: "")
        usernameTextField.placeholder = NSLocalizedString("login_username", comment: "")
        passwordTextField.placeholder = NSLocalizedString("login_password", comment: "")
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        loginButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let username = self.usernameTextField.text ?? ""
                let password = self.passwordTextField.text ?? ""
                viewModel.attemptLogin(
                    username: username,
                    password: password)
            })
            .disposed(by: disposeBag)
        
        viewModel.state
            .subscribe(onNext: { [weak self] state in
                self?.render(state)
            })
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
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/// Implementation of navigation controller delegate methods.
extension LoginViewController: UINavigationControllerDelegate {
    
    // Hide navigation bar
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let hide = type(of: viewController) == LoginViewController.self
        navigationController.setNavigationBarHidden(hide, animated: true)
    }
}
