//
//  IntroductionPageViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

final class IntroductionPageViewModel {
    let router: UnownedRouter<AuthenticationRoute>
    
    init(router: UnownedRouter<AuthenticationRoute>) {
        self.router = router
    }
    
    // TODO: Implement router trigger actions.
    func loginWasSelected() {
        router.trigger(.login)
    }
    
    func createAccountWasSelected() {
        router.trigger(.createAccount)
    }
}
