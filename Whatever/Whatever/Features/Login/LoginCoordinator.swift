//
//  LoginCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator

enum LoginRoute: Route {
    case login
}

class LoginCoordinator: NavigationCoordinator<LoginRoute> {
    override func generateRootViewController() -> UINavigationController {
        return NavigationController()
    }
    
    init() {
        super.init(initialRoute: .login)
        
        // TODO: Listen to change in authentication state to deal with session timeout and logout.
    }
    
    override func prepareTransition(for route: LoginRoute) -> NavigationTransition {
        switch route {
        case .login:
            let vc = LoginViewController()
            let vm = LoginViewModel(router: anyRouter)
            vc.viewModel = vm
            return .show(vc)
        }
    }
}
