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
}

final class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    lazy var state: Observable<LoginViewState> = self.stateSubject.asObservable()
    private let stateSubject = BehaviorSubject<LoginViewState>(value: .initial)
    
    private let router: AnyRouter<AuthenticationRoute>
    
    init(
        router: AnyRouter<AuthenticationRoute>) {
        self.router = router
    }
    
    func attemptLogin(
        username: String,
        password: String) {
    }
    
    func forgotPasswordWasSelected() {
        
    }
}
