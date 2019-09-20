//
//  LoginViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

enum LoginViewState {
    case initial
    case loading
    case wrongCredentials
    case emailUnverified
    case error
}

final class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    lazy var state: Observable<LoginViewState> = self.stateSubject.asObservable()
    private let stateSubject = BehaviorSubject<LoginViewState>(value: .initial)
    
    private let router: AnyRouter<AuthenticationRoute>
    private let authenticationService: AuthenticationService
    
    init(
        router: AnyRouter<AuthenticationRoute>,
        authenticationService: AuthenticationService) {
        self.router = router
        self.authenticationService = authenticationService
    }

    func login(
        email: String,
        password: String) {
        authenticationService.login(
            email: email,
            password: password)
            .flatMap { [weak self] login in
                guard let _ = self else { return .just(.initial) }
                switch login {
                case .success(_):
                    return .just(.initial)
                case .wrongCredentials:
                    return .just(.wrongCredentials)
                case .emailUnverified:
                    return .just(.emailUnverified)
                case .error:
                    return .just(.error)
                }
            }
            .catchErrorJustReturn(.initial)
            .subscribe(onSuccess: self.stateSubject.onNext)
            .disposed(by: disposeBag)
    }
    
    func forgotPasswordWasSelected() {
        router.trigger(.forgotPassword)
    }
}
