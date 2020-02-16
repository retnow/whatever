//
//  ForgotPasswordViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 15/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

final class ForgotPasswordViewModel {
    private let disposeBag = DisposeBag()
    
    private let router: UnownedRouter<AuthenticationRoute>
    private let authenticationService: AuthenticationService
    
    init(
        router: UnownedRouter<AuthenticationRoute>,
        authenticationService: AuthenticationService) {
        self.router = router
        self.authenticationService = authenticationService
    }
    
    func resetPasswordSelected(email: String) {
        authenticationService.sendPasswordReset(to: email)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func backToLoginSelected() {
        router.trigger(.popToLogin)
    }
}
