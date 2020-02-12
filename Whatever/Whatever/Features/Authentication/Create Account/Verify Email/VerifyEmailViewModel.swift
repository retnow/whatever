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

final class VerifyEmailViewModel {
    private let disposeBag = DisposeBag()
    
    let email: String
    
    private let router: UnownedRouter<AuthenticationRoute>
    private let authenticationService: AuthenticationService

    init(
        email: String,
        router: UnownedRouter<AuthenticationRoute>,
        authenticationService: AuthenticationService) {
        
        self.email = email
        self.router = router
        self.authenticationService = authenticationService
    }

    func sendVerificationEmail() {
        _ = authenticationService.sendVerificationEmail()
            .subscribe()
    }

    func continueSelected() {
        authenticationService.authenticatedSubject.onNext(
            .loggedIn(newUser: true))
    }
}
