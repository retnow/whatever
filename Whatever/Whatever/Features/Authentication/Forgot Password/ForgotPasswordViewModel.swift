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
    
    private let router: AnyRouter<AuthenticationRoute>
    private let authenticationManager: AuthenticationManager
    
    init(
        router: AnyRouter<AuthenticationRoute>,
        authenticationManager: AuthenticationManager) {
        self.router = router
        self.authenticationManager = authenticationManager
    }
    
    func resetPasswordSelected(email: String) {
        authenticationManager.sendPasswordReset(to: email)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func backToLoginSelected() {
        router.trigger(.popToLogin)
    }
}
