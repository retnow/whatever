//
//  AuthenticationCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

enum AuthenticationRoute: Route {
    case introduction
    case login
    case createAccount
    case verifyEmail(String)
    case forgotPassword
    case popToLogin
}

class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
    private let disposeBag = DisposeBag()

    init() {
        let nc = NavigationController()
        super.init(
            rootViewController: nc,
            initialRoute: .introduction)
    }
    
    override func prepareTransition(for route: AuthenticationRoute) -> NavigationTransition {
        switch route {
        case .introduction:
            let vc = IntroductionPageViewController()
            let vm = IntroductionPageViewModel(router: unownedRouter)
            vc.viewModel = vm
            return .show(vc)
            
        case .login:
            let vc = LoginViewController()
            let vm = LoginViewModel(
                router: unownedRouter,
                authenticationService: AppService.shared.authentication)
            vc.viewModel = vm
            return .push(vc)
        
        case .createAccount:
            let vc = CreateAccountViewController()
            let vm = CreateAccountViewModel(
                router: unownedRouter,
                authenticationService: AppService.shared.authentication)
            vc.viewModel = vm
            return .push(vc)
            
        case .verifyEmail(let email):
            let vc = VerifyEmailViewController()
            let vm = VerifyEmailViewModel(
                email: email,
                router: unownedRouter,
                authenticationService: AppService.shared.authentication)
            vc.viewModel = vm
            return .push(vc)

        // TODO: Present this flow modally (need a subcoordinator/router)?
        case .forgotPassword:
            let vc = ForgotPasswordViewController()
            let vm = ForgotPasswordViewModel(
                router: unownedRouter,
                authenticationService: AppService.shared.authentication)
            vc.viewModel = vm
            return .push(vc)
            
        case .popToLogin:
            for vc in self.rootViewController.viewControllers {
                if let vc = vc as? LoginViewController {
                    return .pop(to: vc)
                }
            }
            return .popToRoot()
        }
    }
}
