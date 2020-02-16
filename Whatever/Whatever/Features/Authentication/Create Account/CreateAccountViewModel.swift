//
//  CreateAccountViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

enum CreateAccountViewState {
    case initial
    case error
}

protocol CreateAccountViewModelDelegate: class {
    func createAccountViewStateDidUpdate(viewState: CreateAccountViewState)
}

final class CreateAccountViewModel {
    private let disposeBag = DisposeBag()

    var delegate: CreateAccountViewModelDelegate? {
        didSet {
            delegate?.createAccountViewStateDidUpdate(viewState: viewState)
        }
    }
    
    private var viewState: CreateAccountViewState = .initial {
        didSet {
            delegate?.createAccountViewStateDidUpdate(viewState: viewState)
        }
    }
    
    private let router: UnownedRouter<AuthenticationRoute>
    private let authenticationService: AuthenticationService

    init(
        router: UnownedRouter<AuthenticationRoute>,
        authenticationService: AuthenticationService) {
        self.router = router
        self.authenticationService = authenticationService
    }

    func createAccount(
        name: String,
        email: String,
        password: String) {
        _ = authenticationService.createUser(
            name: name,
            email: email,
            password: password)
    }

    // MARK: Validation functions
    private func isValid(name: String,
        email: String,
        password: String,
        confirmedPassword: String) -> Single<String? > {

        // If there are invalid entries, show an alert.
        var validationErrors = String()
        if let nameError = validateName(name) {
            validationErrors.append("- " + NSLocalizedString("create_account_name_title", comment: ""))
            validationErrors.append(": \(nameError)\n")
        }

        if let emailError = validateEmail(email) {
            validationErrors.append("- " + NSLocalizedString("create_account_email_title", comment: ""))
            validationErrors.append(": \(emailError)\n")
        }

        if let passwordError = validatePassword(password) {
            validationErrors.append("-" + NSLocalizedString("create_account_password_title", comment: ""))
            validationErrors.append(": \(passwordError)\n")
        }

        if let confirmPasswordError = validateMatchingPasswords(
            password,
            confirmedPassword) {
            validationErrors.append("-" + NSLocalizedString("create_account_confirm_password_title", comment: ""))
            validationErrors.append(": \(confirmPasswordError)\n")
        }

        return .just(!validationErrors.isEmpty ? validationErrors : nil)
    }

    func validateName(_ name: String) -> String? {
        return !Validation.validate(name, against: .notEmpty) ?
            ValidationInput.notEmpty.errorMessage
            : nil
    }

    func validateEmail(_ email: String) -> String? {
        // First verify email string is not empty.
        if !Validation.validate(email, against: .notEmpty) {
            return ValidationInput.notEmpty.errorMessage
        // Then verify that it is a valid email format.
        } else if !Validation.validate(email, against: .email) {
            return ValidationInput.email.errorMessage
        } else {
            return nil
        }
    }

    func validatePassword(_ password: String) -> String? {
        // First verify password string is not empty.
        if !Validation.validate(password, against: .notEmpty) {
            return ValidationInput.notEmpty.errorMessage
        // Then verify that it satisfies password requirements.
        } else if !Validation.validate(password, against: .password) {
            return ValidationInput.password.errorMessage
        } else {
            return nil
        }
    }

    func validateMatchingPasswords(
        _ enteredPassword: String,
        _ matchingPassword: String) -> String? {
        // First verify password string is not empty.
        if !Validation.validate(matchingPassword, against: .notEmpty) {
            return ValidationInput.notEmpty.errorMessage
            // Then verify that it satisfies password requirements.
        } else if enteredPassword != matchingPassword {
            return NSLocalizedString(
                "validation_error_mismatched_passwords",
                comment: "")
        } else {
            return nil
        }
    }
}
