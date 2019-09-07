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
    let superRouter: AnyRouter<AppRoute>
    
    override func generateRootViewController() -> UINavigationController {
        return NavigationController()
    }
    
    convenience init(superRouter: AnyRouter<AppRoute>) {
        self.init(superRouter: superRouter, initialRoute: .introduction)
    }
    
    init(superRouter: AnyRouter<AppRoute>, initialRoute: IntroductionRoute) {
        self.superRouter = superRouter
        super.init(initialRoute: initialRoute)
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
