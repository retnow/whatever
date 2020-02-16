//
//  AppCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import SnapKit
import RxSwift
import RxCocoa

enum AppRoute: Route {
    case introduction
    case login
    case logout
}

class AppCoordinator: ViewCoordinator<AppRoute> {
    private let disposeBag = DisposeBag()

    init() {
        let vc = AppViewController()
        
        // TODO: Handle first screen logic.
        super.init(
            rootViewController: vc,
            initialRoute: .introduction)
        
        // Listen to change in authentication state to deal with session timeout
        // and logout.
        AppService.shared.authentication.authenticated
            .drive(onNext: { [weak self] state in
                guard let self = self else { return }
                self.rootViewController.dismiss(animated: true)
                switch state {
                case .loggedIn(_):
                    self.unownedRouter.trigger(.login)
                case .loggedOut:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {

        // TODO: Skip introduction for existing user.
        case .introduction:
            // TODO: Remove when UI is complete
//            // TEST: Main coordinator
//            let mainRouter = MainCoordinator()
//            return .embed(
//                mainRouter,
//                in: self.rootViewController)

            let authenticationCoordinator = AuthenticationCoordinator()
            addChild(authenticationCoordinator)
            return .embed(
                authenticationCoordinator,
                in: self.rootViewController)

        // TODO: Handle reauthentication for logged in existing user.
        case .login:
            let mainRouter = MainCoordinator().unownedRouter
            return .embed(
                mainRouter,
                in: self.rootViewController)

        case .logout:
            let loginRouter = AuthenticationCoordinator().unownedRouter
            return .embed(
                loginRouter,
                in: self.rootViewController)
        }
    }
}
