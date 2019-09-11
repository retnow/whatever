//
//  LoginCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator

enum AuthenticationRoute: Route {
    case introduction
    case login
    case createAccount
    case verifyEmail(String)
}

class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
    override func generateRootViewController() -> UINavigationController {
        return SecondaryNavigationController()
    }
    
    init() {
        super.init(initialRoute: .introduction)
        // TODO: Listen to change in authentication state to deal with session timeout and logout.
    }
    
    override func prepareTransition(for route: AuthenticationRoute) -> NavigationTransition {
        switch route {
        case .introduction:
            let vc = IntroductionPageViewController()
            let vm = IntroductionPageViewModel(router: anyRouter)
            vc.viewModel = vm
            return .show(vc)
            
        case .login:
            let vc = LoginViewController()
            let vm = LoginViewModel(router: anyRouter)
            vc.viewModel = vm
            return .push(vc)
        
        case .createAccount:
            let vc = CreateAccountViewController()
            let vm = CreateAccountViewModel(router: anyRouter)
            vc.viewModel = vm
            return .push(vc)
            
        case .verifyEmail(let email):
            let vc = VerifyEmailViewController(with: email)
            // TODO: Create view model and inject.
            return .push(vc)
        }
    }
}
