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

class CreateAccountViewModel {
    private let disposeBag = DisposeBag()
    
    lazy var state: Observable<LoginViewState> = self.stateSubject.asObservable()
    private let stateSubject = BehaviorSubject<LoginViewState>(value: .initial)
    
    private let router: AnyRouter<AuthenticationRoute>
    
    init(
        router: AnyRouter<AuthenticationRoute>) {
        self.router = router
    }
    
    func createAccountWasSelected() {
        // TODO: Pass in e-mail.
        router.trigger(.verifyEmail("cher@fashionvictim.me"))
    }
}
