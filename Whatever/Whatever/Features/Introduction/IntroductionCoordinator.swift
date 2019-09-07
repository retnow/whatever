//
//  OnboardingCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator

enum IntroductionRoute: Route {
    case introduction
    case login
    case createAccount
}

class IntroductionCoordinator: NavigationCoordinator<IntroductionRoute> {
    init() {
        super.init(initialRoute: .introduction)
    }
    
    override func prepareTransition(for route: IntroductionRoute) -> NavigationTransition {
        switch route {
        case .introduction:
            let vc = IntroductionPageViewController()
            let vm = IntroductionPageViewModel(router: anyRouter)
            vc.viewModel = vm
            return .show(vc)
            
        case .login:
           let router = LoginCoordinator().anyRouter
           return .show(router)
        
        case .createAccount:
            return .none()
        }
    }
}
