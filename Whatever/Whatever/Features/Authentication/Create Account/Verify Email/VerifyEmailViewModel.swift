//
//  VerifyEmailViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 18/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

enum VerifyEmailViewState {
    case initial(email: String)
}

final class VerifyEmailViewModel {
    private let disposeBag = DisposeBag()

    // Variable exposing view state.
    lazy var state: Observable<VerifyEmailViewState> = self.stateSubject.asObservable()
    private let stateSubject: BehaviorSubject<VerifyEmailViewState>

    private let router: AnyRouter<AuthenticationRoute>
    private let authenticationService: AuthenticationService

    init(
        email: String,
        router: AnyRouter<AuthenticationRoute>,
        authenticationService: AuthenticationService) {
        self.stateSubject = BehaviorSubject<VerifyEmailViewState>(
            value: .initial(email: email))
        self.router = router
        self.authenticationService = authenticationService
    }

    func sendVerificationEmail() {
        authenticationService.sendVerificationEmail()
            .subscribe()
            .disposed(by: disposeBag)
    }

    func continueSelected() {
        authenticationService.authenticatedSubject.onNext(
            .loggedIn(newUser: true))
    }
}
